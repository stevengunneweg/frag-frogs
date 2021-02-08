package
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		[Embed(source="assets/mapje2.txt", mimeType="application/octet-stream")] private var mapClass2:Class;
		[Embed(source="assets/mapje5.txt", mimeType="application/octet-stream")] private var mapClass5:Class;
		[Embed(source="assets/mapje8.txt", mimeType="application/octet-stream")] private var mapClass8:Class;
		
		[Embed(source="assets/tilemap.png")] private var tilesetClass:Class;
		[Embed(source="assets/bg.png")] private var bgClass:Class;
		
		[Embed(source = 'assets/coin.mp3')] private var coinSound:Class;
		[Embed(source = 'assets/Geneesmiddel Oppakken.mp3')] private var tonquePickupSound:Class;
		[Embed(source = 'assets/Speler Oppeuzelen.mp3')] private var eatPlayerSound:Class;
		[Embed(source = 'assets/In-game (harder).mp3')] private var backgrounMusic:Class;
		
		[Embed(source = 'assets/dash.mp3')] private var dashSound:Class;
		[Embed(source = 'assets/die.mp3')] private var dieSound:Class;
		[Embed(source = 'assets/win.mp3')] private var winSound:Class;
		
		[Embed(source = "assets/blaatjeparticle.png")] private var particleClass:Class;
		
		[Embed(source = "assets/acid.png")] private var acidClass:Class;
		
		public static const TILEWIDTH:int = 16;
		public static const TILEHEIGHT:int = 16 ;
		
		private var _bg:FlxSprite;
		private var widthTiles:int = 25;
		private var heightTiles:int = 18;
		private var tileMapTiles:int = widthTiles * heightTiles;
		private var spawnTimeCure:Number = 4;
		private var cureTaken:Boolean = true;
		private var cureInt:int = 0;
		private var randomSpawnCureNumber:Number = Math.round(Math.random() * 15);
		
		public var _player1:Player;
		public var _player2:Player;
		public var player1score:int = 0;
		public var player2score:int = 0;
		private var _tilemap:FlxTilemap;
		private var _breakableTile:BreakableTile = new BreakableTile();
		
		private var _players:FlxGroup;
		private var _blocks:FlxGroup;
		private var _cures:FlxGroup;
		private var _coins:FlxGroup;
		private var _breakableTile_Group:FlxGroup = new FlxGroup();
		
		private var breakableTile:Array = new Array();
		private var walls:Array = new Array();
		private var walkable:Array = new Array(tileMapTiles);
		
		public var cure:Cure;
		
		private var hud:HUD;
		
		private var level:int;
		private var p1character:int;
		private var p2character:int;
		
		private var powerup1:FlxSprite;
		private var powerup2:FlxSprite;

		public var winner:Player;
		public var winTimer:Number;
		
		public var countdown:Number;
		public var countdownBool:Boolean;
		
		public var rect:FlxSprite;
		public var cdText:FlxText;
		
		public function PlayState(lvl:int = 3, p1char:int = 1, p2char:int = 3)
		{
			FlxG.worldBounds = new FlxRect(0,0,400,321);
			FlxG.visualDebug = false;
			level = lvl;
			p1character = p1char;
			p2character = p2char;
			winTimer = 0;
			countdownBool = true;
			countdown = 0;
		}
		
		override public function create():void
		{	
			_bg = new FlxSprite(0, 0, bgClass);
			FlxG.playMusic(backgrounMusic, 0.7);
			
			_player1 = new Player(0, 0, 1, p1character);
			
			_player2 = new Player(0, 0, 2, p2character);
			
			this.hud = new HUD();
			
			_players = new FlxGroup();
			_blocks = new FlxGroup();
			_coins = new FlxGroup();
			_cures = new FlxGroup();
			
			powerup1 = new FlxSprite();
			powerup2 = new FlxSprite();
			
			powerup1.loadGraphic(acidClass, true, false, 25, 25);
			powerup2.loadGraphic(acidClass, true, false, 25, 25);
			
			powerup1.addAnimation("go", [0,1,2,1], 10);
			powerup2.addAnimation("go", [0,1,2,1], 10);
			powerup1.play("go");
			powerup2.play("go");
			
			_tilemap = new FlxTilemap();
			switch (level) {
				case 1:
					_tilemap.loadMap(new mapClass2, tilesetClass, 16, 16);
					break;
				case 2:
					_tilemap.loadMap(new mapClass5, tilesetClass, 16, 16);
					break;
				case 3:
					_tilemap.loadMap(new mapClass8, tilesetClass, 16, 16);
					break;
				default:
					_tilemap.loadMap(new mapClass2, tilesetClass, 16, 16);
			}
			
			for (var m:int = 0; m < tileMapTiles; m++)
			{
				walkable[m] = new Boolean;
				walkable[m] = true;
			}
			
			var breakableTile:Array = _tilemap.getTileCoords(2);
			
			for ( var j:int = 0; j < breakableTile.length; j++)
			{
				var tile:BreakableTile = new BreakableTile();
				var walkableInt:int = 0;
				tile = new BreakableTile();
				tile.x = breakableTile[j].x - 8;
				tile.y = breakableTile[j].y - 8;
				walkableInt += (tile.x / 16);
				walkableInt += (tile.y / 16) * widthTiles;
				walkable[walkableInt] = false;
				_tilemap.setTile(breakableTile[j].x / 16, breakableTile[j].y / 16, 0);
				_blocks.add(tile);
			}
			walls = _tilemap.getTileCoords(1);
			for (var k:int = 0; k < walls.length; k++)
			{
				var walkableInt2:int = 0;
				walkableInt2 += ((walls[k].x - 8) / 16);
				walkableInt2 += ((walls[k].y - 8) / 16) * widthTiles;
				walkable[walkableInt2] = false;
			}
			
			_player1.x = 368;
			_player1.y = 16;
			_player2.x = 16;
			_player2.y = 16;
			
			add(_bg);
			add(_tilemap);
			add(_breakableTile_Group);
			add(_blocks);
			add(_cures);
			add(_coins);
			add(powerup1);
			add(powerup2);
			_players.add(_player1);
			_players.add(_player2);
			add(_players);
			add(hud);
			
			this.rect = new FlxSprite();
			rect.makeGraphic(400, 320, 0xaa000000);
			
			cdText = new FlxText(0, 100, 400, "4");
			cdText.size = 64;
			cdText.alignment = "center";
			
			add(rect);
			add(cdText);
			
			FlxG.music.pause();
		}
		
		override public function update():void
		{
			if(countdownBool)
			{
				FlxG.paused = true;
				countdown += FlxG.elapsed;
				cdText.text = Math.round(3 - countdown) + "";
				
				if(Math.round(3-countdown) == 0)
				{
					cdText.text = "GO!";
				}
				
				if(countdown > 3)
				{
					countdownBool = false;
					FlxG.paused = false;
					FlxG.music.play(true);
					cdText.visible = false;
					rect.visible = false;
				}
			}
			
			if(winner != null)
			{
				winTimer += FlxG.elapsed;
				
				if(winTimer > 3)
					FlxG.switchState(new WonState(winner.playerColor));
			}
			
			FlxG.collide(_player1, _player2);
			FlxG.collide(_blocks, _players, bushCollide);
			FlxG.collide(_tilemap, _players);
			if (!_player1.tongue.retreating) {
				FlxG.collide(_player1.tongue, _tilemap, _player1.tongue.retreat);
			}
			if (!_player2.tongue.retreating) {
				FlxG.collide(_player2.tongue, _tilemap, _player2.tongue.retreat);
			}
			FlxG.overlap(_blocks, _player1.tongue, destroyblock);
			FlxG.overlap(_blocks, _player2.tongue, destroyblock);
			FlxG.collide(_cures, _players, cureplayer);
			
			FlxG.collide(_coins, _players, getCoin);
	
			if (_player1.combatwait)
			{
				FlxG.collide(_player1.tongue, _player2, eatplayer2);
			}
			if (_player2.combatwait)
			{
				FlxG.collide(_player2.tongue, _player1, eatplayer1);
			}
			
			
			if (FlxG.keys.justPressed("ENTER"))
			{
				FlxG.switchState(new PlayState(level, p1character, p2character));
			}
			if (FlxG.keys.justPressed("ESCAPE"))
			{
				FlxG.switchState(new MenuState());
			}
			
			// powerup on player
			powerup1.x = _player1.x - 5;
			powerup1.y = _player1.y - 5;
			
			powerup2.x = _player2.x - 5;
			powerup2.y = _player2.y - 5;
			
			if(_player1.tongueAvailable) 
				powerup1.visible = true;
			else
				powerup1.visible = false;
			
			if(_player2.tongueAvailable) 
				powerup2.visible = true;
			else
				powerup2.visible = false;
			
			super.update();
		}

		public function get blocks():FlxGroup
		{
			return _blocks;
		}
		
		public function bushCollide(bush:BreakableTile, player:Player):void
		{
			if(true)
			{
				if (bush.state == 3)
				{
					var number:int = Math.ceil(Math.random() * 28);
					
					switch (number) {
						case 1:
						spawnCure(bush.x, bush.y);
						break;
						case 4:
						spawnCure(bush.x, bush.y);
						break;
						case 5:
						spawnCoin(bush.x, bush.y);
						break;

						case 6:
							spawnCure(bush.x, bush.y);
							break;
						case 7:
							spawnCure(bush.x, bush.y);
							break;
						case 13:
						spawnCure(bush.x, bush.y);
						break;
						case 15:
						spawnCoin(bush.x, bush.y);
						break;
						case 16:
							spawnCoin(bush.x, bush.y);
							break;
						case 18:
						spawnCure(bush.x, bush.y);
						break;
					}
				}
				bush.destroy();
				
				var emitter:FlxEmitter = new FlxEmitter(bush.x, bush.y);
				emitter.makeParticles(particleClass, 5, 16);
				emitter.maxParticleSpeed = new FlxPoint(50,50);
				emitter.minParticleSpeed = new FlxPoint(-50,-50);
				add(emitter);
				emitter.start(true, 0.5);
				
				bush.destroy();
				
				if(player.facing == FlxObject.UP) player.y += 3;
				if(player.facing == FlxObject.DOWN) player.y -= 3;
				if(player.facing == FlxObject.LEFT) player.x += 3;
				if(player.facing == FlxObject.RIGHT) player.x -= 3;
				
				player.dash();
			}
			
		}
		
		public function getCoin(c:Coin, p:Player):void
		{
			if (p == _player1)
				player1score += 1;
			else if (p == _player2)
				player2score += 1;
			FlxG.play(coinSound);
			c.kill();
			if (player1score >= 10) {
				
				FlxG.music.stop();
				FlxG.paused = true;
				FlxG.play(winSound);
				winner = _player1;
				
			} else if(player2score >= 10) {
				FlxG.music.stop();
				FlxG.paused = true;
				FlxG.play(winSound);
				winner = _player2;
				
				}
		}

		public function eatplayer1(t:FlxSprite, p:Player):void {
			_player2.tongue.retreat();
			FlxG.play(dieSound);
			p.kill();
			p.tongue.kill();
			
			// run dropcoins function
			dropCoins(Math.ceil(player1score/5), _player1);
			
			player1score -= Math.ceil(player1score/5);
			newPlayer();
		}
		
		public function eatplayer2(t:FlxSprite, p:Player):void {
			_player1.tongue.retreat();
			FlxG.play(dieSound);
			p.kill();
			p.tongue.kill();
			
			// run dropcoins function
			dropCoins(Math.ceil(player2score/5), _player2);
			
			player2score -= Math.ceil(player2score/5);
			newPlayer2();
		}
		
		public function destroyblock(b:BreakableTile, t:FlxSprite):void {
			var emitter:FlxEmitter = new FlxEmitter(b.x, b.y);
			emitter.makeParticles(particleClass, 5, 16);
			emitter.maxParticleSpeed = new FlxPoint(50,50);
			emitter.minParticleSpeed = new FlxPoint(-50,-50);
			
			var number:int = Math.ceil(Math.random() * 30);
			
			switch (number) {
				case 1:
					spawnCure(b.x, b.y);
					break;
				case 4:
					spawnCure(b.x, b.y);
					break;
				case 5:
					spawnCoin(b.x, b.y);
					break;
				case 6:
					spawnCure(b.x, b.y);
					break;
				case 7:
					spawnCure(b.x, b.y);
					break;
				case 13:
					spawnCure(b.x, b.y);
					break;
				case 15:
					spawnCoin(b.x, b.y);
					break;
				case 16:
					spawnCoin(b.x, b.y);
					break;
				case 18:
					spawnCure(b.x, b.y);
					break;
			}
			
			add(emitter);
			emitter.start(true, 0.5);
			b.destroy();
		}
		
		private function dropCoins(count:int, player:Player):void
		{
			var points:Array = new Array();
			
			var currentTile:FlxPoint = new FlxPoint(player.x / 16, player.y / 16);
			
			if(_tilemap.getTile(currentTile.x + 1, currentTile.y - 1) != 1)
				points.push(new FlxPoint(currentTile.x + 1, currentTile.y - 1));
			
			if(_tilemap.getTile(currentTile.x - 1, currentTile.y) != 1)
				points.push(new FlxPoint(currentTile.x - 1, currentTile.y));
			
			if(_tilemap.getTile(currentTile.x + 1, currentTile.y) != 1)
				points.push(new FlxPoint(currentTile.x + 1, currentTile.y));
			
			if(_tilemap.getTile(currentTile.x, currentTile.y - 1) != 1)
				points.push(new FlxPoint(currentTile.x, currentTile.y - 1));
			
			points.push(currentTile);
			
			if(_tilemap.getTile(currentTile.x, currentTile.y + 1) != 1)
				points.push(new FlxPoint(currentTile.x, currentTile.y + 1));
			
			if(_tilemap.getTile(currentTile.x - 1, currentTile.y - 1) != 1)
				points.push(new FlxPoint(currentTile.x - 1, currentTile.y - 1));
			
			if(_tilemap.getTile(currentTile.x + 1, currentTile.y + 1) != 1)
				points.push(new FlxPoint(currentTile.x + 1, currentTile.y + 1));
			
			if(_tilemap.getTile(currentTile.x - 1, currentTile.y + 1) != 1)
				points.push(new FlxPoint(currentTile.x - 1, currentTile.y + 1));
			
			
			
			
			for(var i:int = 0; i < count; i++)
			{
				var coin:Coin = new Coin();
				coin.x = points[i].x * 16 + 1
				coin.y = points[i].y * 16 + 1;
				_coins.add(coin);
			}
		}

		public function cureplayer(c:Cure, p:Player):void 
		{
			FlxG.play(tonquePickupSound);
			c.kill();
			p.tongueAvailable = true;
		}
		
		private function spawnCure(x:int, y:int):void
		{
			var cure:Cure = new Cure();
			cure.x = x;
			cure.y = y;
			
			_cures.add(cure);
		}
		
		private function spawnCoin(x:int, y:int):void
		{
			var coin:Coin = new Coin();
			coin.x = x;
			coin.y = y;
			
			_coins.add(coin);
		}
		
		private function newPlayer():void
		{			
			var number:int = Math.round(Math.random() * 4);
			trace(number);
			switch (number) {
			case 1:
				_player1 = new Player(16, 16, 1, p1character);
				break;
			case 2:
				_player1 = new Player(368, 16, 1, p1character);
				break;
			case 3:
				_player1 = new Player(16, 256, 1, p1character);
				break;
			case 4:
				_player1 = new Player(368, 256, 1, p1character);
				break;
			default:
				_player1 = new Player(16, 16, 1, p1character);
			}
			_players.add(_player1);
			_player1.flicker(1);
		}
		private function newPlayer2():void
		{
			var number:int = Math.round(Math.random() * 4);
			switch (number) {
			case 1:
				_player2 = new Player(16, 16, 2, p2character);
				break;
			case 2:
				_player2 = new Player(368, 16, 2, p2character);
				break;
			case 3:
				_player2 = new Player(16, 256, 2, p2character);
				break;
			case 4:
				_player2 = new Player(368, 256, 2, p2character);
				break;
			default:
				_player2 = new Player(16, 16, 2, p2character);
			}
			_players.add(_player2);
			_player2.flicker(1);
		}
		public function get tilemap():FlxTilemap
		{
			return _tilemap;
		}


	}
}