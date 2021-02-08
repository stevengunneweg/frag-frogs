package
{
	[SWF(width="800", height="640")]
	
	import org.flixel.FlxGame;
	
	public class BlokBuster extends FlxGame
	{
		public function BlokBuster()
		{
			super(400, 320, IntroScene, 2);
		}
	}
}