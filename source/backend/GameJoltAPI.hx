package backend;

#if GAMEJOLT_ALLOWED
import hxgamejolt.GameJolt;
import backend.APIStuff;
#end

class GameJoltAPI
{
    public static var user:String = "";
    public static var token:String = "";

    private static var gameID:String = "1021340";

    static public function init()
    {
        GameJolt.init(gameID, APIStuff.gjAPI);
    }

    static public function auth(successCallback:()->Void = null, errorCallback:()->Void)
    {
        if(user == "" || token == "") {
            trace("User or token not set!");
            return;
        }
        #if !GAMEJOLT_ALLOWED
        trace("Gamejolt not supported on this platform!");
        #else
            GameJolt.authUser(user, token, {
            onSucceed: function():Void
            {  
                if (successCallback != null)
                    successCallback();
            },
            onFail: function(msg:String):Void
            {
                if (errorCallback != null)
                    errorCallback();
            }
            }).requestData();
        #end
    }

    static public function earnTrophy(trophyID:Int, successCallback:Void->Void, errorCallback:Void->Void) 
    {
        #if !GAMEJOLT_ALLOWED
        trace("Gamejolt not supported on this platform!");
        #else
            GameJolt.addTrophy(user, token, trophyID, {
                onSucceed: function():Void {
                    if (successCallback != null)
                        successCallback();
                },
                onFail: function(msg:String):Void {
                    if (errorCallback != null)
                        errorCallback();
                }
            }).requestData();
        #end
    }
}