package ru.alexli.fcake.view.ui.window
{
	import flash.display.Graphics;
	
	import ru.alexli.fcake.view.AbstractVisualObject;
	import ru.alexli.fcake.view.ui.window.AbstractWindow;
	
	/**
	 * Модальный экран
	 *  
	 * @author alexander
	 * 
	 */	
	public class ModalShield extends AbstractWindow
	{
		
		public function ModalShield()
		{
			super();
		}
		
		override protected function arrange():void{
			setSize(stage.stageWidth, stage.stageHeight);
		}
		
		private function setSize(w:Number, h:Number):void{
			var g:Graphics = graphics;
			g.clear();
			g.beginFill(0, 0.3);
			g.drawRect(0, 0, w, h);
			g.endFill();
		}
	}
}