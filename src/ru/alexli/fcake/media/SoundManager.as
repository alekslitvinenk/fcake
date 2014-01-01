package ru.alexli.fcake.media
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.utils.getDefinitionByName;
	
	/**
	 * Менеджер зввуков
	 *  
	 * @author alexander
	 * 
	 */	
	public class SoundManager
	{
		
		private var soundCache:Array = [];
		
		/**
		 * Регистрирует звук в менеджере по id
		 *  
		 * @param id
		 * @param sound
		 * 
		 */		
		public function registerSound(id:String, sound:Class):void{
			
		}
		
		private var _volume:Number = 1;

		public function get volume():Number
		{
			return _volume;
		}

		public function set volume(value:Number):void
		{
			_volume = value;
			
			var sndTfm:SoundTransform = new SoundTransform(value);
			
			for each (var cache:Object in soundCache)
			{
				cache.channel.soundTransform = sndTfm;
			}
		}

		
		/**
		 * Проигрывает нужный звук по заданному id
		 *  
		 * @param id идентификатор звука
		 * @param loop флаг определяющий требуется ли зацикленное воспроизведение звука
		 * 
		 */		
		public function play(id:String, loop:Boolean = false):void
		{
			var snd:Sound;
			
			if(soundCache[id])
			{
				snd = soundCache[id].sound;
			}else
			{
				var sndClass:Class = getDefinitionByName(id) as Class;
				
				if(sndClass)
				{
					snd = new sndClass();
					
					soundCache[id] = {sound: snd};
				}
			}
			
			if(snd)
			{
				soundCache[id].channel = snd.play(0, loop ? int.MAX_VALUE : 0, new SoundTransform(_volume));
			}
		}
	}
}