package ru.alexli.fcake.utils
{
	import flash.geom.Point;

	public class Coord
	{
		public static function getPoint(val:*):Point{
			return new Point(val.x, val.y);
		}
		
		public static function move(pt:Point, obj:*):void{
			obj.x = pt.x;
			obj.y = pt.y;
		}
	}
}