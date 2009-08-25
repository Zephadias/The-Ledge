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
	
	import Game.*;
	
	public class Background extends Sprite
	{
		private var _backgroundTitle:String;
		private var scrollLeftSpeed:uint;
		private var scrollRightSpeed:uint;
		private var scrollUpSpeed:uint;
		private var scrollDownSpeed:uint;
		
		private var levelWidth:uint;
		private var levelHeight:uint;
		
		private var image:Bitmap;
			
		private var rootDisplay:Object;
		
		/**
		 * Background holds the graphic image of one of the 4 background objects that exists.  This background object can be scrolled at variuos speeds.
		 * 
		 * @param   rootMC    		A link to the root display object.   
		 * @param   pName        	The name of the background image.
		 * @param   imageFile    	The locatino of the image file that is being loaded into this background.
		 * @param   pScrollSpeed 	The generic scroll speed of all the scroll directions.
		 * @param   pLevelWidth  	The width of the game in pixels.
		 * @param   pLevelHeight 	The height of the game in pixels.
		 * @return  N/A
		 */
		
		public function Background(rootMC:Object, pName:String, imageFile:String, pScrollSpeed:uint, pLevelWidth:uint, pLevelHeight:uint) 
		{
			rootDisplay = rootMC;
			levelWidth = pLevelWidth;
			levelHeight = pLevelHeight;
			_backgroundTitle = pName;
			scrollLeftSpeed = pScrollSpeed;
			scrollRightSpeed = pScrollSpeed;
			scrollUpSpeed = pScrollSpeed;
			scrollDownSpeed = pScrollSpeed;
			loadImage(imageLoaded, imageFile);
		}
		
		/**
		 * Load the image file into the background object.
		 * 
		 * @param   callFunction The function to call once the image has been loaded into memory.
		 * @param   file         The image file to be loaded.
		 * @return  N/A
		 */
		
		private function loadImage(callFunction:Function, file:String)
		{
			var loader:Loader = new Loader();
			var request:URLRequest;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, callFunction);
			request = new URLRequest(file);
			loader.load(request);
		}
		
		/**
		 * The function that is called once the image has been loaded.
		 * 
		 * @param   event The Event complete listener object. 
		 * @return  N/A
		 */
		
		private function imageLoaded(event:Event):void
		{
			image = Bitmap(event.target.loader.content);
			this.addChild(image);
		}
		
		/**
		 * An update function for the Background object.
		 * \
		 * @param   pTime The amount of time that has passed since the last game loop call.
		 * @return  N/A
		 */
		
		public function update(pTime:Number):void
		{
			
		}
		
		/**
		 * Set the location of the background object.
		 * 
		 * @param   xLoc The X Location
		 * @param   yLoc The Y Location
		 * @return  N/A
		 */
		
		public function setLocation(xLoc:int, yLoc:int):void
		{
			this.x = xLoc;
			this.y = yLoc;
		}
		
		/**
		 * Scroll the background object to the left by the speed amount of the amount of lag from last time the function was called.
		 * 
		 * @param   pTime  The calculated lag time.
		 * @return  N/A
		 */
		
		public function scrollLeft(pTime:Number):void
		{
			this.x -= scrollLeftSpeed*pTime;
		}
		
		/**
		 * Scroll the background object to the right by the speed amount of the amount of lag from last time the function was called.
		 * 
		 * @param   pTime  The calculated lag time.
		 * @return  N/A
		 */
		 
		public function scrollRight(pTime:Number):void
		{
			this.x += scrollRightSpeed*pTime;
		}
		
		/**
		 * Scroll the background object down by the speed amount of the amount of lag from last time the function was called.
		 * 
		 * @param   pTime  The calculated lag time.
		 * @return  N/A
		 */
		 
		public function scrollDown(pTime:Number):void
		{
			
		}
		
		/**
		 * Scroll the background object up by the speed amount of the amount of lag from last time the function was called.
		 * 
		 * @param   pTime  The calculated lag time.
		 * @return  N/A
		 */
		public function scrollUp(pTime:Number):void
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
		
		/**
		 * Get the name of the background object.
		 * 
		 * @return  Returns the background's name.
		 */
		
		public function get backgroundTitle():String
		{
			return _backgroundTitle;
		}
			
	}
	
}