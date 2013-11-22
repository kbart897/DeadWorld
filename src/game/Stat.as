package game
{
	import flash.geom.Point;

	public class Stat
	{
		public function Stat()
		{
		}
		
		public static function distance(a:Point, b:Point):Number
		{
			var dist:Number = 0;
			
			var dX:Number = a.x - b.x;
			var dY:Number = a.y - b.y;
			
			dist = Math.sqrt((dX*dX)+(dY*dY));
			
			return dist;
		}
	}
}