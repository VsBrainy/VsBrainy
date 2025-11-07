package states.editors;

import flixel.FlxG;
import flixel.util.FlxSpriteUtil;

import openfl.utils.ByteArray;

import haxe.io.Bytes;
import haxe.Json;
import StringTools;

import flash.net.FileReference;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.FileFilter;

import backend.Paths;

import sys.io.File;

import states.MainMenuState;

import backend.ui.*;

typedef StrumLineData = {
    var x:Array<Float>;
    var y:Array<Float>;
    var rotation:Array<Float>;
    var alpha:Array<Float>;
}

typedef ModChartData = {
    var type:String;
    var everySteps:Int;
    var reverseEveryOther:Bool;
    var time:Float;
    var beatBasedEase:Bool;
}

//Code entirely by Brainy7890 :o
//Feel free to drop this state into your own mod, but don't delete these comments.
//Or, if you want, add me to a special thanks in a credits section of your mod. You can find my credit icon in this repository. (assets/shared/images/credits/brainy7890.png)
//Of course, if you're just forking Brainy Engine or using the engine for your mod, do what you want.

class ModchartEditorState extends MusicBeatState implements PsychUIEventHandler.PsychUIEvent {
    private var luaFile:String = '
 --Code generated using Brainy Engine v${MainMenuState.psychEngineVersion} Modchart Editor

--Initial setup

local note0X, note0Y, note0Alpha
local note1X, note1Y, note1Alpha
local note2X, note2Y, note2Alpha
local note3X, note3Y, note3Alpha
local note4X, note4Y, note4Alpha
local note5X, note5Y, note5Alpha
local note6X, note6Y, note6Alpha
local note7X, note7Y, note7Alpha

local easeTime

function onCreatePost()';
    private var finalFile:String;
    private var setupFile:String = "";
    private var typeArray:Array<String> = ["Linear", "Sine In/Out"];
    private var strumLineData:StrumLineData;
    private var modChartData:ModChartData;

    private var mainBox:PsychUIBox;
    private var saveButton:PsychUIButton;

    private var hidePlayerNotes:PsychUICheckBox;
    private var hideOpponentNotes:PsychUICheckBox;

    private var everySteps:PsychUINumericStepper;
    private var typeDropDown:PsychUIDropDownMenu;
    private var reverseEveryOtherCheckbox:PsychUICheckBox;
    private var strumLineXInputs:Array<PsychUIInputText>;
    private var strumLineYInputs:Array<PsychUIInputText>;
    private var strumLinerotationInputs:Array<PsychUIInputText>;
    private var strumLineAlphaInputs:Array<PsychUIInputText>;
    private var timeInput:PsychUINumericStepper;
    private var beatBasedEase:PsychUICheckBox;

    private var hideNotes:Array<Bool>;

    private var startHideIdx:Int;
    private var endHideIdx:Int;

    override public function new()
    {
        super();
        strumLineData = defaultStrumLine();
        modChartData = defaultModChartData();
        hideNotes = [false, false];
    }

    function defaultModChartData()
        return {
            type: "linear",
            everySteps: 4,
            reverseEveryOther: false,
            time: 0.0,
            beatBasedEase: false
        };

    function formatType(type:String):String
    {
        var out:String = "";

        switch (type) {
            case "Sine In/Out":
                out = "sineInOut";
            default:
                out = "linear";
        }

        return out;
    }

    function defaultStrumLine():StrumLineData
        return {
            x: [0, 0, 0, 0, 0, 0, 0, 0],
            y: [0, 0, 0, 0, 0, 0, 0, 0],
            rotation: [0, 0, 0, 0, 0, 0, 0, 0],
            alpha: [1, 1, 1, 1, 1, 1, 1, 1]
        };

