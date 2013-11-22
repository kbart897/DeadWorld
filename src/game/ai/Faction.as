package game.ai
{
	import game.entities.Entity;
	import game.entities.L_Human;
	import game.entities.Unit;

	public class Faction
	{
		public static const F_PLAYER:int = 0;
		private var _units:Vector.<Unit>;
		
		private var _currSelectionIndex:int = 0;
		
		//The resources vector slots will
		//correspond to the different resources,
		//by referencing variables such as
		//'R_WOOD' or 'R_METAL'
		private var _resources:Vector.<int>;
		private var _ownerId:int = 0;
		private var _name:String = "";
		
		public function Faction()
		{
			units = new Vector.<Unit>();
			resources = new Vector.<int>();
		}

		public function getNumUnitsWithAPLeft():int
		{
			var numUnitsWithAPLeft:int = 0;
			for (var i:int = 0; i < units.length; i++)
			{
				if (units[i].ap > 0)
				{
					numUnitsWithAPLeft++;
				}
			}
			
			return numUnitsWithAPLeft;
		}
		
		public function getNextSelection(u:Entity=null):Unit
		{
			var currUnit:Unit = null;
			if (u is Unit)
			{
				currUnit = u as Unit;
			}
			
			if (currUnit)
			{
				if (currUnit is L_Human)
				{
					if ((currUnit as L_Human).faction == this)
					{
						getSelectionIndex(currUnit);
						return getSelection();
					}
					else
					{
						return getSelection();
					}
				}
				else
				{
					return getSelection();
				}
			}
			else
			{
				return getSelection();
			}
		}
		
		private function getSelection():Unit
		{
			currSelectionIndex++;
			checkSelectionIndex();
			
			var prevSelectionIndex:int = currSelectionIndex;
			//var currUnit:Unit = null;
			
			do
			{
				if (units[currSelectionIndex].ap > 0)
				{
					return units[currSelectionIndex];
				}
				currSelectionIndex++;
				checkSelectionIndex();
			}
			while (prevSelectionIndex != currSelectionIndex);
			
			return null;
		}
		
		private function checkSelectionIndex():void
		{
			if (units.length <= currSelectionIndex)
			{
				currSelectionIndex = 0;
			}
		}
		
		public function getSelectionIndex(u:Unit):int
		{
			for (var i:int = 0; i < _units.length; i++)
			{
				if (u == _units[i])
				{
					currSelectionIndex = i;
					return i;
				}
			}
			
			currSelectionIndex = 0;
			return 0;
		}
		
		public function get units():Vector.<Unit>
		{
			return _units;
		}

		public function set units(value:Vector.<Unit>):void
		{
			_units = value;
		}

		public function get resources():Vector.<int>
		{
			return _resources;
		}

		public function set resources(value:Vector.<int>):void
		{
			_resources = value;
		}

		public function get ownerId():int
		{
			return _ownerId;
		}

		public function set ownerId(value:int):void
		{
			_ownerId = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get currSelectionIndex():int
		{
			return _currSelectionIndex;
		}

		public function set currSelectionIndex(value:int):void
		{
			_currSelectionIndex = value;
		}


	}
}