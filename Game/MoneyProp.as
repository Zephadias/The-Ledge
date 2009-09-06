package Game
{
	
	import flash.display.*;
	import Engine.*;
	
	public class MoneyProp extends Prop
	{
		private var amount:uint;
		
		private var xVelocity:Number;
		private var yVelocity:Number;
		private var yAcceleration:Number;
		
		public var level:Level;
		
		public function MoneyProp() 
		{
				amount = randomMinMax(50, 100);
				yAcceleration = Math.random();
				while (yAcceleration <= .5)
				{
					yAcceleration = Math.random();
				}
				var tempCheck:int = Math.floor(Math.random() * 2);
				xVelocity = Math.random();
				while ( xVelocity <= .5)
				{
					xVelocity = Math.random();
				}
				xVelocity += Math.ceil(Math.random() * 2);
				if (tempCheck == 0)
				{
					xVelocity = -xVelocity;
				}
								
				yVelocity = - (Math.ceil(Math.random())* 5);
				//super.errorDisplay("Amount is: " + amount);
		}
		
		override public function update():void
		{
			var verticalChange:Number = this.yVelocity + yAcceleration;
			
			var newY:Number = this.y + verticalChange;
			
			for ( var i:int = level.ledgeArray.length - 1; i >= 0; i-- )
			{
				if ( this.x + this.width/2 > level.ledgeArray[i].x && this.x - this.width/2 < level.ledgeArray[i].x + level.ledgeArray[i].width)
				{
					if ( this.y <= level.ledgeArray[i].y && newY > level.ledgeArray[i].y )
					{
						newY = level.ledgeArray[i].y;
						this.yVelocity = 0;
						this.xVelocity = 0;
						this.yAcceleration = 0;
					}
				}
			}
			
			this.x += xVelocity;
			//this.y += yVelocity;
			this.y = newY;
			yVelocity += yAcceleration;
		}
		
		public override function checkCollisions(pPlayer:Player):Boolean
		{
			if (this.hitTestObject(pPlayer) )
			{
				if (pPlayer.money + this.amount >= pPlayer.MONEY_CONST)
				{
						pPlayer.money = pPlayer.MONEY_CONST;
						super.errorDisplay('Player money maxed out: ' + pPlayer.money);
				}
				else
				{
					super.errorDisplay('players money = ' + pPlayer.money);
					pPlayer.money += this.amount;
					super.errorDisplay('player picked up Money Prop.  Money is now: ' + pPlayer.money);
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