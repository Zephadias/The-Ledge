package Game  
{
	import Engine.*;
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.*;
	
	public class Dredge extends Weapon
	{
		public var startTimer:Timer;
		private var tempEnemyArray:Array = [];
		private var tempEnemyArrayCounter:Array = [];
		
		public var dredgeCone:DredgeCone;
		public var dredgeActive:Boolean;
		
		private var dredgeCost:uint = 150;
		
		private var dredgeLength:int = 0;
		
		public function Dredge(pRootDisplay:Object, pDamage:uint, pPlayer:Player) 
		{
			super.rootDisplay = pRootDisplay;
			super.damage = pDamage;
			super.player = pPlayer;
			dredgeCone = new DredgeCone();
			dredgeActive = false;
			
		}
		
		public function activate():void
		{
			if (!dredgeActive)
			{
				dredgeLength = Math.floor(super.player.money / dredgeCost);
				
				if (dredgeLength > 0)
				{
					super.player.money = super.player.money - dredgeCost;
					
					rootDisplay.addChild(dredgeCone);
					dredgeCone.x = super.player.x + super.player.width / 2;
					dredgeCone.y = super.player.y - super.player.height - super.player.height / 4;
			
					startTimer = new Timer(1000, dredgeLength );
					
					var tea:Array = new Array();
					var teac:Array = new Array();
					for ( var j:int = super.player.level.enemyManager.enemyArray.length - 1; j >= 0; j-- )
					{
						if ( super.player.level.enemyManager.enemyArray[j].x <= super.player.x + 800 && super.player.level.enemyManager.enemyArray[j].x + 800 >= super.player.x)
						{
							tea.push(super.player.level.enemyManager.enemyArray[j]);
							teac.push(j);
						}
					}
					tempEnemyArray = tea;
					tempEnemyArrayCounter = teac;
					startTimer.addEventListener(TimerEvent.TIMER, rangedAttackTimer);
					startTimer.addEventListener(TimerEvent.TIMER_COMPLETE, rangedAttackTimerComplete);
					dredgeActive = true;
					startTimer.start();
				}
			}
			
		}
		
		private function rangedAttackTimerComplete(event:TimerEvent):void
		{
			startTimer.reset();
			super.rootDisplay.removeChild(dredgeCone);
			dredgeActive = false;
		}
		
		private function rangedAttackTimer(event:TimerEvent):void
		{	
			if (startTimer.currentCount > 1)
			{
				super.player.money = super.player.money - dredgeCost;
			}
				
			super.errorDisplay("Dredge Doing Damage...Money left: " + super.player.money);
			
			for ( var i:int = tempEnemyArray.length - 1; i >= 0; i-- )
			{
				if (dredgeCone.hitTestObject(tempEnemyArray[i]) )
				{
					if (super.player.level.enemyManager.enemyArray[tempEnemyArrayCounter[i]].takeDamage(super.damage))
					{
						var tempTotal = Math.floor(Math.random() * 4);
					
						var moneyProp:MoneyProp;
						for ( var k:uint = 0; k <= tempTotal; k++)
						{
							moneyProp = new MoneyProp();
							moneyProp.level = super.player.level;
							moneyProp.x = super.player.level.enemyManager.enemyArray[tempEnemyArrayCounter[i]].x ;
							moneyProp.y = super.player.level.enemyManager.enemyArray[tempEnemyArrayCounter[i]].y - super.player.level.enemyManager.enemyArray[tempEnemyArrayCounter[i]].height;
							moneyProp.rootDisplay = super.rootDisplay;
							super.rootDisplay.addChild(moneyProp);
							super.player.level.moneyPropArray.push(moneyProp);
						}
						
						super.rootDisplay.removeChild(super.player.level.enemyManager.enemyArray[tempEnemyArrayCounter[i]]);
						super.player.level.enemyManager.enemyArray.splice(tempEnemyArrayCounter[i], 1);
						
					}
					else
					{
						super.errorDisplay('Enemy took damage.  Health is now: ' + super.player.level.enemyManager.enemyArray[tempEnemyArrayCounter[i]].health);
					}
				}
			}
			
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
	
	}
	
	
	
}