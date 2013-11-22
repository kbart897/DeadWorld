package game.ui
{
	import com.greensock.plugins.EndArrayPlugin;
	
	import flash.net.dns.AAAARecord;
	
	import game.ai.Faction;
	import game.entities.Entity;
	import game.entities.L_Human;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class ActionBar extends Sprite
	{
		public static const BG_SPRITE:String = "action_bg";
		public static const END_TURN_SPRITE:String = "btn_nextTurn";
		public static const MOVE_SPRITE:String = "btn_move";
		
		public static const BTN_NOTHING:int = 0;
		public static const BTN_END_TURN:int = 1;
		public static const BTN_MOVE:int = 2;
		
		private var bg:Image;
		
		private var moveBtn:Image;
		private var attackBtn:Image;
		private var buildBtn:Image;
		private var craftBtn:Image;
		private var waitBtn:Image;
		private var endTurnBtn:Image;
		
		private var clickedBtn:int;
		
		private var _currEntity:Entity;
		
		public function ActionBar()
		{
			super();
			bg = new Image(Assets.getAtlas().getTexture(BG_SPRITE))
			addChild(bg);
				
			endTurnBtn = new Image(Assets.getAtlas().getTexture(END_TURN_SPRITE));
			addChild(endTurnBtn);
			endTurnBtn.x = bg.width - 10 - endTurnBtn.width;
			endTurnBtn.y = 10;
			
			moveBtn = new Image(Assets.getAtlas().getTexture(MOVE_SPRITE));
			addChild(moveBtn);
			moveBtn.x = 10;
			moveBtn.y = 10;
			moveBtn.visible = false;
		}
		
		public function clear():void
		{
			currEntity = null;
			moveBtn.visible = false;
		}
		
		public function setEntity(e:Entity):void
		{
			currEntity = e;
			
			if (e is L_Human)
			{
				var eHuman:L_Human = currEntity as L_Human;
				if (eHuman.faction.ownerId == Faction.F_PLAYER)
				{
					if (eHuman.ap > 0)
					{
						if (eHuman.ap > eHuman.getMoveCost())
						{
							moveBtn.visible = true;
							moveBtn.alpha = 1;
						}
						else
						{
							moveBtn.visible = true;
							moveBtn.alpha = .5;
						}
					}
					else
					{
						moveBtn.visible = true;
						moveBtn.alpha = .5;
					}
				}
				else
				{
					moveBtn.visible = false;
				}
			}
			else
			{
				moveBtn.visible = false;
			}
		}
		
		public function getClickedItem():int
		{
			Log.out("Checking clicked abar item...");
			if (endTurnBtn.visible)
			{
				Log.out("endTurn clicked?  x: " + (this.x + endTurnBtn.x) + " y: " + (this.x + endTurnBtn.y));
				if (GameState.MOUSE_CLICK_POS.x > this.x + endTurnBtn.x &&
					GameState.MOUSE_CLICK_POS.x < this.x + endTurnBtn.x + endTurnBtn.width &&
					GameState.MOUSE_CLICK_POS.y > this.y + endTurnBtn.y &&
					GameState.MOUSE_CLICK_POS.y < this.y + endTurnBtn.y + endTurnBtn.height)
				{
					Log.out("End turn button clicked!");
					return BTN_END_TURN;
				}
			}
			
			if (moveBtn.visible)
			{
				Log.out("moveBtn clicked?  x: " + (this.x + moveBtn.x) + " y: " + (this.y + moveBtn.y));
				if (GameState.MOUSE_CLICK_POS.x > this.x + moveBtn.x &&
					GameState.MOUSE_CLICK_POS.x < this.x + moveBtn.x + moveBtn.width &&
					GameState.MOUSE_CLICK_POS.y > this.y + moveBtn.y &&
					GameState.MOUSE_CLICK_POS.y < this.y + moveBtn.y + moveBtn.height)
				{
					Log.out("Move button clicked!");
					return BTN_MOVE;
				}
			}
			Log.out("No abar item clicked");
			return BTN_NOTHING;
		}

		public function get currEntity():Entity
		{
			return _currEntity;
		}

		public function set currEntity(value:Entity):void
		{
			_currEntity = value;
		}

	}
}