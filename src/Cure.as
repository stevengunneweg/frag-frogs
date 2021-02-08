package  
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Kyrill Dingelstad
	 */
	public class Cure extends FlxSprite
	{
		[Embed(source="assets/fly.PNG")] private var _cureGraphic:Class;
		private var killTimer:Number = (Math.round(Math.random() * 5)) + 10;
		private var _killed:Boolean = false;
		
		public function Cure() 
		{
			this.loadGraphic(_cureGraphic);
			_killed = false;
		}
		override public function update():void
		{
			/**
			killTimer -= FlxG.elapsed;
			if (killTimer >= 0.5)
			{
				_killed = false;
			}
			if (killTimer <= 1.5 && !this.flickering)
			{
				this.flicker(1.5);
			}
			if (killTimer <= 0)
			{
				_killed = true;
			}
			*/
		}
		public function get killed():Boolean
		{
			return _killed;
		}
		public function set killed(value:Boolean):void
		{
			_killed = value;
		}
	}

}