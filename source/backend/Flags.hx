package backend;

//this class is for runtime checking of compile flags.

class Flags
{
    static public function getFlag(flag:String):Bool
    {
        switch (flag)
        {
            case 'MODS_ALLOWED':
                return #if MODS_ALLOWED true #else false #end;
            
            case 'DISCORD_ALLOWED':
                return #if DISCORD_ALLOWED true #else false #end;

            default:
                return false;
        }
    }
}