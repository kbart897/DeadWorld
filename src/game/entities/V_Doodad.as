package game.entities
{
	import game.tiles.V_Tile;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class V_Doodad extends Sprite
	{
		public static var S_TREE:String = "DooDads/tree";
		public static var S_BUSH:String = "DooDads/bush";
		public static var S_BLOOD:String = "DooDads/blood1";
		public static var S_CAN:String = "DooDads/can";
		public static var S_GARBAGE:String = "DooDads/garbagecan";
		public static var S_PAPER:String = "DooDads/Paper";
		public static var S_SKIDMARK:String = "DooDads/skidmark";
		public static var S_ROAD_BROKEN:String = "DooDads/brokenroad";
		
		private var displaySprite:String = "DooDads/black_pixel";
		
		private var _l_doodad:L_Doodad;
		private var _image:Image;
		
		public function V_Doodad(l_component:L_Doodad)
		{
			super();
			_l_doodad = l_component;
			setType();
			wake(true);
		}
		
		private function setType():void
		{
			switch (l_doodad.type)
			{
				case L_Doodad.T_BLOOD:
					displaySprite = S_BLOOD;
					break;
				case L_Doodad.T_BUSH:
					displaySprite = S_BUSH;
					break;
				case L_Doodad.T_CAN:
					displaySprite = S_CAN;
					break;
				case L_Doodad.T_GARBAGE:
					displaySprite = S_GARBAGE;
					break;
				case L_Doodad.T_PAPER:
					displaySprite = S_PAPER;
					break;
				case L_Doodad.T_ROAD_BROKEN:
					displaySprite = S_ROAD_BROKEN;
					break;
				case L_Doodad.T_SKIDMARK:
					displaySprite = S_SKIDMARK;
					break;
				case L_Doodad.T_TREE:
					displaySprite = S_TREE;
					break;
			}
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
					trace("doodad image added!");
					image.y -= image.height/2;
					image.x -= image.width/2;
					_l_doodad.width = image.width;
					_l_doodad.height = image.height;
				}
				else
				{
					image.visible = true;
					//addChild(image);
				}
				_l_doodad.x = this.x;
				_l_doodad.y = this.y;
				
				_l_doodad.awake = true;
			}
			else
			{
				if (image)
				{
					image.visible = false;
					//removeChild(image);
				}
				
				_l_doodad.awake = false;
			}
		}

		public function get image():Image
		{
			return _image;
		}

		public function set image(value:Image):void
		{
			_image = value;
		}

		public function get l_doodad():L_Doodad
		{
			return _l_doodad;
		}

		public function set l_doodad(value:L_Doodad):void
		{
			_l_doodad = value;
		}


	}
}