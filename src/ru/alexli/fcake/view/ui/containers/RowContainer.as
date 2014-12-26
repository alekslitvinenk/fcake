package ru.alexli.fcake.view.ui.containers
{
	import flash.geom.Point;

	public class RowContainer extends AlignContainer
	{
		public function RowContainer(padding:PaddingVO=null)
		{
			super(padding);
		}
		
		override protected function getNextObjPos():Point
		{
			return new Point(0, height);
		}
	}
}