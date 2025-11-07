package states.editors.content;

import backend.MainMenuData;

class EditorMenuItem extends FlxSprite
{
    var data:MenuItem;

    override public function new(data:MenuItem) 
    {
        this.data = data;
        super();
    }
}