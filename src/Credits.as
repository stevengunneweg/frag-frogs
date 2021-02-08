package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author ph
	 */
	public class Credits extends FlxState
	{
		[Embed(source = "assets/Credits.mp3")] private var _creditsSND:Class;
		[Embed(source = 'assets/creditsEnd.PNG')] private var _creditsIMG:Class;
		
		private var _credits:FlxSprite = new FlxSprite(0, 0, _creditsIMG);
		private var _timer:Number = 0;
		private var _timer2:Number = 0;
		
			
		public function Credits() 
		{	
			
			
		}
		
		override public function create():void 
		{
			_credits.x = 200 - _credits.width / 2;
			_credits.y = 595;
			_credits.scale.x = 2.2;
			_credits.scale.y = 2.2;
			FlxG.playMusic(_creditsSND);
			add(_credits);
			super.create();
		}
		override public function update():void 
		{
			_timer += FlxG.elapsed;
			trace(_timer);
			
			if (_timer <= 39)
			{
				_credits.y -= 0.7;
			}
			
			if (_timer >= 41)
			{
				FlxG.switchState(new MenuState);
			}
		if (FlxG.keys.justPressed("ESCAPE") || FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("BACKSPACE"))
			{
				FlxG.switchState(new MenuState());
			}
			super.update();
		}
		
	}

}