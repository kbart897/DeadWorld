package game
{
	import flash.display.Screen;
	import flash.geom.Point;
	
	import game.ai.Faction;
	import game.entities.Entity;
	import game.entities.EntityManager;
	import game.entities.L_Doodad;
	import game.entities.L_Human;
	import game.tiles.ChunkManager;
	import game.tiles.L_Tile;
	import game.tiles.TileManager;
	import game.tiles.V_Tile;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	import views.GameView;
	import views.IUpdateable;
	import views.ViewOverlay;
	
	public class Level extends Sprite implements IUpdateable
	{
		private static var _instance:Level;
		private var tileMgr:TileManager;
		private var gView:GameView;
		
		//====================================
		// references
		//====================================
		private var _screenPos:Point;
		private var _prevScreenPos:Point;
		
		//====================================
		// Layers
		// - They are mostly vectors so that it is easy
		// - to references which height level an object is in
		//====================================
		private var groundLayer:Vector.<Sprite>;
		private var skyLayer:Sprite;
		
		private var dayNight:ViewOverlay;
		
		private var tileLayer:Vector.<Sprite>;
		private var doodadLayer:Vector.<Sprite>;
		private var entityLayer:Vector.<Sprite>;
		private var fxLayer:Vector.<Sprite>;
		
		//=====================================
		// Entities
		//=====================================
		private var _entitiesInitialized:Boolean = false;
		private var entityMgr:EntityManager;
		
		//=====================================
		// Initialization variables
		//=====================================
		private var _loaded:Boolean = false;
		
		//=====================================
		// Game scripting variables
		//=====================================
		//Factions
		private var _f_player:Faction;
		private var _f_enemy:Faction;
		
		//TEMPORARY
		public var tempPerson:L_Human;
		
		public function Level(view:GameView)
		{
			_instance = this;
			gView = view;
			super();
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		public function update():void
		{
			if (tileMgr.mapLoaded)
			{
				updateScreenPosition();
				tileMgr.update();
				entityMgr.update();
			}
			
		}
		
		private function updateScreenPosition():void
		{
			//left checking
			if (_screenPos.x > 0)
			{
				_screenPos.x = 0;
				this.x = 0;
			}
			else
			{
				this.x = Math.floor(_screenPos.x);
			}
			//top checking
			if (_screenPos.y > 0)
			{
				_screenPos.y = 0;
				this.y = 0;
			}
			else
			{
				this.y = Math.floor(_screenPos.y);
			}
			
			//Right checking
			if (_screenPos.x < -1*((TileManager.NUM_L_TILES_WIDE*V_Tile.EXPLICIT_WIDTH)-DeadWorld.EXPLICIT_WIDTH))
			{
				_screenPos.x = -1*((TileManager.NUM_L_TILES_WIDE*V_Tile.EXPLICIT_WIDTH)-DeadWorld.EXPLICIT_WIDTH);
				this.x = _screenPos.x;
			}
			
			//Bottom checking
			if (_screenPos.y < -1*((TileManager.NUM_L_TILES_HEIGH*V_Tile.EXPLICIT_HEIGHT)-DeadWorld.EXPLICIT_HEIGHT))
			{
				_screenPos.y = -1*((TileManager.NUM_L_TILES_HEIGH*V_Tile.EXPLICIT_HEIGHT)-DeadWorld.EXPLICIT_HEIGHT);
				this.y = _screenPos.y;
			}
			//}
			//else
			//{
			//	_prevScreenPos = new Point(_screenPos.x, _screenPos.y);
			//}
		}
		
		//====================================
		// INITIALIZE FUNCTIONS
		//====================================
		protected function initialize(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			initLayers();
			
			//load map/world data
			
			initTiles();
			
			//load entities
			//initEntities();
		}
		
		public static function initEntities():void
		{
			if (!_instance.entitiesInitialized)
			{
				_instance.entitiesInitialized = true;
				_instance.initFactions();
				_instance.initEntities();
			}
		}
		
		private function initFactions():void
		{
			//Temporary until we get factions
			//fully figured out
			f_player = new Faction();
			f_player.ownerId = Faction.F_PLAYER;
			f_player.name = "Player";
			
			f_enemy = new Faction();
			f_enemy.ownerId = 1;
			f_enemy.name = "Enemy";
		}
		
		private function initEntities():void
		{
			
			Log.out("entities initializing...");
			entityMgr = new EntityManager(tileMgr, entityLayer);
			initDoodads();
			
			//temporarily add some people
			tempPerson = new L_Human(f_player);
			entityMgr.addEntity(tempPerson, 150, 150);
			var randPerson:L_Human;
			for (var i:int = 0; i < 1000; i++)
			{
				if (i < 3)
				{
					randPerson = new L_Human(f_player);
				}
				else
				{
					randPerson = new L_Human(f_enemy);
				}
				entityMgr.addEntity(randPerson);
			}
			Log.out("added human");
			
			loaded = true;
			GameState.minimizeConsole(true);
		}
		
		private function initDoodads():void
		{
			//Create a bunch of random doodads
			var currTile:L_Tile;
			var randChance:Number;
			var randChance2:Number;
			var rareChance:Number = .001;
			var smallChance:Number = .01;
			var medChance:Number = .05;
			var highChance:Number = .1;
			var tempDoodad:L_Doodad;
			for (var h:int = 0; h < TileManager.NUM_L_TILES_HEIGH; h++)
			{
				for (var w:int = 0; w < TileManager.NUM_L_TILES_WIDE; w++)
				{
					currTile = getTileAtPixelCoordinates(w*V_Tile.EXPLICIT_WIDTH,
						h*V_Tile.EXPLICIT_HEIGHT);
					
					if (currTile.type == L_Tile.TYPE_GRASS)
					{
						randChance = Math.random();
						randChance2 = Math.random();
						
						if (randChance2 < rareChance)
						{
							tempDoodad = new L_Doodad(L_Doodad.T_BLOOD);
							entityMgr.addEntity(tempDoodad, w*V_Tile.EXPLICIT_WIDTH, h*V_Tile.EXPLICIT_HEIGHT, true);
						}
						
						if (randChance < smallChance)
						{
							tempDoodad = new L_Doodad(L_Doodad.T_TREE);
							entityMgr.addEntity(tempDoodad, w*V_Tile.EXPLICIT_WIDTH, h*V_Tile.EXPLICIT_HEIGHT);
						}
						else if (randChance < medChance)
						{
							tempDoodad = new L_Doodad(L_Doodad.T_BUSH);
							entityMgr.addEntity(tempDoodad, w*V_Tile.EXPLICIT_WIDTH, h*V_Tile.EXPLICIT_HEIGHT, true);
						}
					}
					else if (currTile.type == L_Tile.TYPE_SIDEWALK)
					{
						randChance = Math.random();
						randChance2 = Math.random();
						
						if (randChance2 < smallChance)
						{
							tempDoodad = new L_Doodad(L_Doodad.T_BLOOD);
							entityMgr.addEntity(tempDoodad, w*V_Tile.EXPLICIT_WIDTH, h*V_Tile.EXPLICIT_HEIGHT, true);
						}
						
						if (randChance < smallChance)
						{
							tempDoodad = new L_Doodad(L_Doodad.T_GARBAGE);
							entityMgr.addEntity(tempDoodad, w*V_Tile.EXPLICIT_WIDTH, h*V_Tile.EXPLICIT_HEIGHT);
						}
						else if (randChance < medChance)
						{
							tempDoodad = new L_Doodad(L_Doodad.T_CAN);
							entityMgr.addEntity(tempDoodad, w*V_Tile.EXPLICIT_WIDTH, h*V_Tile.EXPLICIT_HEIGHT, true);
						}
					}
					else if (currTile.type == L_Tile.TYPE_ROAD)
					{
						randChance = Math.random();
						randChance2 = Math.random();
						
						if (randChance2 < rareChance)
						{
							tempDoodad = new L_Doodad(L_Doodad.T_ROAD_BROKEN);
							entityMgr.addEntity(tempDoodad, w*V_Tile.EXPLICIT_WIDTH, h*V_Tile.EXPLICIT_HEIGHT, true);
							
						}
						else if (randChance2 < smallChance)
						{
							tempDoodad = new L_Doodad(L_Doodad.T_BLOOD);
							entityMgr.addEntity(tempDoodad, w*V_Tile.EXPLICIT_WIDTH, h*V_Tile.EXPLICIT_HEIGHT, true);
						}
						
						if (randChance < smallChance)
						{
							tempDoodad = new L_Doodad(L_Doodad.T_SKIDMARK);
							entityMgr.addEntity(tempDoodad, w*V_Tile.EXPLICIT_WIDTH, h*V_Tile.EXPLICIT_HEIGHT, true);
						}
						else if (randChance < medChance)
						{
							randChance2 = Math.random();
							
							if (randChance2 < .5)
							{
								tempDoodad = new L_Doodad(L_Doodad.T_CAN);
								entityMgr.addEntity(tempDoodad, w*V_Tile.EXPLICIT_WIDTH, h*V_Tile.EXPLICIT_HEIGHT, true);
							}
							else
							{
								tempDoodad = new L_Doodad(L_Doodad.T_PAPER);
								entityMgr.addEntity(tempDoodad, w*V_Tile.EXPLICIT_WIDTH, h*V_Tile.EXPLICIT_HEIGHT, true);
							}
						}
					}
					else if (currTile.type == L_Tile.TYPE_DIRT)
					{
						randChance = Math.random();
						randChance2 = Math.random();
						
						if (randChance2 < rareChance)
						{
							tempDoodad = new L_Doodad(L_Doodad.T_BUSH);
							entityMgr.addEntity(tempDoodad, w*V_Tile.EXPLICIT_WIDTH, h*V_Tile.EXPLICIT_HEIGHT, true);
							
						}
//						else if (randChance2 < smallChance)
//						{
//							tempDoodad = new L_Doodad(L_Doodad.T_BLOOD);
//							entityMgr.addEntity(tempDoodad, w*V_Tile.EXPLICIT_WIDTH, h*V_Tile.EXPLICIT_HEIGHT);;
//						}
						
						if (randChance < smallChance)
						{
							tempDoodad = new L_Doodad(L_Doodad.T_BLOOD);
							entityMgr.addEntity(tempDoodad, w*V_Tile.EXPLICIT_WIDTH, h*V_Tile.EXPLICIT_HEIGHT);;
						}
//						else if (randChance < medChance)
//						{
//							tempDoodad = new L_Doodad(L_Doodad.T_CAN);
//							entityMgr.addEntity(tempDoodad, w*V_Tile.EXPLICIT_WIDTH, h*V_Tile.EXPLICIT_HEIGHT);;
//						}
					}
				}
			}
		}
		
		//====================================
		// BEGIN UTILITY FUNCTIONS
		//====================================
		public function getTileAtPixelCoordinates(x:Number, y:Number):L_Tile
		{
			return tileMgr.getTileAtPixelCoordinates(x, y);
		}
		
		//====================================
		// END UTILITY FUNCTIONS
		//====================================
		
		//====================================
		// BEGIN LAYER FUNCTIONS
		//====================================
		private function initLayers():void
		{
			//====================================
			// Add the game layers to the stage
			//====================================
			//Start with the ground; it is on bottom
			groundLayer = new Vector.<Sprite>();
			
			//Initialize the ground layer vectors before adding ground layers
			tileLayer = new Vector.<Sprite>();
			doodadLayer = new Vector.<Sprite>();
			entityLayer = new Vector.<Sprite>();
			fxLayer = new Vector.<Sprite>();
			
			//====================================
			// Initialize height layers in the ground layer
			//====================================
			addGroundLayer(0);
			addGroundLayer(1);
			
			//The sky is on top of the world
			skyLayer = new Sprite();
			addChild(skyLayer);
			
			//add the view overlay to the sky layer
			//dayNight = new ViewOverlay();
			//skyLayer.addChild(dayNight);
		}
		
		private function addGroundLayer(height:int):void
		{
			var currGroundLayer:Sprite = new Sprite();
			groundLayer.push(currGroundLayer);
			addChild(currGroundLayer);
			
			tileLayer.push(new Sprite);
			currGroundLayer.addChild(tileLayer[height]);
			
			doodadLayer.push(new Sprite);
			currGroundLayer.addChild(doodadLayer[height]);
			
			entityLayer.push(new Sprite);
			currGroundLayer.addChild(entityLayer[height]);
			
			fxLayer.push(new Sprite);
			currGroundLayer.addChild(fxLayer[height]);
		}
		//====================================
		// END LAYER FUNCTIONS
		//====================================
		
		//====================================
		// BEGIN TILE FUNCTIONS
		//====================================
		private function initTiles():void
		{
			//create the tile to handle all tile logic
			tileMgr = new TileManager(this, tileLayer);
		}
		
		//====================================
		// END TILE FUNCTIONS
		//====================================
		
		public function get screenPos():Point
		{
			return _screenPos;
		}
		
		public function set screenPos(value:Point):void
		{
			_screenPos = value;
		}

		public function get prevScreenPos():Point
		{
			return _prevScreenPos;
		}

		public function set prevScreenPos(value:Point):void
		{
			_prevScreenPos = value;
		}

		public function get entitiesInitialized():Boolean
		{
			return _entitiesInitialized;
		}

		public function set entitiesInitialized(value:Boolean):void
		{
			_entitiesInitialized = value;
		}

		public function get f_player():Faction
		{
			return _f_player;
		}

		public function set f_player(value:Faction):void
		{
			_f_player = value;
		}

		public function get f_enemy():Faction
		{
			return _f_enemy;
		}

		public function set f_enemy(value:Faction):void
		{
			_f_enemy = value;
		}

		public function get loaded():Boolean
		{
			return _loaded;
		}

		public function set loaded(value:Boolean):void
		{
			_loaded = value;
		}


	}
}