    override function create()
    {
        FlxG.camera.bgColor = FlxColor.fromHSL(0, 0, 0.5);
        FlxG.mouse.visible = true;

        mainBox = new PsychUIBox(20, 100, 1240, 600, ['Properties', 'File']);

        saveButton = new PsychUIButton(30, 15, "Save Lua File", 100);

        hidePlayerNotes = new PsychUICheckBox(30, 15, "Hide Player Notes");
        hideOpponentNotes = new PsychUICheckBox(30, 45, "Hide Opponent Notes");

        var beatLabel:FlxText = new FlxText(30, 75, 0, "Every X Steps");
        everySteps = new PsychUINumericStepper(beatLabel.x + beatLabel.width + 10, 75, 1, 4, 1, 64, 0);
        typeDropDown = new PsychUIDropDownMenu(30, 115, typeArray, function(id:Int, type:String)
        {
            modChartData.type = formatType(type);
        });
        reverseEveryOtherCheckbox = new PsychUICheckBox(30, 145, "Reverse every other 4 steps");

        var timeLabel:FlxText = new FlxText(30, 170, 0, "Easing Time");
        timeInput = new PsychUINumericStepper(30, timeLabel.y + timeLabel.height + 10, 0.05, 0, 0, 999, 2);
        beatBasedEase = new PsychUICheckBox(30, 230, "Ease based on BPM");

        var objX:Int = 230;
        var objY:Int = 15;

        strumLineXInputs = new Array();
        strumLineYInputs = new Array();
        strumLinerotationInputs = new Array();
        strumLineAlphaInputs = new Array();

        var headers:Array<String> = ["X", "Y", "Rotation", "Alpha"];
        var headersPos:Array<Float> = [objX, objX + 110, objX + 220, objX + 330];

        var i:Int = 0;

        for (header in headers) {
            mainBox.getTab("Properties").menu.add(new FlxText(headersPos[i], objY - 15, headers[i]));
            i += 1;
        }

        for (i in 0...8) {
            strumLineXInputs.push(new PsychUIInputText(objX, objY));
            strumLineYInputs.push(new PsychUIInputText(objX+110, objY));
            strumLinerotationInputs.push(new PsychUIInputText(objX+220, objY));
            strumLineAlphaInputs.push(new PsychUIInputText(objX+330, objY));
            mainBox.getTab("Properties").menu.add(strumLineXInputs[i]);
            mainBox.getTab("Properties").menu.add(strumLineYInputs[i]);
            mainBox.getTab("Properties").menu.add(strumLinerotationInputs[i]);
            mainBox.getTab("Properties").menu.add(strumLineAlphaInputs[i]);
            objY += 30;
        }

        mainBox.getTab("File").menu.add(saveButton);

        mainBox.getTab("Properties").menu.add(hidePlayerNotes);
        mainBox.getTab("Properties").menu.add(hideOpponentNotes);
        mainBox.getTab("Properties").menu.add(beatLabel);
        mainBox.getTab("Properties").menu.add(everySteps);
        mainBox.getTab("Properties").menu.add(typeDropDown);
        mainBox.getTab("Properties").menu.add(reverseEveryOtherCheckbox);
        mainBox.getTab("Properties").menu.add(timeInput);
        mainBox.getTab("Properties").menu.add(timeLabel);
        mainBox.getTab("Properties").menu.add(beatBasedEase);
        add(mainBox);
    }

    function saveLuaFile():Void
    {
        var fileRef:FileReference = new FileReference();

        finalFile = luaFile;

        setSetup();
        finalFile += "\n"; //new line for readablity.
        createOnUpdate();
        finalFile += "\n";
        createOnStep();
        var bytes = Bytes.ofString(finalFile);
        var blob = new ByteArray();
        blob.writeBytes(bytes.getData());

        fileRef.save(blob, "modchart.lua");
    }

    function indent(level:Int):String
    {
        var string:String = "";

        for (i in 1...level) {
            string += "    ";
        }
        return string;
    }

    function setSetup():Void
    {
        setupFile = "";
        for (i in 0...8)
        {
            setupFile += "\n" + indent(1) + "note" + i + "X = getPropertyFromGroup('strumLineNotes', " + i + ", 'x')";
            setupFile += "\n" + indent(1) + "note" + i + "Y = getPropertyFromGroup('strumLineNotes', " + i + ", 'y')";
            setupFile += "\n" + indent(1) + "note" + i + "Alpha = getPropertyFromGroup('strumLineNotes', " + i + ", 'alpha')";
        }

        if (modChartData.beatBasedEase)
            setupFile += "\n" + indent(1) + "easeTime = ((60/curBpm)/4) * " + modChartData.everySteps;
        else
            setupFile += "\n" + indent(1) + "easeTime = " + modChartData.time;

        setupFile += "\nend";
        finalFile += setupFile;
    }

