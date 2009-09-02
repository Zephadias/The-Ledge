package Game
{
	
	import flash.display.*;
	import Engine.*;
	
	public class MoneyBag extends Prop
	{
		private var amount:uint;
		
		public function MoneyBag() 
		{
				amount = randomMinMax(50, 250);
				//super.errorDisplay("Amount is: " + amount);
		}
		
		public override function checkCollisions(pPlayer:Player):Boolean
		{
			if (this.hitTestObject(pPlayer) )
			{
				if (pPlayer.money + this.amount >= pPlayer.MONEY_CONST)
				{
						pPlayer.money = pPlayer.MONEY_CONST;
				}
				else
				{
					super.errorDisplay('players money = ' + pPlayer.money);
					pPlayer.money += this.amount;
					super.errorDisplay('player picked up MoneyBag.  Money is now: ' + pPlayer.money);
				}
				return true;
			}
			return false;
		}
		
		public function randomMinMax( min:Number, max:Number ):Number 
		{      
			return Math.floor(min + (max - min) * Math.random()); 
		}
		
	}
	
}