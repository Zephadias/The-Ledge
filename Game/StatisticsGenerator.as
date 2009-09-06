package Game
{
	
	public class StatisticsGenerator 
	{
		public var moneyCollected:uint;
		public var moneySaved:uint;
		public var pledgetsRemain:uint;
		public var courtDocumentsCollected:uint;
		public var compensationLawyersDefeated:uint;
		public var internationalSoftwareLawyersDefeated:uint;
		public var patentLawyersDefeated:uint;
		public var facelessDefeated:uint;
		public var TLDefeated:uint;
		
		public var moneyCollected_score:uint;
		public var moneySaved_score:uint;
		public var pledgetsRemain_score:uint;
		public var courtDocumentsCollected_score:uint;
		public var compensationLawyersDefeated_score:uint;
		public var internationalSoftwareLawyersDefeated_score:uint;
		public var patentLawyersDefeated_score:uint;
		public var facelessDefeated_score:uint;
		public var TLDefeated_score:uint;
		
		private const MONEY_COLLECTED_WORTH:uint = 10;
		private const MONEY_SAVED_WORTH:uint = 20;
		private const PLEDGETS_REMAIN_WORTH:uint = 25;
		private const COURTDOCUMENTS_WORTH:uint = 1000;
		private const COMPENSATION_WORTH:uint = 10;
		private const INTERNATION_WORTH:uint = 20;
		private const PATENT_WORTH:uint = 30;
		private const FACELESS_WORTH:uint = 2000;
		private const TL_WORTH:uint = 5000;
		
		public var totalScore:uint;
		
		public function StatisticsGenerator() 
		{
				
		}
	
		public function calculateScore():uint
		{
			moneyCollected_score = moneyCollected * MONEY_COLLECTED_WORTH;
			moneySaved_score = moneySaved * MONEY_SAVED_WORTH;
			pledgetsRemain_score = pledgetsRemain * PLEDGETS_REMAIN_WORTH;
			courtDocumentsCollected_score = courtDocumentsCollected * COURTDOCUMENTS_WORTH;
			compensationLawyersDefeated_score = compensationLawyersDefeated * COMPENSATION_WORTH;
			internationalSoftwareLawyersDefeated_score = internationalSoftwareLawyersDefeated * INTERNATION_WORTH;
			patentLawyersDefeated_score = patentLawyersDefeated * PATENT_WORTH;
			facelessDefeated_score = facelessDefeated * FACELESS_WORTH;
			TLDefeated_score = TLDefeated * TL_WORTH;
			totalScore = 	moneyCollected_score + 
							moneySaved_score + 
							pledgetsRemain_score + 
							courtDocumentsCollected_score +
							compensationLawyersDefeated_score +
							internationalSoftwareLawyersDefeated_score +
							patentLawyersDefeated_score + 
							facelessDefeated_score +
							TLDefeated_score;
			return totalScore;
		}
		
	}
	
}