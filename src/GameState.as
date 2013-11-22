package
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	import game.Stat;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import views.GameView;
	import views.IUpdateable;
	
	public class GameState extends Sprite
	{
		private static var _instance:GameState;
		
		//Keys vector
		public static var KEYS_DOWN:Vector.<Boolean>;
		public static var KEYS_PREV_DOWN:Vector.<Boolean>;
		
		// Variables for click logic
		public static const DRAG_MINIMUM:Number = 10;
		
		public static var MOUSE_CLICKED:Boolean = false;
		public static var MOUSE_DOWN:Boolean = false;
		public static var MOUSE_DOWN_DURATION:int = 0;
		public static var MOUSE_CLICK_DRAG:Boolean = false;
		public static var MOUSE_CLICK_POS:Point;
		public static var MOUSE_DOWN_START_POS:Point;
		public static var MOUSE_POS:Point;
		public static var MOUSE_PREV_POS:Point;
		
		private static var stateView:IUpdateable;
		
		public static var date:Date;
		private static var dateCreationTime:Number;
		
		public static var log:Log;
		
		
		public function GameState()
		{
			super();
			Assets.init();
			log = new Log();
			addChild(log);
			log.y -= log.height;
			log.visible = false;
			Log.doTrace = true;
			showConsole(true);
			
			date = new Date();
			dateCreationTime = getTimer();
			
			initListeners();
		}
		
		private function initListeners():void
		{
			initKeyListeners();
			changeState(AppState.GAME);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		protected function update(event:Event):void
		{
			updateInputs();
			if (stateView)
			{
				stateView.update();
			}
			postFrameUpdate();
		}
		
		private function postFrameUpdate():void
		{
			MOUSE_CLICKED = false;
			MOUSE_PREV_POS.x = MOUSE_POS.x;
			MOUSE_PREV_POS.y = MOUSE_POS.y;
			
			//Prev frame keys vector
			for (var i:int = 0; i < KEYS_PREV_DOWN.length; i++)
			{
				KEYS_PREV_DOWN[i] = KEYS_DOWN[i];
			}
			
			//timer
			date.time += ( getTimer() - dateCreationTime );
			dateCreationTime = getTimer();
		}
		
		private function updateInputs():void
		{
			//====================================
			//Console control
			//====================================
			
			if (!GameState.KEYS_DOWN[Keyboard.PAGE_DOWN] && GameState.KEYS_PREV_DOWN[Keyboard.PAGE_DOWN])
			{
				showConsole();
			}
			
			if (!GameState.KEYS_DOWN[Keyboard.PAGE_UP] && GameState.KEYS_PREV_DOWN[Keyboard.PAGE_UP])
			{
				minimizeConsole();
			}
			
			if (MOUSE_DOWN)
			{
				MOUSE_DOWN_DURATION++;
				
				if (Stat.distance(new Point(MOUSE_DOWN_START_POS.x, MOUSE_DOWN_START_POS.y),
					new Point(MOUSE_POS.x, MOUSE_POS.y))
					> DRAG_MINIMUM)
				{
					MOUSE_CLICK_DRAG = true;
				}
			}
			else if (MOUSE_DOWN_DURATION > 0)
			{
				MOUSE_DOWN_DURATION = 0;
			}
			else
			{
				MOUSE_CLICK_DRAG = false;
			}
		}
		
		private function initKeyListeners():void
		{
			var keysPressedLogic:NONSENSE;
			KEYS_DOWN = new Vector.<Boolean>();
			KEYS_PREV_DOWN = new Vector.<Boolean>();
			
			for (var i:int = 0; i < 350; i++)
			{
				KEYS_DOWN.push(false);
				KEYS_PREV_DOWN.push(false);
			}
			
			addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			MOUSE_DOWN_START_POS = new Point(0, 0);
			MOUSE_POS = new Point(0, 0);
			MOUSE_PREV_POS = new Point(0, 0);
			MOUSE_CLICK_POS = new Point(0, 0);
			
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		protected function onTouch(e:TouchEvent):void
		{
			var touches:Vector.<Touch> = e.getTouches(this);
			for each (var touch:Touch in touches)
			{
				if (touch.phase == TouchPhase.HOVER )
				{
					//var location:Point = touch.getLocation(this);
					MOUSE_POS.x = touch.globalX;
					MOUSE_POS.y = touch.globalY;
					//Log.out("mouse at x: " + MOUSE_POS.x + ", " + MOUSE_POS.y);
				}
				if (touch.phase == TouchPhase.MOVED )
				{
					//var location:Point = touch.getLocation(this);
					MOUSE_POS.x = touch.globalX;
					MOUSE_POS.y = touch.globalY;
					
					//Log.out("mouse at x: " + MOUSE_POS.x + ", " + MOUSE_POS.y);
				}
				if (touch.phase == TouchPhase.BEGAN )
				{
					MOUSE_DOWN = true;
					MOUSE_DOWN_START_POS.x = touch.globalX;
					MOUSE_DOWN_START_POS.y = touch.globalY;
					MOUSE_CLICK_DRAG = false;
					
				}
				if (touch.phase == TouchPhase.ENDED )
				{
					MOUSE_CLICKED = true;
					MOUSE_DOWN = false;
					//Check the distance
					Log.out("mouse click duration: " + MOUSE_DOWN_DURATION);
					var location:Point = touch.getLocation(this);
					MOUSE_CLICK_POS.x = touch.globalX;
					MOUSE_CLICK_POS.y = touch.globalY;
				}
			}
		}
		
		protected function onKeyUp(e:KeyboardEvent):void
		{
			if (e.keyCode < KEYS_DOWN.length)
			{
				KEYS_DOWN[e.keyCode] = false;
			}
			/*
			switch (e.keyCode)
			{
				case Keyboard.A:
					KEYS_DOWN[Keyboard.A] = false;
					break;
				case Keyboard.W:
					KEYS_DOWN[Keyboard.W] = false;
					break;
				case Keyboard.D:
					KEYS_DOWN[Keyboard.D] = false;
					break;
				case Keyboard.S:
					KEYS_DOWN[Keyboard.S] = false;
					break;
				case Keyboard.SPACE:
					KEYS_DOWN[Keyboard.SPACE] = false;
					break;
			}*/
		}
		
		protected function onKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode < KEYS_DOWN.length)
			{
				KEYS_DOWN[e.keyCode] = true;
			}
			/*
			switch (e.keyCode)
			{
				case Keyboard.A:
					KEYS_DOWN[Keyboard.A] = true;
					break;
				case Keyboard.W:
					KEYS_DOWN[Keyboard.W] = true;
					break;
				case Keyboard.D:
					KEYS_DOWN[Keyboard.D] = true;
					break;
				case Keyboard.S:
					KEYS_DOWN[Keyboard.S] = true;
					break;
				case Keyboard.SPACE:
					KEYS_DOWN[Keyboard.SPACE] = true;
					break;
				
			}*/
		}
		
		public static function changeState(newState:int):void
		{
			_instance.changeState(newState);
		}
		
		public function changeState(newState:int):void 
		{
			if (stateView)
			{
				//stateView.destroy();
				removeChild(stateView as Sprite);
				stateView = null;
			}
			
			switch(newState) 
			{
				case AppState.SPLASH:
					//stateView = new SplashView();
					//addChild(stateView as Sprite);
					break;
				case AppState.MAIN:
					//stateView = new MainView();
					//addChild(stateView as Sprite);
					break;
				case AppState.GAME:
					stateView = new GameView();
					addChild(stateView as Sprite)
					break;
				case AppState.LAUNCH:
					//stateView = new LoadingView();
					//addChild(stateView as Sprite);
					break;
				
			}
			
			setChildIndex(log, numChildren-1);
		}

		//====================================
		// Utility functions
		//====================================
		public static function getCurrTime():String
		{
			return date.toLocaleTimeString()
		}
		
		public static function showConsole(full:Boolean=false):void
		{
			if (full)
			{
				if (!Log.instance.visible)
				{
					Log.instance.visible = true;
					Log.currState = Log.S_FULL;
					TweenLite.to(Log.instance, .25, {y:0});
				}
			}
			else if (Log.currState == Log.S_HIDDEN)
			{
				Log.instance.visible = true;
				Log.currState = Log.S_SINGLE_LINE;
				TweenLite.to(Log.instance, .1, {y:Log.SINGLE_LINE_HEIGHT});
			}
			else if (Log.currState == Log.S_SINGLE_LINE)
			{
				Log.currState = Log.S_FULL;
				TweenLite.to(Log.instance, .25, {y:0});
			}
			else
			{
				Log.currState = Log.S_HIDDEN;
				TweenLite.to(Log.instance, .25, {y:-Log.instance.height, onComplete:hideConsole});
			}
		}

		public static function minimizeConsole(completely:Boolean=false):void
		{
			if (completely)
			{
				if (Log.instance.visible)
				{
					Log.currState = Log.S_HIDDEN;
					TweenLite.to(Log.instance, .25, {y:-Log.instance.height, onComplete:hideConsole});
				}
			}
			else if (Log.currState == Log.S_FULL)
			{
				Log.currState = Log.S_SINGLE_LINE;
				TweenLite.to(Log.instance, .1, {y:Log.SINGLE_LINE_HEIGHT});
			}
			else if (Log.currState == Log.S_SINGLE_LINE)
			{
				Log.currState = Log.S_HIDDEN;
				TweenLite.to(Log.instance, .25, {y:-Log.instance.height, onComplete:hideConsole});
			}
		}
		
		public static function hideConsole():void
		{
			Log.instance.visible = false;
		}
	}
}