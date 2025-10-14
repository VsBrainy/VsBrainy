package options;

class MiscSettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Misc Settings';
		rpcTitle = 'Misc Settings Menu'; //for Discord Rich Presence

		//I'd suggest using "Downscroll" as an example for making your own option since it is the simplest here
		var option:Option = new Option('Make Everything Wavy', //Name
			'If checked, everything is wavy, like D&B backgrounds! This is a joke setting.', //Description
			'dumbWavy', //Save data variable name
			BOOL); //Variable type
		addOption(option);

		super();
	}
}
