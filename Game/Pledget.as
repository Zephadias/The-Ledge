package Game
{
	
	import flash.display.*;
	import Engine.*;
	
	public class Pledget extends Prop
	{
		private var amount:uint;
		
		public function Pledget() 
		{
			
			amount = 50;
		}
		
		public override function checkCollisions(pPlayer:Player):Boolean
		{
			if (this.hitTestObject(pPlayer) )
			{
				if (pPlayer.health + this.amount >= pPlayer.HEALTH_CONST)
				{
						pPlayer.health = pPlayer.HEALTH_CONST;
				}
				else
				{
					super.errorDisplay('players health = ' + pPlayer.health);
					pPlayer.health += this.amount;
					super.errorDisplay('player picked up pledget.  Health is now: ' + pPlayer.health);
				}
				return true;
			}
			return false;
		}
		
	}
	
}