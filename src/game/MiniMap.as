package game
{
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class MiniMap extends Sprite
	{
		private var mapImg:Image;
		
		public function MiniMap()
		{
			super();
			mapImg = new Image(Assets.getAtlas().getTexture("testMap"));
			addChild(mapImg);
		}
	}
}