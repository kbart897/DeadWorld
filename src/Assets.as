package
{
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	public class Assets
	{
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		
		[Embed(source="assets/tiles.png")]
		public static const AtlasTextureGame:Class;
		
		[Embed(source="assets/tiles.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlGame:Class;
		
		//Fonts
		[Embed(source="assets/fonts/lucon.ttf", embedAsCFF="false", mimeType="application/x-font-truetype", fontFamily="ConsolaMono")]
		public static const lucon:Class;
		
		public static function getAtlas():TextureAtlas
		{
			if (gameTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasTextureGame");
				var xml:XML = XML(new AtlasXmlGame());
				gameTextureAtlas = new TextureAtlas(texture, xml);
			}
			return gameTextureAtlas;
		}
		
		public static function getTexture(name:String):Texture
		{
			if (gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
		
		public static function init():void
		{
			
		}
	}
}