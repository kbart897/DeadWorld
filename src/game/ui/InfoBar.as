package game.ui
{
	import game.ai.Faction;
	import game.entities.Entity;
	import game.entities.L_Human;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	public class InfoBar extends Sprite
	{
		public static const BG_SPRITE:String = "info_bg";
		
		private var bg:Image;
		
		private var activeFaction:Faction;
		private var currFaction:TextField;
		private var numUnits:TextField
		private var description:TextField;
		
		public function InfoBar()
		{
			super();
			bg = new Image(Assets.getAtlas().getTexture(BG_SPRITE));
			addChild(bg);
			
			currFaction = new TextField(200, 30, "");
			currFaction.hAlign = HAlign.LEFT;
			addChild(currFaction);
			currFaction.x = 15;
			currFaction.y = 10;
			
			numUnits = new TextField(200, 30, "");
			numUnits.hAlign = HAlign.LEFT;
			addChild(numUnits);
			numUnits.x = 15;
			numUnits.y = 40;
			
			description = new TextField(200, 30, "");
			description.hAlign = HAlign.LEFT;
			addChild(description);
			description.x = 15;
			description.y = 70;
		}
		
		public function setFaction(f:Faction):void
		{
			activeFaction = f;
			
			update();
		}
		
		public function update():void
		{
			currFaction.text = "Current faction: " + activeFaction.name;
			numUnits.text = "Number of units left: " + activeFaction.getNumUnitsWithAPLeft() + "/"
				+ activeFaction.units.length;
		}
	}
}