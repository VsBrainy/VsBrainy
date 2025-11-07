package states.editors;

import backend.ui.PsychUIEventHandler.PsychUIEvent;
import backend.MainMenuData;
import states.editors.content.*;

enum OptionType
{
    LEFT;
    RIGHT;
    CENTER;
}

class MainMenuEditorState extends MusicBeatState implements PsychUIEvent
{
    var box:PsychUIBox;
    var bg:FlxSprite;

    var options:Array<EditorMenuItem>;
    var leftOption:EditorMenuItem;
    var rightOption:EditorMenuItem;
    
    var totalOptions:Int = 0;

    var newOption:String = '';

    var data = {
            center: [
                {name: "story_mode"},
                {name: "freeplay"},
                {name: "mods", displayConditions: "MODS_ALLOWED"},
                {name: "options"}
            ]
        }

    override public function create()
    {
        #if DISCORD_ALLOWED
        DiscordClient.changePresence("Main Editor", "Editing Main Menu...");
        #end

        FlxG.mouse.visible = true;

        bg = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.scrollFactor.set(0, 0);
		bg.updateHitbox();
		bg.screenCenter();
		bg.color = 0xfde871;

        add(bg);

        parseData(data);

        box = new PsychUIBox(700, 0, 500, 500, ['Data', 'Option']);

        box.selectedName = 'Data';
        
        addDataTab();
        addOptionTab();

        add(box);
    }

    var addOptionName:PsychUIInputText;
    var addOption:PsychUIButton;

    function addDataTab()
    {
        var tab_group = box.getTab('Data').menu;

        addOptionName = new PsychUIInputText(10, 10);
        addOption = new PsychUIButton(10, 30, 'Add Option', function()
            {
                data.center.push({name: addOptionName.text});
                parseData(data);
            });

        tab_group.add(addOptionName);
        tab_group.add(addOption);
    }
    
    function addOptionTab()
    {
        var tab_group = box.getTab('Option').menu;
    }

    override public function destroy()
    {
        FlxG.mouse.visible = false;
        super.destroy();
    }

    override public function update(elapsed:Float)
    {
        if (controls.BACK)
        {
            MusicBeatState.switchState(new MainMenuState());
        }
    }

    public function UIEvent(id:String, sender:Dynamic) 
    {
        
    }

    function createMenuItem(data:MenuItem, index:Int, type:OptionType = CENTER):EditorMenuItem
	{
		var menuItem:EditorMenuItem = new EditorMenuItem(data);
		menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_${data.name}');
		menuItem.animation.addByPrefix('idle', '${data.name} idle', 24, true);
		menuItem.animation.addByPrefix('selected', '${data.name} selected', 24, true);
		menuItem.animation.play('idle');
		menuItem.updateHitbox();

        if (data.unlockPos)
        {
            if (data.x != null)
                menuItem.x = data.x;
            else
                menuItem.x = 0;

            if (data.y != null)
                menuItem.y = data.y;
            else
                menuItem.y = 0;
        }
        else
        {
            if (type == LEFT)
            {
                menuItem.x = 60;
                menuItem.y = 490;
            }
            else if (type == RIGHT)
            {
                menuItem.x = FlxG.width - 60;
                menuItem.x -= menuItem.width;
                menuItem.y = 490;
            }
            else
            {
                menuItem.screenCenter(X);
                menuItem.y = ((index * 140) + 90) + (4 - totalOptions) * 70;
            }
        }
		
		menuItem.antialiasing = ClientPrefs.data.antialiasing;
		menuItem.scrollFactor.set();
		return menuItem;
	}

    public function parseData(data:MainMenuFile)
    {
        var i = 0;
        options = new Array();
        totalOptions = data.center.length;
        for (item in data.center)
        {
            options.push(createMenuItem(item, i));

            add(options[i]);
        
            i++;
        }

        if (data.leftOption != null)
        {
            leftOption = createMenuItem(data.leftOption, 0, LEFT);
        }
        
        if (data.rightOption != null)
        {
            rightOption = createMenuItem(data.rightOption, 0, RIGHT);
        }
    }
}