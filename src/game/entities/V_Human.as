package game.entities
{
	import flash.geom.Point;
	
	import game.tiles.V_Tile;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class V_Human extends Sprite
	{
		
		public static var S_FARMER:String = "units/humans/U_H_Farmer";
		public static var S_CONSTRUCTION:String = "units/humans/U_H_Construction";
		public static var S_FOOTBALL:String = "units/humans/U_H_Football";
		public static var S_MECHANIC:String = "units/humans/U_H_Mechanic";
		public static var S_RUNNER:String = "units/humans/U_H_Runner";
		public static var S_SOLDIER:String = "units/humans/U_H_Soldier";
		
		private var displaySprite:String = "";
		private var _l_human:L_Human;
		private var _image:Image;
		
		public function V_Human(l_component:L_Human)
		{
			super();
			_l_human = l_component;
			Log.out("NEW HUMAN ENTITY");
			//Set the display type
			var type:int = Math.ceil(Math.random()*6);
			
			switch (type)
			{
				case 1:
					displaySprite = S_FARMER;
					break;
				case 2:
					displaySprite = S_CONSTRUCTION;
					break;
				case 3:
					displaySprite = S_FOOTBALL;
					break;
				case 4:
					displaySprite = S_MECHANIC;
					break;
				case 5:
					displaySprite = S_RUNNER;
					break;
				case 6:
					displaySprite = S_SOLDIER;
					break;
			}
			
			displaySprite = S_FARMER;
			wake(true);
		}
		
		public function get image():Image
		{
			return _image;
		}

		public function set image(value:Image):void
		{
			_image = value;
		}

		public function get l_human():L_Human
		{
			return _l_human;
		}

		public function set l_human(value:L_Human):void
		{
			_l_human = value;
		}

		public function wake(awaken:Boolean = true):void
		{
			//load the image
			if (awaken)
			{
				if (!image)
				{
					image = new Image(Assets.getAtlas().getTexture(displaySprite));
					addChild(image);
					trace("image added!");
					image.y -= image.height/2;
					image.x -= image.width/2;
					_l_human.width = image.width;
					_l_human.height = image.height;
				}
				else
				{
					image.visible = true;
					//addChild(image);
				}
				_l_human.x = this.x;
				_l_human.y = this.y;
				
				l_human.awake = true;
			}
			else
			{
				if (image)
				{
					image.visible = false;
					//removeChild(image);
				}
				
				l_human.awake = false;
			}
		}
	}
}