package states;

import states.FreeplayState;
import backend.MusicBeatState;

class JumpScareState extends MusicBeatState
{
    override function create()
    {
	    FlxG.sound.play('assets/shared/sounds/synthrolled.ogg');

		var jumpscare:FlxSprite = new FlxSprite().loadGraphic("assets/shared/images/cheater/brofuckingcheated.png");
		var scaleFactor = FlxG.height / jumpscare.height;
		jumpscare.scale.set(scaleFactor, scaleFactor);
		jumpscare.screenCenter();
		add(jumpscare);

		var timer = new FlxTimer();
	    timer.start(10, function(t:FlxTimer) {
			Sys.exit(0);
		});
    }
}