package states;

import backend.GameJoltAPI;

class AuthState extends MusicBeatState implements PsychUIEventHandler.PsychUIEvent
{
    var mainBox:PsychUIBox;

    var userInput:PsychUIInputText;
    var tokenInput:PsychUIInputText;

    var authButton:PsychUIButton;

    override public function destroy()
    {
        FlxG.mouse.visible = false;
        super.destroy();
    }

    override public function create()
    {
        FlxG.mouse.visible = true;

        super.create();

        var bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.scrollFactor.set();
		add(bg);

        mainBox = new PsychUIBox(0, 0, 1200, 600, ["Gamejolt Authentication"]);
        mainBox.screenCenter();

        add(mainBox);

        var objX = 10;
        var objY = 10;

        userInput = new PsychUIInputText(objX, objY, 120, 'Username', 16);

        objY += 20;

        tokenInput = new PsychUIInputText(objX, objY, 120, 'Password', 16);

        objY += 20;

        authButton = new PsychUIButton(objX, objY, "Submit", function() {
            GameJoltAPI.user = userInput.text;
            GameJoltAPI.token = tokenInput.text;
            GameJoltAPI.auth(function() {
                trace("Authentication succeeded!");
                MusicBeatState.switchState(new MainMenuState());
            }, function() {
                GameJoltAPI.user = "";
                GameJoltAPI.token = "";
                trace("Failed to authenticate!");
            });
        });

        mainBox.add(userInput);
        mainBox.add(tokenInput);
        mainBox.add(authButton);
    }
    
    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if(PsychUIInputText.focusOn != null)
			ClientPrefs.toggleVolumeKeys(false);
		else
            if (controls.BACK)
            {
                
                MusicBeatState.switchState(new MainMenuState());
            }
    }

    public function UIEvent(id:String, sender:Dynamic) {}
}