package backend;

import sys.io.File;
import haxe.Json;
#if HSCRIPT_ALLOWED
import psychlua.HScript;
#end
typedef MenuItem =
{
    var name:String;
    @:optional var displayConditions:String;
    @:optional var unlockPos:Bool;
    @:optional var x:Int;
    @:optional var y:Int;
}

typedef MainMenuFile =
{
    var center:Array<MenuItem>;
    @:optional var leftOption:MenuItem;
    @:optional var rightOption:MenuItem;
}

class MainMenuData
{
    public var file:MainMenuFile = null;
    public var hscripts:Map<String, HScript> = new Map();

    static inline public function getScript(item:String):String
    {
        return Paths.hx('data/mainmenu/${item}');
    }

    public function new()
    {
        try {
            var path:String = Paths.json("mainMenu");
            trace(path);
            var raw:String = File.getContent(path);
            file = Json.parse(raw);
        } catch(e:Dynamic)
        {
            trace(e);
        }

        #if HSCRIPT_ALLOWED
        for (item in file.center)
            if (FileSystem.exists(MainMenuData.getScript(item.name)))
                hscripts.set(item.name, new HScript(null, Paths.hx('data/mainmenu/${item.name}')));
        #end
    }

    public function callback(name:String):Dynamic
    {
        #if HSCRIPT_ALLOWED
        var hscript:HScript = hscripts.get(name);
        if (hscript.exists('onCallback'))
        {
            return hscript.call('onCallback');
        }
        else return null;
        #else
        return null;
        #end
    }
}
