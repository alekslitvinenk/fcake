package ru.alexli.fcake.model
{
	public class AbstractVO
	{
		
		protected var initObj:Object;
		
		public function AbstractVO(initObj:Object = null)
		{
			this.initObj = initObj;
			init(initObj);
		}
		
		public function init(data:Object):void{
			if(data){
				for (var prop:String in data){
					if(this.hasOwnProperty(prop)){
						this[prop] = data[prop];
					}
				}
			}
		}
	}
}