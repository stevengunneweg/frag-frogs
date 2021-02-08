package
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Steven
	 */
	public class HUD extends FlxGroup
	{
		[Embed(source = "assets/player.png")] private var _playerGraphic1:Class;
		[Embed(source = "assets/player brown.png")] private var _playerGraphic2:Class;
		[Embed(source = "assets/player blue.png")] private var _playerGraphic3:Class;
		[Embed(source = "assets/player gray.png")] private var _playerGraphic4:Class;
		[Embed(source = "assets/player pink.png")] private var _playerGraphic5:Class;
		[Embed(source = "assets/player red.png")] private var _playerGraphic6:Class;
		[Embed(source = "assets/player skyblue.png")] private var _playerGraphic7:Class;
		[Embed(source = "assets/player yellow.png")] private var _playerGraphic8:Class;
		
		private var background:FlxSprite;
		
		private var p1naam:FlxText;
		private var p2naam:FlxText;
		private var p1Score:FlxText;
		private var p2Score:FlxText;
		private var p1Lick:FlxText;
		private var p2Lick:FlxText;
		//dimensions
		private var top:int = 288;
		private var barHeight:int = 25;
		private var barWidth:int = 60;
		//variables
		private var player1Score:int = 0;
		private var player2Score:int = 0;
		
		private var player1Lick:Boolean = false;
		private var player2Lick:Boolean = false;
		
		private var imagePlayer1:FlxSprite;
		private var imagePlayer2:FlxSprite;
		
		public function HUD()
		{
			background = new FlxSprite(0, top);
			background.makeGraphic(400, 32, 0xff341d03);
			
			p1naam = new FlxText(5, top + 5, 100, "Player 1").setFormat(null, 11, 0xFFFF00);
			p2naam = new FlxText(400 - 105, top + 5, 100, "Player 2").setFormat(null, 11, 0xFFFF00);
			p2naam.alignment = "right";
			
			p1Score = new FlxText(barWidth + 10, top + 5, 100, "");
			p2Score = new FlxText(400 - 110 - barWidth, top + 5, 100, "");
			p2Score.alignment = "right";
			
			p1Score.size = 16;
			p2Score.size = 16;
			
			p1Lick = new FlxText(barWidth + 10, top + 17, 150, "");
			p2Lick = new FlxText(400 - 160 - barWidth, top + 17, 150, "");
			p2Lick.alignment = "right";
			
			add(background);
			//add(p1naam);
			//add(p2naam);
			add(p1Score);
			add(p2Score);
			//add(p1Lick);
			//add(p2Lick);

			
			var color:int = (FlxG.state as PlayState)._player2.playerColor;
			
			imagePlayer1 = new FlxSprite();
			imagePlayer1.y = top + 8;
			imagePlayer1.x = 40;
			imagePlayer1.angle = 180;
			
			imagePlayer2 = new FlxSprite();
			imagePlayer2.y = top + 8;
			imagePlayer2.x = 400-40-16;
			imagePlayer2.angle = 180;
			
			switch (color) {
				case 1:
					imagePlayer1.loadGraphic(_playerGraphic1, true, false, 16, 16, false);
					break;
				case 2:
					imagePlayer1.loadGraphic(_playerGraphic2, true, false, 16, 16, false);
					break;
				case 3:
					imagePlayer1.loadGraphic(_playerGraphic3, true, false, 16, 16, false);
					break;
				case 4:
					imagePlayer1.loadGraphic(_playerGraphic4, true, false, 16, 16, false);
					break;
				case 5:
					imagePlayer1.loadGraphic(_playerGraphic5, true, false, 16, 16, false);
					break;
				case 6:
					imagePlayer1.loadGraphic(_playerGraphic6, true, false, 16, 16, false);
					break;
				case 7:
					imagePlayer1.loadGraphic(_playerGraphic7, true, false, 16, 16, false);
					break;
				case 8:
					imagePlayer1.loadGraphic(_playerGraphic8, true, false, 16, 16, false);
					break;
				default:
					imagePlayer1.loadGraphic(_playerGraphic1, true, false, 16, 16, false);
					
			}
			
			color = (FlxG.state as PlayState)._player1.playerColor;
			
			switch (color) {
				case 1:
					imagePlayer2.loadGraphic(_playerGraphic1, true, false, 16, 16, false);
					break;
				case 2:
					imagePlayer2.loadGraphic(_playerGraphic2, true, false, 16, 16, false);
					break;
				case 3:
					imagePlayer2.loadGraphic(_playerGraphic3, true, false, 16, 16, false);
					break;
				case 4:
					imagePlayer2.loadGraphic(_playerGraphic4, true, false, 16, 16, false);
					break;
				case 5:
					imagePlayer2.loadGraphic(_playerGraphic5, true, false, 16, 16, false);
					break;
				case 6:
					imagePlayer2.loadGraphic(_playerGraphic6, true, false, 16, 16, false);
					break;
				case 7:
					imagePlayer2.loadGraphic(_playerGraphic7, true, false, 16, 16, false);
					break;
				case 8:
					imagePlayer2.loadGraphic(_playerGraphic8, true, false, 16, 16, false);
					break;
				default:
					imagePlayer2.loadGraphic(_playerGraphic1, true, false, 16, 16, false);
					
			}
			
			add(imagePlayer1);
			add(imagePlayer2);
		}
		
		override public function update():void
		{
			p1Score.text = "" + (FlxG.state as PlayState).player2score;
			p2Score.text = "" + (FlxG.state as PlayState).player1score;
			
			if ((FlxG.state as PlayState)._player2.tongueAvailable) {
				p1Lick.text = "Tongue: Availlable";
			} else {
				p1Lick.text = "Tongue: Not Availlable";
			}
			if ((FlxG.state as PlayState)._player1.tongueAvailable) {
				p2Lick.text = "Tongue: Availlable";
			} else {
				p2Lick.text = "Tongue: Not Availlable";
			}
		}
	}
}