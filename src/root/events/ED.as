package root.events
{
	import starling.events.EventDispatcher;
	
	public class ED
	{
		private static var _ed:EventDispatcher = new EventDispatcher();
		
		public static function addEventListener(type:String, listener:Function):void
		{
			_ed.addEventListener(type, listener);
		}
		
		public static function removeEventListener(type:String, listener:Function):void
		{
			_ed.removeEventListener(type, listener);
		}
		
		public static function dispatchEventWith(type:String, bubbles:Boolean = false, data:Object = null):void
		{
			_ed.dispatchEventWith(type, bubbles, data);
		}
	}
}

