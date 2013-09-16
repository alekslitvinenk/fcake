package ru.alexli.fcake.utils.log
{
	public class TraceTarget extends AbstractLogTarget
	{
		public function TraceTarget(level:uint)
		{
			super(level);
		}
		
		override protected function internalSend(val:LogMessageVO):void
		{
			trace(Logger.levelMap[val.level], val.time + "\r", val.message);
		}
	}
}