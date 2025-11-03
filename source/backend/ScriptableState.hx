package backend;

import psychlua.*;

/*

Reccomended way to  use this class
class MyState extends Scriptable State
{
    override public function new():String
    {
        state = "MyState";
        super();    
    }
}
*/

class ScriptableState extends MusicBeatState
{
    public var state:String = "ScriptableState";

    public var hscript:HScript = null;

    private inline function getFile(path:String):Null<String>
    {
        return Paths.getPath(path + '.hx', TEXT, 'states');
    }

    public function init(state:String)
    {
        this.state = state;
        var file = getFile(state);
        trace(file);
        if (FileSystem.exists(file))
            hscript = new HScript(null, file);
        else
            trace("HScript file not found, ignoring");

        call("onInit");
    }

    public function call(func:String, args:Array<Dynamic> = null):Null<Dynamic>
    {
        if (args == null) args = [];
        if (hscript != null && hscript.exists(func))
            return hscript.call(func, args);
        else
            return null;
    }

    override public function create()
    {
        call("onCreate");
        super.create();
        createPost();
    }

    public function createPost()
    {
        call("onCreatePost");
    }

    override public function update(elapsed:Float)
    {
        call("onUpdate", [elapsed]);
        super.update(elapsed);
        updatePost(elapsed);
    }

    public function updatePost(elapsed:Float)
    {
        call("onUpdatePost", [elapsed]);
    }
}