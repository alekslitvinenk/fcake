package ru.alexli.fcake.view.utils
{
	import flash.display.Graphics;

	/**
	 * Contail useful function for quick primitive drwing
	 *  
	 * @author alexander
	 * 
	 */	
	public class DrawShortcuts
	{
		public static function drawRect(obj:Object, w:Number, h:Number, fill:uint = 0, alpha:Number = 1):void
		{
			if(obj.graphics && obj.graphics is Graphics)
			{
				var g:Graphics = obj.graphics;
				g.beginFill(fill, alpha);
				g.drawRect(0, 0, w, h);
				g.endFill();
			}
		}
	}
}