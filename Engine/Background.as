/**********************************************************
/*
/*		Copyright: 2009 - Baygull Studios
/*		All Rights Reserved (R)
/*		
/*    	@Lead Programmer: Ryan Ploetz
/*
/*		@game: The Ledge
/*
/**********************************************************/

package Engine 
{
	import flash.display.*;
	
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	
	public class Background extends Sprite
	{
		private var _backgroundTitle:String;
		private var scrollLeftSpeed:uint;
		private var scrollRightSpeed:uint;
		private var scrollUpSpeed:uint;
		private var scrollDownSpeed:uint;
		
		private var image:Bitmap;
			
		private var rootDisplay:Object;
		
		public function Background(rootMC:Object, pName:String, imageFile:String, pScrollSpeed:uint) 
		{
			rootDisplay = rootMC;
			_backgroundTitle = pName;
			scrollLeftSpeed = pScrollSpeed;
			scrollRightSpeed = pScrollSpeed;
			scrollUpSpeed = pScrollSpeed;
			scrollDownSpeed = pScrollSpeed;
			loadImage(imageLoaded, imageFile);
		}
		
		private function loadImage(callFunction:Function, file:String)
		{
			var loader:Loader = new Loader();
			var request:URLRequest;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, callFunction);
			request = new URLRequest(file);
			loader.load(request);
		}
		
		private function imageLoaded(event:Event):void
		{
			image = Bitmap(event.target.loader.content);
			this.addChild(image);
		}
		
		public function update():void
		{
			
		}
		
		public function setLocation(xLoc:int, yLoc:int):void
		{
			this.x = xLoc;
			this.y = yLoc;
		}
		
		public function scrollLeft():void
		{
			
		}
		
		public function scrollRight():void
		{
			
		}
		
		public function scrollDown():void
		{
			
		}
		
		public function scrollUp():void
		{
			
		}
		
		/**
		* Output text to the debugging console
		* @param arg The output to the debugger 
		*/
		private function errorDisplay(arg:*):void
		{
			rootDisplay.debugger.appendText(arg + '\n');
			rootDisplay.debugger.verticalScrollPosition = rootDisplay.debugger.maxVerticalScrollPosition;
		}
		
		/**
		* Print All the Background info to the debugging console
		*/
		public function printInfo():void
		{
			errorDisplay("--------------------------------");
			errorDisplay("Background Information");
			errorDisplay("Title: " + backgroundTitle);
			errorDisplay("Scroll Left Speed: " + scrollLeftSpeed);
			errorDisplay("Scroll Right Speed: " + scrollRightSpeed);
			errorDisplay("Scroll Down Speed: " + scrollDownSpeed);
			errorDisplay("Scroll Up Speed: " + scrollUpSpeed);
			errorDisplay("X Location: " + this.x);
			errorDisplay("Y Location: " + this.y);
			errorDisplay("--------------------------------");
		}
				
		public function get backgroundTitle():String
		{
			return _backgroundTitle;
		}
			
	}
	
}