package game.ui
{
	import game.ai.Faction;
	import game.entities.Entity;
	import game.entities.L_Human;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class DetailScreen extends Sprite implements ICloseable
	{
		public static const BG_SPRITE:String = "detail_bg";
		
		private var bg:Image;
		
		private var currEntity:Entity;
		
		public function DetailScreen()
		{
			super();
			bg = new Image(Assets.getAtlas().getTexture(BG_SPRITE));
			addChild(bg);
		}
		
		public function update():void
		{
			setEntity(currEntity);
		}
		
		public function clear():void
		{
			this.visible = false;
		}
		
		public function setEntity(e:Entity):void
		{
			currEntity = e;
			
			if (e is L_Human)
			{
				if ((e as L_Human).faction.ownerId == Faction.F_PLAYER)
				{
					setupOwnedHumanDetailScreen();
				}
				else
				{
					setupUnownedHumanDetailScreen();
				}
			}
			else
			{
				setupEntityDetailScreen();
			}
		}
		
		private function setupOwnedHumanDetailScreen():void
		{
			//Show full inventory
			//show character bar / stats screen
		}
		
		private function setupUnownedHumanDetailScreen():void
		{
			//maybe smaller bg?
		}
		
		private function setupEntityDetailScreen():void
		{
			//smaller bg
			//no inventory spaces
			//no character chart, just a description
			//and some stats on the entity
		}
	}
}