package game.ui
{
	import flash.geom.Point;
	
	import game.entities.Entity;
	import game.entities.Unit;
	import game.tiles.L_Tile;
	import game.tiles.V_Tile;
	
	import starling.display.Sprite;
	
	import views.GameView;

	public class MovePath extends Sprite
	{
		private var _path:Vector.<PathPoint>;
		private var gView:GameView;
		
		private var currUpdateTile:L_Tile;
		private var moveEntity:Unit;
		
		private var pathLimit:int = 0;
		
		public function MovePath(g:GameView)
		{
			super();
			gView = g;
			path = new Vector.<PathPoint>();
			
//			var tempPoint:PathPoint = new PathPoint(PathPoint.SPR_A_S, g.level.getTileAtPixelCoordinates(1,1));
//			addChild(tempPoint);
//			tempPoint.x = 500;
//			tempPoint.y = 500;
//			trace("added temp point");
		}
		
		public function getCurrPathCost():int
		{
			return (path.length-1) * moveEntity.getMoveCost();
		}
		
		public function start(e:Unit):void
		{
			this.visible = true;
			moveEntity = e;
			pathLimit = Math.floor(moveEntity.ap/moveEntity.getMoveCost());
			path = new Vector.<PathPoint>();
			
			var firstPoint:PathPoint = new PathPoint(PathPoint.SPR_A_S, moveEntity.currTile);
			addChild(firstPoint);
			path.push(firstPoint);
		}
		
		public function clear():void
		{
			for (var i:int = 0; i < path.length; i++)
			{
				removeChild(path[i]);
			}
			
			moveEntity = null;
			currUpdateTile = null;
			this.visible = false;
		}
		
		public function update():void
		{
			currUpdateTile = gView.level.getTileAtPixelCoordinates(
				GameState.MOUSE_POS.x-gView.level.x, GameState.MOUSE_POS.y-gView.level.y);
			
			if (currUpdateTile.walkable)
			{
				//Check if the tile is in the list
				var tileIsNotInPath:Boolean = checkIfTileInPath(currUpdateTile);
				
				if (tileIsNotInPath && path.length < pathLimit+2)
				{
					checkAddTilePosition();
				}
				else
				{
					if (path.length > 1)
					{
						if (currUpdateTile == path[path.length-2].currTile)
						{
							trace("retracting");
							retract();
						}
					}
				}
			}
		}
		
		private function checkIfTileInPath(currUpdateTile:L_Tile):Boolean
		{
			for (var i:int = 0; i < path.length; i++)
			{
				if (currUpdateTile == path[i].currTile)
				{
					return false;
				}
			}
			return true;
		}
		
		private function checkAddTilePosition():void
		{
			if (currUpdateTile.left == path[path.length-1].currTile)
			{
				trace("adding right!");
				addRight();
			}
			else if (currUpdateTile.top == path[path.length-1].currTile)
			{
				trace("adding bottom!");
				addBottom();
			}
			else if (currUpdateTile.right == path[path.length-1].currTile)
			{
				trace("adding left!");
				addLeft();
			}
			else if (currUpdateTile.bottom == path[path.length-1].currTile)
			{
				trace("adding top!");
				addTop();
			}
		}
		
		private function retract():void
		{
			//First remove the top tile
			removeChild(path[path.length-1]);
			path.splice(path.length-1, 1);
			
			//Then set the current top of the list appearance
			var topPoint:PathPoint = path[path.length-1];
			switch (topPoint.prevDirection)
			{
				case PathPoint.DIR_N:
					topPoint.setGraphic(PathPoint.SPR_A_S);
					break;
				case PathPoint.DIR_T:
					topPoint.setGraphic(PathPoint.SPR_A_E_B);
					break;
				case PathPoint.DIR_R:
					topPoint.setGraphic(PathPoint.SPR_A_E_L);
					break;
				case PathPoint.DIR_B:
					topPoint.setGraphic(PathPoint.SPR_A_E_T);
					break;
				case PathPoint.DIR_L:
					topPoint.setGraphic(PathPoint.SPR_A_E_R);
					break;
			}
		}
		
		private function addLeft():void
		{
			//First check what the previous path was like
			//and set the current graphic to reflect current transition
			// also, the graphic will ALWAYS be an end point
			// in this case, A_E_L
			var prevPoint:PathPoint = path[path.length-1];
			switch (prevPoint.prevDirection)
			{
				case PathPoint.DIR_N:
					//Set the graphic
					prevPoint.setGraphic(PathPoint.SPR_A_E_R);
					break;
				case PathPoint.DIR_T:
					//Set the graphic
					prevPoint.setGraphic(PathPoint.SPR_A_BR);
					break;
				case PathPoint.DIR_R:
					prevPoint.setGraphic(PathPoint.SPR_A_H);
					break;
				case PathPoint.DIR_B:
					prevPoint.setGraphic(PathPoint.SPR_A_TR);
					break;
			}
			//Now one needs to be added
			var newPoint:PathPoint = new PathPoint(PathPoint.SPR_A_E_L, currUpdateTile, prevPoint)
			path.push(newPoint);
			addChild(newPoint)
			newPoint.x = prevPoint.x - V_Tile.EXPLICIT_WIDTH;
			newPoint.y = prevPoint.y;
		}
		
		private function addTop():void
		{
			//First check what the previous path was like
			//and set the current graphic to reflect current transition
			// also, the graphic will ALWAYS be an end point
			// in this case, A_E_T
			var prevPoint:PathPoint = path[path.length-1];
			switch (prevPoint.prevDirection)
			{
				case PathPoint.DIR_N:
					//Set the graphic
					prevPoint.setGraphic(PathPoint.SPR_A_E_B);
					break;
				case PathPoint.DIR_L:
					//Set the graphic
					prevPoint.setGraphic(PathPoint.SPR_A_BR);
					break;
				case PathPoint.DIR_R:
					prevPoint.setGraphic(PathPoint.SPR_A_BL);
					break;
				case PathPoint.DIR_B:
					prevPoint.setGraphic(PathPoint.SPR_A_V);
					break;
			}
			//Now one needs to be added
			var newPoint = new PathPoint(PathPoint.SPR_A_E_T, currUpdateTile, prevPoint)
			path.push(newPoint);
			addChild(newPoint)
			newPoint.x = prevPoint.x;
			newPoint.y = prevPoint.y - V_Tile.EXPLICIT_HEIGHT;
		}
		
		private function addRight():void
		{
			//First check what the previous path was like
			//and set the current graphic to reflect current transition
			// also, the graphic will ALWAYS be an end point
			// in this case, A_E_R
			var prevPoint:PathPoint = path[path.length-1];
			switch (prevPoint.prevDirection)
			{
				case PathPoint.DIR_N:
					//Set the graphic
					prevPoint.setGraphic(PathPoint.SPR_A_E_L);
					break;
				case PathPoint.DIR_L:
					//Set the graphic
					prevPoint.setGraphic(PathPoint.SPR_A_H);
					break;
				case PathPoint.DIR_T:
					prevPoint.setGraphic(PathPoint.SPR_A_BL);
					break;
				case PathPoint.DIR_B:
					prevPoint.setGraphic(PathPoint.SPR_A_TL);
					break;
			}
			//Now one needs to be added
			var newPoint:PathPoint = new PathPoint(PathPoint.SPR_A_E_R, currUpdateTile, prevPoint);
			path.push(newPoint);
			addChild(newPoint)
			newPoint.x = prevPoint.x + V_Tile.EXPLICIT_WIDTH;
			newPoint.y = prevPoint.y;
		}
		
		private function addBottom():void
		{
			//First check what the previous path was like
			//and set the current graphic to reflect current transition
			// also, the graphic will ALWAYS be an end point
			// in this case, A_E_R
			var prevPoint:PathPoint = path[path.length-1];
			switch (prevPoint.prevDirection)
			{
				case PathPoint.DIR_N:
					//Set the graphic
					prevPoint.setGraphic(PathPoint.SPR_A_E_T);
					break;
				case PathPoint.DIR_L:
					//Set the graphic
					prevPoint.setGraphic(PathPoint.SPR_A_TR);
					break;
				case PathPoint.DIR_T:
					prevPoint.setGraphic(PathPoint.SPR_A_V);
					break;
				case PathPoint.DIR_R:
					prevPoint.setGraphic(PathPoint.SPR_A_TL);
					break;
			}
			//Now one needs to be added
			var newPoint:PathPoint = new PathPoint(PathPoint.SPR_A_E_B, currUpdateTile, prevPoint);
			path.push(newPoint);
			addChild(newPoint)
			newPoint.x = prevPoint.x;
			newPoint.y = prevPoint.y + V_Tile.EXPLICIT_HEIGHT;
		}

		public function get path():Vector.<PathPoint>
		{
			return _path;
		}

		public function set path(value:Vector.<PathPoint>):void
		{
			_path = value;
		}

	}
}