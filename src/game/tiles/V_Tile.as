package game.tiles
{
	//import views.world.TileMC;
	//import flash.display.Bitmap;
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.Sprite;
	
	//import game.Assets;
	
	public class V_Tile extends Sprite
	{
		//====================================
		// Constant reference varaibles
		//====================================
		//Dirt
		public static var TYPE_D_G_1_T:int = 101;
		public static var TYPE_D_G_1_R:int = 102;
		public static var TYPE_D_G_1_B:int = 103;
		public static var TYPE_D_G_1_L:int = 104;
		public static var TYPE_D_G_2_BL:int = 105;
		public static var TYPE_D_G_2_BR:int = 106;
		public static var TYPE_D_G_2_TR:int = 107;
		public static var TYPE_D_G_2_TL:int = 108;
		public static var TYPE_D_G_2_V:int = 109;
		public static var TYPE_D_G_2_H:int = 110;
		public static var TYPE_D_G_3_T:int = 111;
		public static var TYPE_D_G_3_R:int = 112;
		public static var TYPE_D_G_3_B:int = 113;
		public static var TYPE_D_G_3_L:int = 114;
		public static var TYPE_D_G_4:int = 115;
		public static var TYPE_D_O:int = 116;
		
		//Grass
		public static var TYPE_G_O:int = 200;
		
		//Water
		public static var TYPE_W_G_1_T:int = 301;
		public static var TYPE_W_G_1_R:int = 302;
		public static var TYPE_W_G_1_B:int = 303;
		public static var TYPE_W_G_1_L:int = 304;
		
		public static var TYPE_W_G_2_BL:int = 305;
		public static var TYPE_W_G_2_BR:int = 306;
		public static var TYPE_W_G_2_TR:int = 307;
		public static var TYPE_W_G_2_TL:int = 308;
		public static var TYPE_W_G_2_V:int = 309;
		public static var TYPE_W_G_2_H:int = 310;
		
		public static var TYPE_W_G_3_T:int = 311;
		public static var TYPE_W_G_3_R:int = 312;
		public static var TYPE_W_G_3_B:int = 313;
		public static var TYPE_W_G_3_L:int = 314;
		
		public static var TYPE_W_G_4:int = 315;
		public static var TYPE_W_O:int = 316;
		
		//Road
		public static var TYPE_R_O_T:int = 401;
		public static var TYPE_R_O_R:int = 402;
		public static var TYPE_R_O_B:int = 403;
		public static var TYPE_R_O_L:int = 404;
		public static var TYPE_R_W_T:int = 405;
		public static var TYPE_R_W_R:int = 406;
		public static var TYPE_R_W_B:int = 407;
		public static var TYPE_R_W_L:int = 408;
		public static var TYPE_RCI_BL:int = 409;
		public static var TYPE_RCI_BR:int = 410;
		public static var TYPE_RCI_TR:int = 411;
		public static var TYPE_RCI_TL:int = 412;
		public static var TYPE_RCO_BL:int = 413;
		public static var TYPE_RCO_BR:int = 414;
		public static var TYPE_RCO_TL:int = 415;
		public static var TYPE_RCO_TR:int = 416;
		
		//Sidewalk
		public static var TYPE_S_T:int = 501;
		public static var TYPE_S_R:int = 502;
		public static var TYPE_S_B:int = 503;
		public static var TYPE_S_L:int = 504;
		public static var TYPE_SCI_BL:int = 505;
		public static var TYPE_SCI_BR:int = 506;
		public static var TYPE_SCI_TR:int = 507;
		public static var TYPE_SCI_TL:int = 508;
		public static var TYPE_SCO_BL:int = 509;
		public static var TYPE_SCO_BR:int = 510;
		public static var TYPE_SCO_TL:int = 511;
		public static var TYPE_SCO_TR:int = 512;
		
		public static var TYPE_SCI_BL_NR:int = 513;
		public static var TYPE_SCI_BL_NT:int = 514;
		
		public static var TYPE_SCI_BR_NL:int = 515;
		public static var TYPE_SCI_BR_NT:int = 516;
		
		public static var TYPE_SCI_TR_NL:int = 517;
		public static var TYPE_SCI_TR_NB:int = 518;
		
		public static var TYPE_SCI_TL_NR:int = 519;
		public static var TYPE_SCI_TL_NB:int = 520;
		public static var TYPE_S_O:int = 521;
		
		//Building
		public static var TYPE_B_1_T:int = 601;
		public static var TYPE_B_1_R:int = 602;
		public static var TYPE_B_1_B:int = 603;
		public static var TYPE_B_1_L:int = 604;
		
		public static var TYPE_B_2_BL:int = 605;
		public static var TYPE_B_2_BR:int = 606;
		public static var TYPE_B_2_TL:int = 607;
		public static var TYPE_B_2_TR:int = 608;
		public static var TYPE_B_2_V:int = 609;
		public static var TYPE_B_2_H:int = 610;
		
		public static var TYPE_B_3_T:int = 611;
		public static var TYPE_B_3_R:int = 612;
		public static var TYPE_B_3_B:int = 613;
		public static var TYPE_B_3_L:int = 614;
		
		public static var TYPE_B_4:int = 615;
		public static var TYPE_B_O:int = 616;
		
		//====================================
		// Class varaibles
		//====================================
		private var _type:int;
		public static var EXPLICIT_HEIGHT:int = 16;
		public static var EXPLICIT_WIDTH:int = 16;
		
		//Tile Types
		public static var T_NULL:int = 1;
		public static var T_GRASS:int = 2;
		public static var T_WATER:int = 3;
		
		private var _t_type:int;
		private var _t_id:int;
		
		private var _t_height:int;
		
		private var _left:V_Tile;
		private var _right:V_Tile;
		private var _top:V_Tile;
		private var _bottom:V_Tile;
		
		private var _lTile:L_Tile;
		
		private var tileImg:Image;
		
		public function V_Tile()
		{
			super();
		}
		
		//========================================================
		// Begin Tile Getter/Setters
		//========================================================
		public function get left():V_Tile
		{
			return _left;
		}
		
		public function set left(value:V_Tile):void
		{
			_left = value;
			if (!_left.right)
			{
				_left.right = this;
			}
		}
		
		public function get right():V_Tile
		{
			return _right;
		}
		
		public function set right(value:V_Tile):void
		{
			_right = value;
			if (!_right.left)
			{
				_right.left = this;
			}
		}
		
		public function get top():V_Tile
		{
			return _top;
		}
		
		public function set top(value:V_Tile):void
		{
			_top = value;
			if (!_top.bottom)
			{
				_top.bottom = this;				
			}
		}
		
		public function get bottom():V_Tile
		{
			return _bottom;
		}
		
		public function set bottom(value:V_Tile):void
		{
			_bottom = value;
			if (!_bottom.top)
			{
				_bottom.top = this;
			}
		}
		
		public function get lTile():L_Tile
		{
			return _lTile;
		}
		
		//========================================================
		// Whenever the view tile is updated, update the tile image
		//========================================================
		public function set lTile(value:L_Tile):void
		{
			//Unlink the old logical tile from this
			//tile, then link this tile to the new
			//logical tile, and link the new logical
			//tile to this tile
			if (_lTile)
			{
				_lTile.vTile = null;
			}
			_lTile = value;
			_lTile.vTile = this;
			
			//Remove the old texture
			if (tileImg)
			{
				removeChild(tileImg);
			}
			
			TileFactory.setTileImage(tileImg, this);
			
			if (tileImg)
			{
				tileImg.blendMode = BlendMode.NONE;
			}
			
		}
		
		
		public function get t_type():int
		{
			return _t_type;
		}

		public function set t_type(value:int):void
		{
			_t_type = value;
		}

		public function get t_id():int
		{
			return _t_id;
		}

		public function set t_id(value:int):void
		{
			_t_id = value;
		}

		public function get t_height():int
		{
			return _t_height;
		}

		public function set t_height(value:int):void
		{
			_t_height = value;
		}
		//========================================================
		// End Tile Getters/Setters
		//========================================================
	}
}