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
	import Game.*;
	
	public class EnemyManager
	{
		private var level:Level;
		private var rootDisplay:Object;
		public var enemyArray:Array;
		
		public function EnemyManager(pLevel:Level) {
			level = pLevel;
			rootDisplay = level.rootDisplay;
			enemyArray = [];
		}
		
		public function getAllEnemies():void {
			// Loop through root display.
			for ( var i:int = rootDisplay.numChildren - 1; i >= 0; i-- )		
			{
				var tempItem = rootDisplay.getChildAt(i).valueOf();				
				if ( tempItem is Enemy )
				{
					enemyArray.push(rootDisplay.getChildAt(i));
					enemyArray[enemyArray.length - 1].rootDisplay = rootDisplay;
				}
			}
		}
		/**
		 * @param	pTime Length of time since last update.
		 */
		public function runAI (pTime:Number):void {
			for each (var enemy:Enemy in enemyArray) {
				enemy.runAI(pTime);
			}
		}
	}
}