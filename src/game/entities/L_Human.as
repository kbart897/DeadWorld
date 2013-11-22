package game.entities
{
	import flash.geom.Point;
	
	import game.ai.Faction;
	import game.tiles.L_Chunk;
	import game.tiles.L_Tile;

	public class L_Human extends Unit
	{
		//===================================
		// Some base stats
		//===================================
		
		public static const HP_MAX:int = 100;
		
		private var _v_human:V_Human;
		
		//===================================
		// Game logic variables
		//===================================
		
		
		public function L_Human(f:Faction)
		{
			super();
			faction = f;
			alive = true;
			health = HP_MAX;
			//for now create a v_human and wake it
			v_human = new V_Human(this);
			trace("human created");
			v_component = v_human;
			hLayer = 0;
		}
		
		public override function update():void
		{
			//temporary chunk testing
			var tempChunkTestingInHuman:NONSENSE;
			
			//movement
			
//			x += currXModifier;
//			y += currYModifier;
//			
//			if (goingUp)
//			{
//				currXModifier -= .1;
//				currYModifier -= .1;
//				
//				if (currXModifier < -2)
//				{
//					goingUp = true;
//				}
//			}
//			else
//			{
//				currXModifier += .1;
//				currYModifier += .1;
//				if (currXModifier > 2)
//				{
//					goingUp = false;
//				}
//			}
			//if (currTile.vTile)
			//{
				/*
				for (var h:int = 0; h < L_Chunk.NUM_C_TILES_HEIGH; h++)
				{
					for (var w:int = 0; w < L_Chunk.NUM_C_TILES_WIDE; w++)
					{
						if (currTile != prevTile)
						{
							if (prevTile)
							{
								if (prevTile.chunk != currTile.chunk &&
									prevTile.chunk.l_tiles[h][w].vTile)
								{
									//prevTile.chunk.l_tiles[h][w].vTile.alpha = 1;
								}
							}
						}
						if (currTile.chunk.l_tiles[h][w].vTile)
						{
							//currTile.chunk.l_tiles[h][w].vTile.alpha = .5;
						}
					}
				}
				//currTile.vTile.alpha=.5;
				*/
			//}
			super.update();
		}

		public override function wake(state:Boolean):void
		{
			if (state)
			{
				if (_v_human)
				{
					_v_human.wake(true);
					trace("awoken");
				}
			}
			else
			{
				if (_v_human)
				{
					_v_human.wake(false);
					trace("put to sleep");
				}
			}
			awake = state;
		}

		public function get v_human():V_Human
		{
			return _v_human;
		}

		public function set v_human(value:V_Human):void
		{
			_v_human = value;
		}
	}
}