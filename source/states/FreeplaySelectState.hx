package states;

import backend.WeekData;
import backend.Controls;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class FreeplaySelectState extends MusicBeatState {
    var weeks:Array<String> = [];
    var curWeek:Int = 0;
    var inputCooldown:Float = 0;
    var lastDirection:Int = 1;
    var weekImage:FlxSprite = null;
    var weekName:FlxText;
    var hintText:FlxText;

    override function create():Void {
        super.create();

        backend.WeekData.reloadWeekFiles(false);
        weeks = WeekData.weeksList.copy();
        if (weeks.length == 0) {
            FlxG.switchState(new MainMenuState());
            return;
        }

        var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
        bg.scrollFactor.set(0, 0);
        bg.setGraphicSize(Std.int(bg.width * 1.175));
        bg.updateHitbox();
        bg.screenCenter();
        bg.antialiasing = ClientPrefs.data.antialiasing;
        insert(0, bg);

        weekName = new FlxText(0, 50, FlxG.width, '', 48);
        weekName.setFormat(Paths.font("vcr.ttf"), 48, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
        insert(2, weekName);

        hintText = new FlxText(0, FlxG.height - 32, FlxG.width, '←/→: Navigate   ACCEPT: Select   BACK: Back', 16);
        hintText.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        insert(3, hintText);

        updateWeekDisplay();
    }

    override function update(elapsed:Float):Void {
        super.update(elapsed);
        inputCooldown -= elapsed;
        if (inputCooldown <= 0) {
            if (FlxG.keys.justPressed.LEFT) changeWeek(-1);
            else if (FlxG.keys.justPressed.RIGHT) changeWeek(1);
        }

        if (controls.ACCEPT) {
            selectCurrentWeek();
        } else if (controls.BACK) {
            FlxG.switchState(new MainMenuState());
        }
    }

    function selectCurrentWeek():Void {
        var sel = weeks[curWeek];
        var weekData = WeekData.weeksLoaded.get(sel);
        WeekData.setDirectoryFromWeek(weekData);

        FlxTween.color(weekName, 0.25, FlxColor.WHITE, FlxColor.LIME, {
            ease: FlxEase.linear,
            onComplete: function(_) {
                FlxTween.color(weekName, 0.25, FlxColor.LIME, FlxColor.WHITE, {
                    ease: FlxEase.linear
                });
            }
        });

        var sound1 = 'confirmMenu';
        var sound2 = 'fpsselect';
        if (FileSystem.exists(Paths.getSharedPath('sounds/' + sound1 + '.ogg'))) {
            FlxG.sound.play(Paths.sound(sound1));
        }

        var baseX = weekName.x;
        var baseY = weekName.y;
        var timer = new flixel.util.FlxTimer();
        var duration:Float = 0.7;
        var elapsedShake:Float = 0;
        timer.start(0.02, function(t:flixel.util.FlxTimer) {
            elapsedShake += 0.02;
            var progress = elapsedShake / duration;
            var intensity = 15 * (1 - progress);
            weekName.x = baseX + FlxG.random.float(-intensity, intensity);
            weekName.y = baseY + FlxG.random.float(-intensity, intensity);
            if (elapsedShake >= duration) {
                weekName.x = baseX;
                weekName.y = baseY;
                FlxG.switchState(new FreeplayState(sel));
                t.cancel();
            }
        }, Std.int(duration / 0.02));
    }

    function changeWeek(direction:Int):Void {
        lastDirection = direction;
        curWeek = wrapIndex(curWeek + direction, weeks.length);
        updateWeekDisplay();
        flashWeekName();
        inputCooldown = 0.2;
    }

    function wrapIndex(index:Int, length:Int):Int {
        return (index % length + length) % length;
    }

    function updateWeekDisplay():Void {
        var weekId = weeks[curWeek];
        var data = WeekData.weeksLoaded.get(weekId);
        weekName.text = (data != null && data.weekName != null) ? data.weekName : weekId;

        if (weekImage != null) {
            var offX = weekImage.x - lastDirection * (FlxG.width + 100);
            FlxTween.tween(weekImage, { alpha:0, x:offX }, 0.2, {
                ease: FlxEase.cubeIn,
                onComplete: function(_) {
                    remove(weekImage, true);
                    weekImage.destroy();
                    loadNewWeekImage(weekId);
                }
            });
        } else {
            loadNewWeekImage(weekId);
        }
    }

    function loadNewWeekImage(weekId:String):Void {
        weekImage = new FlxSprite();
        weekImage.loadGraphic(Paths.image(weekId));
        weekImage.screenCenter();
        weekImage.alpha = 0;
        weekImage.x += lastDirection * (FlxG.width + 100) / 2;
        weekImage.camera = FlxG.camera;
        insert(1, weekImage);
        FlxTween.tween(weekImage, {
            alpha: 1,
            x: (FlxG.width - weekImage.frameWidth) / 2
        }, 0.4, { ease: FlxEase.cubeOut });
    }

    function flashWeekName():Void {
        FlxTween.color(weekName, 0.15, FlxColor.BLACK, FlxColor.YELLOW, {
            ease: FlxEase.quadOut,
            onComplete: function(_) {
                FlxTween.color(weekName, 0.15, FlxColor.YELLOW, FlxColor.BLACK, {
                    ease: FlxEase.quadIn
                });
            }
        });
    }
}
