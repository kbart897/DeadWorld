package game.tiles
{
	import starling.display.Image;

	public class TileFactory
	{
		public static function setTileImage(tileImg:Image, tile:V_Tile):void
		{
			//Set the new image
			if (tile.lTile.type == L_Tile.TYPE_GRASS)
			{
				setGrassImage(tileImg, tile);
			}
			else if (tile.lTile.type == L_Tile.TYPE_WATER)
			{
				TileFactory.setWaterImage(tileImg, tile);
			}
			else if (tile.lTile.type == L_Tile.TYPE_DIRT)
			{
				TileFactory.setDirtImage(tileImg, tile);
			}
			else if (tile.lTile.type == L_Tile.TYPE_BUILDING)
			{
				TileFactory.setBuildingImage(tileImg, tile);
			}
			else if (tile.lTile.type == L_Tile.TYPE_ROAD)
			{
				TileFactory.setRoadImage(tileImg, tile);
			}
			else if (tile.lTile.type == L_Tile.TYPE_SIDEWALK)
			{
				TileFactory.setSidewalkImage(tileImg, tile);
			}
			else
			{
				tileImg = new Image(Assets.getAtlas().getTexture("G_O"));
				tile.addChild(tileImg);
			}
			tile.t_height = tile.lTile.height;
		}
		
		public static function setGrassImage(tileImg:Image, tile:V_Tile):void
		{
			tileImg = new Image(Assets.getAtlas().getTexture("G_O"));
			tile.addChild(tileImg);
		}
		
		public static function setWaterImage(tileImg:Image, tile:V_Tile):void
		{
			if (tile.lTile.viewTileType == V_Tile.TYPE_W_G_1_T)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("W_G_1_T"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_W_G_1_R)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("W_G_1_R"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_W_G_1_B)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("W_G_1_B"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_W_G_1_L)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("W_G_1_L"));
				tile.addChild(tileImg);
			}
				
				//2 sides
			else if (tile.lTile.viewTileType == V_Tile.TYPE_W_G_2_BL)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("W_G_2_BL"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_W_G_2_BR)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("W_G_2_BR"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_W_G_2_TL)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("W_G_2_TL"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_W_G_2_TR)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("W_G_2_TR"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_W_G_2_H)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("W_G_2_H"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_W_G_2_V)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("W_G_2_V"));
				tile.addChild(tileImg);
			}
				
				//3 sides
			else if (tile.lTile.viewTileType == V_Tile.TYPE_W_G_3_T)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("W_G_3_T"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_W_G_3_R)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("W_G_3_R"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_W_G_3_B)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("W_G_3_B"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_W_G_3_L)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("W_G_3_L"));
				tile.addChild(tileImg);
			}
				
				//4 sides
			else if (tile.lTile.viewTileType == V_Tile.TYPE_W_G_4)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("W_G_4"));
				tile.addChild(tileImg);
			}
				//Open space
			else
			{
				tileImg = new Image(Assets.getAtlas().getTexture("W_O"));
				tile.addChild(tileImg);
			}
		}
		
		public static function setBuildingImage(tileImg:Image, tile:V_Tile):void
		{
			if (tile.lTile.viewTileType == V_Tile.TYPE_B_1_T)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("B_1_T"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_B_1_R)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("B_1_R"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_B_1_B)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("B_1_B"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_B_1_L)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("B_1_L"));
				tile.addChild(tileImg);
			}
				
				//2 sides
			else if (tile.lTile.viewTileType == V_Tile.TYPE_B_2_BL)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("B_2_BL"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_B_2_BR)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("B_2_BR"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_B_2_TL)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("B_2_TL"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_B_2_TR)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("B_2_TR"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_B_2_H)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("B_2_H"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_B_2_V)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("B_2_V"));
				tile.addChild(tileImg);
			}
				
				//3 sides
			else if (tile.lTile.viewTileType == V_Tile.TYPE_B_3_T)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("B_3_T"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_B_3_R)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("B_3_R"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_B_3_B)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("B_3_B"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_B_3_L)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("B_3_L"));
				tile.addChild(tileImg);
			}
				
				//4 sides
			else if (tile.lTile.viewTileType == V_Tile.TYPE_B_4)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("B_4"));
				tile.addChild(tileImg);
			}
				//Open space
			else
			{
				tileImg = new Image(Assets.getAtlas().getTexture("B_O"));
				tile.addChild(tileImg);
			}
		}
		
		public static function setRoadImage(tileImg:Image, tile:V_Tile):void
		{
			if (tile.lTile.viewTileType == V_Tile.TYPE_R_O_B)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("R_O_B"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_R_O_L)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("R_O_L"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_R_O_R)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("R_O_R"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_R_O_T)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("R_O_T"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_R_W_B)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("R_W_B"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_R_W_L)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("R_W_L"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_R_W_R)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("R_W_R"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_R_W_T)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("R_W_T"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_RCI_BL)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("RCI_BL"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_RCI_BR)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("RCI_BR"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_RCI_TL)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("RCI_TL"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_RCI_TR)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("RCI_TR"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_RCO_BL)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("RCO_BL"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_RCO_BR)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("RCO_BR"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_RCO_TL)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("RCO_TL"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_RCO_TR)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("RCO_TR"));
				tile.addChild(tileImg);
			}
			else
			{
				tileImg = new Image(Assets.getAtlas().getTexture("RCO_TL"));
				tile.addChild(tileImg);
			}
		}
		
		public static function setSidewalkImage(tileImg:Image, tile:V_Tile):void
		{
			//Sidewalk blending
			if (tile.lTile.viewTileType == V_Tile.TYPE_S_B)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("S_B"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_S_L)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("S_L"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_S_R)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("S_R"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_S_T)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("S_T"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_SCI_BL)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("SCI_BL"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_SCI_BR)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("SCI_BR"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_SCI_TL)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("SCI_TL"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_SCI_TR)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("SCI_TR"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_SCO_BL)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("SCO_BL"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_SCO_BR)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("SCO_BR"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_SCO_TL)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("SCO_TL"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_SCO_TR)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("SCO_TR"));
				tile.addChild(tileImg);
			}
				//special blending tiles
			else if (tile.lTile.viewTileType == V_Tile.TYPE_SCI_BL_NR)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("SCI_BL_NR"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_SCI_BL_NT)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("SCI_BL_NT"));
				tile.addChild(tileImg);
			}
				
			else if (tile.lTile.viewTileType == V_Tile.TYPE_SCI_BR_NL)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("SCI_BR_NL"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_SCI_BR_NT)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("SCI_BR_NT"));
				tile.addChild(tileImg);
			}
				
			else if (tile.lTile.viewTileType == V_Tile.TYPE_SCI_TR_NL)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("SCI_TR_NL"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_SCI_TR_NB)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("SCI_TR_NB"));
				tile.addChild(tileImg);
			}
				
			else if (tile.lTile.viewTileType == V_Tile.TYPE_SCI_TL_NR)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("SCI_TL_NR"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_SCI_TL_NB)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("SCI_TL_NB"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_S_O)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("S_O"));
			}
		}
		
		public static function setDirtImage(tileImg:Image, tile:V_Tile):void
		{
			//dirt blending
			if (tile.lTile.viewTileType == V_Tile.TYPE_D_O)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("D_O"));
				tile.addChild(tileImg);
			}
				//==============================
				//1 side
			else if (tile.lTile.viewTileType == V_Tile.TYPE_D_G_1_B)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("D_G_1_B"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_D_G_1_L)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("D_G_1_L"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_D_G_1_T)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("D_G_1_T"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_D_G_1_R)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("D_G_1_R"));
				tile.addChild(tileImg);
			}
				
				//==============================
				//2 sides
			else if (tile.lTile.viewTileType == V_Tile.TYPE_D_G_2_TL)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("D_G_2_TL"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_D_G_2_TR)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("D_G_2_TR"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_D_G_2_BL)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("D_G_2_BL"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_D_G_2_BR)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("D_G_2_BR"));
				tile.addChild(tileImg);
			}
				//horizontal
			else if (tile.lTile.viewTileType == V_Tile.TYPE_D_G_2_H)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("D_G_2_H"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_D_G_2_V)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("D_G_2_V"));
				tile.addChild(tileImg);
			}
				//==============================
				//3 sides
			else if (tile.lTile.viewTileType == V_Tile.TYPE_D_G_3_B)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("D_G_3_B"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_D_G_3_L)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("D_G_3_L"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_D_G_3_T)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("D_G_3_T"));
				tile.addChild(tileImg);
			}
			else if (tile.lTile.viewTileType == V_Tile.TYPE_D_G_3_R)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("D_G_3_R"));
				tile.addChild(tileImg);
			}
				//===============================
				//4 sides
			else if (tile.lTile.viewTileType == V_Tile.TYPE_D_G_4)
			{
				tileImg = new Image(Assets.getAtlas().getTexture("D_G_4"));
				tile.addChild(tileImg);
			}
		}
	}
}