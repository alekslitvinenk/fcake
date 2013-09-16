package ru.alexli.fcake.view.ui.button
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * Простая кнопка с несколькими состояниями
	 * @author Alexander Litvinenko
	 * 
	 */	
	public class UIButton extends Sprite
	{
		
		public static const STATE_UP:String 	= "up_state";
		public static const STATE_OVER:String 	= "over_state";
		public static const STATE_DOWN:String 	= "down_state";
		
		private var mapStates:Object = new Object();
		
		protected var state:String = STATE_UP;
		
		public function UIButton(upState:DisplayObject = null, overState:DisplayObject = null, downState:DisplayObject = null)
		{
			
			this.upState 	= upState;
			this.overState 	= overState;
			this.downState 	= downState;
			
			init();
			super();
		}
		
		protected function init():void{
			
			useHandCursor = buttonMode = true;
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_OVER, onRollOver);
			addEventListener(MouseEvent.MOUSE_OUT, onRollOut);
		}
		
		protected function switchState(val:String):void{
				
			mapStates[state].visible = false;
			
			state = val;
			
			mapStates[state].visible = true;
				
		}
		
		protected function setState(clip:DisplayObject, state:String):void{
			if(clip){
				clip.visible = false;
				addChild(clip);
				
				mapStates[state] = clip;
			}
		}
		
		public function set upState(val:DisplayObject):void{
			setState(val, STATE_UP);
			if(upState){
				switchState(STATE_UP);
			}
		}
		
		public function get upState():DisplayObject{
			return mapStates[STATE_UP];
		}
		
		public function set overState(val:DisplayObject):void{
			setState(val, STATE_OVER);
		}
		
		public function get overState():DisplayObject{
			return mapStates[STATE_OVER];
		}
		
		
		public function set downState(val:DisplayObject):void{
			setState(val, STATE_DOWN);
		}
		
		public function get downState():DisplayObject{
			return mapStates[STATE_DOWN];
		}
		
		//Event
		private function onMouseDown(evt:Event):void{
			switchState(STATE_DOWN);
		}
		
		private function onMouseUp(evt:Event):void{
			switchState(STATE_OVER);
		}
		
		private function onRollOver(evt:Event):void{
			switchState(STATE_OVER);
		}
		
		private function onRollOut(evt:Event):void{
			switchState(STATE_UP);
		}
	}
}