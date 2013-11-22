package game.ui
{
	import game.ai.Faction;
	import game.entities.Entity;
	import game.entities.L_Human;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	public class EntityPreview extends Sprite
	{
		public static const BG_SPRITE:String = "selection_bg";
		public static const BAR_GREEN_SPRITE:String = "p_green";
		public static const BAR_RED_SPRITE:String = "p_red";
		public static const BAR_BG_SPRITE:String = "black_pixel";
		
		private var bg:Image;
		
		private var greenBar:Image;
		private var redBar:Image;
		private var grayBarBg:Image;
		
		private var bar_height:Number = 20;
		
		private var title:TextField
		private var description:TextField;
		
		private var entityImage:Image;
		
		private var _currEntity:Entity;
		
		public function EntityPreview()
		{
			super();
			bg = new Image(Assets.getAtlas().getTexture(BG_SPRITE));
			addChild(bg);
			title = new TextField(200, 30, "");
			title.hAlign = HAlign.LEFT;
			addChild(title);
			title.x = 15;
			title.y = 10;
			
			description = new TextField(200, 30, "");
			description.hAlign = HAlign.LEFT;
			addChild(description);
			description.x = 15;
			description.y = 50;
			
			grayBarBg = new Image(Assets.getAtlas().getTexture(BAR_BG_SPRITE));
			addChild(grayBarBg);
			grayBarBg.y = bg.height-(2*bar_height);
			grayBarBg.width = bg.width;
			grayBarBg.height = 2*bar_height;
			grayBarBg.alpha = .5;
			
			greenBar = new Image(Assets.getAtlas().getTexture(BAR_GREEN_SPRITE));
			addChild(greenBar);
			greenBar.y = bg.height-bar_height;
			greenBar.width = bg.width;
			greenBar.height = bar_height;
			
			redBar = new Image(Assets.getAtlas().getTexture(BAR_RED_SPRITE));
			addChild(redBar);
			redBar.y = bg.height-(2*bar_height);
			redBar.width = bg.width;
			redBar.height = bar_height;
		}
		
		public function update():void
		{
			setEntity(currEntity);
		}
		
		public function clear():void
		{
			this.visible = false;
			title.text = "";
			description.text = "";
		}
		
		public function setEntity(e:Entity):void
		{
			currEntity = e;
			
			if (e is L_Human)
			{
				title.text = "Human";
				if ((e as L_Human).faction.ownerId == Faction.F_PLAYER)
				{
					description.text = "Owned by " + (e as L_Human).faction.name;
					greenBar.visible = true;
					redBar.visible = true;
					
					greenBar.width = bg.width * ((e as L_Human).ap / (e as L_Human).apMax);
					redBar.width = bg.width * ((e as L_Human).health / L_Human.HP_MAX);
					
					grayBarBg.visible = true;
					grayBarBg.height = 2*bar_height;
				}
				else
				{
					description.text = "Owned by " + (e as L_Human).faction.name;
					redBar.visible = true;
					redBar.width = bg.width * ((e as L_Human).health / L_Human.HP_MAX);
					
					greenBar.visible = false;
					
					grayBarBg.visible = true;
					grayBarBg.height = bar_height;
				}
			}
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