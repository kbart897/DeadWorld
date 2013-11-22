package game.tiles
{
	import game.entities.Entity;

	public class L_Chunk
	{
		//A chunk is loaded when there are active units in that chunk, and
		//when an active unit can see the current chunk
		public static var NUM_C_TILES_WIDE:int = 16;
		public static var NUM_C_TILES_HEIGH:int = 16;
		
		private var _l_tiles:Vector.<Vector.<L_Tile>>;
		
		private var _active:Boolean = false;
		private var _loaded:Boolean = false;
		
		private var _vChunk:V_Chunk;
		
		//=========================================
		//This is the whole purpose of the chunk:For entity optimization
		//=========================================
		private var _entities:Vector.<Entity>;
		
		private var _top:L_Chunk;
		private var _right:L_Chunk;
		private var _bottom:L_Chunk;
		private var _left:L_Chunk;
		private var _xPos:int;
		private var _yPos:int;
		
		
		public function L_Chunk()
		{
			
			l_tiles = new Vector.<Vector.<L_Tile>>();
			
			_entities = new Vector.<Entity>();
			
			for (var h:int = 0; h < NUM_C_TILES_HEIGH; h++)
			{
				l_tiles.push(new Vector.<L_Tile>());
				//for (var w:int = 0; w < NUM_C_TILES_WIDE; w++)
				//{
					
				//}
			}
		}
		
		
		public function get l_tiles():Vector.<Vector.<L_Tile>>
		{
			return _l_tiles;
		}

		public function set l_tiles(value:Vector.<Vector.<L_Tile>>):void
		{
			_l_tiles = value;
		}

		public function get yPos():int
		{
			return _yPos;
		}

		public function set yPos(value:int):void
		{
			_yPos = value;
		}

		public function get xPos():int
		{
			return _xPos;
		}

		public function set xPos(value:int):void
		{
			_xPos = value;
		}

		public function get left():L_Chunk
		{
			return _left;
		}

		public function set left(value:L_Chunk):void
		{
			_left = value;
			if (!value.right)
			{
				value.right = this;
			}
		}

		public function get bottom():L_Chunk
		{
			return _bottom;
		}

		public function set bottom(value:L_Chunk):void
		{
			_bottom = value;
			if (!value.top)
			{
				value.top = this;
			}
		}

		public function get right():L_Chunk
		{
			return _right;
		}

		public function set right(value:L_Chunk):void
		{
			_right = value;
			if (!value.left)
			{
				value.left = this;
			}
		}

		public function get top():L_Chunk
		{
			return _top;
		}

		public function set top(value:L_Chunk):void
		{
			_top = value;
			if (!value.bottom)
			{
				value.bottom = this;
			}
		}

		public function get entities():Vector.<Entity>
		{
			return _entities;
		}

		public function set entities(value:Vector.<Entity>):void
		{
			_entities = value;
		}

		public function get active():Boolean
		{
			return _active;
		}

		public function set active(value:Boolean):void
		{
			_active = value;
		}

		public function get loaded():Boolean
		{
			return _loaded;
		}

		public function set loaded(value:Boolean):void
		{
			_loaded = value;
		}

		public function get vChunk():V_Chunk
		{
			return _vChunk;
		}

		public function set vChunk(value:V_Chunk):void
		{
			_vChunk = value;
		}


	}
}