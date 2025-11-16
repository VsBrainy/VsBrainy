package backend;

//might finish this idk

typedef Keyframe =
{
    var type:String;
    var value:String;
    var note:String;
    @:optional var time:Float;
    @:optional var easing:String;
}

typedef ModchartFile = 
{
    var keyframes:Array<Keyframe>;
}

class ModchartData
{
    var data:ModchartFile;

    public function new(path)
    {
        this.data = haxe.Json.parse(File.getContent(Paths.json(path)));
    }
}