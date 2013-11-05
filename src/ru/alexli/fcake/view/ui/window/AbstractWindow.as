package ru.alexli.fcake.view.ui.window
{
	import flash.events.Event;
	
	import ru.alexli.fcake.view.AbstractVisualObject;
	
	/**
	 * Аьстрактное окно
	 *  
	 * @author Alexander Litvinenko
	 * 
	 */	
	[Event(name="window_close", type="ru.finam.games.islands.view.ui.WindowEvent")]
	public class AbstractWindow extends AbstractVisualObject
	{
		public var status:String = WindowStatus.OK;
		
		protected var _modal:Boolean;
		
		public function get modal():Boolean{
			return _modal;
		}
		
		public function set modal(val:Boolean):void{
			_modal = val;
		}
		
		public function get data():Object{
			return _data;
		}
		
		public function set data(val:Object):void{
			_data = val;
			commitData();
		}
		
		protected var _data:Object;
		
		public function AbstractWindow(id:String = null)
		{
			_id = id;
			if(id){
				name = id;
			}
		}
		
		protected var _id:String;
		
		public function get id():String{
			return _id;
		}
		
		override protected function onShow():void{
			arrange();
			stage.addEventListener(Event.RESIZE, onStageResize);
		}
		
		override protected function onHide():void{
			stage.removeEventListener(Event.RESIZE, onStageResize);
		}
		
		protected function commitData():void{
			//virtual function
		}
		
		protected function arrange():void{
			x = stage.stageWidth/2 - width/2;
			y = stage.stageHeight/2 - height/2;
		}
		
		private function onStageResize(evt:Event):void{
			arrange();
		}
		
		/**
		 * Закрыть окно 
		 * 
		 */		
		public function close():void{
			dispatchEvent(new WindowEvent(WindowEvent.WINDOW_CLOSE));
		}
	}
}