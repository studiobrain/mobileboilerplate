package 
{
	import root.events.*;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	
	import utils.ProgressBar;
	
	public class AssetLoader extends Sprite
	{
		private var _background:Image; 
		private var _assets:AssetManager; 
		
		public function AssetLoader()
		{
			super();
		}
		
		public function start(assets:AssetManager, background:Image = null):void
		{
			trace("AssetLoader start()")
			
			var progressBar:ProgressBar = new ProgressBar(MobileBoilerPlate.stageWidth * 0.5, MobileBoilerPlate.stageHeight * 0.05);
			progressBar.x = (MobileBoilerPlate.stageWidth * 0.5) - (progressBar.width * 0.5);
			progressBar.y = (MobileBoilerPlate.stageHeight * 0.75) - (progressBar.height * 0.5);
			
			_assets = assets;
			
			if (background) 
			{
				_background = background;
				addChild(_background);
			}
			
			addChild(progressBar);
			
			assets.loadQueue(function onProgress(ratio:Number):void
			{
				progressBar.ratio = ratio;
				
				trace("AssetLoader ratio: " + progressBar.ratio);
				
				if (ratio == 1)
				{
					Starling.juggler.delayCall(function():void
					{
						progressBar.removeFromParent(true);
						
					}, 0.15);
					
					ED.dispatchEventWith(ES.DATA_ASSETS_LOADED);
				}
			});
		}
	}
}

