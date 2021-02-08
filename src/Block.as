package
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;

	public class Block extends FlxSprite
	{
		[Embed(source="assets/block.png")] private var _blockGraphic:Class;
		
		public function Block()
		{
			this.loadGraphic(_blockGraphic);
			this.immovable = true;
		}

	}
}