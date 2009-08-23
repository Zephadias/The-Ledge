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
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	
	public class Ledge extends MovieClip
	{
		public var isVisible:Boolean;
		private var gameLevel:Level;
		private var rootDisplay:Object;
		private var _ledgeType:String;
		private var _ID:int;
		
		private var _bottomY:Number;
		private var _topY:Number;
		private var _leftX:Number;
		private var _rightX:Number;
		
		public function Ledge(rootMC:Object ,pLevel:Level, vis:Boolean) 
		{ 
			rootDisplay = rootMC;
			gameLevel = pLevel;
			isVisible = vis;
			
			_bottomY = this.height;
			_topY = 0;
			_leftX = 0;
			_rightX = this.width;
		}
		
		public function spawn(xLoc:int, yLoc:int):Void
		{
			this.x = xLoc;
			this.y = yLoc;
		}
		
		public function fadeIn(pStartTime:Number, pEndTime:Number):Void
		{
			
		}
		
		public function setLocation(xLoc:int, yLoc:int):Void
		{
			this.x = xLoc;
			this.y = yLoc;
		}
		
		/**
		* Get a random number from between two different numbers
		* @param min The low number of the random number
		* @param max The max number of the random number
		* @return Returns a random number between a min and max
		*/
		public function randomMinMax( min:Number, max:Number ):Number 
		{      
			return min + (max - min) * Math.random(); 
		}
		
		public function fadeIn(item:MovieClip, time:Number, fadeOut:Boolean):void
        {
            item.alpha = 0;
        	var timer:Timer = new Timer(100, time*10);
			timer.addEventListener(TimerEvent.TIMER, addArguments(fadeInTimer, [item, time]));
			if(fadeOut)
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, addArguments(fadeInComplete_startFadeOut, [item, time]));
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, addArguments(fadeInComplete, [item,timer])); 
           	timer.start();
			
        }
		
		private function fadeInTimer(event:TimerEvent, item:MovieClip, time:Number):void
		{
			item.alpha += ((10/time)*.01);
		}
		
		private function fadeInComplete(event:TimerEvent, item:MovieClip, timer:Timer):void
		{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, addArguments(fadeInComplete, [timer]));
			timer.removeEventListener(TimerEvent.TIMER, addArguments(fadeInTimer, [item, timer]));
		}
		
		private function fadeInComplete_startFadeOut(event:TimerEvent, item:MovieClip, time:Number):void
		{
			fadeOut(item, time, false);
		}
		
		public function fadeOut(item:MovieClip, time:Number, fadeIn:Boolean):void
        {
            item.alpha = 1;
			var timer:Timer = new Timer(100, time*10);
			timer.addEventListener(TimerEvent.TIMER, addArguments(fadeOutTimer, [item, time]));
			if(fadeIn)
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, addArguments(fadeOutComplete_startFadeIn, [item, timer]));
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, addArguments(fadeOutComplete, [item, timer]));
			timer.start();
          
        }
		
		private function fadeOutTimer(event:TimerEvent, item:MovieClip, time:Number):void
		{
			
			item.alpha -= ((10/time)*.01);
		}
		
		private function fadeOutComplete(event:TimerEvent, item:MovieClip, timer:Timer):void
		{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, addArguments(fadeOutComplete, [timer]));
			timer.removeEventListener(TimerEvent.TIMER, addArguments(fadeOutTimer, [item, timer]));
		}
		
		private function fadeOutComplete_startFadeIn(event:TimerEvent, item:MovieClip, time:Number):void
		{
			fadeIn(item, time, false);
		}
		
		
		/**
		* Pass arguments through to a function
		* @param method The function that you are passing arguments to
		* @param additionalArguments Arguments you want to pass
		*/
		function addArguments(method:Function, additionalArguments:Array):Function 
		{
			return function(event:Event):void 
			{
				method.apply(null, [event].concat(additionalArguments));
			}
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
		* Print All the Ledge info to the debugging console
		*/
		public function printInfo():void
		{
			errorDisplay("--------------------------------");
			errorDisplay("Ledge Information");
			errorDisplay("Ledge Type: " + ledgeType);
			errorDisplay("ID: " + ID);
			errorDisplay("Is Visible: " + isVisible);
			errorDisplay("X Location: " + this.x);
			errorDisplay("Y Location: " + this.y);
			errorDisplay("--------------------------------");
		}
		
		public function get ledgeType():String
		{
			return _ledgeType;
		}
		
		public function set ledgeType(pLedgeType:String):Void
		{
			_ledgeType = pLedgeType;
		}
		
		public function get ID():int
		{
			return _ID;
		}
		
		public function get bottomY():Number
		{
			return _bottomY;
		}
		
		public function get topY():Number
		{
			return _topY;
		}
		
		public function get leftX():Number
		{
			return _leftX;
		}
		
		public function get rightX():Number
		{
			return _rightX;
		}
	}
	
}