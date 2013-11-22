package game.tiles
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.net.URLRequest;
	
	import game.Level;
	
	import starling.display.Sprite;
	
	public class TileManager
	{
		private var _level:Level;
		private var _tileLayer:Vector.<Sprite>;
		
		private var v_tiles:Vector.<Vector.<V_Tile>>;
		private var l_tiles:Vector.<Vector.<L_Tile>>;
		
		private var _chunkMgr:ChunkManager;
		
		public static var NUM_L_TILES_WIDE:int;
		public static var NUM_L_TILES_HEIGH:int;
		
		public static var NUM_V_TILES_WIDE:int;
		public static var NUM_V_TILES_HEIGH:int;
		
		//corner tiles
		private var lTL:L_Tile;
		private var lTR:L_Tile;
		private var lBL:L_Tile;
		private var lBR:L_Tile;
		
		private var _vTL:V_Tile;
		private var _vTR:V_Tile;
		private var _vBL:V_Tile;
		private var _vBR:V_Tile;
		
		//Map loading
		private var loader:Loader;
		private var mapData:BitmapData;
		public var mapLoaded:Boolean = false;
		
		//points for flipping
		/*private var fTLx = 0;
		private var fTLy = 0;
		private var fBRx = 0;
		private var fBRy = 0;
		*/
		
		public function TileManager(lvl:Level, tileLyr:Vector.<Sprite>)
		{
			_level = lvl;
			_tileLayer = tileLyr;
			
			initialize();
		}
		
		public function update():void
		{
			if (mapLoaded)
			{
				checkMapScrolling();
				chunkMgr.update();
			}
		}
		
		private function checkMapScrolling():void
		{
			//check if at the end of the map
			
			//if not, then flip the tiles
			//NOTWORKIGNRIGHT
			var scrollingFinished:Boolean = false;
			var chunksHaveNotFlipped:Boolean = true;
			var prevHeight:int;
			
			while(!scrollingFinished)
			{
				chunksHaveNotFlipped = true;
				//left scrolling
				if (((vTL.x + V_Tile.EXPLICIT_WIDTH) + level.x) < 0  &&
					vTR.lTile != lTR)
				{
					var prevLTile:L_Tile;
					var nextTile:V_Tile = vTL;
					do
					{
						nextTile.x = vTR.x + V_Tile.EXPLICIT_WIDTH;
						//set the logical tile
						prevLTile = nextTile.lTile;
						nextTile.lTile = nextTile.left.lTile.right;
						prevLTile.vTile = null;
						
						//Goto the next tile
						nextTile = nextTile.bottom;
					}
					while(nextTile != vTL)
					
					vTR = vTL;
					vBR = vBL;
					
					vTL = vTL.right;
					vBL = vBL.right;
				}
				//right scrolling
				else if ((vTR.x + level.x) > DeadWorld.EXPLICIT_WIDTH &&
					vTL.lTile != lTL)
				{
					var prevLTile:L_Tile;
					var nextTile:V_Tile = vTR;
					do
					{
						nextTile.x = vTL.x - V_Tile.EXPLICIT_WIDTH;
						//set the logical tile
						prevLTile = nextTile.lTile;
						nextTile.lTile = nextTile.right.lTile.left;
						prevLTile.vTile = null;
						
						//Goto the next tile
						nextTile = nextTile.bottom;
					}
					while(nextTile != vTR)
					
					vTL = vTR;
					vBL = vBR;
					
					vTR = vTR.left;
					vBR = vBR.left;
				}
				//top scrolling
				else if (((vTL.y + V_Tile.EXPLICIT_HEIGHT) + level.y) < 0 &&
					vBL.lTile != lBL)
				{
					var prevLTile:L_Tile;
					var nextTile:V_Tile = vTL;
					do
					{
						nextTile.y = vBL.y + V_Tile.EXPLICIT_HEIGHT;
						//set the logical tile
						prevLTile = nextTile.lTile;
						nextTile.lTile = nextTile.top.lTile.bottom;
						prevLTile.vTile = null;
						
						//Goto the next tile
						nextTile = nextTile.right;
					}
					while(nextTile != vTL)
					
					vBL = vTL;
					vBR = vTR;
					
					vTL = vBL.bottom;
					vTR = vBR.bottom;
				}
				//down scrolling
				else if ((vTL.y + level.y) > 0 &&
					vTL.lTile != lTL)
				{
					var prevLTile:L_Tile;
					var nextTile:V_Tile = vBL;
					do
					{
						nextTile.y = vTL.y - V_Tile.EXPLICIT_HEIGHT;
						//set the logical tile
						prevLTile = nextTile.lTile;
						nextTile.lTile = nextTile.bottom.lTile.top;
						prevLTile.vTile = null;
						
						//Goto the next tile
						nextTile = nextTile.right;
					}
					while(nextTile != vBL)
					
					vTL = vBL;
					vTR = vBR;
					
					vBL = vTL.top;
					vBR = vTR.top;
				}
				else
				{
					scrollingFinished = true;
				}
				//check if the next chunk needs to be loaded
			}
		}
		
		//===============================================================
		// UTILITY FUNCTIONS
		//===============================================================
		public function getTileAtCoords(x:int, y:int):L_Tile
		{
			return l_tiles[y][x];
		}
		
		public function getTileAtPixelCoordinates(x:Number, y:Number):L_Tile
		{
			var xPos:int = Math.floor(x/V_Tile.EXPLICIT_WIDTH);
			var yPos:int = Math.floor(y/V_Tile.EXPLICIT_HEIGHT);
			
			if (xPos < 0) 
			{
				xPos = 0;
			}
			else if (xPos > NUM_L_TILES_WIDE-1)
			{
				xPos = NUM_L_TILES_WIDE-1;
			}
			
			if (yPos < 0)
			{
				yPos = 0;
			}
			else if (yPos > NUM_L_TILES_HEIGH-1)
			{
				yPos = NUM_L_TILES_HEIGH-1;
			}
			
			return l_tiles[yPos][xPos];
		}
		
		//===============================================================
		// INITIALIZE FUNCTIONS
		//===============================================================
		private function initialize():void
		{
			loadData();
			//loadTiles();
		}
		
		private function loadData():void
		{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onMapLoadComplete);
			loader.load(new URLRequest(File.applicationDirectory.nativePath + "/assets/testMap.png"));

		}
		
		private function onMapLoadComplete(e:Event):void
		{
			Log.out("bitmap loaded!");
			mapData = Bitmap(LoaderInfo(e.target).content).bitmapData;
			
			//just hard code a number of tiles for the game for simplicity for the time being
			NUM_L_TILES_WIDE = mapData.width;
			NUM_L_TILES_HEIGH = mapData.height;
			
			NUM_V_TILES_WIDE = Math.ceil(DeadWorld.EXPLICIT_WIDTH/V_Tile.EXPLICIT_WIDTH) + 1;
			NUM_V_TILES_HEIGH = Math.ceil(DeadWorld.EXPLICIT_HEIGHT/V_Tile.EXPLICIT_HEIGHT) + 1;
			
			//temporary
			level.screenPos = new Point();
			level.screenPos.x = 0;
			level.screenPos.y = 0;
			
			level.prevScreenPos = new Point();
			level.prevScreenPos.x = 0;
			level.prevScreenPos.y = 0;
			//load map data or something
			
			loadTiles();
			
			//Tiles are done; tell level to load entities
			Level.initEntities();
		}
		
		private function loadTiles():void
		{
			//====================================
			// Logical tile loading
			//====================================
			l_tiles = new Vector.<Vector.<L_Tile>>();
			
			var tempTile:L_Tile;
			
			//temporary tile type loading
			var temporaryTileType:NONSENSE;
			var rand:Number;
			
			var id:int = 0;
			
			//initialize and load the logical tiles
			for (var h:int = 0; h < NUM_L_TILES_HEIGH; h++)
			{
				l_tiles.push(new Vector.<L_Tile>());
				
				for (var w:int = 0; w < NUM_L_TILES_WIDE; w++)
				{
					tempTile = new L_Tile();
					l_tiles[h].push(tempTile);
					
					tempTile.x = w;
					tempTile.y = h;
					tempTile.id = id;
					
					var currPixel:uint = mapData.getPixel(w, h);
					TileBlender.loadTileType(tempTile, currPixel);
					id++;
				}
			}
			
			//====================================
			// View tile loading
			//====================================
			v_tiles = new Vector.<Vector.<V_Tile>>();
			
			var tempVTile:V_Tile;
			id = 0;
			
			for (var h:int = 0; h < NUM_V_TILES_HEIGH; h++)
			{
				v_tiles.push(new Vector.<V_Tile>());
				
				for (var w:int = 0; w < NUM_V_TILES_WIDE; w++)
				{
					tempVTile = new V_Tile();
					v_tiles[h].push(tempVTile);
					
					tempVTile.x = w*V_Tile.EXPLICIT_WIDTH;
					tempVTile.y = h*V_Tile.EXPLICIT_HEIGHT;
					tempVTile.t_id = id;
					
					id++;
				}
			}
			
			//====================================
			// Tile flipping vector
			//====================================
			
			linkTiles();
			TileBlender.setupTileBlending(l_tiles);
			linkViewTilesToLogicalTiles();
			loadChunks();
		}
		
		private function loadChunks():void
		{
			chunkMgr = new ChunkManager(l_tiles, level);
			
		}
		
		private function linkViewTilesToLogicalTiles():void
		{
			var tempVTile:V_Tile;
			
			for (var h:int = 0; h < NUM_V_TILES_HEIGH; h++)
			{
				for (var w:int = 0; w < NUM_V_TILES_WIDE; w++)
				{
					tempVTile = v_tiles[h][w];
					tempVTile.lTile = l_tiles[level.screenPos.y+h][level.screenPos.x+w];
					
					//fix height issues later
					var fixHeightIssues:NONSENSE;
					tileLayer[0].addChild(tempVTile);
				}
			}
		}
		
		private function linkTiles():void
		{
			linkLogicalTiles();
			linkViewTiles();
		}
		
		private function linkLogicalTiles():void
		{
			for (var h:int = 0; h < NUM_L_TILES_HEIGH; h++)
			{
				for (var w:int = 0; w < NUM_L_TILES_WIDE; w++)
				{
					//===================
					// COLUMN SPECIFIC
					//===================
					//link left if not first column
					if (w > 0)
					{
						l_tiles[h][w].left = l_tiles[h][w-1];
					}
					var logicalTileWrapping:NONSENSE;
					/*dont have to for logical tiles really. take this out*/
					//link right if last in the column
					if (w == (NUM_L_TILES_WIDE-1))
					{
						l_tiles[h][w].right = l_tiles[h][0];
					}
					//===================
					// ROW SPECIFIC
					//===================
					//link top if not first row
					if (h > 0)
					{
						l_tiles[h][w].top = l_tiles[h-1][w];
					}
					logicalTileWrapping;
					/*dont have to for logical tiles really. take this out*/
					//link right if last in the column
					//link bottom if last row
					if (h == (NUM_L_TILES_HEIGH-1))
					{
						l_tiles[h][w].bottom = l_tiles[0][w];
					}
				}
			}
			
			//set the corner tiles
			lTL = l_tiles[0][0];
			lTR = l_tiles[0][NUM_L_TILES_WIDE-1];
			lBL = l_tiles[NUM_L_TILES_HEIGH-1][0];
			lBR = l_tiles[NUM_L_TILES_HEIGH-1][NUM_L_TILES_WIDE-1];
			
			vTL = v_tiles[0][0];
			vTR = v_tiles[0][NUM_V_TILES_WIDE-1];
			vBL = v_tiles[NUM_V_TILES_HEIGH-1][0];
			vBR = v_tiles[NUM_V_TILES_HEIGH-1][NUM_V_TILES_WIDE-1];
		}
		
		private function linkViewTiles():void
		{
			for (var h:int = 0; h < NUM_V_TILES_HEIGH; h++)
			{
				for (var w:int = 0; w < NUM_V_TILES_WIDE; w++)
				{
					//===================
					// COLUMN SPECIFIC
					//===================
					//link left if not first column
					if (w > 0)
					{
						v_tiles[h][w].left = v_tiles[h][w-1];
					}
					//link right if last in the column
					if (w == (NUM_V_TILES_WIDE-1))
					{
						v_tiles[h][w].right = v_tiles[h][0];
					}
					//===================
					// ROW SPECIFIC
					//===================
					//link top if not first row
					if (h > 0)
					{
						v_tiles[h][w].top = v_tiles[h-1][w];
					}
					//link right if last in the column
					//link bottom if last row
					if (h == (NUM_V_TILES_HEIGH-1))
					{
						v_tiles[h][w].bottom = v_tiles[0][w];
					}
				}
			}
			mapLoaded = true;
		}
		
		//====================================
		// BEGIN GETTERS/SETTERS
		//====================================
		public function get level():Level
		{
			return _level;
		}

		public function set level(value:Level):void
		{
			_level = value;
		}
		
		public function get tileLayer():Vector.<Sprite>
		{
			return _tileLayer;
		}

		public function set tileLayer(value:Vector.<Sprite>):void
		{
			_tileLayer = value;
		}

		
		public function get vBR():V_Tile
		{
			return _vBR;
		}
		
		public function set vBR(value:V_Tile):void
		{
			_vBR = value;
		}
		
		public function get vBL():V_Tile
		{
			return _vBL;
		}
		
		public function set vBL(value:V_Tile):void
		{
			_vBL = value;
		}
		
		public function get vTR():V_Tile
		{
			return _vTR;
		}
		
		public function set vTR(value:V_Tile):void
		{
			_vTR = value;
		}
		
		public function get vTL():V_Tile
		{
			return _vTL;
		}
		
		public function set vTL(value:V_Tile):void
		{
			_vTL = value;
		}

		
		public function get chunkMgr():ChunkManager
		{
			return _chunkMgr;
		}

		public function set chunkMgr(value:ChunkManager):void
		{
			_chunkMgr = value;
		}


	}
}