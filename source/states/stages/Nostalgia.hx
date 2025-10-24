package states.stages;

import states.stages.objects.*;
import states.PlayState;

import flixel.util.FlxColor;

class Nostalgia extends BaseStage
{
    override public function destroy()
    {
        backend.WindowUtil.setWindowSize(1280, 720, 1280, 720);
        super.destroy();
    }

    override public function create()
    {
        backend.WindowUtil.setWindowSize(776, 800, 776, 800);
        super.create();
    }
}