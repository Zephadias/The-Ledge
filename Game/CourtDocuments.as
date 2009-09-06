package Game  
{
	import Engine.*;
	import flash.display.*;
	
	public class CourtDocuments extends Prop
	{
	
		public function CourtDocuments() 
		{
			
		}
		
		public override function checkCollisions(pPlayer:Player):Boolean 
		{
			if ( this.hitTestObject(pPlayer) )
			{
				pPlayer.courtDocuments++;
				super.errorDisplay("Picked up Court Document.  Total is now: " + pPlayer.courtDocuments);
				return true;
			}
			else 
				return false;
		}
	
	}
	
}