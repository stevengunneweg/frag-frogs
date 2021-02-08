package
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Steven
	 */
	public class LevelState extends FlxState
	{
		[Embed(source="assets/Menu.mp3")]
		private var _menuSound:Class;
		
		[Embed(source="assets/pijl.PNG")]
		private var _arrow:Class;
		[Embed(source='assets/startButton.png')]
		private var _startButton:Class;
		[Embed(source='assets/menuNavigation.png')]
		private var _menuNavigation:Class;
		[Embed(source='assets/menuNavigation2.png')]
		private var _menuNavigation2:Class;
		
		[Embed(source="assets/mapje2.txt",mimeType="application/octet-stream")]
		private var lvl1:Class;
		[Embed(source="assets/mapje5.txt",mimeType="application/octet-stream")]
		private var lvl2:Class;
		[Embed(source="assets/mapje8.txt",mimeType="application/octet-stream")]
		private var lvl3:Class;/*
		[Embed(source="assets/mapje4.txt",mimeType="application/octet-stream")]
		private var lvl4:Class;
		[Embed(source="assets/mapje5.txt",mimeType="application/octet-stream")]
		private var lvl5:Class;
		[Embed(source="assets/mapje6.txt",mimeType="application/octet-stream")]
		private var lvl6:Class;
		[Embed(source="assets/mapje7.txt",mimeType="application/octet-stream")]
		private var lvl7:Class;
		[Embed(source="assets/mapje8.txt",mimeType="application/octet-stream")]
		private var lvl8:Class;
		[Embed(source="assets/mapje9.txt",mimeType="application/octet-stream")]
		private var lvl9:Class;
		[Embed(source="assets/mapje10.txt",mimeType="application/octet-stream")]
		private var lvl10:Class;*/
		[Embed(source="assets/tilemapSmall.png")]
		private var tilesetClass:Class;
		
		private var level:int = 1;
		private var _tilemap:FlxTilemap;
		
		private var arrowLeft:FlxSprite;
		private var arrowRight:FlxSprite;
		
		private var _start:FlxSprite = new FlxSprite(0, 0, _startButton);
		private var _navigation:FlxSprite = new FlxSprite(0, 0, _menuNavigation);
		private var _navigation2:FlxSprite = new FlxSprite(0, 0, _menuNavigation2);
		private var _timer:Number = 0;
		
		private var instructions:FlxText;
		
		public function LevelState()
		{
		
		}
		
		override public function create():void
		{
			_tilemap = new FlxTilemap();
			_tilemap.loadMap(new lvl1, tilesetClass, 10, 10);
			_tilemap.x = 75;
			_tilemap.y = 20;
			add(_tilemap);
			
			arrowLeft = new FlxSprite(-10, 65);
			arrowRight = new FlxSprite(315, 65);
			arrowLeft.loadRotatedGraphic(_arrow, 2);
			arrowRight.loadRotatedGraphic(_arrow, 2);
			arrowLeft.scale.x = arrowRight.scale.x = 0.5;
			arrowLeft.angle = 180;
			add(arrowLeft);
			add(arrowRight);
			
			_start.x = 200 - _start.width / 2;
			_start.y = 250;
			_navigation.x = 200 - _start.width - _navigation.width + 40;
			_navigation.y = _start.y + _navigation.height / 2;
			_navigation2.x = 200 + _start.width - 40;
			_navigation2.y = _start.y + _navigation2.height / 2;
			add(_start);
			add(_navigation);
			add(_navigation2);
			
			instructions = new FlxText(0, 205, 400, "Press A/Left or D/Right to change map");
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
				FlxG.switchState(new MenuState);
			}

			if (FlxG.keys.justPressed("ENTER")||FlxG.keys.justPressed("SPACE"))
			{
				FlxG.switchState(new CharacterState(level));
			}
			
			switch (level)
			{
				case 1: 
					_tilemap.loadMap(new lvl1, tilesetClass, 10, 10);
					break;
				case 2: 
					_tilemap.loadMap(new lvl2, tilesetClass, 10, 10);
					break;
				case 3: 
					_tilemap.loadMap(new lvl3, tilesetClass, 10, 10);
					break;
				/*case 4: 
					_tilemap.loadMap(new lvl4, tilesetClass, 10, 10);
					break;
				case 5: 
					_tilemap.loadMap(new lvl5, tilesetClass, 10, 10);
					break;
				case 6: 
					_tilemap.loadMap(new lvl6, tilesetClass, 10, 10);
					break;
				case 7: 
					_tilemap.loadMap(new lvl7, tilesetClass, 10, 10);
					break;
				case 8: 
					_tilemap.loadMap(new lvl8, tilesetClass, 10, 10);
					break;
				case 9: 
					_tilemap.loadMap(new lvl9, tilesetClass, 10, 10);
					break;
				case 10: 
					_tilemap.loadMap(new lvl10, tilesetClass, 10, 10);
					break;*/
			}
			if (FlxG.keys.justPressed("D") || FlxG.keys.justPressed("RIGHT"))
			{
				if (level < 3)
				{
					level++;
				}
				else
				{
					level = 1;
				}
			}
			if ((FlxG.keys.justPressed("A") || FlxG.keys.justPressed("LEFT")))
			{
				if (level > 1)
				{
					level--;
				}
				else
				{
					level = 3;
				}
			}
			if (FlxG.keys.justPressed("ESCAPE"))
			{
				FlxG.switchState(new MenuState());
			}
			super.update();
		}
	}

}