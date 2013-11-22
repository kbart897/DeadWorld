package game.tiles
{
	public class TileBlender
	{
		public static function loadTileType(tempTile:L_Tile, currPixel:uint):void
		{
			tempTile.height = 0;
			if (currPixel == 0x00FF00)
			{
				tempTile.type = L_Tile.TYPE_GRASS;
				tempTile.walkable = true;
			}
			else if (currPixel == 0x0000FF)
			{
				tempTile.type = L_Tile.TYPE_WATER;
				tempTile.walkable = false;
			}
			else if (currPixel == 0x885500)
			{
				tempTile.type = L_Tile.TYPE_DIRT;
				tempTile.walkable = true;
			}
			else if (currPixel == 0x000000)
			{
				tempTile.type = L_Tile.TYPE_ROAD;
				tempTile.walkable = true;
			}
			else if (currPixel == 0xAAAAAA)
			{
				tempTile.type = L_Tile.TYPE_SIDEWALK;
				tempTile.walkable = true;
			}
			else if (currPixel == 0xFFAA00)
			{
				tempTile.type = L_Tile.TYPE_BUILDING;
				tempTile.height = 1;
				tempTile.walkable = false;
			}
			else
			{
				tempTile.type = L_Tile.TYPE_NULL;
				tempTile.walkable = false;
			}
		}
		
		public static function setupTileBlending(l_tiles:Vector.<Vector.<L_Tile>>):void
		{
			var currTile:L_Tile;
			//go thru each tile
			for (var h:int = 0; h < TileManager.NUM_L_TILES_HEIGH; h++)
			{
				for (var w:int = 0; w < TileManager.NUM_L_TILES_WIDE; w++)
				{
					currTile = l_tiles[h][w];
					if (currTile.type == L_Tile.TYPE_GRASS)
					{
						grassBlending(currTile);
					}
					else if (currTile.type == L_Tile.TYPE_ROAD)
					{
						roadBlending(currTile);
					}
					else if (currTile.type == L_Tile.TYPE_SIDEWALK)
					{
						sidewalkBlending(currTile);
					}
					else if (currTile.type == L_Tile.TYPE_WATER)
					{
						waterBlending(currTile);
					}
					else if (currTile.type == L_Tile.TYPE_DIRT)
					{
						dirtBlending(currTile);
					}
					else if (currTile.type == L_Tile.TYPE_BUILDING)
					{
						buildingBlending(currTile);
					}
				}
			}
		}
		
		public static function grassBlending(currTile:L_Tile):void
		{
			currTile.viewTileType = V_Tile.TYPE_G_O;
		}
		
		public static function roadBlending(currTile:L_Tile):void
		{
			//TL
			if (currTile.top.type != L_Tile.TYPE_ROAD &&
				currTile.right.type == L_Tile.TYPE_ROAD &&
				currTile.bottom.type == L_Tile.TYPE_ROAD &&
				currTile.left.type != L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_RCO_TL;
			}
				//TR
			else if (currTile.top.type != L_Tile.TYPE_ROAD &&
				currTile.right.type != L_Tile.TYPE_ROAD &&
				currTile.bottom.type == L_Tile.TYPE_ROAD &&
				currTile.left.type == L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_RCO_TR;
			}
				//BR
			else if (currTile.top.type == L_Tile.TYPE_ROAD &&
				currTile.right.type != L_Tile.TYPE_ROAD &&
				currTile.bottom.type != L_Tile.TYPE_ROAD &&
				currTile.left.type == L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_RCO_BR;
			}
				//BL
			else if (currTile.top.type == L_Tile.TYPE_ROAD &&
				currTile.right.type == L_Tile.TYPE_ROAD &&
				currTile.bottom.type != L_Tile.TYPE_ROAD &&
				currTile.left.type != L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_RCO_BL;
			}
				//ITL
			else if (currTile.top.type == L_Tile.TYPE_ROAD &&
				currTile.right.type == L_Tile.TYPE_ROAD &&
				currTile.bottom.type == L_Tile.TYPE_ROAD &&
				currTile.left.type == L_Tile.TYPE_ROAD &&
				currTile.bottom.right.type != L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_RCI_TL;
			}
				//ITR
			else if (currTile.top.type == L_Tile.TYPE_ROAD &&
				currTile.right.type == L_Tile.TYPE_ROAD &&
				currTile.bottom.type == L_Tile.TYPE_ROAD &&
				currTile.left.type == L_Tile.TYPE_ROAD &&
				currTile.bottom.left.type != L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_RCI_TR;
			}
				//IBR
			else if (currTile.top.type == L_Tile.TYPE_ROAD &&
				currTile.right.type == L_Tile.TYPE_ROAD &&
				currTile.bottom.type == L_Tile.TYPE_ROAD &&
				currTile.left.type == L_Tile.TYPE_ROAD &&
				currTile.top.left.type != L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_RCI_BR;
			}
				//IBL
			else if (currTile.top.type == L_Tile.TYPE_ROAD &&
				currTile.right.type == L_Tile.TYPE_ROAD &&
				currTile.bottom.type == L_Tile.TYPE_ROAD &&
				currTile.left.type == L_Tile.TYPE_ROAD &&
				currTile.top.right.type != L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_RCI_BL;
			}
				//Middle pieces==============
				//MT
			else if (currTile.top.type != L_Tile.TYPE_ROAD &&
				currTile.right.type == L_Tile.TYPE_ROAD &&
				currTile.bottom.type == L_Tile.TYPE_ROAD &&
				currTile.left.type == L_Tile.TYPE_ROAD &&
				currTile.left.left.type == L_Tile.TYPE_ROAD &&
				currTile.right.right.type == L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_R_W_T;
			}
				//MR
			else if (currTile.top.type == L_Tile.TYPE_ROAD &&
				currTile.right.type != L_Tile.TYPE_ROAD &&
				currTile.bottom.type == L_Tile.TYPE_ROAD &&
				currTile.left.type == L_Tile.TYPE_ROAD &&
				currTile.top.top.type == L_Tile.TYPE_ROAD &&
				currTile.bottom.bottom.type == L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_R_W_R;
			}
				//MB
			else if (currTile.top.type == L_Tile.TYPE_ROAD &&
				currTile.right.type == L_Tile.TYPE_ROAD &&
				currTile.bottom.type != L_Tile.TYPE_ROAD &&
				currTile.left.type == L_Tile.TYPE_ROAD &&
				currTile.left.left.type == L_Tile.TYPE_ROAD &&
				currTile.right.right.type == L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_R_W_B;
			}
				//ML
			else if (currTile.top.type == L_Tile.TYPE_ROAD &&
				currTile.right.type == L_Tile.TYPE_ROAD &&
				currTile.bottom.type == L_Tile.TYPE_ROAD &&
				currTile.left.type != L_Tile.TYPE_ROAD &&
				currTile.top.top.type == L_Tile.TYPE_ROAD &&
				currTile.bottom.bottom.type == L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_R_W_L;
			}
				//end middle pieces
				//======================
				//close to corners
				//MTL
			else if (currTile.top.type != L_Tile.TYPE_ROAD &&
				currTile.right.type == L_Tile.TYPE_ROAD &&
				currTile.bottom.type == L_Tile.TYPE_ROAD &&
				currTile.left.type == L_Tile.TYPE_ROAD &&
				(currTile.left.left.type != L_Tile.TYPE_ROAD ||
					currTile.right.right.type != L_Tile.TYPE_ROAD))
			{
				currTile.viewTileType = V_Tile.TYPE_R_O_T;
			}
				//MTR
			else if (currTile.top.type == L_Tile.TYPE_ROAD &&
				currTile.right.type != L_Tile.TYPE_ROAD &&
				currTile.bottom.type == L_Tile.TYPE_ROAD &&
				currTile.left.type == L_Tile.TYPE_ROAD &&
				(currTile.top.top.type != L_Tile.TYPE_ROAD ||
					currTile.bottom.bottom.type != L_Tile.TYPE_ROAD))
			{
				currTile.viewTileType = V_Tile.TYPE_R_O_R;
			}
				//MBL
			else if (currTile.top.type == L_Tile.TYPE_ROAD &&
				currTile.right.type == L_Tile.TYPE_ROAD &&
				currTile.bottom.type != L_Tile.TYPE_ROAD &&
				currTile.left.type == L_Tile.TYPE_ROAD &&
				(currTile.left.left.type != L_Tile.TYPE_ROAD ||
					currTile.right.right.type != L_Tile.TYPE_ROAD))
			{
				currTile.viewTileType = V_Tile.TYPE_R_O_B;
			}
				//MBR
			else if (currTile.top.type == L_Tile.TYPE_ROAD &&
				currTile.right.type == L_Tile.TYPE_ROAD &&
				currTile.bottom.type == L_Tile.TYPE_ROAD &&
				currTile.left.type != L_Tile.TYPE_ROAD &&
				(currTile.top.top.type != L_Tile.TYPE_ROAD ||
					currTile.bottom.bottom.type != L_Tile.TYPE_ROAD))
			{
				currTile.viewTileType = V_Tile.TYPE_R_O_L;
			}
			//BCL
			//BCR
			//TCL
			//TCR
			//LCT
			//LCB
			//RCT
			//RCB
		}
		
		public static function sidewalkBlending(currTile:L_Tile):void
		{
			//All sides
			if (currTile.top.type == L_Tile.TYPE_SIDEWALK &&
				currTile.right.type == L_Tile.TYPE_SIDEWALK &&
				currTile.bottom.type == L_Tile.TYPE_SIDEWALK &&
				currTile.left.type == L_Tile.TYPE_SIDEWALK)
			{
				currTile.viewTileType = V_Tile.TYPE_S_O;
			}
				//OTR
			else if (currTile.top.type != L_Tile.TYPE_ROAD &&
				currTile.right.type != L_Tile.TYPE_ROAD &&
				currTile.bottom.type == L_Tile.TYPE_SIDEWALK &&
				currTile.left.type == L_Tile.TYPE_SIDEWALK)
			{
				currTile.viewTileType = V_Tile.TYPE_SCO_TR;
			}
				//OBR
			else if (currTile.top.type == L_Tile.TYPE_SIDEWALK &&
				currTile.right.type != L_Tile.TYPE_ROAD &&
				currTile.bottom.type != L_Tile.TYPE_ROAD &&
				currTile.left.type == L_Tile.TYPE_SIDEWALK)
			{
				currTile.viewTileType = V_Tile.TYPE_SCO_BR;
			}
				//OBL
			else if (currTile.top.type == L_Tile.TYPE_SIDEWALK &&
				currTile.right.type == L_Tile.TYPE_SIDEWALK &&
				currTile.bottom.type != L_Tile.TYPE_ROAD &&
				currTile.left.type != L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_SCO_BL;
			}
				//OTL
			else if (currTile.top.type != L_Tile.TYPE_ROAD &&
				currTile.right.type == L_Tile.TYPE_SIDEWALK &&
				currTile.bottom.type == L_Tile.TYPE_SIDEWALK &&
				currTile.left.type != L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_SCO_TL;
			}
				//ITR
			else if (currTile.top.type == L_Tile.TYPE_ROAD &&
				currTile.right.type == L_Tile.TYPE_ROAD &&
				currTile.bottom.type == L_Tile.TYPE_SIDEWALK &&
				currTile.left.type == L_Tile.TYPE_SIDEWALK &&
				currTile.bottom.left.type != L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_SCI_TR;
			}
				//IBR
			else if (currTile.top.type == L_Tile.TYPE_SIDEWALK &&
				currTile.right.type == L_Tile.TYPE_ROAD &&
				currTile.bottom.type == L_Tile.TYPE_ROAD &&
				currTile.left.type == L_Tile.TYPE_SIDEWALK &&
				currTile.top.left.type != L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_SCI_BR;
			}
				//IBL
			else if (currTile.top.type == L_Tile.TYPE_SIDEWALK &&
				currTile.right.type == L_Tile.TYPE_SIDEWALK &&
				currTile.bottom.type == L_Tile.TYPE_ROAD &&
				currTile.left.type == L_Tile.TYPE_ROAD &&
				currTile.top.right.type != L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_SCI_BL;
			}
				//ITL
			else if (currTile.top.type == L_Tile.TYPE_ROAD &&
				currTile.right.type == L_Tile.TYPE_SIDEWALK &&
				currTile.bottom.type == L_Tile.TYPE_SIDEWALK &&
				currTile.left.type == L_Tile.TYPE_ROAD &&
				currTile.bottom.right.type != L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_SCI_TL;
			}
				//T
			else if (currTile.top.type == L_Tile.TYPE_ROAD &&
				currTile.right.type == L_Tile.TYPE_SIDEWALK &&
				currTile.bottom.type != L_Tile.TYPE_ROAD &&
				currTile.left.type == L_Tile.TYPE_SIDEWALK)
			{
				currTile.viewTileType = V_Tile.TYPE_S_T;
			}
				//R
			else if (currTile.top.type == L_Tile.TYPE_SIDEWALK &&
				currTile.right.type == L_Tile.TYPE_ROAD &&
				currTile.bottom.type == L_Tile.TYPE_SIDEWALK &&
				currTile.left.type != L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_S_R;
			}
				//B
			else if (currTile.top.type != L_Tile.TYPE_ROAD &&
				currTile.right.type == L_Tile.TYPE_SIDEWALK &&
				currTile.bottom.type == L_Tile.TYPE_ROAD &&
				currTile.left.type == L_Tile.TYPE_SIDEWALK)
			{
				currTile.viewTileType = V_Tile.TYPE_S_B;
			}
				//L
			else if (currTile.top.type == L_Tile.TYPE_SIDEWALK &&
				currTile.right.type != L_Tile.TYPE_ROAD &&
				currTile.bottom.type == L_Tile.TYPE_SIDEWALK &&
				currTile.left.type == L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_S_L;
			}
				//There are 4 inside ending corners to check
				//These have to be created yet
				//BL NR
			else if (currTile.top.type == L_Tile.TYPE_SIDEWALK &&
				currTile.right.type != L_Tile.TYPE_SIDEWALK &&
				currTile.bottom.type == L_Tile.TYPE_ROAD &&
				currTile.left.type == L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_SCI_BL_NR;
			}
				//BL NT
			else if (currTile.top.type != L_Tile.TYPE_SIDEWALK &&
				currTile.right.type == L_Tile.TYPE_SIDEWALK &&
				currTile.bottom.type == L_Tile.TYPE_ROAD &&
				currTile.left.type == L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_SCI_BL_NT;
			}
				//BR NL
			else if (currTile.top.type == L_Tile.TYPE_SIDEWALK &&
				currTile.right.type == L_Tile.TYPE_ROAD &&
				currTile.bottom.type == L_Tile.TYPE_ROAD &&
				currTile.left.type != L_Tile.TYPE_SIDEWALK)
			{
				currTile.viewTileType = V_Tile.TYPE_SCI_BR_NL;
			}
				//BR NT
			else if (currTile.top.type != L_Tile.TYPE_SIDEWALK &&
				currTile.right.type == L_Tile.TYPE_ROAD &&
				currTile.bottom.type == L_Tile.TYPE_ROAD &&
				currTile.left.type == L_Tile.TYPE_SIDEWALK)
			{
				currTile.viewTileType = V_Tile.TYPE_SCI_BR_NT;
			}
				
				//TR NL
			else if (currTile.top.type == L_Tile.TYPE_ROAD &&
				currTile.right.type == L_Tile.TYPE_ROAD &&
				currTile.bottom.type == L_Tile.TYPE_SIDEWALK &&
				currTile.left.type != L_Tile.TYPE_SIDEWALK)
			{
				currTile.viewTileType = V_Tile.TYPE_SCI_TR_NL;
			}
				//TR NB
			else if (currTile.top.type == L_Tile.TYPE_ROAD &&
				currTile.right.type == L_Tile.TYPE_ROAD &&
				currTile.bottom.type != L_Tile.TYPE_SIDEWALK &&
				currTile.left.type == L_Tile.TYPE_SIDEWALK)
			{
				currTile.viewTileType = V_Tile.TYPE_SCI_TR_NB;
			}
				
				//TL NR
			else if (currTile.top.type == L_Tile.TYPE_ROAD &&
				currTile.right.type != L_Tile.TYPE_SIDEWALK &&
				currTile.bottom.type == L_Tile.TYPE_SIDEWALK &&
				currTile.left.type == L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_SCI_TR_NL;
			}
				
				//TL NB
			else if (currTile.top.type == L_Tile.TYPE_ROAD &&
				currTile.right.type == L_Tile.TYPE_SIDEWALK &&
				currTile.bottom.type != L_Tile.TYPE_SIDEWALK &&
				currTile.left.type == L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_SCI_TR_NL;
			}
				//8 last ones: use the outside corner pieces
				//for merging onto a road
				//TL
			else if (currTile.top.type != (L_Tile.TYPE_SIDEWALK || L_Tile.TYPE_ROAD) &&
				currTile.left.type != (L_Tile.TYPE_SIDEWALK || L_Tile.TYPE_ROAD) &&
				currTile.bottom.type == L_Tile.TYPE_SIDEWALK &&
				currTile.right.type == L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_SCO_TL;
			}
				//TR
			else if (currTile.top.type != (L_Tile.TYPE_SIDEWALK || L_Tile.TYPE_ROAD) &&
				currTile.right.type != (L_Tile.TYPE_SIDEWALK || L_Tile.TYPE_ROAD) &&
				currTile.bottom.type == L_Tile.TYPE_SIDEWALK &&
				currTile.left.type == L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_SCO_TR;
			}
				//BL
			else if (currTile.bottom.type != (L_Tile.TYPE_SIDEWALK || L_Tile.TYPE_ROAD) &&
				currTile.left.type != (L_Tile.TYPE_SIDEWALK || L_Tile.TYPE_ROAD) &&
				currTile.top.type == L_Tile.TYPE_SIDEWALK &&
				currTile.right.type == L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_SCO_BL;
			}
				//BR
			else if (currTile.bottom.type != (L_Tile.TYPE_SIDEWALK || L_Tile.TYPE_ROAD) &&
				currTile.right.type != (L_Tile.TYPE_SIDEWALK || L_Tile.TYPE_ROAD) &&
				currTile.top.type == L_Tile.TYPE_SIDEWALK &&
				currTile.left.type == L_Tile.TYPE_ROAD)
			{
				currTile.viewTileType = V_Tile.TYPE_SCO_BR;
			}
				
				//same thing, but horizontal
				//TL
			else if (currTile.top.type != (L_Tile.TYPE_SIDEWALK || L_Tile.TYPE_ROAD) &&
				currTile.left.type != (L_Tile.TYPE_SIDEWALK || L_Tile.TYPE_ROAD) &&
				currTile.bottom.type == L_Tile.TYPE_ROAD &&
				currTile.right.type == L_Tile.TYPE_SIDEWALK)
			{
				currTile.viewTileType = V_Tile.TYPE_SCO_TL;
			}
				//TR
			else if (currTile.top.type != (L_Tile.TYPE_SIDEWALK || L_Tile.TYPE_ROAD) &&
				currTile.right.type != (L_Tile.TYPE_SIDEWALK || L_Tile.TYPE_ROAD) &&
				currTile.bottom.type == L_Tile.TYPE_ROAD &&
				currTile.left.type == L_Tile.TYPE_SIDEWALK)
			{
				currTile.viewTileType = V_Tile.TYPE_SCO_TR;
			}
				//BL
			else if (currTile.bottom.type != (L_Tile.TYPE_SIDEWALK || L_Tile.TYPE_ROAD) &&
				currTile.left.type != (L_Tile.TYPE_SIDEWALK || L_Tile.TYPE_ROAD) &&
				currTile.top.type == L_Tile.TYPE_ROAD &&
				currTile.right.type == L_Tile.TYPE_SIDEWALK)
			{
				currTile.viewTileType = V_Tile.TYPE_SCO_BL;
			}
				//BR
			else if (currTile.bottom.type != (L_Tile.TYPE_SIDEWALK || L_Tile.TYPE_ROAD) &&
				currTile.right.type != (L_Tile.TYPE_SIDEWALK || L_Tile.TYPE_ROAD) &&
				currTile.top.type == L_Tile.TYPE_ROAD &&
				currTile.left.type == L_Tile.TYPE_SIDEWALK)
			{
				currTile.viewTileType = V_Tile.TYPE_SCO_BR;
			}
			else
			{
				currTile.viewTileType = V_Tile.TYPE_S_O;
			}
		}
		
		public static function waterBlending(currTile:L_Tile):void
		{
			//1 side
			if (currTile.top.type != L_Tile.TYPE_WATER &&
				currTile.right.type == L_Tile.TYPE_WATER &&
				currTile.bottom.type == L_Tile.TYPE_WATER &&
				currTile.left.type == L_Tile.TYPE_WATER)
			{
				currTile.viewTileType = V_Tile.TYPE_W_G_1_T;
			}
			else if (currTile.top.type == L_Tile.TYPE_WATER &&
				currTile.right.type != L_Tile.TYPE_WATER &&
				currTile.bottom.type == L_Tile.TYPE_WATER &&
				currTile.left.type == L_Tile.TYPE_WATER)
			{
				currTile.viewTileType = V_Tile.TYPE_W_G_1_R;
			}
			else if (currTile.top.type == L_Tile.TYPE_WATER &&
				currTile.right.type == L_Tile.TYPE_WATER &&
				currTile.bottom.type != L_Tile.TYPE_WATER &&
				currTile.left.type == L_Tile.TYPE_WATER)
			{
				currTile.viewTileType = V_Tile.TYPE_W_G_1_B;
			}
			else if (currTile.top.type == L_Tile.TYPE_WATER &&
				currTile.right.type == L_Tile.TYPE_WATER &&
				currTile.bottom.type == L_Tile.TYPE_WATER &&
				currTile.left.type != L_Tile.TYPE_WATER)
			{
				currTile.viewTileType = V_Tile.TYPE_W_G_1_L;
			}
				
				//2 sides
			else if (currTile.top.type == L_Tile.TYPE_WATER &&
				currTile.right.type == L_Tile.TYPE_WATER &&
				currTile.bottom.type != L_Tile.TYPE_WATER &&
				currTile.left.type != L_Tile.TYPE_WATER)
			{
				currTile.viewTileType = V_Tile.TYPE_W_G_2_BL;
			}
			else if (currTile.top.type != L_Tile.TYPE_WATER &&
				currTile.right.type == L_Tile.TYPE_WATER &&
				currTile.bottom.type == L_Tile.TYPE_WATER &&
				currTile.left.type != L_Tile.TYPE_WATER)
			{
				currTile.viewTileType = V_Tile.TYPE_W_G_2_TL;
			}
			else if (currTile.top.type == L_Tile.TYPE_WATER &&
				currTile.right.type != L_Tile.TYPE_WATER &&
				currTile.bottom.type != L_Tile.TYPE_WATER &&
				currTile.left.type == L_Tile.TYPE_WATER)
			{
				currTile.viewTileType = V_Tile.TYPE_W_G_2_BR;
			}
			else if (currTile.top.type != L_Tile.TYPE_WATER &&
				currTile.right.type != L_Tile.TYPE_WATER &&
				currTile.bottom.type == L_Tile.TYPE_WATER &&
				currTile.left.type == L_Tile.TYPE_WATER)
			{
				currTile.viewTileType = V_Tile.TYPE_W_G_2_TR;
			}
			else if (currTile.top.type == L_Tile.TYPE_WATER &&
				currTile.right.type != L_Tile.TYPE_WATER &&
				currTile.bottom.type == L_Tile.TYPE_WATER &&
				currTile.left.type != L_Tile.TYPE_WATER)
			{
				currTile.viewTileType = V_Tile.TYPE_W_G_2_V;
			}
			else if (currTile.top.type != L_Tile.TYPE_WATER &&
				currTile.right.type == L_Tile.TYPE_WATER &&
				currTile.bottom.type != L_Tile.TYPE_WATER &&
				currTile.left.type == L_Tile.TYPE_WATER)
			{
				currTile.viewTileType = V_Tile.TYPE_W_G_2_H;
			}
				
				//3 SIDES
			else if (currTile.top.type != L_Tile.TYPE_WATER &&
				currTile.right.type != L_Tile.TYPE_WATER &&
				currTile.bottom.type == L_Tile.TYPE_WATER &&
				currTile.left.type != L_Tile.TYPE_WATER)
			{
				currTile.viewTileType = V_Tile.TYPE_W_G_3_T;
			}
			else if (currTile.top.type != L_Tile.TYPE_WATER &&
				currTile.right.type != L_Tile.TYPE_WATER &&
				currTile.bottom.type != L_Tile.TYPE_WATER &&
				currTile.left.type == L_Tile.TYPE_WATER)
			{
				currTile.viewTileType = V_Tile.TYPE_W_G_3_R;
			}
			else if (currTile.top.type == L_Tile.TYPE_WATER &&
				currTile.right.type != L_Tile.TYPE_WATER &&
				currTile.bottom.type != L_Tile.TYPE_WATER &&
				currTile.left.type != L_Tile.TYPE_WATER)
			{
				currTile.viewTileType = V_Tile.TYPE_W_G_3_B;
			}
			else if (currTile.top.type != L_Tile.TYPE_WATER &&
				currTile.right.type == L_Tile.TYPE_WATER &&
				currTile.bottom.type != L_Tile.TYPE_WATER &&
				currTile.left.type != L_Tile.TYPE_WATER)
			{
				currTile.viewTileType = V_Tile.TYPE_W_G_3_L;
			}
				//4 SIDES
			else if (currTile.top.type != L_Tile.TYPE_WATER &&
				currTile.right.type != L_Tile.TYPE_WATER &&
				currTile.bottom.type != L_Tile.TYPE_WATER &&
				currTile.left.type != L_Tile.TYPE_WATER)
			{
				currTile.viewTileType = V_Tile.TYPE_W_G_4;
			}
			else
			{
				currTile.viewTileType = V_Tile.TYPE_W_O;
			}
		}
		
		public static function dirtBlending(currTile:L_Tile):void
		{
			//4 side checking
			if (currTile.top.type != L_Tile.TYPE_DIRT &&
				currTile.right.type != L_Tile.TYPE_DIRT &&
				currTile.bottom.type != L_Tile.TYPE_DIRT &&
				currTile.left.type != L_Tile.TYPE_DIRT)
			{
				currTile.viewTileType = V_Tile.TYPE_D_G_4;
			}
				//3 side checking
			else if (currTile.top.type == L_Tile.TYPE_DIRT &&
				currTile.right.type != L_Tile.TYPE_DIRT &&
				currTile.bottom.type != L_Tile.TYPE_DIRT &&
				currTile.left.type != L_Tile.TYPE_DIRT)
			{
				currTile.viewTileType = V_Tile.TYPE_D_G_3_B;
			}
			else if (currTile.top.type != L_Tile.TYPE_DIRT &&
				currTile.right.type == L_Tile.TYPE_DIRT &&
				currTile.bottom.type != L_Tile.TYPE_DIRT &&
				currTile.left.type != L_Tile.TYPE_DIRT)
			{
				currTile.viewTileType = V_Tile.TYPE_D_G_3_L;
			}
			else if (currTile.top.type != L_Tile.TYPE_DIRT &&
				currTile.right.type != L_Tile.TYPE_DIRT &&
				currTile.bottom.type == L_Tile.TYPE_DIRT &&
				currTile.left.type != L_Tile.TYPE_DIRT)
			{
				currTile.viewTileType = V_Tile.TYPE_D_G_3_T;
			}
			else if (currTile.top.type != L_Tile.TYPE_DIRT &&
				currTile.right.type != L_Tile.TYPE_DIRT &&
				currTile.bottom.type != L_Tile.TYPE_DIRT &&
				currTile.left.type == L_Tile.TYPE_DIRT)
			{
				currTile.viewTileType = V_Tile.TYPE_D_G_3_R;
			}
				//2 side checking
			else if (currTile.top.type != L_Tile.TYPE_DIRT &&
				currTile.right.type != L_Tile.TYPE_DIRT &&
				currTile.bottom.type == L_Tile.TYPE_DIRT &&
				currTile.left.type == L_Tile.TYPE_DIRT)
			{
				currTile.viewTileType = V_Tile.TYPE_D_G_2_TR;
			}
			else if (currTile.top.type == L_Tile.TYPE_DIRT &&
				currTile.right.type != L_Tile.TYPE_DIRT &&
				currTile.bottom.type != L_Tile.TYPE_DIRT &&
				currTile.left.type == L_Tile.TYPE_DIRT)
			{
				currTile.viewTileType = V_Tile.TYPE_D_G_2_BR;
			}
			else if (currTile.top.type == L_Tile.TYPE_DIRT &&
				currTile.right.type == L_Tile.TYPE_DIRT &&
				currTile.bottom.type != L_Tile.TYPE_DIRT &&
				currTile.left.type != L_Tile.TYPE_DIRT)
			{
				currTile.viewTileType = V_Tile.TYPE_D_G_2_BL;
			}
			else if (currTile.top.type != L_Tile.TYPE_DIRT &&
				currTile.right.type == L_Tile.TYPE_DIRT &&
				currTile.bottom.type == L_Tile.TYPE_DIRT &&
				currTile.left.type != L_Tile.TYPE_DIRT)
			{
				currTile.viewTileType = V_Tile.TYPE_D_G_2_TL;
			}
				//horizontal
			else if (currTile.top.type == L_Tile.TYPE_DIRT &&
				currTile.right.type != L_Tile.TYPE_DIRT &&
				currTile.bottom.type == L_Tile.TYPE_DIRT &&
				currTile.left.type != L_Tile.TYPE_DIRT)
			{
				currTile.viewTileType = V_Tile.TYPE_D_G_2_V;
			}
			else if (currTile.top.type != L_Tile.TYPE_DIRT &&
				currTile.right.type == L_Tile.TYPE_DIRT &&
				currTile.bottom.type != L_Tile.TYPE_DIRT &&
				currTile.left.type == L_Tile.TYPE_DIRT)
			{
				currTile.viewTileType = V_Tile.TYPE_D_G_2_H;
			}
				//1 side checking
			else if (currTile.top.type == L_Tile.TYPE_DIRT &&
				currTile.right.type == L_Tile.TYPE_DIRT &&
				currTile.bottom.type == L_Tile.TYPE_DIRT &&
				currTile.left.type != L_Tile.TYPE_DIRT)
			{
				currTile.viewTileType = V_Tile.TYPE_D_G_1_L;
			}
			else if (currTile.top.type != L_Tile.TYPE_DIRT &&
				currTile.right.type == L_Tile.TYPE_DIRT &&
				currTile.bottom.type == L_Tile.TYPE_DIRT &&
				currTile.left.type == L_Tile.TYPE_DIRT)
			{
				currTile.viewTileType = V_Tile.TYPE_D_G_1_T;
			}
			else if (currTile.top.type == L_Tile.TYPE_DIRT &&
				currTile.right.type != L_Tile.TYPE_DIRT &&
				currTile.bottom.type == L_Tile.TYPE_DIRT &&
				currTile.left.type == L_Tile.TYPE_DIRT)
			{
				currTile.viewTileType = V_Tile.TYPE_D_G_1_R;
			}
			else if (currTile.top.type == L_Tile.TYPE_DIRT &&
				currTile.right.type == L_Tile.TYPE_DIRT &&
				currTile.bottom.type != L_Tile.TYPE_DIRT &&
				currTile.left.type == L_Tile.TYPE_DIRT)
			{
				currTile.viewTileType = V_Tile.TYPE_D_G_1_B;
			}
				//surrounded by dirt
			else if (currTile.top.type == L_Tile.TYPE_DIRT &&
				currTile.right.type == L_Tile.TYPE_DIRT &&
				currTile.bottom.type == L_Tile.TYPE_DIRT &&
				currTile.left.type == L_Tile.TYPE_DIRT)
			{
				currTile.viewTileType = V_Tile.TYPE_D_O;
			}
		}
		
		public static function buildingBlending(currTile:L_Tile):void
		{
			//1 side
			if (currTile.top.type != L_Tile.TYPE_BUILDING &&
				currTile.right.type == L_Tile.TYPE_BUILDING &&
				currTile.bottom.type == L_Tile.TYPE_BUILDING &&
				currTile.left.type == L_Tile.TYPE_BUILDING)
			{
				currTile.viewTileType = V_Tile.TYPE_B_1_T;
			}
			else if (currTile.top.type == L_Tile.TYPE_BUILDING &&
				currTile.right.type != L_Tile.TYPE_BUILDING &&
				currTile.bottom.type == L_Tile.TYPE_BUILDING &&
				currTile.left.type == L_Tile.TYPE_BUILDING)
			{
				currTile.viewTileType = V_Tile.TYPE_B_1_R;
			}
			else if (currTile.top.type == L_Tile.TYPE_BUILDING &&
				currTile.right.type == L_Tile.TYPE_BUILDING &&
				currTile.bottom.type != L_Tile.TYPE_BUILDING &&
				currTile.left.type == L_Tile.TYPE_BUILDING)
			{
				currTile.viewTileType = V_Tile.TYPE_B_1_B;
			}
			else if (currTile.top.type == L_Tile.TYPE_BUILDING &&
				currTile.right.type == L_Tile.TYPE_BUILDING &&
				currTile.bottom.type == L_Tile.TYPE_BUILDING &&
				currTile.left.type != L_Tile.TYPE_BUILDING)
			{
				currTile.viewTileType = V_Tile.TYPE_B_1_L;
			}
				
				//2 sides
			else if (currTile.top.type == L_Tile.TYPE_BUILDING &&
				currTile.right.type == L_Tile.TYPE_BUILDING &&
				currTile.bottom.type != L_Tile.TYPE_BUILDING &&
				currTile.left.type != L_Tile.TYPE_BUILDING)
			{
				currTile.viewTileType = V_Tile.TYPE_B_2_BL;
			}
			else if (currTile.top.type != L_Tile.TYPE_BUILDING &&
				currTile.right.type == L_Tile.TYPE_BUILDING &&
				currTile.bottom.type == L_Tile.TYPE_BUILDING &&
				currTile.left.type != L_Tile.TYPE_BUILDING)
			{
				currTile.viewTileType = V_Tile.TYPE_B_2_TL;
			}
			else if (currTile.top.type == L_Tile.TYPE_BUILDING &&
				currTile.right.type != L_Tile.TYPE_BUILDING &&
				currTile.bottom.type != L_Tile.TYPE_BUILDING &&
				currTile.left.type == L_Tile.TYPE_BUILDING)
			{
				currTile.viewTileType = V_Tile.TYPE_B_2_BR;
			}
			else if (currTile.top.type != L_Tile.TYPE_BUILDING &&
				currTile.right.type != L_Tile.TYPE_BUILDING &&
				currTile.bottom.type == L_Tile.TYPE_BUILDING &&
				currTile.left.type == L_Tile.TYPE_BUILDING)
			{
				currTile.viewTileType = V_Tile.TYPE_B_2_TR;
			}
			else if (currTile.top.type == L_Tile.TYPE_BUILDING &&
				currTile.right.type != L_Tile.TYPE_BUILDING &&
				currTile.bottom.type == L_Tile.TYPE_BUILDING &&
				currTile.left.type != L_Tile.TYPE_BUILDING)
			{
				currTile.viewTileType = V_Tile.TYPE_B_2_V;
			}
			else if (currTile.top.type != L_Tile.TYPE_BUILDING &&
				currTile.right.type == L_Tile.TYPE_BUILDING &&
				currTile.bottom.type != L_Tile.TYPE_BUILDING &&
				currTile.left.type == L_Tile.TYPE_BUILDING)
			{
				currTile.viewTileType = V_Tile.TYPE_B_2_H;
			}
				
				//3 SIDES
			else if (currTile.top.type != L_Tile.TYPE_BUILDING &&
				currTile.right.type != L_Tile.TYPE_BUILDING &&
				currTile.bottom.type == L_Tile.TYPE_BUILDING &&
				currTile.left.type != L_Tile.TYPE_BUILDING)
			{
				currTile.viewTileType = V_Tile.TYPE_B_3_T;
			}
			else if (currTile.top.type != L_Tile.TYPE_BUILDING &&
				currTile.right.type != L_Tile.TYPE_BUILDING &&
				currTile.bottom.type != L_Tile.TYPE_BUILDING &&
				currTile.left.type == L_Tile.TYPE_BUILDING)
			{
				currTile.viewTileType = V_Tile.TYPE_B_3_R;
			}
			else if (currTile.top.type == L_Tile.TYPE_BUILDING &&
				currTile.right.type != L_Tile.TYPE_BUILDING &&
				currTile.bottom.type != L_Tile.TYPE_BUILDING &&
				currTile.left.type != L_Tile.TYPE_BUILDING)
			{
				currTile.viewTileType = V_Tile.TYPE_B_3_B;
			}
			else if (currTile.top.type != L_Tile.TYPE_BUILDING &&
				currTile.right.type == L_Tile.TYPE_BUILDING &&
				currTile.bottom.type != L_Tile.TYPE_BUILDING &&
				currTile.left.type != L_Tile.TYPE_BUILDING)
			{
				currTile.viewTileType = V_Tile.TYPE_B_3_L;
			}
				//4 SIDES
			else if (currTile.top.type != L_Tile.TYPE_BUILDING &&
				currTile.right.type != L_Tile.TYPE_BUILDING &&
				currTile.bottom.type != L_Tile.TYPE_BUILDING &&
				currTile.left.type != L_Tile.TYPE_BUILDING)
			{
				currTile.viewTileType = V_Tile.TYPE_B_4;
			}
			else
			{
				currTile.viewTileType = V_Tile.TYPE_B_O;
			}
		}
	}
}