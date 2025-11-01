package backend;

class CustomState extends ScriptableState
{
    override public function new(state:String = "CustomState")
    {
        super();
        this.state = state;
    }
}