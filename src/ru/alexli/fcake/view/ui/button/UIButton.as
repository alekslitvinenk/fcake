package ru.alexli.fcake.view.ui.button
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ru.alexli.fcake.view.AbstractVisualObject;
	import ru.alexli.fcake.view.skinable.Skin;
	
	public class UIButton extends AbstractVisualObject
	{
		public static const NORMAL_STATE:String = "normal_state";
		public static const OVER_STATE:String = "over_state";
		public static const DOWN_STATE:String = "down_state";
		
		public static function createStatesFromSimpleButton(btn:SimpleButton, targetButton:UIButton = null):UIButton
		{
			var button:UIButton = targetButton || new UIButton();
			button.normalState = btn.upState;
			button.overState = btn.overState;
			button.downState = btn.downState;
			
			return button;
		}
		
		public static function createStatesFromSkins(skins:Array, targetButton:UIButton = null):UIButton
		{
			if(skins.length == 1)
			{
				skins[1] = skins[0];
			}
			
			if(skins.length == 2)
			{
				skins[2] = skins[0];
			}
			
			var button:UIButton = targetButton || new UIButton();
			button.normalState = new Skin(skins[0]);
			button.overState = new Skin(skins[1]);
			button.downState = new Skin(skins[2]);
			
			return button;
		}
		
		private var statesContainer:Sprite
		
		public function UIButton()
		{
			super();
		}
		
		private var _normalState:DisplayObject;
		
		public function get normalState():DisplayObject
		{
			return _normalState;
		}
		
		public function set normalState(value:DisplayObject):void
		{	
			var stateView:DisplayObject = _normalState;
			
			if(stateView && stateView.parent && stateView.parent == statesContainer)
			{
				statesContainer.removeChild(stateView);
			}
			
			_normalState = value;
			
			statesContainer.addChild(value);
		}
		
		private var _overState:DisplayObject;
		
		public function get overState():DisplayObject
		{
			return _overState;
		}
		
		public function set overState(value:DisplayObject):void
		{
			var stateView:DisplayObject = _overState;
			
			if(stateView && stateView.parent && stateView.parent == statesContainer)
			{
				statesContainer.removeChild(stateView);
			}
			
			_overState = value;
			
			statesContainer.addChild(value);
		}
		
		private var _downState:DisplayObject;
		
		public function get downState():DisplayObject
		{
			return _downState;
		}
		
		public function set downState(value:DisplayObject):void
		{
			var stateView:DisplayObject = _downState;
			
			if(stateView && stateView.parent && stateView.parent == statesContainer)
			{
				statesContainer.removeChild(stateView);
			}
			
			_downState = value;
			
			statesContainer.addChild(value);
		}
		
		override protected function init():void
		{
			addChild(statesContainer = new Sprite());
			statesContainer.mouseEnabled = false;
			statesContainer.mouseChildren = false;
			
			useHandCursor = buttonMode = true;
			
			listenToMouse();
			
			super.init();
		}
		
		override protected function onShow():void
		{
			super.onShow();
			
			//listenToMouse();
			
			state = NORMAL_STATE;
		}
		
		private var _state:String;
		
		public function get state():String
		{
			return _state;
		}
		
		public function set state(value:String):void
		{
			_state = value;
			
			exitState(value);
			enterState(value);
		}
		
		protected function exitState(val:String):void
		{
			_normalState.visible = false;
			_overState.visible = false;
			_downState.visible = false;
		}
		
		protected function enterState(val:String):void
		{
			switch(val)
			{
				case NORMAL_STATE:
				{
					_normalState.visible = true;
					break;
				}
					
				case OVER_STATE:
				{
					_overState.visible = true;
					break;
				}
					
				case DOWN_STATE:
				{
					_downState.visible = true;
					break;
				}
			}
		}
		
		public function listenToMouse():void
		{
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		public function unlistenToMouse():void
		{
			removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			removeEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		//events
		protected function onMouseOver(evt:Event):void
		{
			state = OVER_STATE;
		}
		
		protected function onMouseOut(evt:Event):void
		{
			state = NORMAL_STATE;
		}
		
		protected function onMouseDown(evt:Event):void
		{
			state = DOWN_STATE;
		}
		
		protected function onMouseClick(evt:Event):void
		{
			state = NORMAL_STATE;
		}
	}
}

