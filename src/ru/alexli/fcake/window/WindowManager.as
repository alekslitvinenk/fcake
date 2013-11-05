package ru.alexli.fcake.window
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.errors.IllegalOperationError;
	
	import ru.alexli.fcake.view.ui.window.AbstractWindow;
	import ru.alexli.fcake.view.ui.window.ModalShield;
	import ru.alexli.fcake.view.ui.window.WindowEvent;
	
	/**
	 * Менеджер показа окон
	 *  
	 * @author Alexander Litvinenko
	 * 
	 */	
	public class WindowManager
	{
		
		[Bindable]
		public var currentWindow:String;
		
		public var container:DisplayObjectContainer;
		
		/**
		 * Карта классов для строковых констант, представляющих собой имена окон 
		 */		
		private static var windowsMap:Object = {};
		
		/**
		 * Карта настроек для окон 
		 */		
		private static var windowsSettings:Object = {};
		
		private var windowsCache:Object = {};
		
		private var modal:ModalShield = new ModalShield();
		
		/**
		 * Флаг, указывающий на то, что было показано терминальное окно 
		 */		
		private var terminate:Boolean;
		
		/**
		 * Текущий список открытых окон 
		 */		
		private var windowsStack:Array = [];
		
		/**
		 * Список окно находящихся в очереди на отображение 
		 */		
		private var sequenceArray:Array = [];
		
		private static var canBeInstantiated:Boolean;
		
		private static var _instance:WindowManager;
		
		public static function get instance():WindowManager
		{
			if(!_instance){
				canBeInstantiated = true;
				_instance = new WindowManager();
				canBeInstantiated = false;
			}
			return _instance;
		}
		
		public function WindowManager()
		{
			if(!canBeInstantiated)
			{
				throw new IllegalOperationError("Error!");
			}
		}
		
		/**
		 * Register conatainer for displaying windows
		 *  
		 * @param container
		 * 
		 */		
		public function registerContainer(container:DisplayObjectContainer):void
		{
			this.container = container;
		}
		
		/**
		 * Регистрирует класс окна в менеджере показа окон
		 *  
		 * @param alias
		 * @param winClass
		 * @param settings
		 * 
		 */		
		public function registerWindow(alias:String, winClass:Class, settings:WindowSettings = null):void{
			windowsMap[alias] = winClass;
			if(settings){
				windowsSettings[alias] = settings;
			}
		}
		
		public function showWindow(name:String, params:Object = null):AbstractWindow{
			
			//Если было показано терминальное окно, то больше никаких окон не показываем
			if(terminate){
				return null;
			}
			
			//ищем настройки окна
			var winSettings:WindowSettings;
			if(windowsSettings[name]){
				winSettings = windowsSettings[name];
			}else{
				winSettings = new WindowSettings(WindowPresencePolicy.SINGLE);
			}
			
			var policy:int = winSettings.policy;
			
			//если в настройках окна указано, что это окно должно быть единственным на экране, то
			//закрываем остальные окна
			if(checkPolicy(policy, WindowPresencePolicy.SINGLE)){
				closeAll();
				
			//текущее окно замещает собой любое из окн, указанных в массиве parent
			}else if(checkPolicy(policy, WindowPresencePolicy.REPLACE)){
				var curWin:DisplayObject = container.getChildByName(currentWindow);
				if(winSettings.parent)
				{
					if(winSettings.parent.indexOf(currentWindow) != -1){
						container.removeChild(curWin);
					}
				}else{
					container.removeChild(curWin);
				}
				
				for(var i:uint = 0; i < windowsStack.length; i++){
					if(windowsStack[i] == currentWindow){
						windowsStack.splice(i, 1);
					}
				}
				
			//если текущее окно является терминальным, то закрываем все окно и показываем его
			//дальнейшие вызовы показа окон будут игнорироваться
			}else if(checkPolicy(policy, WindowPresencePolicy.TERMINATE)){
				closeAll();
				
				//Хак
				terminate = true;
				
			//добавлет новое окно поверх остальных
			}else if(checkPolicy(policy, WindowPresencePolicy.ADD)){
				if(winSettings.parent)
				{
					if(winSettings.parent.indexOf(currentWindow) == -1){
						return null;
					}
				}
			
			//если текущее открытое окно поддерживает политику очереди
			//и то окно которое хотим открыть тоже поддерживает эту политику,
			//то ставим новое окно в очередь
			}else if(checkPolicy(policy, WindowPresencePolicy.SEQUENCE)){
				if(windowsSettings[currentWindow] && checkPolicy(windowsSettings[currentWindow].policy, WindowPresencePolicy.SEQUENCE)){
					sequenceArray.push(arguments);
					return null;
				}
			}
			
			//создаем и настраиваем экземпляр окна
			var winClass:Class = windowsMap[name];
			var window:AbstractWindow;
			if(winClass){
				
				//проверяем было ли текущее окно закэшировано
				if(windowsCache[name]){
					window = windowsCache[name];
				}else{
					window = new winClass(name);
				}
				
				//если окно модальное, рисуем модальный щит
				if(winSettings.modal){
					container.addChild(modal);
				}
				
				window.data = params;
				container.addChild(window);
				
				window.addEventListener(WindowEvent.WINDOW_CLOSE, onWindowClose);
				
				//кешируем окно, если настройки окна позволяют это сделать
				if(winSettings.cache){
					windowsCache[name] = window;
				}
				
				windowsStack.push(name);
				currentWindow = name;
			}
			
			return window;
		}
		
		public function onWindowClose(evt:WindowEvent):void{
			
			var window:AbstractWindow = evt.target as AbstractWindow;
			window.removeEventListener(WindowEvent.WINDOW_CLOSE, onWindowClose);
			
			if(container.contains(window)){
				container.removeChild(window);
			}
			
			//Некторые окна могут зыкрываться не сразу после вызова метода close(),
			//а после завершения проигрывания определенной анимации.
			//В этом случае уже может быть открыто другое окно, которое является модальным
			if(currentWindow == window.id){
				closeModal();
			}
			
			for(var i:uint = 0; i < windowsStack.length; i++){
				if(windowsStack[i] == window.id){
					windowsStack.splice(i, 1);
				}
			}
			
			currentWindow = windowsStack[windowsStack.length - 1];
			
			//показываем окно из очереди
			if(windowsSettings[window.id] && checkPolicy(windowsSettings[window.id].policy, WindowPresencePolicy.SEQUENCE) && sequenceArray.length){
				showWindow.apply(this, sequenceArray.shift());
			}
		}
		
		public function closeAll():void{
			while(container.numChildren){
				container.removeChildAt(0);
			}
			
			windowsStack = [];
			currentWindow = null;
			
			closeModal();
		}
		
		private function closeModal():void{
			if(modal && container.contains(modal)){
				container.removeChild(modal);
			}
		}
		
		private function checkPolicy(policy:int, val:int):Boolean{
			return Boolean((policy & val) == val);
		}
	}
}