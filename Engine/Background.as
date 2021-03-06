﻿/**********************************************************
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
	
	public class Background extends MovieClip
	{
		private var _backgroundTitle:String;
		private var scrollLeftSpeed:uint;
		private var scrollRightSpeed:uint;
		private var scrollUpSpeed:uint;
		private var scrollDownSpeed:uint;
		
		private var level:Level;
		
		private var image:Bitmap;
			
		private var rootDisplay:Object;
		
		public function Background()
		{
			
		}
		
		public function setProperties(pRootDisplay:Object, pName:String, pScrollSpeed:uint, pLevel:Level)
		{
				rootDisplay = pRootDisplay;
				level = pLevel;
				_backgroundTitle = pName;
				scrollLeftSpeed = pScrollSpeed;
				scrollRightSpeed = pScrollSpeed;
				scrollDownSpeed = pScrollSpeed;
				scrollUpSpeed = pScrollSpeed;
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
			if (this.x <= -5)
			{
				//errorDisplay(this.x);
				this.x += scrollRightSpeed * pTime;
			}
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