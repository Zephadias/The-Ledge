package Game  
{
	import Engine.*;
	
	public class SledgeHammer extends Weapon
	{
		
		public function SledgeHammer(pRootDisplay:Object, pDamage:uint, pPlayer:Player) 
		{
			super.rootDisplay = pRootDisplay;
			super.damage = pDamage;
			super.player = pPlayer;
		}
		
	}
	
}