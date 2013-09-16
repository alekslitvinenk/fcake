package ru.alexli.fcake.utils.log
{

	public class AbstractLogTarget implements IloggerTarget
	{
		
		public var level:uint;
		
		public function AbstractLogTarget(level:uint)
		{
			this.level = level;
		}
		
		public function send(val:LogMessageVO):void
		{
			if(val.level <= level){
				internalSend(val);
			}
		}
		
		protected function internalSend(val:LogMessageVO):void{
			
		}
	}
}