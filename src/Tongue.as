/*
package  
{
	import org.flixel.*;
	public class Tongue extends FlxGroup
	{
		[Embed(source = "assets/tongue.png")] private var _tongueMidGraphic:Class;
		[Embed(source = "assets/tongueEnd.png")] private var _tongueEndGraphic:Class;
		
		private var _tongueEnd:FlxSprite;
		private var _tongueMid:FlxSprite;
		private var _speed:int = 1000;
		private var _playerx:int;
		private var _playery:int;
		private var _player:Player;
		
		public static var tongueHeight:int = 6;
		public static var tongueWidth:int = 6;
		
		public function Tongue() 
		{
			
			
		}
		
		public function start(_x:int, _y:int, _facing:uint, player:Player):void
		{	
			this.visible = true;
			
			_player = player;
			_playerx = _x;
			_playery = _y;
			if(_facing == FlxObject.LEFT){
				_tongueEnd = new FlxSprite(_playerx - 19, _playery);
				_tongueMid = new FlxSprite(_playerx - 3, _playery);
			}
			if(_facing == FlxObject.RIGHT){
				_tongueEnd = new FlxSprite(_playerx + 19, _playery);
				_tongueMid = new FlxSprite(_playerx + 3, _playery);
			}
			if(_facing == FlxObject.UP){
				_tongueEnd = new FlxSprite(_playerx, _playery - 19);
				_tongueMid = new FlxSprite(_playerx, _playery - 3);
			}
			if(_facing == FlxObject.DOWN){
				_tongueEnd = new FlxSprite(_playerx, _playery + 19);
				_tongueMid = new FlxSprite(_playerx, _playery + 3);
			}
			_tongueEnd.loadRotatedGraphic(_tongueEndGraphic, 4);
			_tongueMid.loadRotatedGraphic(_tongueMidGraphic, 4);
			_tongueEnd.facing = _facing;
			_tongueMid.facing = _facing;
			
			_tongueEnd.maxVelocity.x = _speed / 2;
			_tongueEnd.maxVelocity.y = _speed / 2;
			
			add(_tongueEnd);
			add(_tongueMid);
		}
		
		override public function update():void 
		{
			if (_tongueEnd.facing == FlxObject.RIGHT) {
				if (_tongueEnd.x - _playerx <= 8 && _tongueEnd.x - _playerx > 0 && _tongueEnd.y == _playery){
					reset();
					_player.combatwait = false;
				}
				_tongueEnd.acceleration.x = _speed;
				_tongueEnd.angle = 90;
				_tongueMid.scale.x = (_tongueEnd.x - _playerx) / 6;
				_tongueMid.angle = 90;
				_tongueMid.setOriginToCorner();
			}
			if (_tongueEnd.facing == FlxObject.LEFT) {
				if (_playerx - _tongueEnd.x <= 8 && _playerx - _tongueEnd.x > 0 && _tongueEnd.y == _playery){
					reset();
					_player.combatwait = false;
				}
				_tongueEnd.acceleration.x = -_speed;
				_tongueEnd.angle = -90;
				_tongueMid.scale.x = (_tongueEnd.x - _playerx) / 6;
				_tongueMid.setOriginToCorner();
				_tongueMid.angle = -90;
				_tongueMid.x = _playerx + 13;
			}
			if (_tongueEnd.facing == FlxObject.UP) {
				if (_playery - _tongueEnd.y <= 8 && _playery - _tongueEnd.y > 0 && _tongueEnd.x == _playerx){
					reset();
					_player.combatwait = false;
				}
				_tongueEnd.acceleration.y = -_speed;
				_tongueMid.scale.y = (_tongueEnd.y - _playery) / 6;
				_tongueMid.setOriginToCorner();
				_tongueMid.y = _playery + 13;
			}
			if (_tongueEnd.facing == FlxObject.DOWN) {
				if (_tongueEnd.y - _playery <= 8 && _tongueEnd.y - _playery > 0 && _tongueEnd.x == _playerx){
					reset();
					_player.combatwait = false;
				}
				_tongueEnd.acceleration.y = _speed;
				_tongueEnd.angle = 180;
				_tongueMid.scale.y = (_tongueEnd.y - _playery)/6;
				_tongueMid.setOriginToCorner();
			}
			super.update();
		}
		
		public function retreat(tongue:FlxSprite, tilemap:FlxTilemap):void
		{
			trace("jaaa");
			_speed = _speed * -1;
		}
		
		public function reset():void
		{
			this.visible = false;
			remove(_tongueMid);
			remove(_tongueEnd);
		}
	}
}

*/
	
