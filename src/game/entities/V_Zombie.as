package game.entities
{
	import starling.display.Sprite;
	import starling.display.Image;
	
	public class V_Zombie extends Sprite
	{
		public static var DISPLAY_SPRITE:String = "temp_player";
		private var _l_zombie:L_Zombie;
		private var _image:Image;
		
		public function V_Zombie(l_component:L_Zombie)
		{
			super();
			_l_zombie = l_component;
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
		
		public function get l_zombie():L_Zombie
		{
			return _l_zombie;
		}
		
		public function set l_zombie(value:L_Zombie):void
		{
			_l_zombie = value;
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
					_l_zombie.width = image.width;
					_l_zombie.height = image.height;
				}
				else
				{
					image.visible = true;
					//addChild(image);
				}
				_l_zombie.x = this.x;
				_l_zombie.y = this.y;
				
				l_zombie.awake = true;
			}
			else
			{
				if (image)
				{
					image.visible = false;
					//removeChild(image);
				}
				
				l_zombie.awake = false;
			}
		}
	}
}