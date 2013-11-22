package views
{
	import com.greensock.TweenLite;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class ViewOverlay extends Sprite
	{
		private var nightOverlay:Image;
		private var dayOverlay:Image;
		private var nightAlpha:Number = .3;
		private var dayAlpha:Number = .3;
		
		private var dayLength:Number = 20;
		
		public function ViewOverlay()
		{
			nightOverlay = new Image(Assets.getAtlas().getTexture("black_pixel"));
			addChild(nightOverlay);
			nightOverlay.width = DeadWorld.EXPLICIT_WIDTH;
			nightOverlay.height = DeadWorld.EXPLICIT_HEIGHT;
			nightOverlay.alpha = nightAlpha;
			
			dayOverlay = new Image(Assets.getAtlas().getTexture("white_pixel"));
			addChild(dayOverlay);
			dayOverlay.width = DeadWorld.EXPLICIT_WIDTH;
			dayOverlay.height = DeadWorld.EXPLICIT_HEIGHT;
			dayOverlay.alpha = 0;
			
			TweenLite.to(nightOverlay, dayLength/2, {alpha: 0, onComplete:daytime});
			TweenLite.to(dayOverlay, dayLength/2, {alpha: dayAlpha});
		}
		
		private function daytime():void
		{
			TweenLite.to(nightOverlay, dayLength/2, {alpha: nightAlpha, onComplete:nighttime});
			TweenLite.to(dayOverlay, dayLength/2, {alpha: 0});
		}
		
		private function nighttime():void
		{
			TweenLite.to(nightOverlay, dayLength/2, {alpha: 0, onComplete:daytime});
			TweenLite.to(dayOverlay, dayLength/2, {alpha: dayAlpha});
		}
	}
}