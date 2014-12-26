package ru.alexli.fcake.utils.log
{
	import flash.text.TextField;

	public class TextFieldTarget extends AbstractLogTarget implements IloggerTarget
	{
		private var tf:TextField;
		
		public function TextFieldTarget(level:uint, tf:TextField)
		{
			this.tf = tf;
			
			super(level);
		}
		
		override protected function internalSend(val:LogMessageVO):void
		{
			tf.appendText(Logger.levelMap[val.level] + val.time + "\r" + val.message + "\r");
		}
	}
}