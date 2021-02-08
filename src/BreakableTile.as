package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Hugo
	 */
	public class BreakableTile extends FlxSprite
	{
		[Embed(source="assets/block.png")] private var _blockGraphic:Class;
		
		private var _state:int;
		private var _timer:Number;
		private var _random:Number;
		
		public function BreakableTile() 
		{
			_timer = 0;
			_state = 3;
			this.loadGraphic(_blockGraphic, true, false, 16, 16);
			this.immovable = true;
			this.addAnimation("0", [0]);
			this.addAnimation("1", [1]);
			this.addAnimation("2", [2]);
			this.addAnimation("3", [3]);
			
			_random = Math.random() * 1.5 + 8;
			
		}
		
		override public function destroy():void
		{
			_state = 0;
			_timer = 0;
		}
		
		override public function update():void
		{
			if(_state < 3)
				_timer += FlxG.elapsed;
			
			if(_timer > _random-(_state*1.4) && _state < 3)
			{
				_state++;
				_timer = 0;
			}
			
			if(_state == 0) play("0");
			if(_state == 1) play("1");
			if(_state == 2) play("2");
			if(_state == 3) play("3");
			
			if(_state == 0)
				this.solid = false;
			else
				this.solid = true;
			
			super.update();
		}

		/** 
		 * State 3 is volledig
		 * State 2 is een half bosje
		 * State 1 bosje is een bosje waarover je kan lopen
		 */
		public function get state():int
		{
			return _state;
		}

		
	}

}