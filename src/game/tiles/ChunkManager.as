package game.tiles
{
	import game.Level;

	public class ChunkManager
	{
		private var level:Level;
		
		public static var NUM_L_CHUNKS_WIDE:int;
		public static var NUM_L_CHUNKS_HEIGH:int;
		
		public static var NUM_V_CHUNKS_WIDE:int;
		public static var NUM_V_CHUNKS_HEIGH:int;
		
		//This is for chunk flipping
		public static var FLIP_RIGHT:int = 0;
		public static var FLIP_LEFT:int = 1;
		public static var FLIP_DOWN:int = 2;
		public static var FLIP_UP:int = 3;
		
		//-1 is flag to not flip.
		private var _flip:int = -1;
		
		private var _vTL:V_Chunk;
		private var _vTR:V_Chunk;
		private var _vBL:V_Chunk;
		private var _vBR:V_Chunk;
		
		private var _lTL:L_Chunk;
		private var _lTR:L_Chunk;
		private var _lBL:L_Chunk;
		private var _lBR:L_Chunk;
		
		private var v_chunks:Vector.<Vector.<V_Chunk>>;
		private var l_chunks:Vector.<Vector.<L_Chunk>>;
		
		private var _vChunks:Vector.<V_Chunk>;
		
		public function ChunkManager(l_tiles:Vector.<Vector.<L_Tile>>, lvl:Level)
		{
			l_chunks = new Vector.<Vector.<L_Chunk>>();
			v_chunks = new Vector.<Vector.<V_Chunk>>();
			vChunks = new Vector.<V_Chunk>();
			level = lvl;
			
			initLogicalChunks(l_tiles);
			initViewChunks();
		}
		
		private function initLogicalChunks(l_tiles:Vector.<Vector.<L_Tile>>):void
		{
			NUM_L_CHUNKS_WIDE = TileManager.NUM_L_TILES_WIDE/L_Chunk.NUM_C_TILES_WIDE;
			NUM_L_CHUNKS_HEIGH = TileManager.NUM_L_TILES_HEIGH/L_Chunk.NUM_C_TILES_HEIGH;
			
			l_chunks = new Vector.<Vector.<L_Chunk>>();
			
			var tempChunk:L_Chunk;
			
			for (var h:int = 0; h < NUM_L_CHUNKS_HEIGH; h++)
			{
				l_chunks.push(new Vector.<L_Chunk>());
				
				for (var w:int = 0; w < NUM_L_CHUNKS_WIDE; w++)
				{
					tempChunk = new L_Chunk();
					tempChunk.xPos = w*L_Chunk.NUM_C_TILES_WIDE*V_Tile.EXPLICIT_WIDTH;
					tempChunk.yPos = h*L_Chunk.NUM_C_TILES_HEIGH*V_Tile.EXPLICIT_HEIGHT;
					
					l_chunks[h].push(tempChunk);
				}
			}
			
			//Now link together the chunks
			for (var h:int = 0; h < NUM_L_CHUNKS_HEIGH; h++)
			{
				for (var w:int = 0; w < NUM_L_CHUNKS_WIDE; w++)
				{
					//===================
					// COLUMN SPECIFIC
					//===================
					//link left if not first column
					if (w > 0)
					{
						l_chunks[h][w].left = l_chunks[h][w-1];
					}
					var logicalTileWrapping:NONSENSE;
					/*dont have to for logical tiles really. take this out*/
					//link right if last in the column
					if (w == (NUM_L_CHUNKS_WIDE-1))
					{
						l_chunks[h][w].right = l_chunks[h][0];
					}
					//===================
					// ROW SPECIFIC
					//===================
					//link top if not first row
					if (h > 0)
					{
						l_chunks[h][w].top = l_chunks[h-1][w];
					}
					logicalTileWrapping;
					/*dont have to for logical tiles really. take this out*/
					//link right if last in the column
					//link bottom if last row
					if (h == (NUM_L_CHUNKS_HEIGH-1))
					{
						l_chunks[h][w].bottom = l_chunks[0][w];
					}
				}
			}
			
			//Set logical chunk corners
			lTL = l_chunks[0][0];
			lTR = l_chunks[0][NUM_L_CHUNKS_WIDE-1];
			lBL = l_chunks[NUM_L_CHUNKS_HEIGH-1][0];
			lBR = l_chunks[NUM_L_CHUNKS_HEIGH-1][NUM_L_CHUNKS_WIDE-1];
			
			var currColumn:int = 0;
			var currRow:int = 0;
			var currTile:L_Tile;
			//Now populate the chunks with tiles
			//might not be workign right
			var idkIfAllChunksAreLoadingRight:NONSENSE;
			trace("Chunks: wide: " + NUM_L_CHUNKS_WIDE + " heigh: " + NUM_L_CHUNKS_HEIGH);
			for (var h:int = 0; h < NUM_L_CHUNKS_HEIGH; h++)
			{
				for (var w:int = 0; w < NUM_L_CHUNKS_WIDE; w++)
				{
					tempChunk = l_chunks[h][w];
					
					for (var dH:int = 0; dH < L_Chunk.NUM_C_TILES_HEIGH; dH++)
					{
						for (var dW:int = 0; dW < L_Chunk.NUM_C_TILES_WIDE; dW++)
						{
							currTile = l_tiles[h*L_Chunk.NUM_C_TILES_HEIGH+dH][w*L_Chunk.NUM_C_TILES_WIDE+dW];
							currTile.chunk = tempChunk;
							tempChunk.l_tiles[dH].push(currTile);
						}
					}
				}
			}
		}
		
		private function initViewChunks():void
		{
			NUM_V_CHUNKS_WIDE = (Math.ceil((DeadWorld.EXPLICIT_WIDTH/V_Tile.EXPLICIT_WIDTH)/L_Chunk.NUM_C_TILES_WIDE)+1);
			NUM_V_CHUNKS_HEIGH = (Math.ceil((DeadWorld.EXPLICIT_HEIGHT/V_Tile.EXPLICIT_HEIGHT)/L_Chunk.NUM_C_TILES_HEIGH)+1);
			
			//Check to make sure the view chunks are not
			//greater than the number of total chunks. If
			//so, set the view chunks to equal the total chunks
			if (NUM_V_CHUNKS_WIDE > NUM_L_CHUNKS_WIDE)
			{
				NUM_V_CHUNKS_WIDE = NUM_L_CHUNKS_WIDE;
			}
			
			if (NUM_V_CHUNKS_HEIGH > NUM_L_CHUNKS_HEIGH)
			{
				NUM_V_CHUNKS_HEIGH = NUM_L_CHUNKS_HEIGH;
			}
			
			trace("Num vChunks wide: " + NUM_V_CHUNKS_WIDE + " heigh: " + NUM_V_CHUNKS_HEIGH);
			
			//Create all of the view chunks
			var tempChunk:V_Chunk;
			
			for (var h:int = 0; h < NUM_V_CHUNKS_HEIGH; h++)
			{
				v_chunks.push(new Vector.<V_Chunk>());
				
				for (var w:int = 0; w < NUM_V_CHUNKS_WIDE; w++)
				{
					tempChunk = new V_Chunk();
					
					v_chunks[h].push(tempChunk);
					vChunks.push(tempChunk);
				}
			}
			
			//Now link together the viewChunks
			for (var h:int = 0; h < NUM_V_CHUNKS_HEIGH; h++)
			{
				for (var w:int = 0; w < NUM_V_CHUNKS_WIDE; w++)
				{
					//===================
					// viewCOLUMN SPECIFIC
					//===================
					//link left if not first viewColumn
					if (w > 0)
					{
						v_chunks[h][w].left = v_chunks[h][w-1];
					}
					var chunkWrapping:NONSENSE;
					/*dont have to for logical tiles really. take this out*/
					//link right if last in the viewColumn
					if (w == (NUM_V_CHUNKS_WIDE-1))
					{
						v_chunks[h][w].right = v_chunks[h][0];
					}
					//===================
					// ROW SPECIFIC
					//===================
					//link top if not first row
					if (h > 0)
					{
						v_chunks[h][w].top = v_chunks[h-1][w];
					}
					chunkWrapping;
					/*dont have to for logical tiles really. take this out*/
					//link right if last in the viewColumn
					//link bottom if last row
					if (h == (NUM_V_CHUNKS_HEIGH-1))
					{
						v_chunks[h][w].bottom = v_chunks[0][w];
					}
				}
				trace("tiles should be linked!");
			}
			
			//Link the view chunks to the logical chunks
			//Have to make sure the view chunks will fit. Start by checking the
			//location of the bottom right view tile. If it's at the edge, then
			//we know to shift all of the view chunks over
			
			//================================
			// WE ARE GOING TO ASSUME IT WILL
			// ALWAYS START TOP LEFT. If the game
			// starts elsewhere, just
			// move it after level initalization
			//================================
			
			//Set the top left view chunk based on the top left
			vTL = v_chunks[0][0];
			vTR = v_chunks[0][NUM_V_CHUNKS_WIDE-1];
			vBL = v_chunks[NUM_V_CHUNKS_HEIGH-1][0];
			vBR = v_chunks[NUM_V_CHUNKS_HEIGH-1][NUM_V_CHUNKS_WIDE-1];
			//Now link to logical chunks
			
			for (var h:int = 0; h < NUM_V_CHUNKS_HEIGH; h++)
			{
				for (var w:int = 0; w < NUM_V_CHUNKS_WIDE; w++)
				{
					v_chunks[h][w].lChunk = l_chunks[h][w];
					v_chunks[h][w].lChunk.loaded = true;
				}
			}
		}

		public function update():void
		{
			//Check for chunk flipping
			var scrollingFinished:Boolean = false;
			while (!scrollingFinished)
			{
				//Left and Right scrolling
				if ((vTL.lChunk.xPos + (V_Tile.EXPLICIT_WIDTH*L_Chunk.NUM_C_TILES_WIDE) + level.x) < 0 &&
					vTR.lChunk != lTR)
				{
					flip = FLIP_RIGHT;
				}
				else if ((vTR.lChunk.xPos + level.x) > DeadWorld.EXPLICIT_WIDTH &&
					vTL.lChunk != lTL)
				{
					flip = FLIP_LEFT;
				}
				
				//Up and Down scrolling
				if ((vTL.lChunk.yPos + (V_Tile.EXPLICIT_HEIGHT*L_Chunk.NUM_C_TILES_HEIGH) + level.y) < 0 &&
					vBL.lChunk != lBL)
				{
					flip = FLIP_DOWN;
				}
				else if ((vTL.lChunk.yPos + level.y) > 0 &&
					vTL.lChunk != lTL)
				{
					flip = FLIP_UP;
				}
				else
				{
					scrollingFinished = true;
				}
			}
		}
		
		//========================================================
		// Begin Getters/Setters
		//========================================================
		public function get lBR():L_Chunk
		{
			return _lBR;
		}

		public function set lBR(value:L_Chunk):void
		{
			_lBR = value;
		}

		public function get lBL():L_Chunk
		{
			return _lBL;
		}

		public function set lBL(value:L_Chunk):void
		{
			_lBL = value;
		}

		public function get lTR():L_Chunk
		{
			return _lTR;
		}

		public function set lTR(value:L_Chunk):void
		{
			_lTR = value;
		}

		public function get lTL():L_Chunk
		{
			return _lTL;
		}

		public function set lTL(value:L_Chunk):void
		{
			_lTL = value;
		}

		public function get vBR():V_Chunk
		{
			return _vBR;
		}

		public function set vBR(value:V_Chunk):void
		{
			_vBR = value;
		}

		public function get vBL():V_Chunk
		{
			return _vBL;
		}

		public function set vBL(value:V_Chunk):void
		{
			_vBL = value;
		}

		public function get vTR():V_Chunk
		{
			return _vTR;
		}

		public function set vTR(value:V_Chunk):void
		{
			_vTR = value;
		}

		public function get vTL():V_Chunk
		{
			return _vTL;
		}

		public function set vTL(value:V_Chunk):void
		{
			_vTL = value;
		}

		public function get flip():int
		{
			return _flip;
		}

		public function set flip(value:int):void
		{
			//asdfasdf
			//Do the flipping as the value gets set
			//NOTWORKIGNRIGHT
			var chunkFlippingWrapsCouldBeBadOnSmallMaps:NONSENSE;
			switch (value)
			{
				case FLIP_RIGHT:
					//First check if its at the edge of the map
					//var prevLChunk:L_Chunk;
					trace("flip right!");
					var nextChunk:V_Chunk = vTL;
					//if (vTL.left.lChunk != lTL)
					//{
						do
						{
							nextChunk.lChunk = nextChunk.left.lChunk.right;
							nextChunk = nextChunk.bottom;
						}
						while (nextChunk != vTL)
					//}
					
					vTR = vTL;
					vBR = vBL;
					
					vTL = vTL.right;
					vBL = vBL.right;
					break;
				case FLIP_LEFT:
					//First check if its at the edge of the map
					//var prevLChunk:L_Chunk;
					trace("flip left!");
					var nextChunk:V_Chunk = vTR;
					//if (vTR.right.lChunk != lTR)
					//{
						do
						{
							nextChunk.lChunk = nextChunk.right.lChunk.left;
							nextChunk = nextChunk.bottom;
						}
						while (nextChunk != vTR)
					//}
					
					vTL = vTR;
					vBL = vBR;
					
					vTR = vTR.left;
					vBR = vBR.left;
					break;
				case FLIP_DOWN:
					//First check if its at the edge of the map
					//var prevLChunk:L_Chunk;
					trace("flip down!");
					var nextChunk:V_Chunk = vTL;
					//if (vTL.top.lChunk != lTL)
					//{
						do
						{
							nextChunk.lChunk = nextChunk.top.lChunk.bottom;
							nextChunk = nextChunk.right;
						}
						while (nextChunk != vTL)
					//}
					
					vBL = vTL;
					vBR = vTR;
					
					vTL = vBL.bottom;
					vTR = vBR.bottom;
					break;
				case FLIP_UP:
					//First check if its at the edge of the map
					//var prevLChunk:L_Chunk;
					trace("flip up!");
					var nextChunk:V_Chunk = vBL;
					//if (vBL.bottom.lChunk != lBL)
					//{
						do
						{
							nextChunk.lChunk = nextChunk.bottom.lChunk.top;
							nextChunk = nextChunk.right;
						}
						while (nextChunk != vBL)
					//}
					
					vTL = vBL;
					vTR = vBR;
					
					vBL = vTL.top;
					vBR = vTR.top;
					break;
			}
			
			var chunkFlipPrivVarUseless:NONSENSE;
			//Hmm. This really serves no purpose after this.
			//Possibly get rid of this and delete the var at the top
			//and get rid of the gettter?
			_flip = value;
		}

		public function get vChunks():Vector.<V_Chunk>
		{
			return _vChunks;
		}

		public function set vChunks(value:Vector.<V_Chunk>):void
		{
			_vChunks = value;
		}


		//========================================================
		// End Getters/Setters
		//========================================================
	}
}