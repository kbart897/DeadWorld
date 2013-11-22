package
{
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	import starling.core.Starling;
	
	import views.GameView;
	import views.IUpdateable;
	import views.Stats;
	
	[SWF(width="1280", height="720", frameRate=60)]
	public class DeadWorld extends Sprite
	{
		private static var _instance:DeadWorld;
		
		//Screen size
		public static var EXPLICIT_HEIGHT:int;
		public static var EXPLICIT_WIDTH:int;
		public static var EXPLICIT_FRAMERATE:int = 60;
		
		private var stat:Stats;
		
		private var _starling:Starling;
		
		public function DeadWorld()
		{
			_instance = this;
			//stat = new Stats();
			//addChild(stat);
			
			EXPLICIT_HEIGHT = stage.stageHeight;
			EXPLICIT_WIDTH = stage.stageWidth;
			EXPLICIT_FRAMERATE = 60;
			
			_starling = new Starling(GameState, stage);
			_starling.start();
		}
	}
}