package game.ui
{
	import game.entities.Entity;
	
	import starling.display.Sprite;
	
	import views.GameView;

	public class HudManager
	{
		//Static constants for hud clicks
		public static const HCLICK_NOTHING:int = 0;
		public static const HCLICK_INFOBAR:int = 1;
		public static const HCLICK_PREVIEW:int = 2;
		public static const HCLICK_ACTIONBAR:int = 3;
		public static const HCLICK_DETAIL:int = 4;
		public static const HCLICK_BTN_MOVE:int = 5;
		public static const HCLICK_BTN_END:int = 6;
		
		//Static update flag
		public static var UPDATE_FLAG:Boolean = false;
		private var gView:GameView;
		
		private var _elements:Vector.<Sprite>;
		private var contextMenus:Vector.<ICloseable>;
		
		private var h_entityPreview:EntityPreview;
		private var h_infoBar:InfoBar;
		private var h_actionBar:ActionBar;
		private var h_detailScreen:DetailScreen;
		
		public function HudManager(gv:GameView)
		{
			gView = gv;
			UPDATE_FLAG = false;
			elements = new Vector.<Sprite>();
			contextMenus = new Vector.<ICloseable>();
			
			//create all menus
		}
		
		public function update():void
		{
			if (UPDATE_FLAG)
			{
				UPDATE_FLAG = false;
				
				updateElements();
			}
		}
		
		public function getClickedItem():int
		{
			Log.out("Checking clicked hud item...");
			for each (var e:Sprite in elements)
			{
				if (currElementClicked(e))
				{
					if (e is EntityPreview)
					{
						//openDetailScreen();
						return HCLICK_PREVIEW;
					}
					else if (e is InfoBar)
					{
						return HCLICK_INFOBAR;
					}
					else if (e is ActionBar)
					{
						Log.out("action bar was clicked!");
						var clickedABarItem:int = h_actionBar.getClickedItem();
						switch (clickedABarItem)
						{
							case ActionBar.BTN_END_TURN:
								return HCLICK_BTN_END;
								break;
							case ActionBar.BTN_MOVE:
								Log.out("move button clicked!");
								return HCLICK_BTN_MOVE;
								break;
						}
						return HCLICK_ACTIONBAR;
					}
					else if (e is DetailScreen)
					{
						return HCLICK_DETAIL;
					}
				}
			}
			Log.out("No hud item clicked!");
			
			return HCLICK_NOTHING;
		}
		
		public function openDetailScreen(e:Entity=null):void
		{
			h_detailScreen.visible = true;
			
			if (e)
			{
				h_detailScreen.setEntity(e);
			}
			else
			{
				h_detailScreen.setEntity(h_entityPreview.currEntity);
			}
		}
		
		private function currElementClicked(e:Sprite):Boolean
		{
			if (e.visible)
			{
				if (GameState.MOUSE_CLICK_POS.x > e.x &&
					GameState.MOUSE_CLICK_POS.x < e.x + e.width &&
					GameState.MOUSE_CLICK_POS.y > e.y &&
					GameState.MOUSE_CLICK_POS.y < e.y + e.height)
				{
					Log.out("Hud item clicked!");
					return true;
				}
			}
			return false;
		}
		
		private function updateElements(e:Entity=null):void
		{
			clearOpenWindows();
			rebuildContextItems(e);
		}
		
		private function rebuildContextItems(e:Entity=null):void
		{
			if (e)
			{
				h_entityPreview.visible = true;
				h_entityPreview.setEntity(e);
				
				h_actionBar.setEntity(e);
			}
			else
			{
				h_entityPreview.visible = false;
				h_actionBar.clear();
			}
		}
		
		private function clearOpenWindows():void
		{
			for each (var m:ICloseable in contextMenus)
			{
				m.clear();
			}
		}
		
		public function removeElement(e:Sprite):void
		{
			if (elements.indexOf(e) > 0)
			{
				elements.splice(elements.indexOf(e), 1);
			}
		}
		
		public function updateSelection(e:Entity=null):void
		{
			updateElements(e);
			
		}
		
		public function addElement(e:Sprite):void
		{
			elements.push(e);
			if (e is ICloseable)
			{
				contextMenus.push(e);
				
				if (e is DetailScreen)
				{
					h_detailScreen = e as DetailScreen;
				}
			}
			else if (e is EntityPreview)
			{
				h_entityPreview = e as EntityPreview;
			}
			else if (e is InfoBar)
			{
				h_infoBar = e as InfoBar;
			}
			else if (e is ActionBar)
			{
				h_actionBar = e as ActionBar;
			}
		}

		public function get elements():Vector.<Sprite>
		{
			return _elements;
		}

		public function set elements(value:Vector.<Sprite>):void
		{
			_elements = value;
		}

	}
}