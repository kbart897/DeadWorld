package views
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	import game.Level;
	import game.MiniMap;
	import game.ai.Faction;
	import game.entities.Entity;
	import game.entities.L_Doodad;
	import game.entities.L_Human;
	import game.entities.Unit;
	import game.tiles.L_Tile;
	import game.tiles.TileManager;
	import game.tiles.V_Tile;
	import game.ui.ActionBar;
	import game.ui.DetailScreen;
	import game.ui.EntityPreview;
	import game.ui.HudManager;
	import game.ui.InfoBar;
	import game.ui.MovePath;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.deg2rad;
	import starling.utils.rad2deg;
	
	public class GameView extends Sprite implements IUpdateable
	{
		//====================================
		// CONSTANTS
		//====================================
		// Game logic constants
		public static const DIR_UP:int = 0;
		public static const DIR_RIGHT:int = 1;
		public static const DIR_BOTTOM:int = 2;
		public static const DIR_LEFT:int = 3;
		
		
		//Click/selection
		public static var CLICKED_NOTHING:int = 0;
		public static var CLICKED_NEW_ENTITY:int = 1;
		public static var CLICKED_SAME_ENTITY:int = 2;
		
		//Turn State
		public static var S_LOAD_GAME:int = 0;
		public static var S_GAME_BEGIN:int = 1;
		public static var S_TURN_BEGIN:int = 2;
		public static var S_TURN_RUNNING:int = 3;
		public static var S_TURN_END:int = 4;
		public static var S_END_GAME:int = 5;
		public static var S_PAUSED:int = 6;
		
		//Action State
		public static var A_NOTHING:int = 0;
		public static var A_SELECT:int = 1;
		public static var A_MOVE:int = 2;
		public static var A_VIEW_SUPPLIES:int = 3;
		public static var A_VIEW_FACTION_SKILLS:int = 4;
		public static var A_VIEW_MISSION:int = 5;
		public static var A_END_TURN:int = 6;
		public static var A_GAME_MENU:int = 7;
		
		//====================================
		// Initialization variables
		//====================================
		private var levelLoaded:Boolean = false;
		
		//====================================
		// Game references
		//====================================
		private var _level:Level;
		public static var SCROLL_SPEED:Number = .8;
		
		
		//====================================
		// Game logic variables
		//====================================
		private var _currState:int = 0;
		private var currAction:int;
		private var _currActiveFaction:Faction;
		private var actionRunning:Boolean = false;
		
		private var _currClickedEntity:Entity;
		private var _currSelectedEntity:Entity;
		
		//Movement
		private var movePath:MovePath;
		private var currMovingEntity:Unit = null;
		
		//====================================
		//Hud variables
		//====================================
		private var h_entityPreview:EntityPreview;
		private var h_actionBar:ActionBar;
		private var h_infoBar:InfoBar;
		private var h_miniMap:MiniMap;
		private var h_detailScreen:DetailScreen;
		private var hudMgr:HudManager;
		
		//====================================
		// TEMPORARY
		//====================================
		private var tempPlyr:L_Human;
		private var tempCounter:int = 0;
		
		//====================================
		// This class handles the high-level game
		// logic, such as hud updating, inventory,
		// character, etc
		//====================================
		public function GameView()
		{
			super();
			currState = S_TURN_BEGIN;
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		protected function initialize(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			level = new Level(this);
			addChild(level);
			
			
			initHud();
			
			//Should overlay a load screen
			//initLoader();
		}
		
		private function initHud():void
		{
			hudMgr = new HudManager(this);
			
			initMiniMap();
			//dynamic windows
			h_entityPreview = new EntityPreview();
			hudMgr.addElement(h_entityPreview);
			addChild(h_entityPreview);
			h_entityPreview.visible = false;
			
			h_actionBar = new ActionBar();
			hudMgr.addElement(h_actionBar);
			h_actionBar.x = DeadWorld.EXPLICIT_WIDTH/2 - (h_actionBar.width/2);
			h_actionBar.y = DeadWorld.EXPLICIT_HEIGHT - h_actionBar.height;
			addChild(h_actionBar);
			
			h_infoBar = new InfoBar();
			hudMgr.addElement(h_infoBar);
			addChild(h_infoBar);
			h_infoBar.x = DeadWorld.EXPLICIT_WIDTH/2  - (h_infoBar.width/2);
			
			h_detailScreen = new DetailScreen();
			hudMgr.addElement(h_detailScreen);
			addChild(h_detailScreen);
			h_detailScreen.x = DeadWorld.EXPLICIT_WIDTH/2 - (h_detailScreen.width/2);
			h_detailScreen.y = DeadWorld.EXPLICIT_HEIGHT/2 - (h_detailScreen.height/2);
			h_detailScreen.clear();
			
		}
		
		private function initMiniMap():void
		{
			h_miniMap = new MiniMap();
			addChild(h_miniMap);
			//save orig width to get ratio
			var origMapWidth:Number = h_miniMap.width;
			h_miniMap.width = DeadWorld.EXPLICIT_WIDTH*.2;
			h_miniMap.height = (h_miniMap.width/origMapWidth)*h_miniMap.height;
			h_miniMap.x = DeadWorld.EXPLICIT_WIDTH-h_miniMap.width;
			//h_miniMap.y = DeadWorld.EXPLICIT_HEIGHT-h_miniMap.height;
		}
		
		public function update():void
		{
			if (level)
			{
				if (level.loaded)
				{
						switch (currState)
						{
							case S_TURN_BEGIN:
								beginTurn();
								break;
							case S_TURN_RUNNING:
								if (!actionRunning)
								{
									checkClick();
									checkTab();
								}
								else
								{
									if (currAction == A_MOVE)
									{
										doMove();
									}
								}
								break;
							case S_TURN_END:
								tempEndTurn();
								break;
						}
						//Always update these
						checkKeyboard();
						checkHudClick();
						checkMapMovement();
						level.update();
						hudMgr.update();
						
						//minimap won't go here anymore
						var deprecateWithNewHud:NONSENSE;
						checkMiniMapClick();
				}
			}
		}
		
		private function doMove():void
		{
			movePath.update();
			
			if (GameState.MOUSE_CLICKED && !GameState.MOUSE_CLICK_DRAG)
			{
				var clickTile:L_Tile = level.getTileAtPixelCoordinates(
					GameState.MOUSE_CLICK_POS.x - level.x, 
					GameState.MOUSE_CLICK_POS.y - level.y);
				
				Log.out("clicked while moving");
				if (clickTile == movePath.path[movePath.path.length-1].currTile)
				{
					Log.out("moving to tile!");
					moveUnitToTileOnPath();
				}
			}
			//Check if the player clicked or something in order to finish the movement
		}
		
		private function moveUnitToTileOnPath():void
		{
			currMovingEntity = currSelectedEntity as Unit;
			//update ap
			currMovingEntity.ap -= movePath.getCurrPathCost();
			h_infoBar.update();
			h_entityPreview.update();
			//first put the path into the entity
			for (var i:int = movePath.path.length-1; i > 0; i--)
			{
				currMovingEntity.movePath.push(new Point(
					movePath.path[i].x+movePath.x+(V_Tile.EXPLICIT_WIDTH/2),
					movePath.path[i].y+movePath.y+(V_Tile.EXPLICIT_HEIGHT/2)));
			}
			
			level.removeChild(movePath);
			//movePath.clear();
			
			//Then start the movement
			updateEntityMovement();
		}
		
		private function updateEntityMovement():void
		{
			if (currMovingEntity.movePath.length > 0)
			{
				Log.out("next node!");
				var currNode:Point = currMovingEntity.movePath[currMovingEntity.movePath.length-1];
				
				//Tween the rotation too
				var direction:int = getRotationBetweenPoints(currMovingEntity.getPositionPoint(), currNode);
				var eRotation:Number;
				
				switch (direction)
				{
					case DIR_UP:
						eRotation = deg2rad(0);
						break;
					case DIR_RIGHT:
						eRotation = deg2rad(90);
						break;
					case DIR_BOTTOM:
						eRotation = deg2rad(180);
						break;
					case DIR_LEFT:
						eRotation = deg2rad(270);
						break;
				}
				TweenLite.to(currMovingEntity, .1, {x:currNode.x, y:currNode.y, rotation:eRotation, ease:Linear.easeNone, onComplete:updateEntityMovement});
				currMovingEntity.movePath.splice(currMovingEntity.movePath.length-1,1);
			}
			else
			{
				clearAction();
//				actionRunning = false;
//				currAction = A_NOTHING;
			}
		}
		
		private function getRotationBetweenPoints(basePoint:Point, nextPoint:Point):int
		{
			//Up or down
			if (Math.abs(basePoint.x - nextPoint.x) < 5)
			{
				if (basePoint.y < nextPoint.y)
				{
					return DIR_BOTTOM;
				}
				else
				{
					return DIR_UP;
				}
			}
			else if (Math.abs(basePoint.y - nextPoint.y) < 5)
			{
				if (basePoint.x < nextPoint.x)
				{
					return DIR_RIGHT;
				}
				else
				{
					return DIR_LEFT;
				}
			}
			
			return DIR_UP;
		}				
		
		private function checkKeyboard():void
		{
			if (GameState.KEYS_PREV_DOWN[Keyboard.M] && !GameState.KEYS_DOWN[Keyboard.M])
			{
				checkMove();
			}
		}
		
		private function checkTab():void
		{
			if (GameState.KEYS_PREV_DOWN[Keyboard.TAB] && !GameState.KEYS_DOWN[Keyboard.TAB])
			{
				if (!actionRunning)
				{
					var nextSelectedEntity:Entity = level.f_player.getNextSelection(currSelectedEntity);
					if (nextSelectedEntity)
					{
						currClickedEntity = nextSelectedEntity;
						updateSelectedEntity(false, true);
					}
				}
			}
		}
		
		private function checkMove():void
		{
//			if (GameState.KEYS_PREV_DOWN[Keyboard.M] && !GameState.KEYS_DOWN[Keyboard.M])
//			{
				if (!actionRunning)
				{
					Log.out("move initiated!!");
					if (currSelectedEntity)
					{
						if (currSelectedEntity is L_Human)
						{
							if ((currSelectedEntity as L_Human).faction == level.f_player)
							{
								setAction(A_MOVE);
//								movePath = new MovePath(this);
//								level.addChild(movePath);
//								actionRunning = true;
//								currAction = A_MOVE;
//								movePath.start(currSelectedEntity as Unit);
//								movePath.x = currSelectedEntity.currTile.x*V_Tile.EXPLICIT_WIDTH;
//								movePath.y = currSelectedEntity.currTile.y*V_Tile.EXPLICIT_HEIGHT;
//								Log.out("starting move! at: x: " + movePath.x + " y: " + movePath.y);
							}
						}
					}	
				}
				else
				{
					if (currAction == A_MOVE)
					{
						level.removeChild(movePath);
						//						movePath.clear();
						clearAction()
//						actionRunning = false;
//						currAction = A_NOTHING;
					}
				}
//			}
		}
		
		private function beginTurn():void
		{
			h_actionBar.visible = true;
			currState = S_TURN_RUNNING;
			h_infoBar.setFaction(level.f_player);
		}
		
		private function tempEndTurn():void
		{
			if (tempCounter == 0)
			{
				h_actionBar.visible = false;
			}
			
			if (tempCounter < 120)
			{
				tempCounter++;
			}
			else
			{
				tempCounter = 0;
				currState = S_TURN_RUNNING;
			}
		}
		
		private function checkClick():void
		{
			if (GameState.MOUSE_CLICKED && !GameState.MOUSE_CLICK_DRAG)
			{
				if (!mouseOverHudElements())
				{
					//first check if the player clicked an entity
					currClickedEntity = getClickedEntity(level.getTileAtPixelCoordinates(
						GameState.MOUSE_CLICK_POS.x - level.x, 
						GameState.MOUSE_CLICK_POS.y - level.y));
					if (currClickedEntity)
					{
						//If they did, check if there is an entity already selected
						if (currSelectedEntity)
						{
							entityIsSelectedCheckClicked();
						}
						//If not, then set the current selected
						//entity to what the player clicked
						else
						{
							updateSelectedEntity();
						}
					}
					else
					{
						if (currSelectedEntity)
						{
							updateSelectedEntity(true);
						}
						
						var redundantHudUpdating:NONSENSE;
						HudManager.UPDATE_FLAG = true;
						hudMgr.update();
					}
				}
//				else
//				{
//					checkHudClick();
//				}
			}
		}
		
		private function checkHudClick():void
		{
			if (GameState.MOUSE_CLICKED && !GameState.MOUSE_CLICK_DRAG)
			{
				var currClickedHudItem:int = hudMgr.getClickedItem();
				
				switch (currClickedHudItem)
				{
					case HudManager.HCLICK_BTN_MOVE:
						checkMove();
						break;
					case HudManager.HCLICK_PREVIEW:
						openDetailScreen();
						break;
				}
			}
		}
		
		private function setAction(action:int):void
		{
			switch (action)
			{
				case A_MOVE:
					movePath = new MovePath(this);
					level.addChild(movePath);
					actionRunning = true;
					currAction = A_MOVE;
					movePath.start(currSelectedEntity as Unit);
					movePath.x = currSelectedEntity.currTile.x*V_Tile.EXPLICIT_WIDTH;
					movePath.y = currSelectedEntity.currTile.y*V_Tile.EXPLICIT_HEIGHT;
					Log.out("starting move! at: x: " + movePath.x + " y: " + movePath.y);
					break;
			}
		}
		
		private function clearAction():void
		{
			actionRunning = false;
			currAction = A_NOTHING;
		}
		
		/**
		 * This function only fires if the player had an entity
		 * selected, and they clicked an entity 
		 * 
		 */		
		private function entityIsSelectedCheckClicked():void
		{
			//If there is one selected, check if it's owned
			//by the player
			//But first make sure its a human
			if (currClickedEntity is L_Human)
			{
				if ((currClickedEntity as L_Human).faction ==
					level.f_player)
				{
					//If it is already selected
					if (currSelectedEntity == currClickedEntity)
					{
						//If if is, open the units inventory
						openDetailScreen();
					}
					else
					{
						updateSelectedEntity();
					}
				}
				else
				{
					if ((currSelectedEntity as L_Human).faction ==
						level.f_player)
					{
						//If its not owned by the player, and
						//the currselected unit is the player's,
						//check to see if the unit is by the current 
						//selected entity
						if (currClickedEntity.currTile.top == currSelectedEntity.currTile ||
							currClickedEntity.currTile.right == currSelectedEntity.currTile ||
							currClickedEntity.currTile.bottom == currSelectedEntity.currTile ||
							currClickedEntity.currTile.left == currSelectedEntity.currTile)
						{
							var clickedUnitNextToEntity:NONSENSE;
							//do actions!
						}
						//else (check if within weapon range)
						else
						{
							updateSelectedEntity();
						}
					}
					else
					{
						if (currSelectedEntity == currClickedEntity)
						{
							openDetailScreen();
						}
						else
						{
							updateSelectedEntity();
						}
					}
				}
			}
			else
			{
				if (currClickedEntity == currSelectedEntity)
				{
					openDetailScreen();
				}
				else
				{
					updateSelectedEntity();
				}
			}
		}		
		
		private function openDetailScreen():void
		{
			hudMgr.openDetailScreen(currSelectedEntity);
		}
		
		/**
		 * 
		 * @param deselect=false
		 * 	Set to true if you are deselecting the entity. Otherwise,
		 * leave it false
		 * 
		 */
		private function updateSelectedEntity(deselect:Boolean=false, moveScreen:Boolean=false):void
		{
			Log.out("Updating entity selection");
			if (deselect)
			{
				Log.out("Deselecting...");
				currSelectedEntity = null;
				hudMgr.updateSelection();
			}
			else
			{
				Log.out("Selecting!");
				//prevent reupdating the selection
				if (currSelectedEntity != currClickedEntity)
				{
					currSelectedEntity = currClickedEntity;
					hudMgr.updateSelection(currSelectedEntity);
				}
			}
			
			if (!deselect && moveScreen)
			{
				moveScreenToEntity(currSelectedEntity);
			}
		}
		
		private function getClickedEntity(tile:L_Tile):Entity
		{
			var clickedEntity:Entity = null;
			for each (var e:Entity in tile.chunk.entities)
			{
				if ((GameState.MOUSE_CLICK_POS.x - level.x) > (e.x-(e.width/2)) &&
					(GameState.MOUSE_CLICK_POS.y - level.y) > (e.y-(e.height/2)) &&
					(GameState.MOUSE_CLICK_POS.x - level.x) < (e.x+(e.width/2)) &&
					(GameState.MOUSE_CLICK_POS.y - level.y) < (e.y+(e.height/2)))
				{
					//Make sure the entity is not a doodad
					if (!(e is L_Doodad))
					{
						clickedEntity = e;
					}
				}
			}
			
			return clickedEntity;
		}
		
		//======================================
		//DEPRECATE THIS
		//======================================
		private function checkClickedEntity(tile:L_Tile):int
		{
			var clickedEntity:int = CLICKED_NOTHING;
			for each (var e:Entity in tile.chunk.entities)
			{
				if (e.v_component)
				{
					if ((GameState.MOUSE_CLICK_POS.x - level.x) > e.v_component.x &&
						(GameState.MOUSE_CLICK_POS.y - level.y) > e.v_component.y &&
						(GameState.MOUSE_CLICK_POS.x - level.x) < (e.v_component.x+e.v_component.width) &&
						(GameState.MOUSE_CLICK_POS.y - level.y) < (e.v_component.y+e.v_component.height))
					{
						if (e != currSelectedEntity)
						{
							if (currSelectedEntity)
							{
								currSelectedEntity.v_component.alpha = 1;
							}
							Log.out("Clicked entity!");
							clickedEntity = GameView.CLICKED_NEW_ENTITY;
							//currSelectedEntity = e;
							//moveScreenToEntity(e);
							
							var tempUnitSelectionChecking:NONSENSE;
							//e.v_component.alpha = .5;
						}
						else
						{
							clickedEntity = GameView.CLICKED_SAME_ENTITY;
						}
					}
				}
			}
			
			return clickedEntity;
		}
		
		private function moveScreenToEntity(e:Entity):void
		{
			var xPos:Number = -1*(e.x-(DeadWorld.EXPLICIT_WIDTH/2));
			var yPos:Number = -1*(e.y-(DeadWorld.EXPLICIT_HEIGHT/2));
			TweenLite.to(level.screenPos, 1, {x:xPos, y:yPos});
		}
		
		private function checkMiniMapClick():void
		{
			if (GameState.MOUSE_DOWN)
			{
				if (mouseOverMiniMap())
				{
					//level.screenPos.x = (TileManager.NUM_V_TILES_WIDE/2)*V_Tile.EXPLICIT_WIDTH;
					//Log.out(level.screenPos.x);
					var xPos:Number = (((GameState.MOUSE_POS.x - h_miniMap.x)/h_miniMap.width)
						*TileManager.NUM_L_TILES_WIDE*V_Tile.EXPLICIT_WIDTH)
						-(DeadWorld.EXPLICIT_WIDTH/2);
					var yPos:Number = (((GameState.MOUSE_POS.y - h_miniMap.y)/h_miniMap.height)
						*TileManager.NUM_L_TILES_HEIGH*V_Tile.EXPLICIT_HEIGHT)
						-(DeadWorld.EXPLICIT_HEIGHT/2);
					
					//Log.out("Location on minimap: x: " + xPos +
					//		" y: " + yPos);
					
					xPos = -1*(xPos);
					yPos = -1*(yPos);
					
					TweenLite.to(level.screenPos, 1, {x:xPos, y:yPos});
					
				}
			}
		}
		
		private function checkMapMovement():void
		{
//			if (currSelectedEntity)
//			{
//				if (GameState.KEYS_DOWN[Keyboard.A])
//				{
//					//currSelectedEntity.velX += -SCROLL_SPEED;
//					//level.screenPos.x -= SCROLL_SPEED;
//				}
//				if (GameState.KEYS_DOWN[Keyboard.D])
//				{
//					//currSelectedEntity.velX += SCROLL_SPEED;
//					//level.screenPos.x += SCROLL_SPEED;
//				}
//				
//				if (GameState.KEYS_DOWN[Keyboard.W])
//				{
//					//currSelectedEntity.velY += -SCROLL_SPEED;
//					//level.screenPos.y -= SCROLL_SPEED;
//				}
//				if (GameState.KEYS_DOWN[Keyboard.S])
//				{
//					//currSelectedEntity.velY += SCROLL_SPEED;
//					//level.screenPos.y += SCROLL_SPEED;
//				}
//			}
			//do mouse scrolling
			if (GameState.MOUSE_DOWN)
			{
				if (!mouseOverHudElements())
				{
					if (GameState.MOUSE_PREV_POS.x != GameState.MOUSE_POS.x)
					{
						level.screenPos.x += GameState.MOUSE_POS.x - GameState.MOUSE_PREV_POS.x;
					}
					
					if (GameState.MOUSE_PREV_POS.y != GameState.MOUSE_POS.y)
					{
						level.screenPos.y += GameState.MOUSE_POS.y - GameState.MOUSE_PREV_POS.y;
					}
				}
			}
			
			if (GameState.KEYS_DOWN[Keyboard.SPACE])
			{
				//reset to 0
				if (currSelectedEntity)
				{
					moveScreenToEntity(currSelectedEntity);
				}
			}
			
//			if (movePath.visible)
//			{
//				movePath.x = level.x;
//				movePath.y = level.y;
//			}
		}
		
		private function mouseOverHudElements():Boolean
		{
			//Check each element in the hud, to see if the
			//mouse is over it, but for now just check against the minimap
			for each (var e:Sprite in hudMgr.elements)
			{
				if (e.visible)
				{
					if (GameState.MOUSE_DOWN_START_POS.x > e.x &&
						GameState.MOUSE_DOWN_START_POS.y > e.y &&
						GameState.MOUSE_DOWN_START_POS.x < (e.x + e.width) &&
						GameState.MOUSE_DOWN_START_POS.y < (e.y + e.height))
					{
						if (GameState.MOUSE_POS.x > e.x &&
							GameState.MOUSE_POS.y > e.y &&
							GameState.MOUSE_POS.x < (e.x + e.width) &&
							GameState.MOUSE_POS.y < (e.y + e.height))
						{
							return true;
						}
					}
				}
			}
			
			return false;
		}
		
		private function mouseOverMiniMap():Boolean
		{
			//First check the starting mouse position to
			//prevent map scrolling when dragging map
			if (GameState.MOUSE_DOWN_START_POS.x > h_miniMap.x &&
				GameState.MOUSE_DOWN_START_POS.y > h_miniMap.y &&
				GameState.MOUSE_DOWN_START_POS.x < (h_miniMap.x + h_miniMap.width) &&
				GameState.MOUSE_DOWN_START_POS.y < (h_miniMap.y + h_miniMap.height))
			{
				if (GameState.MOUSE_POS.x > h_miniMap.x &&
					GameState.MOUSE_POS.y > h_miniMap.y &&
					GameState.MOUSE_POS.x < (h_miniMap.x + h_miniMap.width) &&
					GameState.MOUSE_POS.y < (h_miniMap.y + h_miniMap.height))
				{
					return true;
				}
			}
			return false;
		}

		public function get currState():int
		{
			return _currState;
		}

		public function set currState(value:int):void
		{
			_currState = value;
		}

		public function get currSelectedEntity():Entity
		{
			return _currSelectedEntity;
		}

		public function set currSelectedEntity(value:Entity):void
		{
			_currSelectedEntity = value;
		}

		public function get currClickedEntity():Entity
		{
			return _currClickedEntity;
		}

		public function set currClickedEntity(value:Entity):void
		{
			_currClickedEntity = value;
		}

		public function get currActiveFaction():Faction
		{
			return _currActiveFaction;
		}

		public function set currActiveFaction(value:Faction):void
		{
			_currActiveFaction = value;
		}

		public function get level():Level
		{
			return _level;
		}

		public function set level(value:Level):void
		{
			_level = value;
		}


	}
}