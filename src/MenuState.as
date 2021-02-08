package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author ph
	 */
	public class MenuState extends FlxState
	{
		[Embed(source = "assets/Menu.mp3")] private var _menuSound:Class;
		[Embed(source = 'assets/startButton.png')] private var _startButton:Class;
		[Embed(source = 'assets/instructions.PNG')] private var _instructionsButton:Class;
		[Embed(source = 'assets/credits.PNG')] private var _creditsButton:Class;
		[Embed(source = 'assets/menuNavigation.png')] private var _menuNavigation:Class;
		[Embed(source = 'assets/menuNavigation2.png')] private var _menuNavigation2:Class;
		[Embed(source = 'assets/logoFrog.PNG')] private var _logoFrog:Class;
		
			
		private var _start:FlxSprite = new FlxSprite(0,0,_startButton);
		private var _instructions:FlxSprite = new FlxSprite(0, 0, _instructionsButton);
		private var _credits:FlxSprite = new FlxSprite(0, 0, _creditsButton);
		private var _navigation:FlxSprite = new FlxSprite(0, 0, _menuNavigation);
		private var _navigation2:FlxSprite = new FlxSprite(0, 0, _menuNavigation2);
		private var _logo:FlxSprite = new FlxSprite(0, 0, _logoFrog);
		
		private var _menuPosition:int = 1;
		private var _timer:Number = 0;
		
		public function MenuState()
		{
			
		}
		
		override public function create():void 
		{
			FlxG.playMusic(_menuSound);
			_start.x = 200 - _start.width/2;
			_start.y = 125;
			
			_instructions.x = 200 - _instructions.width / 2;
			_instructions.y = 175;
			
			_credits.x = 200 - _credits.width / 2;
			_credits.y = 225;
			
			_navigation.x = 200 - _start.width - _navigation.width+ 40;
			_navigation.y = _start.y + _navigation.height / 2;
			
			_navigation2.x = 200 + _start.width - 40;
			_navigation2.y = _start.y +_navigation2.height / 2;
			
			_logo.x = 200 - _logo.width / 2;
			_logo.y = 5;
			
	
			
			add(_logo);
			add(_start);
			add(_instructions);
			add(_credits);
			add(_navigation);
			add(_navigation2);
			
			super.create();
		}
		
		override public function update():void 
		{ 
			_timer += FlxG.elapsed;
		
			if (_menuPosition == 1)
			{
				_navigation.y = _start.y + _navigation.height / 2;
				_navigation2.y = _start.y + _navigation.height / 2 ;
				
			}
			
			if (_menuPosition == 2)
			{
				_menuNavigation.x += 5;
				_navigation.y = _instructions.y + _navigation.height/ 2;
				_navigation2.y = _instructions.y + _navigation2.height / 2 ;
			}
			
			if (_menuPosition == 3)
			{
				_menuNavigation.x += 5;
				_navigation.y = _credits.y + _navigation.height/ 2;
				_navigation2.y = _credits.y + _navigation2.height / 2 ;
			}
			
			if (FlxG.keys.justPressed("DOWN"))
			{
				_timer = 0.5;
				_menuPosition += 1;
			}
			
			if (FlxG.keys.justPressed("UP"))
			{
				_timer = 0.5;
				_menuPosition -= 1;
			}
			if (_menuPosition >= 3)
			{
				_menuPosition = 3;
			}
			
			if (_menuPosition <= 1)
			{
				_menuPosition = 1;
			}
			
			if (FlxG.keys.justPressed("ENTER")&& _menuPosition == 1 || FlxG.keys.justPressed("SPACE")&& _menuPosition == 1)
			{
				FlxG.switchState(new LevelState);
			}
			
			if (FlxG.keys.justPressed("ENTER")&& _menuPosition == 2 || FlxG.keys.justPressed("SPACE") && _menuPosition == 2)
			{
				FlxG.switchState(new HelpState);
			}
			
			if (FlxG.keys.justPressed("ENTER")&& _menuPosition == 3 || FlxG.keys.justPressed("SPACE") && _menuPosition == 3)
			{
				FlxG.switchState(new Credits);
				FlxG.music.stop();
			}
			if (_timer <= 0.4)
			{
				_navigation2.x = 200 + _start.width - 40;
				_navigation.x = 200 - _start.width - _navigation.width+ 40;
			}
			
				if (_timer >= 0.4 && _timer <= 0.8)
			{
				_navigation2.x = 200 + _start.width - 65;
				_navigation.x = 200 - _start.width - _navigation.width+ 65;
			}
			
			if (_timer >= 0.8)
			{
				_timer = 0;
			}
			
			super.update();
		}
	}

}