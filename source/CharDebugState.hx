package;

#if desktop
import Discord.DiscordClient;
#end
import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.ui.FlxButton;

class CharDebugState extends MusicBeatState
{
	var bg:FlxSprite;
	var debugOptionss:FlxTypedGroup<FlxSprite>;
	var curSelected:Int = 0;
	var curchar1 = 'bf';
	var curchar2 = 'dad';

	var menuItems:FlxTypedGroup<FlxSprite>;
	var textMenuItems:Array<String> = ['Character Debug', 'Character Options', 'Animation Debug', 'Exit'];

	var selector:FlxSprite;

	var grpCharsDebugs:FlxTypedGroup<FlxText>;

	public function new()
	{
		super();

		bg = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.18;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.visible = false;
		bg.antialiasing = true;
		bg.color = 0xFFfd719b;
		add(bg);

		grpCharsDebugs = new FlxTypedGroup<FlxText>();
		add(grpCharsDebugs);

		/*
		selector = new FlxSprite().makeGraphic(5, 5, FlxColor.RED);
		add(selector);
		*/

		for (i in 0...textMenuItems.length)
		{
			var optionText:FlxText = new FlxText(20, 20 + (i * 50), 0, textMenuItems[i], 32);
			optionText.ID = i;
			grpCharsDebugs.add(optionText);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.UP_P)
			curSelected -= 1;

		if (controls.DOWN_P)
			curSelected += 1;

		if (curSelected < 0)
			curSelected = textMenuItems.length - 1;

		if (curSelected >= textMenuItems.length)
			curSelected = 0;

		grpCharsDebugs.forEach(function(txt:FlxText)
		{
			txt.color = FlxColor.WHITE;

			if (txt.ID == curSelected)
				txt.color = FlxColor.YELLOW;
		});

		if (controls.ACCEPT)
		{
			switch (textMenuItems[curSelected])
			{
				// 'Character Debug', 'Character Options', 'Animation Debug', 'Exit'
				case "Character Debug":
					FlxG.switchState(new MainMenuState()); // MainMenuState for now, till i get substates & crap
				case "Character Options":
						FlxG.switchState(new MainMenuState()); // MainMenuState for now, till i get substates & crap
				case "Animation Debug":
						FlxG.switchState(new AnimationDebug());
						// figure this shit out later AnimationDebug.daAnim = 'dad';
						AnimationDebug.isDad = true;
				case "Exit":
							FlxG.switchState(new MainMenuState());
			}
		}
	}
}