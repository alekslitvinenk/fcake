package ru.alexli.fcake.view.preload
{
	import flash.display.DisplayObject;

	public interface IPreloaderAnimation
	{
		function setProgress(progress:Number):void;
		function get display():DisplayObject;
	}
}