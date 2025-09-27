package backend;

import openfl.utils.Assets;
import haxe.Json;

typedef PackFile =
{
    displayName:String,
    weeks:Array<String>,
    image:String,
    color:String
}

class PackData
{
    public static function dummy():PackFile
        return {
            displayName: "Test Pack",
            weeks: [
                "week1"
            ],
            image: "story",
            color: "ffd500"
        };

    public static function getPackFile(pack:String):PackFile {
		try
		{
			var path:String = Paths.getPath('packs/' + pack + '.json', TEXT, null, true);
			#if MODS_ALLOWED
			if(FileSystem.exists(path))
				return cast tjson.TJSON.parse(File.getContent(path));
			#else
			if(Assets.exists(path))
				return cast tjson.TJSON.parse(Assets.getText(path));
			#end
		}
		return dummy();
	}
}