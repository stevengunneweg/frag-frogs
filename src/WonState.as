package  
{
	import flash.accessibility.Accessibility;
	
	import org.flixel.*;
	/**
	 * ...
	 * @author Kyrill Dingelstad
	 */
	public class WonState extends FlxState
	{
		[Embed(source = "assets/player.png")] private var _playerGraphic1:Class;
		[Embed(source = "assets/player brown.png")] private var _playerGraphic2:Class;
		[Embed(source = "assets/player blue.png")] private var _playerGraphic3:Class;
		[Embed(source = "assets/player gray.png")] private var _playerGraphic4:Class;
		[Embed(source = "assets/player pink.png")] private var _playerGraphic5:Class;
		[Embed(source = "assets/player red.png")] private var _playerGraphic6:Class;
		[Embed(source = "assets/player skyblue.png")] private var _playerGraphic7:Class;
		[Embed(source = "assets/player yellow.png")] private var _playerGraphic8:Class;
		
		[Embed(source='assets/continue.png')]
		private var _startButton:Class;
		[Embed(source='assets/menuNavigation.png')]
		private var _menuNavigation:Class;
		[Embed(source='assets/menuNavigation2.png')]
		private var _menuNavigation2:Class;
		
		[Embed(source='assets/part-red.png')]
		private var part_red:Class;
		
		[Embed(source='assets/part-blue.png')]
		private var part_blue:Class;
		
		[Embed(source='assets/part-yellow.png')]
		private var part_yellow:Class;
		
		[Embed(source='assets/Wiener.mp3')]
		private var winMusic:Class;
		
		private var winner:Boolean;
		private var score:int;
		private var winnertext:FlxText;
		
		private var _start:FlxSprite = new FlxSprite(0, 0, _startButton);
		private var _navigation:FlxSprite = new FlxSprite(0, 0, _menuNavigation);
		private var _navigation2:FlxSprite = new FlxSprite(0, 0, _menuNavigation2);
		private var _timer:Number = 0;
		
		private var _emitter1:FlxEmitter;
		private var _emitter2:FlxEmitter;
		private var _emitter3:FlxEmitter;
		
		private var _player:int;
		private var _playerSprite:FlxSprite;
		
		public function WonState(player:int) 
		{
			FlxG.paused = false;
			_player = player;
			FlxG.music.loadEmbedded(winMusic);
			FlxG.music.play(true);
		}
		override public function create():void 
		{
			_playerSprite = new FlxSprite();
			
			switch (_player) {
				case 1:
					_playerSprite.loadGraphic(_playerGraphic1, true, false, 16, 16, false);
					break;
				case 2:
					_playerSprite.loadGraphic(_playerGraphic2, true, false, 16, 16, false);
					break;
				case 3:
					_playerSprite.loadGraphic(_playerGraphic3, true, false, 16, 16, false);
					break;
				case 4:
					_playerSprite.loadGraphic(_playerGraphic4, true, false, 16, 16, false);
					break;
				case 5:
					_playerSprite.loadGraphic(_playerGraphic5, true, false, 16, 16, false);
					break;
				case 6:
					_playerSprite.loadGraphic(_playerGraphic6, true, false, 16, 16, false);
					break;
				case 7:
					_playerSprite.loadGraphic(_playerGraphic7, true, false, 16, 16, false);
					break;
				case 8:
					_playerSprite.loadGraphic(_playerGraphic8, true, false, 16, 16, false);
					break;
				default:
					_playerSprite.loadGraphic(_playerGraphic1, true, false, 16, 16, false);
					
			}
			
			_playerSprite.angle = 180;
			_playerSprite.scale.x = 4;
			_playerSprite.scale.y = 4;
			_playerSprite.x = 400 / 2;
			_playerSprite.y = 100;
			
			winnertext = new FlxText(0, 200, 400, "You won the game!");
			
			winnertext.alignment = "center";
			winnertext.setFormat(null, 24);
			add(winnertext);
			
			_emitter1 = new FlxEmitter(200, 0, 50);
			_emitter1.makeParticles(part_red, 50, 16);
			_emitter1.gravity = 500;
			_emitter1.start(false);
			
			_emitter2 = new FlxEmitter(200, 0, 50);
			_emitter2.makeParticles(part_blue, 50, 16);
			_emitter2.gravity = 500;
			_emitter2.start(false);
			
			_emitter3 = new FlxEmitter(200, 0, 50);
			_emitter3.makeParticles(part_yellow, 50, 16);
			_emitter3.gravity = 500;
			_emitter3.start(false);
			
			_start.x = 200 - _start.width / 2;
			_start.y = 250;
			_navigation.x = 200 - _start.width - _navigation.width + 40;
			_navigation.y = _start.y + _navigation.height / 2;
			_navigation2.x = 200 + _start.width - 40;
			_navigation2.y = _start.y + _navigation2.height / 2;
			add(_start);
			add(_navigation);
			add(_navigation2);
			
			add(_playerSprite);
			
			add(_emitter1);
			add(_emitter2);
			add(_emitter3);
			
			super.create();
		}
		override public function update():void 
		{
			_timer += FlxG.elapsed;
			_navigation.y = _start.y + _navigation.height / 2;
			_navigation2.y = _start.y + _navigation.height / 2;
			if (_timer <= 0.4)
			{
				_navigation2.x = 200 + _start.width - 40;
				_navigation.x = 200 - _start.width - _navigation.width + 40;
			}
			
			if (_timer >= 0.4 && _timer <= 0.8)
			{
				_navigation2.x = 200 + _start.width - 65;
				_navigation.x = 200 - _start.width - _navigation.width + 65;
			}
			if (_timer >= 0.8)
			{
				_timer = 0;
			}
			if (FlxG.keys.justPressed("ENTER")||FlxG.keys.justPressed("SPACE"))
			{
				FlxG.switchState(new MenuState());
			}
			super.update();
		}
	}

}