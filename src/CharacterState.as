package
{
	import flash.geom.Point;
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Steven
	 */
	public class CharacterState extends FlxState
	{
		[Embed(source="assets/Menu.mp3")]
		private var _menuSound:Class;
		
		[Embed(source="assets/keuze green.PNG")]
		private var char1:Class;
		[Embed(source="assets/keuze brown.PNG")]
		private var char2:Class;
		[Embed(source="assets/keuze blauw.PNG")]
		private var char3:Class;
		[Embed(source="assets/keuze gray.PNG")]
		private var char4:Class;
		[Embed(source="assets/keuze pink.PNG")]
		private var char5:Class;
		[Embed(source="assets/keuze red.PNG")]
		private var char6:Class;
		[Embed(source="assets/keuze skyblue.PNG")]
		private var char7:Class;
		[Embed(source="assets/keuze yellow.PNG")]
		private var char8:Class;
		
		[Embed(source="assets/p1.PNG")]
		private var _p1:Class;
		[Embed(source="assets/p2.PNG")]
		private var _p2:Class;
		
		[Embed(source='assets/startButton.png')]
		private var _startButton:Class;
		[Embed(source='assets/menuNavigation.png')]
		private var _menuNavigation:Class;
		[Embed(source='assets/menuNavigation2.png')]
		private var _menuNavigation2:Class;
		
		private var p1character:int = 1;
		private var p2character:int = 2;
		private var player1:FlxSprite;
		private var player2:FlxSprite;
		private var img_char1:FlxSprite;
		private var img_char2:FlxSprite;
		private var img_char3:FlxSprite;
		private var img_char4:FlxSprite;
		private var img_char5:FlxSprite;
		private var img_char6:FlxSprite;
		private var img_char7:FlxSprite;
		private var img_char8:FlxSprite;
		private var p1:FlxSprite;
		private var p2:FlxSprite;
		private var startpoint:Point = new Point(130, 100);
		
		private var _start:FlxSprite = new FlxSprite(0, 0, _startButton);
		private var _navigation:FlxSprite = new FlxSprite(0, 0, _menuNavigation);
		private var _navigation2:FlxSprite = new FlxSprite(0, 0, _menuNavigation2);
		private var _timer:Number = 0;
		
		private var instructions:FlxText;
		
		private var level:int;
		
		public function CharacterState(lvl:int)
		{
			level = lvl;
		}
		
		override public function create():void
		{
			
			
			img_char1 = new FlxSprite(startpoint.x, startpoint.y, char1);
			add(img_char1);
			img_char2 = new FlxSprite(startpoint.x + 36, startpoint.y, char2);
			add(img_char2);
			img_char3 = new FlxSprite(startpoint.x + 72, startpoint.y, char3);
			add(img_char3);
			img_char4 = new FlxSprite(startpoint.x + 108, startpoint.y, char4);
			add(img_char4);
			img_char5 = new FlxSprite(startpoint.x, startpoint.y + 40, char5);
			add(img_char5);
			img_char6 = new FlxSprite(startpoint.x + 36, startpoint.y + 40, char6);
			add(img_char6);
			img_char7 = new FlxSprite(startpoint.x + 72, startpoint.y + 40, char7);
			add(img_char7);
			img_char8 = new FlxSprite(startpoint.x + 108, startpoint.y + 40, char8);
			add(img_char8);
			
			p1 = new FlxSprite(0, 0, _p1);
			add(p1);
			p2 = new FlxSprite(0, 0, _p2);
			add(p2);
			
			player1 = new FlxSprite(startpoint.x - 32, 20, char1);
			add(player1);
			add(new FlxText(player1.x + 32 + 5, player1.y + 10, 100, "Player 1"));
			player2 = new FlxSprite(startpoint.x + 140, 20, char2);
			add(player2);
			var i:FlxText;
			add(i = new FlxText(player2.x - 100 - 5, player2.y + 10, 100, "Player 2"));
			i.alignment = "right";
			
			_start.x = 200 - _start.width / 2;
			_start.y = 250;
			_navigation.x = 200 - _start.width - _navigation.width + 40;
			_navigation.y = _start.y + _navigation.height / 2;
			_navigation2.x = 200 + _start.width - 40;
			_navigation2.y = _start.y + _navigation2.height / 2;
			add(_start);
			add(_navigation);
			add(_navigation2);
			
			instructions = new FlxText(0, 205, 400, "Press WASD or use the arrow keys to change character");
			instructions.alignment = "center";
			add(instructions);
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

if (FlxG.keys.justPressed("ESCAPE") || FlxG.keys.justPressed("BACKSPACE"))
			{
				FlxG.switchState(new LevelState);
			}

			if (FlxG.keys.justPressed("ENTER")||FlxG.keys.justPressed("SPACE"))
			{
				FlxG.switchState(new InstructionState(level, p1character, p2character));
			}
			
			if (FlxG.keys.justPressed("RIGHT"))
			{
				if (p1character < 8)
				{
					if (p2character != p1character + 1)
					{
						p1character++;
					}
					else
					{
						if (p1character < 7)
						{
							p1character += 2;
						}
						else
						{
							p1character = 1;
						}
					}
				}
				else
				{
					if (p2character == 1)
					{
						p1character = 2;
					}
					else
					{
						p1character = 1;
					}
				}
			}
			if (FlxG.keys.justPressed("LEFT"))
			{
				if (p1character > 1)
				{
					if (p1character - 1 != p2character)
					{
						p1character--;
					}
					else
					{
						if (p1character > 2)
						{
							p1character -= 2;
						}
						else
						{
							p1character = 8;
						}
					}
				}
				else
				{
					if (p2character != 8)
					{
						p1character = 8;
					}
					else
					{
						p1character = 7;
					}
				}
			}
			if (FlxG.keys.justPressed("DOWN"))
			{
				if (p2character != p1character + 4 && p1character <= 4)
				{
					p1character += 4;
				}
			}
			if (FlxG.keys.justPressed("UP"))
			{
				if (p2character != p1character - 4 && p1character > 4)
				{
					p1character -= 4;
				}
			}
			if (FlxG.keys.justPressed("D"))
			{
				if (p2character < 8)
				{
					if (p1character != p2character + 1)
					{
						p2character++;
					}
					else
					{
						if (p2character < 7)
						{
							p2character += 2;
						}
						else
						{
							p2character = 1;
						}
					}
				}
				else
				{
					if (p1character == 1)
					{
						p2character = 2;
					}
					else
					{
						p2character = 1;
					}
				}
			}
			
			if (FlxG.keys.justPressed("A"))
			{
				if (p2character > 1)
				{
					if (p2character - 1 != p1character)
					{
						p2character--;
					}
					else
					{
						if (p2character > 2)
						{
							p2character -= 2;
						}
						else
						{
							p2character = 8;
						}
					}
				}
				else
				{
					if (p1character != 8)
					{
						p2character = 8;
					}
					else
					{
						p2character = 7;
					}
				}
			}
			if (FlxG.keys.justPressed("S"))
			{
				if (p1character != p2character + 4 && p2character <= 4)
				{
					p2character += 4;
				}
			}
			if (FlxG.keys.justPressed("W"))
			{
				if (p1character != p2character - 4 && p2character > 4)
				{
					p2character -= 4;
				}
			}
			switch (p1character)
			{
				case 1: 
					player1.loadGraphic(char1);
					break;
				case 2:
					player1.loadGraphic(char2);
					break;
				case 3:
					player1.loadGraphic(char3); 
					break;
				case 4: 
					player1.loadGraphic(char4);
					break;
				case 5: 
					player1.loadGraphic(char5);
					break;
				case 6: 
					player1.loadGraphic(char6);
					break;
				case 7: 
					player1.loadGraphic(char7);
					break;
				case 8: 
					player1.loadGraphic(char8);
					break;
				default: 
					player1.loadGraphic(char1);
			}
			switch (p2character)
			{
				case 1: 
					player2.loadGraphic(char1);
					break;
				case 2:
					player2.loadGraphic(char2);
					break;
				case 3:
					player2.loadGraphic(char3); 
					break;
				case 4: 
					player2.loadGraphic(char4);
					break;
				case 5: 
					player2.loadGraphic(char5);
					break;
				case 6: 
					player2.loadGraphic(char6);
					break;
				case 7: 
					player2.loadGraphic(char7);
					break;
				case 8: 
					player2.loadGraphic(char8);
					break;
				default: 
					player2.loadGraphic(char1);
			}
			
			if (p1character <= 4)
			{
				p1.x = startpoint.x + (36 * (p1character - 1)) + 3;
				p1.y = startpoint.y + 3;
			}
			else
			{
				p1.x = startpoint.x + (36 * (p1character - 5)) + 3;
				p1.y = startpoint.y + 40 + 3;
			}
			if (p2character <= 4)
			{
				p2.x = startpoint.x + (36 * (p2character - 1)) + 3;
				p2.y = startpoint.y + 3;
			}
			else
			{
				p2.x = startpoint.x + (36 * (p2character - 5)) + 3;
				p2.y = startpoint.y + 40 + 3;
			}
			if (FlxG.keys.justPressed("ESCAPE"))
			{
				FlxG.switchState(new MenuState());
			}
			super.update();
		}
	}

}