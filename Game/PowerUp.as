package Game
{
	import flash.display.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.*;
	
	public class PowerUp extends MovieClip
	{
		private var _damageValue:uint = 5;
		public var timeLength:uint = 5000;
		
		private var _rootDisplay:Object;
		
		private var startTimer:Timer;

		public function PowerUp() 
		{
			
		}
		
		public function checkCollisions(pPlayer:Player):Boolean 
		{
			if ( this.hitTestObject(pPlayer) )
			{
				if ( pPlayer.damage == 25 )
				{
					errorDisplay("Picking up PowerUp...");
					pPlayer.damage += _damageValue;
					errorDisplay("Player damage: " + pPlayer.damage);
					startTimer = new Timer(timeLength, 1);
					startTimer.addEventListener(TimerEvent.TIMER, addArguments(timer, [pPlayer]));
					startTimer.start();
					return true;
				}
				return false;
			}
			else 
				return false;
		}
		
		private function timer(event:TimerEvent, pPlayer:Player):void
		{
			errorDisplay("PLAYER DAMAGE BACK TO NORMAL");
			pPlayer.damage -= _damageValue;
			errorDisplay("Player damage: " + pPlayer.damage);
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
			_rootDisplay.debugger.appendText(arg + '\n');
			_rootDisplay.debugger.verticalScrollPosition = _rootDisplay.debugger.maxVerticalScrollPosition;
		}
			
		public function set rootDisplay(pRootDisplay:Object):void
		{
			_rootDisplay = pRootDisplay;
		}
		
		public function get damageValue():uint
		{
			return _damageValue;
		}
		
	}
	
}