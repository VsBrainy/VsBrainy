package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class FadingOverlay extends FlxSprite
{
    public function new(color:Int = 0xffffff, alpha:Float = 0)
    {
        super();
        makeGraphic(FlxG.width, FlxG.height, color);
        scrollFactor.set(0, 0);
        screenCenter();
        this.alpha = alpha;
    }

    public function fade(endAlpha:Float, fadeTime:Float, ?onComplete:Void->Void, ?delay:Float = 0):Void
    {
        FlxTween.tween(this, { alpha: endAlpha }, fadeTime);
        
        if (onComplete != null)
        {
            var timer = new FlxTimer();
            timer.start(fadeTime + delay, function(_) {
                onComplete();
            });
        }
    }

}
