package states.stages;

import states.stages.objects.*;
import states.PlayState;

import flixel.util.FlxColor;

#if SHADERS_ALLOWED
import shaders.PerspectiveEffect;
#end


class Brainy extends BaseStage
{
    #if SHADERS_ALLOWED
    var land3d:FlxSprite;
    var effect:PerspectiveEffect;
    #end

    var offset = 0;

    override function createPost()
    {
        super.createPost();
        PlayState.instance.boyfriend.y += offset * 2;
        PlayState.instance.gf.y += offset * 2;
        PlayState.instance.dad.y += offset * 2;
    }

    override function create()
    {
        var skyType:String = "sky";

        if (PlayState.curStage == "brainyslandnight") 
        {
            if (PlayState.SONG.song.toLowerCase() != "irritated") PlayState.instance.defaultCamZoom = 0.7;
            skyType = "sky_space";
        }
        if (PlayState.curStage == "brainyslandsunset") skyType = "sky_sunset";
        
        var bg:BGSprite = new BGSprite('skys/${skyType}', -300, -150 + offset, 0.05, 0.05);

        if (PlayState.curStage == "brainyslandnight" || PlayState.curStage == "brainyslandsunset") 
        {
            if (PlayState.curStage == "brainyslandnight")
            {
                bg.scale.x = 2;
                bg.scale.y = 2;
            }
            bg.updateHitbox();
            bg.screenCenter();

            if (PlayState.curStage == "brainyslandsunset")
                bg.x += 200;
        }

        var hills:BGSprite = new BGSprite('brainysland/funny_hill', -1422, -500 + offset, 0.15, 0.15);


        add(bg);
        add(hills);
        #if (!SHADERS_ALLOWED)
        var land:BGSprite = new BGSprite('brainysland/i_think_this_is_grass', -1200, -400 + offset, 1, 1);
        add(land);
        #else
        if (!ClientPrefs.data.shaders || ClientPrefs.data.lowQuality)
        {
            var land:BGSprite = new BGSprite('brainysland/i_think_this_is_grass', -1200, -400 + offset, 1, 1);
            add(land);
        }
        else
        {
            land3d = new FlxSprite(0, -1300);
            land3d.loadGraphic('assets/shared/images/brainysland/flatgrass.png');
            land3d.scale.set(2, 1.75);
            land3d.screenCenter(X);

            effect = new PerspectiveEffect(land3d, 0.25);

            add(land3d);
        }
        #end

        super.create();
    }

    #if SHADERS_ALLOWED
    override function update(elapsed:Float)
    {
        if (ClientPrefs.data.shaders || !ClientPrefs.data.lowQuality)
        {
            if (effect != null) effect.update(elapsed, camGame.scroll.x + FlxG.width/2, (camGame.scroll.y + FlxG.height/2)*-1);
        }

        super.update(elapsed);
    }
    #end
}