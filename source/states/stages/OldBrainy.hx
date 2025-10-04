package states.stages;

import states.stages.objects.*;
import states.PlayState;

import flixel.util.FlxColor;

class OldBrainy extends BaseStage
{
    override function create()
    {
        var skyType:String = "sky";

        if (PlayState.curStage == "brainyslandnight") 
        {
            if (PlayState.SONG.song.toLowerCase() != "irritated") PlayState.instance.defaultCamZoom = 0.7;
            skyType = "sky_space";
        }
        if (PlayState.curStage == "brainyslandsunset") skyType = "sky_sunset";
        
        var bg:BGSprite = new BGSprite('skys/${skyType}', -300, -150, 0.05, 0.05);

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

        var hills:BGSprite = new BGSprite('brainysland/old/hills', -1422, -301, 0.15, 0.15);
        var land:BGSprite = new BGSprite('brainysland/old/land', -1042, 239, 1, 1);

        add(bg);
        add(hills);
        add(land);

        super.create();
    }
}