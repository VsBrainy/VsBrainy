package backend;

import haxe.Json;

typedef MenuItem =
{
    var name:String;
    var callbackFile:String;
    @:optional var displayConditions:String;
    @:optional var unlockPos:Bool;
    @:optional var x:Int;
    @:optional var y:Int;
}

typedef MainMenuFile =
{
    var center:Array<MenuItem>;
    @:optional var leftOption:MenuItem;
    @:optional var RightOption:MenuItem;
}


class MainMenuData
{
    var file:MenuItem = null;

    public function new()
    {
        file = Json.parse(Paths.json("data/mainMenu"));
    }
}
