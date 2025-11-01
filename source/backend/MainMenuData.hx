package backend;

typedef MenuItem =
{
    var name:String;
    var callbackFile:String;
}

typedef MainMenuFile =
{
    var center:Array<MenuItem>;
    @:optional var leftOption:MenuItem;
    @:optional var RightOption:MenuItem;
}