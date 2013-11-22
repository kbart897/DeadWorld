package game.entities
{
	import flash.geom.Point;
	
	import game.tiles.L_Tile;
	import game.tiles.V_Tile;
	
	import starling.display.Image;
	import starling.display.Sprite;

	public class Entity
	{
		//======================================
		// Entity type constants
		//======================================
		public static const T_HUMAN:int = 0;
		public static const T_ZOMBIE:int = 1;
		public static const T_WALL:int = 2;
		
		//======================================
		// Common Entity Variables
		//======================================
		private var _x:Number = 0;
		private var _y:Number = 0;
		
		private var _hLayer:int = 0;
		private var _height:Number;
		private var _width:Number;
		private var _v_component:Sprite;
		
		//Awake controls whether the entity is rendered or not
		private var _awake:Boolean = false;
		
		//Tile/chunk control variables
		private var _currTile:L_Tile;
		private var _prevTile:L_Tile;
		private var _needNewTile:Boolean = false;
		private var _changingChunk:Boolean = false;
		
		//References for entity management
		private var _entityMgr:EntityManager;
		
		public function Entity()
		{
			
		}

		public function getPositionPoint():Point
		{
			return new Point(x, y);
		}
		
		public function get prevTile():L_Tile
		{
			return _prevTile;
		}

		public function set prevTile(value:L_Tile):void
		{
			_prevTile = value;
		}

		public function update():void
		{	
			
		}
		
		public function get currTile():L_Tile
		{
			return _currTile;
		}

		public function set currTile(value:L_Tile):void
		{
			//Check to see if it's the first time through.
			//If so, then nothing can be done for the
			//previous tile element.
			if (_currTile)
			{
				//If it's not, then you can set
				//the previous tile.
				if (value != _currTile)
				{
					if (_prevTile)
					{
						if (value != _prevTile)
						{
							_prevTile = _currTile;
						}
					}
					else
					{
						_prevTile = value;
					}
				}
			}
			_currTile = value;
			
			//If there was no previous tile, as in
			//on the first loop through, then you
			//can set the previous tile.
			if (!_prevTile)
			{
				_prevTile = _currTile;
			}
			
			//Now you need to see if the entity has been
			//put into a new chunk
			if (_prevTile.chunk != _currTile.chunk)
			{
				changingChunk = true;
				//If it is in a new chunk, then:
				//First remove self from previous chunk
				var entityIndex:int = _prevTile.chunk.entities.indexOf(this);
				_prevTile.chunk.entities.splice(entityIndex, 1);
				//add self to new chunk
				_currTile.chunk.entities.push(this);
				trace("\nadded to new chunk!\n");
				//check if new chunk is loaded,
				//or in other words a view chunk.
//				if (!_currTile.chunk.loaded)
//				{
//					trace("Entity put to sleep on chunk change");
//					//if not, then put self to sleep.
//					wake(false);
//				}
//				else
//				{
//					trace("!!Awoken from chunk change!");
//					//If it is, then
//					wake(true);
//				}
			}
		}
		
		public function get hLayer():int
		{
			return _hLayer;
		}

		public function set hLayer(value:int):void
		{
			_hLayer = value;
		}

		public function get width():Number
		{
			return _width;
		}

		public function set width(value:Number):void
		{
			_width = value;
		}

		public function get v_component():Sprite
		{
			return _v_component;
		}

		public function set v_component(value:Sprite):void
		{
			_v_component = value;
		}

		public function get height():Number
		{
			return _height;
		}

		public function set height(value:Number):void
		{
			_height = value;
		}

		public function get x():Number
		{
			return _x;
		}

		public function set x(value:Number):void
		{
			_x = value;
			if (v_component)
			{
				v_component.x = _x;
			}
			
			if (currTile)
			{
				if (!needNewTile)
				{
					if (_x > ((currTile.x * V_Tile.EXPLICIT_WIDTH)+V_Tile.EXPLICIT_WIDTH) ||
						_x < (currTile.x * V_Tile.EXPLICIT_WIDTH))
					{
						entityMgr.entitiesNeedingNewTile.push(this);
						needNewTile = true;
					}
				}
			}
		}

		public function get y():Number
		{
			return _y;
		}

		public function set y(value:Number):void
		{
			_y = value;
			if (v_component)
			{
				v_component.y = _y
			}
			
			if (currTile)
			{
				if (!needNewTile)
				{
					if (_y > ((currTile.y * V_Tile.EXPLICIT_HEIGHT)+V_Tile.EXPLICIT_HEIGHT) ||
						_y < (currTile.y * V_Tile.EXPLICIT_HEIGHT))
					{
						entityMgr.entitiesNeedingNewTile.push(this);
						needNewTile = true;
					}
				}
			}
		}

		public function wake(state:Boolean):void
		{
			//Override in entity members
			trace("called super wake function...");
		}
		
		public function get awake():Boolean
		{
			return _awake;
		}

		public function set awake(value:Boolean):void
		{
			_awake = value;
		}

		public function get needNewTile():Boolean
		{
			return _needNewTile;
		}

		public function set needNewTile(value:Boolean):void
		{
//			if (value && !_needNewTile)
//			{
				_needNewTile = value;
				//_entityMgr.entitiesNeedingNewTile.push(this);
//			}
		}

		public function get changingChunk():Boolean
		{
			return _changingChunk;
		}

		public function set changingChunk(value:Boolean):void
		{
			_changingChunk = value;
		}

		public function get entityMgr():EntityManager
		{
			return _entityMgr;
		}

		public function set entityMgr(value:EntityManager):void
		{
			_entityMgr = value;
		}
	}
}