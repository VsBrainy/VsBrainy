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
        makeGraphic(color, FlxG.width, FlxG.height);
        scrollFactor.set(0, 0);
        screenCenter();
        this.alpha = alpha;
    }

    public function fade(endAlpha:Float, fadeTime:Float, ?onComplete:FlxTween->Void)
    {
        FlxTween.tween(
            this,
            { alpha: endAlpha },
            fadeTime,
            {
                ease: FlxEase.linear,
                onComplete: onComplete
            }
        );
    }
}
