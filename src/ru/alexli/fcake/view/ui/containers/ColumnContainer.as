package ru.alexli.fcake.view.ui.containers
{
	import flash.geom.Point;

	public class ColumnContainer extends AlignContainer
	{
		public function ColumnContainer(padding:PaddingVO=null)
		{
			super(padding);
		}
		
		override protected function getNextObjPos():Point
		{
			return new Point(height, 0);
		}
	}
}