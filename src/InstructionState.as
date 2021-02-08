package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Kyrill Dingelstad
	 */
	public class InstructionState extends FlxState
	{
		[Embed(source = "assets/controls.PNG")] private var controlls:Class;
		[Embed(source='assets/menuNavigation.png')]
		private var _menuNavigation:Class;
		[Embed(source='assets/menuNavigation2.png')]
		private var _menuNavigation2:Class;
		[Embed(source="assets/keuze green.PNG")] private var _playerGraphic1:Class;
		[Embed(source="assets/keuze brown.PNG")] private var _playerGraphic2:Class;
		[Embed(source="assets/keuze blauw.PNG")] private var _playerGraphic3:Class;
		[Embed(source="assets/keuze gray.PNG")] private var _playerGraphic4:Class;
		[Embed(source="assets/keuze pink.PNG")] private var _playerGraphic5:Class;
		[Embed(source="assets/keuze red.PNG")] private var _playerGraphic6:Class;
		[Embed(source="assets/keuze skyblue.PNG")] private var _playerGraphic7:Class;
		[Embed(source = "assets/keuze yellow.PNG")] private var _playerGraphic8:Class;
		
		private var level:int;
		private var p1character:int;
		private var p2character:int;
		
		private var player1:FlxSprite;
		private var player2:FlxSprite;
		private var p1ready:Boolean = false;
		private var p2ready:Boolean = false;
		private var player1ready:FlxText;
		private var player2ready:FlxText;
		
		private var instructions:FlxSprite = new FlxSprite((400 / 2) - (202 / 2), 50, controlls);
		
		private var _navigation:FlxSprite = new FlxSprite(0, 0, _menuNavigation);
		private var _navigation2:FlxSprite = new FlxSprite(0, 0, _menuNavigation2);
		
		private var _nav2igation:FlxSprite = new FlxSprite(0, 0, _menuNavigation);
		private var _nav2igation2:FlxSprite = new FlxSprite(0, 0, _menuNavigation2);
		
		private var instruct:FlxText = new FlxText(0, 220, 400, "Shoot to ready");
		
		public function InstructionState(lvl:int = 5, p1char:int = 1, p2char:int = 3) 
		{
			level = lvl;
			p1character = p1char;
			p2character = p2char;
		}
		override public function create():void 
		{
			add(instructions);
			switch (p1character) {
				case 1:
					player1 = new FlxSprite(300 - (32 / 2), 230, _playerGraphic1);
					break;
				case 2:
					player1 = new FlxSprite(300 - (32 / 2), 230, _playerGraphic2);
					break;
				case 3:
					player1 = new FlxSprite(300 - (32 / 2), 230, _playerGraphic3);
					break;
				case 4:
					player1 = new FlxSprite(300 - (32 / 2), 230, _playerGraphic4);
					break;
				case 5:
					player1 = new FlxSprite(300 - (32 / 2), 230, _playerGraphic5);
					break;
				case 6:
					player1 = new FlxSprite(300 - (32 / 2), 230, _playerGraphic6);
					break;
				case 7:
					player1 = new FlxSprite(300 - (32 / 2), 230, _playerGraphic7);
					break;
				case 8:
					player1 = new FlxSprite(300 - (32 / 2), 230, _playerGraphic8);
					break;
			}
			switch (p2character) {
				case 1:
					player2 = new FlxSprite(100 - (32 / 2), 230, _playerGraphic1);
					break;
				case 2:
					player2 = new FlxSprite(100 - (32 / 2), 230, _playerGraphic2);
					break;
				case 3:
					player2 = new FlxSprite(100 - (32 / 2), 230, _playerGraphic3);
					break;
				case 4:
					player2 = new FlxSprite(100 - (32 / 2), 230, _playerGraphic4);
					break;
				case 5:
					player2 = new FlxSprite(100 - (32 / 2), 230, _playerGraphic5);
					break;
				case 6:
					player2 = new FlxSprite(100 - (32 / 2), 230, _playerGraphic6);
					break;
				case 7:
					player2 = new FlxSprite(100 - (32 / 2), 230, _playerGraphic7);
					break;
				case 8:
					player2 = new FlxSprite(100 - (32 / 2), 230, _playerGraphic8);
					break;
			}
			add(player1);
			add(player2);
			
			player1ready = new FlxText(200, 270, 200, "Ready");
			player1ready.alignment = "center";
			add(player1ready);
			player2ready = new FlxText(0, 270, 200, "Ready");
			player2ready.alignment = "center";
			add(player2ready);
			
			_navigation.x = 300 - 90 - _navigation.width + 65;
			_navigation.y = player1ready.y;
			_navigation2.x = 300 + 90 - 65;
			_navigation2.y = player1ready.y;
			add(_navigation);
			add(_navigation2);
			
			_nav2igation.x = 100 - 90 - _nav2igation.width + 65;
			_nav2igation.y = player2ready.y;
			_nav2igation2.x = 100 + 90 - 65;
			_nav2igation2.y = player2ready.y;
			add(_nav2igation);
			add(_nav2igation2);
			
			_navigation.visible = _navigation2.visible = _nav2igation.visible = _nav2igation2.visible = player1ready.visible = player2ready.visible = false;
			
			instruct.alignment = "center";
			add(instruct);
			
			super.create();
		}
		override public function update():void 
		{
			if (FlxG.keys.justPressed("SLASH")) {
				if (p1ready) {
					_navigation.visible = _navigation2.visible = player1ready.visible = p1ready = false;
				} else {
					_navigation.visible = _navigation2.visible = player1ready.visible = p1ready = true;
				}
			}
			if (FlxG.keys.justPressed("SPACE")) {
				if (p2ready) {
					_nav2igation.visible = _nav2igation2.visible = player2ready.visible = p2ready = false;
				} else {
					_nav2igation.visible = _nav2igation2.visible = player2ready.visible = p2ready = true;
				}
			}
			
			if (p1ready && p2ready)
			{
				FlxG.switchState(new PlayState(level, p1character, p2character));
			}
			
			if (FlxG.keys.justPressed("ESCAPE") || FlxG.keys.justPressed("BACKSPACE"))
			{
				FlxG.switchState(new CharacterState(level));
			}
			super.update();
		}
	}

}