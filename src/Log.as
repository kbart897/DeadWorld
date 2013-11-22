package
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.Color;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class Log extends Sprite
	{
		private static var _instance:Log;
		public static var doTrace:Boolean = false;
		public static var SINGLE_LINE_HEIGHT:int;
		private static var NUM_LINES:int = 12;
		
		public static var currState:int = 0;
		
		public static var S_HIDDEN:int = 0;
		public static var S_SINGLE_LINE:int = 1;
		public static var S_FULL:int = 2;
		
		public static var logLength:int = 0;
		public static var logHistory:Vector.<String>;
		
		public static var date:Date;
		
		private var bg:Image;
		
		private static var history:TextField;
		
		public function Log()
		{
			if (!_instance)
			{
				super();
				_instance = this;
				//load image
				bg = new Image(Assets.getAtlas().getTexture("console"));
				addChild(bg);
				bg.alpha = .75;
				bg.width = DeadWorld.EXPLICIT_WIDTH;
				bg.height = DeadWorld.EXPLICIT_HEIGHT/3;
				SINGLE_LINE_HEIGHT = (-bg.height)+15;
				history = new TextField(DeadWorld.EXPLICIT_WIDTH, bg.height, "First Entry");
				addChild(history);
				logHistory = new Vector.<String>();
				history.hAlign = HAlign.LEFT;
				history.vAlign = VAlign.BOTTOM;
				history.color = Color.WHITE;
				
				date = new Date();
			}
		}
		
		public static function out(message:String, forceTrace:Boolean=false):void
		{
			logLength++;
			
			if (forceTrace || doTrace)
			{
				trace(message);
			}
			
			logHistory.push("[" + GameState.getCurrTime() + "] " + message);
			history.text = "";
			
			if (logHistory.length > NUM_LINES)
			{
				for (var i:int = logHistory.length-NUM_LINES-1; i < logHistory.length; i++)
				{
					history.text += "\n" + logHistory[i];
				}
			}
			else
			{
				for each (var m:String in logHistory)
				{
					history.text += "\n" + m;
				}
			}
		}

		public static function get instance():Log
		{
			return _instance;
		}

		public static function set instance(value:Log):void
		{
			_instance = value;
		}

	}
}