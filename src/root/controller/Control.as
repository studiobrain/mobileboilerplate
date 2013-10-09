package root.controller
{
	import root.events.*;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Control extends Sprite
	{
		public function Control()
		{
			trace("Control Added");
			
			ED.addEventListener(ES.DATA_ASSETS_LOADED, assetsLoaded);
		}
		
		private function assetsLoaded(event:Event):void
		{
			trace("Control assetsLoaded()");
		}
	}
}