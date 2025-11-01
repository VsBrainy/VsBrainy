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

    public var hscript:HScript;

    private inline function getFile(path:String):Null<String>
    {
        return Paths.getPath(path, TEXT, 'states/');
    }

    override public function new()
    {
        hscript = new HScript(null, getFile(state));
        super();
    }

    override public function create()
    {
        hscript.call("onCreate");
        super.create();
        createPost();
    }

    public function createPost()
    {
        hscript.call("onCreatePost");
    }

    override public function update(elapsed:Float)
    {
        hscript.call("onUpdate", [elapsed]);
        super.update(elapsed);
        updatePost(elapsed);
    }

    public function updatePost(elapsed:Float)
    {
        hscript.call("onUpdatePost", [elapsed]);
    }
}