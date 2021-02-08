package
{
	import flash.display.Sprite;
	
	import org.flixel.*;

	public class Player extends FlxSprite
	{
		[Embed(source = "assets/player.png")] private var _playerGraphic1:Class;
		[Embed(source = "assets/player brown.png")] private var _playerGraphic2:Class;
		[Embed(source = "assets/player blue.png")] private var _playerGraphic3:Class;
		[Embed(source = "assets/player gray.png")] private var _playerGraphic4:Class;
		[Embed(source = "assets/player pink.png")] private var _playerGraphic5:Class;
		[Embed(source = "assets/player red.png")] private var _playerGraphic6:Class;
		[Embed(source = "assets/player skyblue.png")] private var _playerGraphic7:Class;
		[Embed(source = "assets/player yellow.png")] private var _playerGraphic8:Class;
		
		[Embed(source = 'assets/Lopen.mp3')] private var walkSound:Class;
		[Embed(source = 'assets/Tong Eruit.mp3')] private var tongueInUseSound:Class;
		
		public const SPEED:int = 140;
		public const BOOST:int = 300;
		
		public var tongueAvailable:Boolean = false;
		private var _tongue:Tongue;
		private var _combatwait:Boolean = false;
		public var dashing:Boolean;
		public var dashTimer:Number;
		
		/**
		 * Houd bij hoeveel radiation de speler heeft
		 */
		public var radiation:Number;
		private var radiationRegen:Number = 0;
		
		/**
		 * Geef het of het player 1 of player 2 is
		 */
		public var player:int;
		
		/**
		 * Houd score bij
		 */
		public var score:int;
		
		private var _targetX:int;
		private var _targetY:int;
		private var _moving:Boolean;
		
		public var playerColor:int;
		
		public function Player(x:int, y:int, player:int, color:int)
		{
			_targetX = x;
			_targetY = y;
			this.x = x;
			this.y = y;
			
			this.player = player;
			this.score = 0;
			_tongue = new Tongue(this);
			
			switch (color) {
				case 1:
					this.loadGraphic(_playerGraphic1, true, false, 16, 16, false);
					break;
				case 2:
					this.loadGraphic(_playerGraphic2, true, false, 16, 16, false);
					break;
				case 3:
					this.loadGraphic(_playerGraphic3, true, false, 16, 16, false);
					break;
				case 4:
					this.loadGraphic(_playerGraphic4, true, false, 16, 16, false);
					break;
				case 5:
					this.loadGraphic(_playerGraphic5, true, false, 16, 16, false);
					break;
				case 6:
					this.loadGraphic(_playerGraphic6, true, false, 16, 16, false);
					break;
				case 7:
					this.loadGraphic(_playerGraphic7, true, false, 16, 16, false);
					break;
				case 8:
					this.loadGraphic(_playerGraphic8, true, false, 16, 16, false);
					break;
				default:
					this.loadGraphic(_playerGraphic1, true, false, 16, 16, false);
					
			}
			this.addAnimation("down", [0,4], 8);
			this.addAnimation("up", [1,5], 8);
			this.addAnimation("left", [2,6], 8);
			this.addAnimation("right", [3,7], 8);
			this.addAnimation("idledown", [0]);
			this.addAnimation("idleup", [1]);
			this.addAnimation("idleleft", [2]);
			this.addAnimation("idleright", [3]);
			
			this.maxVelocity.x = SPEED;
			this.maxVelocity.y = SPEED;
			this.drag.x = this.maxVelocity.x * 100;
			this.drag.y = this.maxVelocity.y * 100;
			
			this.playerColor = color;
		}
		
		override public function update():void
		{
			if(player == 1 && _combatwait == false && dashing == false && !FlxG.paused)
			{
				if(FlxG.keys.UP)
				{
					//this.acceleration.y = this.maxVelocity.y * -5;
					this.velocity.y = -SPEED;
					this.play("up");
					//move(UP);
					this.facing = UP;
				}
				else if(FlxG.keys.DOWN)
				{
					this.velocity.y = SPEED;
					this.play("down");
					//move(DOWN);
					//this.acceleration.y = this.maxVelocity.y * 5;
					this.facing = DOWN;
					
				}
				else if(FlxG.keys.LEFT)
				{
					this.velocity.x = -SPEED;
					this.play("left");
					//move(LEFT);
					//this.acceleration.x = this.maxVelocity.x * -5;
					this.facing = LEFT;
					
				}
				
				else if(FlxG.keys.RIGHT)
				{
					this.velocity.x = SPEED;
					this.play("right");
					//move(RIGHT);
					//this.acceleration.x = this.maxVelocity.x * 5;
					this.facing = RIGHT;
					
				}
				
				// fire button
				if(FlxG.keys.justPressed("SLASH") && tongueAvailable == true)
				{
					this.velocity.x = 0;
					this.velocity.y = 0;
					
					FlxG.play(tongueInUseSound);
					
					_combatwait = true;
					tongueAvailable = false;
					
					if (this.facing == RIGHT) 
						_tongue.fire(this.x + this.width, this.y + this.height / 2 - Tongue.tongueHeight / 2, this.facing);
					
					if (this.facing == LEFT) {
						_tongue.fire(this.x - this.width, this.y + this.height/2 - Tongue.tongueHeight/2, this.facing);
					}
					if (this.facing == UP) {
						_tongue.fire(this.x - this.width / 2 + Tongue.tongueWidth / 2, this.y - this.height, this.facing);
					}
					if (this.facing == DOWN) {
						_tongue.fire(this.x - this.width / 2 + Tongue.tongueWidth / 2, this.y + this.height, this.facing);
					}
					
					(FlxG.state as PlayState).add(_tongue);
					
				}
				
					else if(FlxG.keys.justPressed("U") && _combatwait == false && dashing == false)
				{
					dash();
				}
			}
			
			if(player == 2 && _combatwait == false && dashing == false && !FlxG.paused)
			{
				if(FlxG.keys.A)
				{
					//move(LEFT);
					this.velocity.x = -SPEED;
					this.play("left");
					this.facing = LEFT;
				}
					
				else if(FlxG.keys.D)
				{
					//move(RIGHT);
					this.velocity.x = SPEED;
					this.play("right");
					this.facing = RIGHT;
					
				}
				else if(FlxG.keys.W)
				{
					//move(UP);
					this.velocity.y = -SPEED;
					this.play("up");
					this.facing = UP;
					
					
				}
				else if(FlxG.keys.S)
				{
					//move(DOWN);
					this.velocity.y = SPEED;
					this.play("down");
					this.facing = DOWN;
				}
				
				// fire button
				if (FlxG.keys.justPressed("SPACE") && tongueAvailable == true)
				{
					this.velocity.x = 0;
					this.velocity.y = 0;
					
					FlxG.play(tongueInUseSound);
					
					_combatwait = true;
					tongueAvailable = false;
					
					if (this.facing == RIGHT) {
						_tongue.fire(this.x + this.width, this.y + this.height / 2 - Tongue.tongueHeight / 2, this.facing);
						}
					if (this.facing == LEFT) {
						_tongue.fire(this.x - this.width, this.y + this.height/2 - Tongue.tongueHeight/2, this.facing);
					}
					if (this.facing == UP) {
						_tongue.fire(this.x - this.width / 2 + Tongue.tongueWidth / 2, this.y - this.height, this.facing);
					}
					if (this.facing == DOWN) {
						_tongue.fire(this.x - this.width / 2 + Tongue.tongueWidth / 2, this.y + this.height, this.facing);
					}
					
					(FlxG.state as PlayState).add(_tongue);
				}
				else if(FlxG.keys.justPressed("Q") && _combatwait == false && dashing == false)
				{
					//dash();
				}
			}
			
			if(dashing)
			{
				dashTimer += FlxG.elapsed;
				
				velocity.x = 0;
				velocity.y = 0;
				
				if(dashTimer > 0.2)
				{
					dashing = false;
				}
			}
			
			if (this.velocity.x == 0 && this.velocity.y == 0) {
				switch (facing) {
					case UP:
						this.play("idleup");
						break;
					case DOWN:
						this.play("idledown");
						break;
					case LEFT:
						this.play("idleleft");
						break;
					case RIGHT:
						this.play("idleright");
						break;
				}
			}
			super.update();
		}
		
		public function resetTargets():void
		{
			_targetX = x;
			_targetY = y;
		}
		
		public function dash():void
		{
			dashing = true;
			dashTimer = 0;
		}

		public function get tongue():Tongue
		{
			return _tongue;
		}

		public function get combatwait():Boolean {
			return _combatwait;
		}
		
		public function set combatwait(value:Boolean):void {
			_combatwait = value;
		}
	}
}