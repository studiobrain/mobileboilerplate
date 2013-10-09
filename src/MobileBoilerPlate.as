package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import root.controller.Control;
	import root.events.ES;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	import starling.utils.formatString;
	
	[SWF(frameRate="60", backgroundColor="#000000")]
	
	/**
	 * 
	 * rename project and this file to the name of App/Game
	 * 
	*/
	
	public class MobileBoilerPlate extends Sprite
	{
		/**
		 *	
		 * setup all possible bg images here and instantiate them within getScaleFactor();
		 * ex: [Embed(source="/textures/3x/xhdpi_bg.png")]
		 * 
		 */
		
		//[Embed(source="/textures/3x/xhdpi__bg.png")]
		
		public static var XHDPI:Class;
		
		public static var stageWidth:int  = 240;
		public static var stageHeight:int = 426;
		public static var star:Starling;
		
		public static var scaleFactor:int;
		public static var stageRef:Stage;
		public static var viewPort:Rectangle;
		public static var prefix:String;
		
		private var _stageWidth:int;
		private var _stageHeight:int;
		private var _background:Bitmap;
		private var _assets:AssetManager;
		private var _appDir:File;
		
		public function MobileBoilerPlate()
		{
			var iOS:Boolean 	 		= Capabilities.manufacturer.indexOf("iOS") != -1;
			var AND:Boolean 	 		= Capabilities.manufacturer.indexOf("Android") != -1;
			
			MobileBoilerPlate.stageRef 				= stage;
			MobileBoilerPlate.stageRef.align 		= StageAlign.TOP_LEFT;
			MobileBoilerPlate.stageRef.scaleMode 	= StageScaleMode.NO_SCALE;
			
			//Starling.multitouchEnabled 	= false;
			Starling.handleLostContext 	= true;
			Starling.handleLostContext 	= !iOS;
			
			switch (true)
			{
				case iOS: getScaleFactor("iOS"); break;
				case AND: getScaleFactor("Android"); break;
				default:  getScaleFactor("default"); break;
			}
			 
			MobileBoilerPlate.viewPort = RectangleUtil.fit(
				new Rectangle(0, 0, _stageWidth, _stageHeight), 
				new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight), 
				ScaleMode.NO_BORDER);
			
			_appDir		= File.applicationDirectory;
			_assets 	= new AssetManager(MobileBoilerPlate.scaleFactor);
			
			_assets.enqueue(
				_appDir.resolvePath("audio"),
				_appDir.resolvePath(formatString("fonts/{0}x", MobileBoilerPlate.scaleFactor)),
				_appDir.resolvePath(formatString("textures/{0}x", MobileBoilerPlate.scaleFactor))
			);
			
			if (_background)
			{
				_background.width  		= MobileBoilerPlate.stageWidth;
				_background.height 		= MobileBoilerPlate.stageHeight;
				_background.smoothing 	= true;
				
				addChild(_background);
			}
			
			trace("**********************************************************");
			trace("Main 				version 0.01");
			trace("viewPort:			" + MobileBoilerPlate.viewPort);
			trace("Main.stageWidth:		" + MobileBoilerPlate.stageWidth);
			trace("Main.stageHeight:		" + MobileBoilerPlate.stageHeight);
			trace("scaleFactor: 			" + MobileBoilerPlate.scaleFactor);
			trace("Capabilities.screenDPI: 	" + Capabilities.screenDPI);
			trace("Capabilities.os: 		"	+ Capabilities.os);
			trace("Capabilities.screenResolutionX: " + Capabilities.screenResolutionX);
			trace("Capabilities.screenResolutionY: " + Capabilities.screenResolutionY);
			trace("**********************************************************");
			
			MobileBoilerPlate.star 						= new Starling(AssetLoader, stage, MobileBoilerPlate.viewPort);
			MobileBoilerPlate.star.stage.stageWidth  	= _stageWidth;
			MobileBoilerPlate.star.stage.stageHeight 	= _stageHeight;
			MobileBoilerPlate.star.simulateMultitouch  	= false;
			MobileBoilerPlate.star.enableErrorChecking 	= Capabilities.isDebugger;
			MobileBoilerPlate.star.addEventListener(starling.events.Event.ROOT_CREATED, rootCreated); 
		}
		
		private function getScaleFactor(OS:String):int
		{
			switch (OS) 
			{
				case "iOS":
					trace("iOS");
					break;
				case "Android":
					trace("Android");
					if (Capabilities.screenDPI <= 160)  
					{
						MobileBoilerPlate.scaleFactor = 1; 
						// scaled 1
					}
					if (Capabilities.screenDPI > 160 && 
						Capabilities.screenDPI <= 240)  
					{
						MobileBoilerPlate.scaleFactor = 2; 
						// scaled 1.5 
					}
					if (Capabilities.screenDPI > 240)  
					{
						MobileBoilerPlate.scaleFactor = 3; 
						//_background = new XHDPI(); 
						//Main.prefix = "xhdpi_";
					}
					break;
				default:
					trace("default");
					if (Capabilities.screenDPI <= 160)  
					{
						MobileBoilerPlate.scaleFactor = 1; // scaled 1
					}
					if (Capabilities.screenDPI > 160 && 
						Capabilities.screenDPI <= 240)  
					{
						MobileBoilerPlate.scaleFactor = 2; // scaled 1.5 
					}
					if (Capabilities.screenDPI > 240)  
					{
						MobileBoilerPlate.scaleFactor = 3; // scaled 2
					}
					break;
			}
			
			_stageWidth   		= stage.fullScreenWidth;
			_stageHeight  		= stage.fullScreenHeight;
			
			MobileBoilerPlate.stageWidth 	= _stageWidth;
			MobileBoilerPlate.stageHeight 	= _stageHeight;
			
			return MobileBoilerPlate.scaleFactor;
		}
		
		private function rootCreated(event:Object, app:AssetLoader):void
		{
			trace("Main rootCreated(): " + app);
			
			var eventStack:ES 	 = new ES();
			var control:Control  = new Control();
			
			
			MobileBoilerPlate.star.removeEventListener(starling.events.Event.ROOT_CREATED, rootCreated);
			
			//removeChild(_background);
			
			//var bgTexture:Texture = Texture.fromBitmap(_background, false, false, Main.scaleFactor);
			//var backGroundImage:Image = new Image(bgTexture);
			
			//backGroundImage.alignPivot();
			//backGroundImage.x 		= (-Main.stageWidth * 0.05);
			//backGroundImage.width 	= Main.stageWidth * 2;
			//backGroundImage.height 	= Main.stageHeight * 1.05;
			
			app.start(_assets/*, backGroundImage*/);
			MobileBoilerPlate.star.start();
			
			Starling.current.showStats = true;
			Starling.current.showStatsAt("left", "top");
		}
	}
}