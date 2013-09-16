package ru.alexli.fcake.view.ui.containers
{
	import ru.alexli.fcake.model.AbstractVO;
	
	public class PaddingVO extends AbstractVO
	{
		
		public var paddingLeft:Number = 1;
		public var paddingTop:Number = 1;
		public var paddingRight:Number = 1;
		public var paddingBottom:Number = 1;
		public var verticalGap:Number = 5;
		public var horizontalGap:Number = 5;
		
		public function PaddingVO(initObj:Object=null)
		{
			super(initObj);
		}
	}
}