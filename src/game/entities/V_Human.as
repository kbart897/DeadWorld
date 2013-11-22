package game.entities
{
	import flash.geom.Point;
	
	import game.tiles.V_Tile;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class V_Human extends Sprite
	{
		public static var DISPLAY_SPRITE:String = "temp_player";
		private var _l_human:L_Human;
		private var _image:Image;
		
		public function V_Human(l_component:L_Human)
		{
			super();
			_l_human = l_component;
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
					image = new Image(Assets.getAtlas().getTexture(DISPLAY_SPRITE));
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