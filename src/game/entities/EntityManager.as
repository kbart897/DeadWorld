package game.entities
{
	import game.Level;
	import game.tiles.L_Tile;
	import game.tiles.TileManager;
	import game.tiles.V_Chunk;
	import game.tiles.V_Tile;
	
	import starling.display.Sprite;
	import starling.utils.deg2rad;

	public class EntityManager
	{
		private var tileMgr:TileManager;
		private var entityLayer:Vector.<Sprite>;
		
		private var entities:Vector.<Entity>;
		private var humans:Vector.<L_Human>;
		private var zombies:Vector.<L_Zombie>;
		private var constructs:Vector.<L_Construct>;
		
		//This is special for entity movement
		private var _entitiesNeedingNewTile:Vector.<Entity>;
		
		//This class will manage what entities are loaded on screen,
		//and dynamically load and unload objects
		public function EntityManager(tileManager:TileManager, entLyr:Vector.<Sprite>)
		{
			tileMgr = tileManager;
			entityLayer = entLyr;
			
			entities = new Vector.<Entity>();
			humans = new Vector.<L_Human>();
			zombies = new Vector.<L_Zombie>();
			constructs = new Vector.<L_Construct>();
			
			entitiesNeedingNewTile = new Vector.<Entity>();
		}
		
		public function update():void
		{
			//only update awake entities eventually
			var onlyUpdateAwakeEntities:NONSENSE;
			var maybeNeedBetterReferenceToViewChunks:NONSENSE;
			//I say this because now v_chunks in ChunkManager is public...
			var numEntities:int = 0;
			
			var e:Entity;
			
			for each (var c:V_Chunk in tileMgr.chunkMgr.vChunks)
			{
				for each (e in c.lChunk.entities)
				{
					//Might be able to omit this; I don't
					//think it will ever get called
					var redundantWakeCodeInMgrUpdate:NONSENSE;
					if (!e.awake)
					{
						e.wake(true);
					}
					e.update();
					
					numEntities++;
				}
			}
			
			//trace("Entities on screen: " + numEntities);
			numEntities = 0;
			for each (e in entitiesNeedingNewTile)
			{
				numEntities++;
				e.currTile = tileMgr.getTileAtPixelCoordinates(e.x, e.y);
				e.needNewTile = false;
				
				if (e.currTile.chunk.loaded)
				{
					if (!e.awake)
					{
						e.wake(true);
					}
				}
				else
				{
					if (e.awake)
					{
						e.wake(false);
					}
				}
			}
			
			//Clear the vector so that it works freshly next iteration
			entitiesNeedingNewTile.splice(0, entitiesNeedingNewTile.length);
			
			/*for each (var e:Entity in entities)
			{
				e.currTile = tileMgr.getTileAtPixelCoordinates(e.x, e.y);
				if (e.currTile.vTile)
				{
					if (!e.wake)
					{
						e.wake = true;
					}
					e.update();
				}
				else
				{
					e.wake = false;
				}
			}*/
			
		}
		
		public function addZombie(z:L_Zombie):void
		{
			
		}
		
		public function addHuman(h:L_Human):void
		{
			
		}
		
		public function addEntity(ent:Entity, xPos:Number=-1, yPos:Number=-1, randRotation:Boolean=false):void
		{
			entities.push(ent);
			
			if (xPos != -1)
			{
				xPos += V_Tile.EXPLICIT_WIDTH/2;
			}
			if (yPos != -1)
			{
				yPos += V_Tile.EXPLICIT_HEIGHT/2;
			}
			
			if (ent is L_Human)
			{
				humans.push(ent);
			}
			else if (ent is L_Zombie)
			{
				zombies.push(ent);
			}
			//Get its tile
			//Add it to the appropriate chunk
			//Update the chunk its in maybe??
			//For now just add it to the entity layer
			
			//======================================
			// !!!ADD ENTITIES TO THEIR PROPER CHUNK!!!
			//======================================
			//asdfasdf
			//The x and y values will be populated via the Factory classes
			if (xPos < 0)
			{
				ent.x = Math.ceil(Math.random()*TileManager.NUM_L_TILES_WIDE)*V_Tile.EXPLICIT_WIDTH - (V_Tile.EXPLICIT_WIDTH/2);
			}
			else
			{
				ent.x = xPos;
			}
					
			if (yPos < 0)
			{
				ent.y = Math.ceil(Math.random()*TileManager.NUM_L_TILES_HEIGH)*V_Tile.EXPLICIT_HEIGHT - (V_Tile.EXPLICIT_HEIGHT/2);
			}
			else
			{
				ent.y = yPos;
			}
			ent.currTile = tileMgr.getTileAtPixelCoordinates(ent.x, ent.y);
			ent.currTile.chunk.entities.push(ent);
			ent.entityMgr = this;
			
			var makeSureEntitiesDynamicallyChangeChunks:NONSENSE;
			
//			if (randRotation)
//			{
//				var rand:Number = Math.random();
//				
//				if (rand < .25)
//				{
//					ent.v_component.rotation += (deg2rad(90));
//					ent.v_component.x += ent.v_component.width;
//				}
//				if (rand < .5)
//				{
//					ent.v_component.rotation += (deg2rad(180));
//					ent.v_component.x += ent.v_component.width;
//					ent.v_component.y += ent.v_component.height;
//				}
//				if (rand < .75)
//				{
//					ent.v_component.rotation += (deg2rad(270));
//					ent.v_component.y += ent.v_component.height;
//				}
//			}
			//ent.currChunk = ent.currTile.chunk;
			entityLayer[ent.hLayer].addChild(ent.v_component);
			trace("entity added and moved");
		}

		public function get entitiesNeedingNewTile():Vector.<Entity>
		{
			return _entitiesNeedingNewTile;
		}

		public function set entitiesNeedingNewTile(value:Vector.<Entity>):void
		{
			_entitiesNeedingNewTile = value;
		}

	}
}