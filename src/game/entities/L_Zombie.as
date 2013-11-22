package game.entities
{
	import game.ai.Faction;

	public class L_Zombie extends Unit
	{
		//===================================
		// Some base stats
		//===================================
		
		public static const HP_MAX:int = 100;
		
		private var _v_zombie:V_Zombie;
		
		//===================================
		// Game logic variables
		//===================================
		
		public function L_Zombie(f:Faction)
		{
			super();
			faction = f;
			alive = true;
			health = HP_MAX;
			//for now create a v_zombie and wake it
			v_zombie = new V_Zombie(this);
			trace("zombie created");
			v_component = v_zombie;
			hLayer = 0;
		}
		
		public override function update():void
		{
			super.update();
		}
		
		public override function wake(state:Boolean):void
		{
			if (state)
			{
				if (_v_zombie)
				{
					_v_zombie.wake(true);
					trace("awoken");
				}
			}
			else
			{
				if (_v_zombie)
				{
					_v_zombie.wake(false);
					trace("put to sleep");
				}
			}
			awake = state;
		}
		
		public function get v_zombie():V_Zombie
		{
			return _v_zombie;
		}
		
		public function set v_zombie(value:V_Zombie):void
		{
			_v_zombie = value;
		}
	}
}