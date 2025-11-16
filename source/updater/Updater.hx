package updater;

import backend.CoolUtil;
import sys.FileSystem;
import sys.io.File;

typedef BuildInfo =
{
    var version:String;
}

class Updater
{
    static function checkForUpdates():Bool
    {
        #if desktop
        #if windows
        var path = '';
        #elseif mac
        var path = 'VsBrainy.app/Contents/Resources/';
        #else
        Sys.println('Unsupported platform');
        return false;
        #end
        Sys.println('Checking for updates...');
        if (FileSystem.exists(path + 'buildInfo.json'))
        {
            var info:BuildInfo = haxe.Json.parse(File.getContent(path + 'buildInfo.json'));

            return (info.version == CoolUtil.checkForUpdates(null, false));
        }
        return false;
        #else
        Sys.println('Not supported!');
        return false;
        #end
    }
}