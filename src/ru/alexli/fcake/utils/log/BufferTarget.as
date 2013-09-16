package ru.alexli.fcake.utils.log
{

	public class BufferTarget extends AbstractLogTarget implements IloggerTarget
	{
		
		private var _output:String = "";

		public function get output():String
		{
			var res:String = _output;
			_output = "";
			return res;
		}

		
		public function BufferTarget(level:uint)
		{
			super(level);
		}
		
		override protected function internalSend(val:LogMessageVO):void{
			_output += Logger.levelMap[val.level] + val.time + "\r" + val.message;
		}
	}
}