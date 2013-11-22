package game.entities
{
	public class L_Doodad extends Entity
	{
		public static const T_TREE:int = 0;
		public static const T_BUSH:int = 1;
		public static const T_BLOOD:int = 2;
		public static const T_CAN:int = 3;
		public static const T_GARBAGE:int = 4;
		public static const T_PAPER:int = 5;
		public static const T_SKIDMARK:int = 6;
		public static const T_ROAD_BROKEN:int = 7;
		
		private var _type:int;
		private var _v_doodad:V_Doodad;
		
		public function L_Doodad(t:int)
		{
			type = t;
			hLayer = 0;
			v_doodad = new V_Doodad(this);
			v_component = v_doodad;
		}
		
		public override function wake(state:Boolean):void
		{
			if (state)
			{
				if (_v_doodad)
				{
					_v_doodad.wake(true);
					trace("awoken");
				}
			}
			else
			{
				if (_v_doodad)
				{
					_v_doodad.wake(false);
					trace("put to sleep");
				}
			}
			awake = state;
		}

		public function get type():int
		{
			return _type;
		}

		public function set type(value:int):void
		{
			_type = value;
		}

		public function get v_doodad():V_Doodad
		{
			return _v_doodad;
		}

		public function set v_doodad(value:V_Doodad):void
		{
			_v_doodad = value;
		}


	}
}