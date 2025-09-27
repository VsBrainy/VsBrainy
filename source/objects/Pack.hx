package objects;

import backend.PackData;

class Pack extends FlxSprite
{
    public var pack:String; //simply for identification just in case i guess.
    public var packFile:PackFile;
    public var bgColor:Int;
    public var name:String;
    public var weeks:Array<String>;

    public var defaultX:Float = 0;

    override public function new(pack:String)
    {
        super();
        
        this.pack = pack;

        packFile = PackData.getPackFile(pack);

        this.bgColor = Std.parseInt(packFile.color);
        this.name = packFile.displayName;
        this.weeks = packFile.weeks;
        this.loadGraphic("assets/shared/images/pack/pack_story" + packFile.image + ".png");
    }

    public function setPackPosition(x:Float)
    {
        screenCenter();
        this.x += x;
        defaultX = this.x; 
    }
}