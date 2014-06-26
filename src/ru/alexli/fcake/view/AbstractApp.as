package ru.alexli.fcake.view
{
	import flash.events.Event;
	
	import ru.alexli.fcake.command.AbstractCommand;
	import ru.alexli.fcake.command.load.LoadSequenceCommand;
	import ru.alexli.fcake.command.load.LoaderData;
	import ru.alexli.fcake.command.load.LoaderEvent;
	import ru.alexli.fcake.view.preload.AbstractPreloader;
	import ru.alexli.fcake.view.preload.IPreloaderAnimation;

	public class AbstractApp extends AbstractVisualObject
	{
		protected var preloaderAnimation:IPreloaderAnimation;
		
		public function AbstractApp()
		{
			super();
		}
		
		protected var _initSequence:LoadSequenceCommand;

		public function get initSequence():LoadSequenceCommand
		{
			if(!_initSequence)
			{
				_initSequence = new LoadSequenceCommand();
				_initSequence.addEventListener(Event.COMPLETE, onLoadSequenceComplete);
				_initSequence.addEventListener(LoaderEvent.LOADER_PROGRESS, onLoadSequenceProgress);
			}
			
			return _initSequence;
		}

		override protected function onShow():void
		{
			super.onShow();
			
			var preloader:AbstractPreloader = root as AbstractPreloader;
			
			if(preloader)
			{
				preloaderAnimation = preloader.preloaderAnimation;
			}
			
			onAppCreated();
			
			if(_initSequence && !_initSequence.isReqSent)
			{
				initSequence.execute();
			}
		}
		
		/**
		 * Вызывается, когда приложение полностью загружено
		 * Сюда можно добавить комманды предварительной инициализации клиента если понадобится 
		 * 
		 */		
		protected virtual function onAppCreated():void
		{
			
		}
		
		/**
		 * Вызывается когда приложение полностью загружено и были выполнены все комманды предварительной инициализации 
		 * 
		 */		
		protected function onAppInited():void
		{
			
		}
		
		protected function addInitCommand(cmd:AbstractCommand, w:Number):void
		{
			initSequence.addLoader(new LoaderData(cmd, w));
		}
		
		[Deprecated]
		protected function startInitSequence():void
		{
			initSequence.execute();
		}
		
		//events
		private function onLoadSequenceComplete(evt:Event):void
		{
			onAppInited();
		}
		
		private function onLoadSequenceProgress(evt:LoaderEvent):void
		{
			if(preloaderAnimation)
			{
				preloaderAnimation.addProgress(evt.weight);
			}
		}
	}
}