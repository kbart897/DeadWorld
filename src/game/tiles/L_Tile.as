package game.tiles
{
	import flash.geom.Point;
	
	import game.tiles.V_Tile;
	
	public class L_Tile
	{
		//====================================
		// Constant reference varaibles
		//====================================
		public static const TYPE_NULL:int = 1;
		public static const TYPE_GRASS:int = 2;
		public static const TYPE_ROAD:int = 3;
		public static const TYPE_SIDEWALK:int = 4;
		public static const TYPE_WATER:int = 5;
		public static const TYPE_DIRT:int = 6;
		public static const TYPE_BUILDING:int = 7;
		
		//====================================
		// Class variables
		//====================================
		private var _type:int;
		private var _id:int;
		private var _height:int = 0;
		private var _walkable:Boolean = true;
		
		public var tempAlpha:Number = 1;
		
		//View tile type will be related to the orientation
		//and blending tile image for the view tile
		private var _viewTileType:int;
		
		private var _chunk:L_Chunk;
		
		private var _x:int;
		private var _y:int;
		
		//linking
		private var _left:L_Tile = null;
		private var _topLeft:L_Tile = null;
		private var _top:L_Tile = null;
		private var _topRight:L_Tile = null;
		private var _right:L_Tile = null;
		private var _bottomRight:L_Tile = null;
		private var _bottom:L_Tile = null;
		private var _bottomLeft:L_Tile = null;
		
		private var _vTile:V_Tile;
		
		public function L_Tile()
		{
			
		}

		//========================================================
		// Begin Getter/Setters
		//========================================================

		public function get chunk():L_Chunk
		{
			return _chunk;
		}

		public function set chunk(value:L_Chunk):void
		{
			_chunk = value;
		}

		public function get left():L_Tile
		{
			return _left;
		}
		
		public function set left(value:L_Tile):void
		{
			_left = value;
			if (!_left.right)
			{
				_left.right = this;
			}
		}
		
		public function get bottomLeft():L_Tile
		{
			return _bottomLeft;
		}
		
		public function set bottomLeft(value:L_Tile):void
		{
			_bottomLeft = value;
			if (!_bottomLeft.topRight)
			{
				_bottomLeft.topRight = this;
			}
		}
		
		public function get bottom():L_Tile
		{
			return _bottom;
		}
		
		public function set bottom(value:L_Tile):void
		{
			_bottom = value;
			if (!_bottom.top)
			{
				_bottom.top = this;
			}
		}
		
		public function get bottomRight():L_Tile
		{
			return _bottomRight;
		}
		
		public function set bottomRight(value:L_Tile):void
		{
			_bottomRight = value;
			if (!_bottomRight.topLeft)
			{
				_bottomRight.topLeft = this;
			}
		}
		
		public function get right():L_Tile
		{
			return _right;
		}
		
		public function set right(value:L_Tile):void
		{
			_right = value;
			if (!_right.left)
			{
				_right.left = this;
			}
		}
		
		public function get topRight():L_Tile
		{
			return _topRight;
		}
		
		public function set topRight(value:L_Tile):void
		{
			_topRight = value;
			if (!_topRight.bottomLeft)
			{
				_topRight.bottomLeft = this;
			}
		}
		
		public function get top():L_Tile
		{
			return _top;
		}
		
		public function set top(value:L_Tile):void
		{
			_top = value;
			if (!_top.bottom)
			{
				_top.bottom = this;				
			}
		}
		
		public function get topLeft():L_Tile
		{
			return _topLeft;
		}
		
		public function set topLeft(value:L_Tile):void
		{
			_topLeft = value;
			if (!_topLeft.bottomRight)
			{
				_topLeft.bottomRight = this;				
			}
		}
		
		//========================================================
		// End Tile Getters/Setters
		//========================================================
		
		public function get type():int
		{
			return _type;
		}

		public function set type(value:int):void
		{
			_type = value;
		}

		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}

		public function get x():int
		{
			return _x;
		}

		public function set x(value:int):void
		{
			_x = value;
		}

		public function get y():int
		{
			return _y;
		}

		public function set y(value:int):void
		{
			_y = value;
		}

		public function get viewTileType():int
		{
			return _viewTileType;
		}

		public function set viewTileType(value:int):void
		{
			_viewTileType = value;
		}

		public function get height():int
		{
			return _height;
		}

		public function set height(value:int):void
		{
			_height = value;
		}

		public function get vTile():V_Tile
		{
			return _vTile;
		}

		public function set vTile(value:V_Tile):void
		{
			_vTile = value;
		}

		public function get walkable():Boolean
		{
			return _walkable;
		}

		public function set walkable(value:Boolean):void
		{
			_walkable = value;
		}


	}
}