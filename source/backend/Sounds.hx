package backend;

import flixel.sound.FlxSoundGroup;
import flixel.sound.FlxSound;
import flixel.FlxG;

class Sounds
{
    public static function play(soundString:String, volume:Float = 1.0, looped:Bool = false, ?group:FlxSoundGroup, autoDestroy:Bool = true, ?onComplete:() -> Void):FlxSound
        return FlxG.sound.play(soundString, volume, looped, group, autoDestroy, onComplete);
}