    function createOnStep():Void
    {
        var stepFile:String = "";
        var run:Int = modChartData.everySteps;

        if (modChartData.reverseEveryOther)
            run = run * 2;


        stepFile += "\nfunction onStepHit()";
        stepFile += "\n" + indent(1) + "run = curStep % " + run;
        stepFile += "\n" + indent(1) + "if run == 0  or curStep == 1 then";

        var i:Int = 0;
        for (field in strumLineData.x) {
            if (field != 0 || !Math.isNaN(field))
            {
                stepFile += "\n" + indent(2) + "noteTweenX('noteTweenX" + i + "', " + i + ", " + "note" + i + "X + " + field + ", easeTime, " + "'" + modChartData.type + "')";
            }
            i += 1;
        }

        i = 0;

        for (field in strumLineData.y) {
            if (field != 0 || !Math.isNaN(field))
            {
                stepFile += "\n" + indent(2) + "noteTweenY('noteTweenY" + i + "', " + i + ", " + "note" + i + "Y + " + field + ", easeTime, " + "'" + modChartData.type + "')";
            }
            i += 1;
        }

        i = 0;

        for (field in strumLineData.alpha) {
            if (field != 1 || !Math.isNaN(field))
            {
                stepFile += "\n" + indent(2) + "noteTweenAlpha('noteTweenAlpha" + i + "', " + i + ", " + field + ", easeTime, " + "'" + modChartData.type + "')";
            }
            i += 1;
        }

        for (field in strumLineData.alpha) {
            if (field != 1 || !Math.isNaN(field))
            {
                stepFile += "\n" + indent(2) + "noteTweenAngle('noteTweenAngle" + i + "', " + i + ", " + field + ", easeTime, " + "'" + modChartData.type + "')";
            }
            i += 1;
        }

        stepFile += "\n" + indent(1) + "end";

        if (modChartData.reverseEveryOther)
        {
            i = 0;

            stepFile += indent(1) + "\nif run == " + (modChartData.everySteps + 1) + "then";
            for (field in strumLineData.x) {
                if (field != 0)
                {
                    stepFile += "\n" + indent(2) + "noteTweenX('noteTweenX" + i + "', " + i + ", " + "note" + i + "X" + ", easeTime, " + "'" + modChartData.type + "')";
                }
                i += 1;
            }

            i = 0;

            for (field in strumLineData.y) {
                if (field != 0)
                {
                    stepFile += "\n" + indent(2) + "noteTweenY('noteTweenY" + i + "', " + i + ", " + "note" + i + "Y" + ", easeTime, " + "'" + modChartData.type + "')";
                }
                i += 1;
            }

            i = 0;

            for (field in strumLineData.alpha) {
                if (field != 1)
                {
                    stepFile += "\n" + indent(2) + "noteTweenAlpha('noteTweenAlpha" + i + "', " + i + ", " + field + ", easeTime, " + "'" + modChartData.type + "')";
                }
                i += 1;
            }

            i = 0;
            for (field in strumLineData.rotation) {
                if (field != 1)
                {
                    stepFile += "\n" + indent(2) + "noteTweenAlpha('noteTweenAngle" + i + "', " + i + ", " + field + ", easeTime, " + "'" + modChartData.type + "')";
                }
            }

            stepFile += "\nend";
        }

        stepFile += "\n" + "end"; 
        finalFile += stepFile;
    }

    function createOnUpdate():Void
    {
        var updateFile:String = "function onUpdate(elapsed)";

        if (hideNotes[0] || hideNotes[1])
        {
            startHideIdx = 4;
            endHideIdx = 3;

            if (hideNotes[0])
                startHideIdx = 0;
            if (hideNotes[1])
                endHideIdx = 7;

            updateFile += "\n" + indent(1) + "if curBeat == 0 then";
            updateFile += "\n" + indent(2) + "for note = " + startHideIdx + ", " + endHideIdx + " do";
            updateFile += "\n" + indent(3) + "setPropertyFromGroup('strumLineNotes', note, 'alpha', 0)";
            updateFile += "\n" + indent(2) + "end";
            updateFile += "\n" + indent(1) + "end";
        }
        updateFile += "\n" + "end"; 

        finalFile += updateFile;

    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ESCAPE)
            LoadingState.loadAndSwitchState(new MainMenuState());
    }

    public function UIEvent(id:String, sender:Dynamic):Void {
        switch (id) {
            case PsychUIButton.CLICK_EVENT:
                if (sender == saveButton) saveLuaFile();
            case PsychUICheckBox.CLICK_EVENT:
                if (sender == hideOpponentNotes) {
                    hideNotes[0] = !hideNotes[0];
                }
                
                else if (sender == hidePlayerNotes) {
                    hideNotes[1] = !hideNotes[1];
                }

                if (sender == reverseEveryOtherCheckbox) {
                    modChartData.reverseEveryOther = !modChartData.reverseEveryOther;
                }

                if (sender == beatBasedEase) {
                    modChartData.beatBasedEase = !modChartData.beatBasedEase;
                }
            case PsychUINumericStepper.CHANGE_EVENT:
                if (sender == everySteps)
                {
                    reverseEveryOtherCheckbox.label = "Reverse every other " + everySteps.value + " steps";
                    modChartData.everySteps = Std.int(everySteps.value);
                }
                else if (sender == timeInput)
                    modChartData.time = timeInput.value;

            case PsychUIInputText.CHANGE_EVENT:

                var i = 0;
                for (input in strumLineXInputs) {
                    if (sender == input) {
                        var value = if (input.text != null) input.text else "0";
                        strumLineData.x[i] = Std.parseFloat(input.text);
                    }
                    i++;
                }

                i = 0;

                for (input in strumLineYInputs) {
                    if (sender == input) {
                        var value = if (input.text != null) input.text else "0";
                        strumLineData.y[i] = Std.parseFloat(input.text);
                    }
                    i++;
                }

                i = 0;

                for (input in strumLinerotationInputs) {
                    if (sender == input) {
                        var value = if (input.text != null) input.text else "0";
                        strumLineData.rotation[i] = Std.parseFloat(input.text);
                    }
                    i++;
                }

                i = 0;

                for (input in strumLineAlphaInputs) {
                    if (sender == input) {
                        var value = if (input.text != null) input.text else "0";
                        strumLineData.alpha[i] = Std.parseFloat(input.text);
                    }
                    i++;
                }
        }
    }
}