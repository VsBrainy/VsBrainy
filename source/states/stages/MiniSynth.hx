package states.stages;
import states.PlayState;
import objects.WavyBGSprite;
class MiniSynth extends BaseStage
{
    public var bg:WavyBGSprite;
    var dumbBorder:FlxSprite;

    override function create()
    {
        if (PlayState.curStage == 'minisynth-grey')
        {
            bg = new WavyBGSprite('minisynth/bg-grey', 0, 0, 0, 0);
            bg.scale.set(4, 4);
        }
        else
        {
            bg = new WavyBGSprite('minisynth/bg', 0, 0, 0.25, 0.25);
            bg.scale.set(2, 2);
        }
        bg.screenCenter();

        dumbBorder = new FlxSprite();
        add(dumbBorder);

        add(bg);
    }

    override function createPost()
    {
        PlayState.instance.gf.visible = false;

        if (PlayState.curStage == 'minisynth-grey')
        {
            PlayState.instance.dad.scrollFactor.set(0.25, 0.25);
            PlayState.instance.boyfriend.scrollFactor.set(2, 2);
        }
    }

    override function update(elapsed:Float)
    {
        bg.updateShader(elapsed);
        super.update(elapsed);
    }
}