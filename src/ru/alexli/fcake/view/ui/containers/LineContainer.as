package ru.alexli.fcake.view.ui.containers
{
	import flash.geom.Point;

	public class LineContainer extends AlignContainer
	{
		public function LineContainer(padding:PaddingVO=null)
		{
			super(padding);
		}
		
		override protected function getNextObjPos():Point
		{
			return new Point(width, 0);
		}
	}
}