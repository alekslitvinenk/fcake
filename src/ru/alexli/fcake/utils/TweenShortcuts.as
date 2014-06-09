package ru.alexli.fcake.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.ColorShortcuts;
	import caurina.transitions.properties.CurveModifiers;

	public class TweenShortcuts
	{
		public static function initColors():void
		{
			ColorShortcuts.init();
		}
		
		public static function initCurves():void
		{
			CurveModifiers.init();
		}
		
		/**
		 * Анимация покачивания машинки, когда в нее падают монетки или сажают демонстранта 
		 * 
		 */		
		public static function jiggle(obj:DisplayObject, onEndAnimation:Function = null, args:Array = null, min:Number = -7, max:Number = 7, time:Number = 0.1, normalize:Boolean = true):void
		{
			Tweener.removeTweens(obj);
			
			if(normalize)
			{
				Tweener.addTween(obj, {rotation: min, time: time, transition: "linear"});
				Tweener.addTween(obj, {rotation: max, time: time, delay: time, transition: "linear"});
				Tweener.addTween(obj, {rotation: 0, time: time, delay: 2 * time, transition: "linear", onComplete: onEndAnimation, onCompleteParams: args});
			}else
			{
				Tweener.addTween(obj, {rotation: min, time: time, transition: "linear"});
				Tweener.addTween(obj, {rotation: max, time: time, delay: time, transition: "linear", onComplete: onEndAnimation, onCompleteParams: args});
			}
		}
		
		/**
		 * Анимация приближения/отдаления машины
		 *  
		 * @param onEndAnimation
		 * 
		 */		
		public static function zoomInOut(obj:DisplayObject, scale:Number = 1.1, time:Number = 0.1, onEndAnimation:Function = null, args:Array = null):void
		{
			Tweener.removeTweens(obj);
			
			//normalizePosition();
			var delay:Number = 0.1;
			
			Tweener.addTween(obj, {scaleX: scale, scaleY:scale, time: time, delay: delay, transition: "easeOutQuart"});
			Tweener.addTween(obj, {scaleX: 1, scaleY: 1, time: time, delay: time + delay, transition: "easeOutQuart", onComplete: onEndAnimation, onCompleteParams: args});
		}
		
		/**
		 * Анимация подпрыгивания машины при отправке машины в лагерь 
		 * @param onEndAnimation функция которая должна выполниться после завершения анимации
		 * 
		 */			
		public static function jump(obj:DisplayObject, onEndAnimation:Function = null, args:Array = null):void
		{
			Tweener.removeTweens(obj);
			
			//normalizePosition();
			
			var startPos:Number = obj.y;
			var endPos:Number = obj.y - 25;
			
			Tweener.addTween(obj, {y: endPos, time: 0.1, transition: "easeOutQuart"});
			Tweener.addTween(obj, {y: startPos, time: 0.1, delay: 0.1, transition: "easeInQuart", onComplete: onEndAnimation, onCompleteParams: args});
		}
		
		public static function touchRightBottom(obj:DisplayObject, onEndAnimation:Function = null, args:Array = null):void
		{
			Tweener.removeTweens(obj);
			
			var startXPos:Number = obj.x;
			var endXPos:Number = obj.x + 5;
			
			var startYPos:Number = obj.y;
			var endYPos:Number = obj.y + 5;
			
			Tweener.addTween(obj, {x: endXPos, y: endYPos, time: 0.03, transition: "easeOutQuart"});
			Tweener.addTween(obj, {x:startXPos, y:startYPos, time: 0.03, delay: 0.1, transition: "easeInQuart", onComplete: onEndAnimation, onCompleteParams: args});
		}
		
		public static function upAndDown(obj:DisplayObject, onEndAnimation:Function = null, args:Array = null, startPos:Number = 25, endPos:Number = 0, time:Number = 1):void
		{
			Tweener.addTween(obj, {y: startPos, time: time, transition: "linear"});
			Tweener.addTween(obj, {y: endPos, time: time, delay: time, transition: "linear", onComplete: onEndAnimation, onCompleteParams: args});
		}
		
		public static function blinkWithFade(obj:DisplayObject, onEndAnimation:Function = null, args:Array = null, prop:String = "alpha", startVal:Number = 1, endVal:Number = 0, time:Number = 0.3):void
		{
			var props:Object = {};
			props[prop] = startVal;
			props.time = time;
			props.transition = "easeOutQuart";
			
			var props2:Object = {};
			props2[prop] = endVal;
			props2.time = time;
			props2.delay = time;
			props2.transition = "easeOutQuart";
			props2.onComplete = onEndAnimation;
			props2.onCompleteParams = args;
			
			Tweener.addTween(obj, props);
			Tweener.addTween(obj, props2);
		}
		
		public static function setPos(obj:DisplayObject, pt:Point, onEndAnimation:Function = null, args:Array = null):void
		{
			Tweener.addTween(obj, {x: pt.x, y: pt.y, time: 1, transition: "easeInQuart", onComplete: onEndAnimation, onCompleteParams: args});
		}
		
		public static function makeBesierArray(p:Array):Array
		{
			var bezier:Array = [];
			// convert all points between p[0] and p[last]
			for (var i:int = 1; i < p.length -2; i++)
			{
				var b1:Object = {}, b2:Object = {};
				
				b1.x = -p[i -1].x/6 +p[i].x +p[i +1].x/6;
				b2.x = +p[i].x/6 +p[i +1].x -p[i +2].x/6;
				
				b1.y = -p[i -1].y/6 +p[i].y +p[i +1].y/6;
				b2.y = +p[i].y/6 +p[i +1].y -p[i +2].y/6;
				
				bezier.push(b1); bezier.push(b2);
			}
			return bezier;
		}
		
		private static function removeObj(target:DisplayObject):void
		{
			var parent:DisplayObjectContainer = target.parent;
			
			if(parent){
				parent.removeChild(target);
			}
		}
	}
}