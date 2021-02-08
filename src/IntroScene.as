package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author ph
	 */
	public class IntroScene extends FlxState
	{
		[Embed(source = 'assets/logo.PNG')] private var _logoIntro:Class;
		[Embed(source = 'assets/Intro.mp3')] private var _musicIntro:Class;
		
		private var _logo:FlxSprite = new FlxSprite(0, 0, _logoIntro);
		private var _timer:Number = 0;
		
		
		public function IntroScene() 
		{
			_logo.loadGraphic(_logoIntro, true, false, 128, 128, false);
			_logo.addAnimation("logo", [0, 1, 2, 3], 8, true);
			_logo.x = 200 - _logo.width / 2;
			_logo.y = 160 - _logo.height / 2;
			_logo.alpha = 0;
			
		}
		override public function create():void 
		{
			add(_logo);
			_logo.play("logo");
			FlxG.playMusic(_musicIntro);
			super.create();
		}
		override public function update():void 
		{
			_timer += FlxG.elapsed;
			_logo.alpha += 0.003;
			
			if (FlxG.keys.justPressed("SPACE") ||FlxG.keys.justPressed("ENTER") || _timer >= 7)
			{
				FlxG.music.stop();
				FlxG.switchState(new MenuState);
			}
			super.update();
		}
		
	}

}