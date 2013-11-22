package game.ui
{
	import game.tiles.L_Tile;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class PathPoint extends Sprite
	{
		public static const SPR_A_H:String = "path/A_H";
		public static const SPR_A_V:String = "path/A_V";
		public static const SPR_A_TL:String = "path/A_TL";
		public static const SPR_A_TR:String = "path/A_TR";
		public static const SPR_A_BR:String = "path/A_BR";
		public static const SPR_A_BL:String = "path/A_BL";
		public static const SPR_A_E_R:String = "path/A_E_R";
		public static const SPR_A_E_B:String = "path/A_E_B";
		public static const SPR_A_E_L:String = "path/A_E_L";
		public static const SPR_A_E_T:String = "path/A_E_T";
		public static const SPR_A_S:String = "path/A_S";
		
		public static const DIR_N:int = 0;
		public static const DIR_T:int = 1;
		public static const DIR_R:int = 2;
		public static const DIR_B:int = 3;
		public static const DIR_L:int = 4;
		
		private var _prevPoint:PathPoint;
		private var _nextPoint:PathPoint;
		
		private var _prevDirection:int;
		
		private var _type:String;
		private var image:Image;
		private var _currTile:L_Tile;
		
		public function PathPoint(t:String, tile:L_Tile, prev:PathPoint=null)
		{
			super();
			prevPoint = prev;
			currTile = tile;
			if (prev)
			{
				if (prev.currTile.right == currTile)
				{
					prevDirection = DIR_L;
				}
				else if (prev.currTile.bottom == currTile)
				{
					prevDirection = DIR_T;
				}
				else if (prev.currTile.left == currTile)
				{
					prevDirection = DIR_R;
				}
				else if (prev.currTile.top == currTile)
				{
					prevDirection = DIR_B;
				}
			}
			else
			{
				prevDirection = DIR_N;
			}
			
			setGraphic(t);
		}
		
		public function setGraphic(t:String):void
		{
			type = t;
			
			if (image)
			{
				removeChild(image);
			}
			
			image = new Image(Assets.getAtlas().getTexture(type));
			addChild(image);
		}

		public function get currTile():L_Tile
		{
			return _currTile;
		}

		public function set currTile(value:L_Tile):void
		{
			_currTile = value;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public function get prevDirection():int
		{
			return _prevDirection;
		}

		public function set prevDirection(value:int):void
		{
			_prevDirection = value;
		}

		public function get prevPoint():PathPoint
		{
			return _prevPoint;
		}

		public function set prevPoint(value:PathPoint):void
		{
			_prevPoint = value;
		}

		public function get nextPoint():PathPoint
		{
			return _nextPoint;
		}

		public function set nextPoint(value:PathPoint):void
		{
			_nextPoint = value;
		}


	}
}