package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Philippe Wedema & Kyrill Dingelstad
	 */
	public class Tongue extends FlxGroup
	{
		[Embed(source = "assets/tongue.png")] private var _tongueMidGraphic:Class;
		[Embed(source = "assets/tongueEnd.png")] private var _tongueEndGraphic:Class;
		
		public static const SPEED:int = 600;
		
		public static var tongueHeight:int = 6;
		public static var tongueWidth:int = 6;
		
		public var activated:Boolean;
		public var retreating:Boolean;
		
		private var _player:Player;
		private var _end:FlxSprite;
		private var _body:FlxSprite;
		private var _facing:uint;
		private var tilemap:FlxTilemap;
		
		public function Tongue(player:Player) 
		{
			_player = player;
			
			activated = false;
			retreating = false;
			
			_end = new FlxSprite(0,0);
			_end.loadRotatedGraphic(_tongueEndGraphic, 4);
			
			_body = new FlxSprite(0,0);
			_body.loadRotatedGraphic(_tongueMidGraphic, 4);
			
			add(_end);
			add(_body);
		}
		
		public function fire(playerX:int, playerY:int, facing:uint):void
		{
			var checkX:int;
			var checkY:int;
			tilemap = (FlxG.state as PlayState).tilemap;
			
			// checken of er een tile voor zn neus is
			if(facing == FlxObject.UP)
			{
				checkX = playerX + 8;
				checkY = playerY + 8;
				
				if(tilemap.getTile(checkX / 16, checkY / 16) == 1)
				{
					_player.tongueAvailable = true;
					stop();
					return;
				} else if(tilemap.getTile(playerX / 16, playerY / 16) == 1)
				{
					_player.tongueAvailable = true;
					stop();
					return;
				}
			}
			
			if(facing == FlxObject.LEFT)
			{
				checkX = playerX + 8;
				checkY = playerY + 8;
				
				if(tilemap.getTile(checkX / 16, checkY / 16) == 1)
				{
					_player.tongueAvailable = true;
					stop();
					return;
				} else if(tilemap.getTile(playerX / 16, playerY / 16) == 1)
				{
					_player.tongueAvailable = true;
					stop();
					return;
				}
			}
			if(facing == FlxObject.RIGHT)
			{
				checkX = playerX + 8;
				checkY = playerY + 8;
				
				if(tilemap.getTile(checkX / 16, checkY / 16) == 1)
				{
					_player.tongueAvailable = true;
					stop();
					return;
				} else if(tilemap.getTile(playerX / 16, playerY / 16) == 1)
				{
					_player.tongueAvailable = true;
					stop();
					return;
				}
			}
			if(facing == FlxObject.DOWN)
			{
				checkX = playerX + 8;
				checkY = playerY + 8;
				
				if(tilemap.getTile(checkX / 16, checkY / 16) == 1)
				{
					_player.tongueAvailable = true;
					stop();
					return;
				} else if(tilemap.getTile(playerX / 16, playerY / 16) == 1)
				{
					_player.tongueAvailable = true;
					stop();
					return;
				}
			}
			activated = true;
			
			_facing = facing;
			
			_body.x = playerX;
			_body.y = playerY;
			
			_end.x = playerX;
			_end.y = playerY;
			
			if(facing == FlxObject.LEFT)
			{
				_body.x += 16;
				_body.angle = -90;
				_end.angle = -90;
				
				_end.velocity.x = -SPEED;
			}
			
			if(facing == FlxObject.RIGHT)
			{
				_body.angle = 90;
				_end.angle = 90;
				
				_end.velocity.x = SPEED;
			}
			
			if(facing == FlxObject.UP)
			{
				_body.x += 10;
				_body.y += 16;
				_end.x += 10;
				_end.y -= 10;
				_body.angle = 0;
				_end.angle = 0;
				
				_end.velocity.y = -SPEED;
			}
			
			if(facing == FlxObject.DOWN)
			{
				_body.x += 10;
				_end.x += 10;
				_body.angle = 180;
				_end.angle = 180;
				
				_end.velocity.y = SPEED;
			}
				
		}
		
		override public function update():void
		{
			super.update();
			
			if(activated)
			{
				_end.visible = true;
				_body.visible = true;
				_end.solid = true;
				_body.solid = true;
				
				if(_facing == FlxObject.LEFT)
				{
					_body.scale.x = (_end.x - _body.x + 6) / 6;
					_body.setOriginToCorner();
				}
				
				if(_facing == FlxObject.RIGHT)
				{
					_body.scale.x = (_end.x - _body.x) / 6;
					_body.setOriginToCorner();
				}
				
				if(_facing == FlxObject.UP)
				{
					_body.scale.y = (_end.y - _body.y) / 6;
					_body.setOriginToCorner();
				}
				
				if(_facing == FlxObject.DOWN)
				{
					_body.scale.y = (_end.y - _body.y) / 6;
					_body.setOriginToCorner();
				}
			}
			else
			{
				_end.visible = false;
				_body.visible = false;
				_end.solid = false;
				_body.solid = false;
			}
			
			// als hij terecht checkt, checken wanneer hij voorbij de player is
			if(retreating)
			{
				if(_facing == FlxObject.LEFT)
					if(_end.x > _player.x) stop();
				
				if(_facing == FlxObject.RIGHT)
					if(_end.x < _player.x) stop();
				
				if(_facing == FlxObject.UP)
					if(_end.y > _player.y) stop();
				
				if(_facing == FlxObject.DOWN)
					if(_end.y < _player.y) stop();
			}
		}
		
		public function retreat(tongue:FlxSprite = null, tilemap:FlxTilemap = null):void
		{
			if (!retreating)
			{
				retreating = true;
				
				if(_facing == FlxObject.LEFT) _end.velocity.x = SPEED;
				if(_facing == FlxObject.RIGHT) _end.velocity.x = -SPEED;
				if(_facing == FlxObject.UP) _end.velocity.y = SPEED;
				if(_facing == FlxObject.DOWN) _end.velocity.y = -SPEED;
			}
			
		}
		
		public function stop(tongue:FlxSprite = null, tilemap:FlxTilemap = null):void
		{
			activated = false;
			retreating = false;
			_end.velocity.x = 0;
			_end.velocity.y = 0;
			_body.scale.x = 1;
			_body.scale.y = 1;
			
			_player.combatwait = false;
		}
		
	}
	
}