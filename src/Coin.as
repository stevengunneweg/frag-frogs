package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Kyrill Dingelstad
	 */
	public class Coin extends FlxSprite
	{
		[Embed(source = 'assets/coin.png')] private var _coinTurn:Class;
		
		public function Coin() 
		{
			loadGraphic(_coinTurn, true, false, 16, 16, false);
			addAnimation("coin", [0, 1, 2, 3, 2, 1], 7, true);
			
			play("coin");
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		
	}

}