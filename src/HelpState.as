package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Kyrill Dingelstad
	 */
	public class HelpState extends FlxState
	{
		[Embed(source = "assets/controls.PNG")] private var controlls:Class;
		[Embed(source='assets/menuNavigation.png')]
		private var _menuNavigation:Class;
		[Embed(source='assets/menuNavigation2.png')]
		private var _menuNavigation2:Class;
		
		private var level:int;
		private var p1character:int;
		private var p2character:int;
		
		private var instructions:FlxSprite = new FlxSprite((400 / 2) - (202 / 2), 50, controlls);
		
		public function HelpState() {
		}
		override public function create():void 
		{
			add(instructions);
			
			super.create();
		}
		override public function update():void 
		{
			if (FlxG.keys.justPressed("ESCAPE") || FlxG.keys.justPressed("BACKSPACE"))
			{
				FlxG.switchState(new MenuState);
			}
			super.update();
		}
	}

}