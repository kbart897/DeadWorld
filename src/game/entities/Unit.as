package game.entities
{
	import flash.geom.Point;
	import game.ai.Faction;

	public class Unit extends Entity
	{
		private var _health:Number;
		private var _alive:Boolean;
		private var _movePath:Vector.<Point>;
		private var _ap:int = 100;
		private var _apMax:int = 100;
		private var _faction:Faction;
		
		public function Unit()
		{
			movePath = new Vector.<Point>();
		}

		public function hurt():Boolean
		{
			return false;
		}
		
		public function die():void
		{
			//remove from faction
		}
		
		public function attack():void
		{
			
		}
		
		public function getMoveCost():int
		{
			return 15;
		}
		
		public function get alive():Boolean
		{
			return _alive;
		}

		public function set alive(value:Boolean):void
		{
			_alive = value;
		}

		public function get health():Number
		{
			return _health;
		}

		public function set health(value:Number):void
		{
			_health = value;
		}

		public function get movePath():Vector.<Point>
		{
			return _movePath;
		}

		public function set movePath(value:Vector.<Point>):void
		{
			_movePath = value;
		}

		public function get ap():int
		{
			return _ap;
		}

		public function set ap(value:int):void
		{
			_ap = value;
		}

		public function get faction():Faction
		{
			return _faction;
		}

		public function set faction(value:Faction):void
		{
			//Here you can add the unit to the new faction
			//First splice from the old faction if it
			//belonged to the faction, and do
			//anything else you need to do
			if (_faction)
			{
				_faction.units.splice(_faction.units.indexOf(this), 1);
			}
			
			//Then add it to the new faction
			_faction = value;
			_faction.units.push(this);
		}

		public function get apMax():int
		{
			return _apMax;
		}

		public function set apMax(value:int):void
		{
			_apMax = value;
		}

	}
}