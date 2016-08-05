package entity
{
	public class HoldEmInfo
	{
		private var strTableName : String;
		private var strStatus: String;
		private var nSmallBlind : Number;
		private var nBigBlind : Number;
		private var nNumPlayers: int;
		private var nMinBlind: Number;
		private var nMaxBlind: Number;
		
		public function HoldEmInfo()
		{
		}
		
		
		public function get TableName():String
		{
			return strTableName;
		}

		public function set TableName(value:String):HoldEmInfo
		{
			strTableName = value;
			return this;
		}

		public function get SmallBlind():Number
		{
			return nSmallBlind;
		}

		public function set SmallBlind(value:Number):HoldEmInfo
		{
			nSmallBlind = value;
			return this;
		}

		public function get BigBlind():Number
		{
			return nBigBlind;
		}

		public function set BigBlind(value:Number):HoldEmInfo
		{
			nBigBlind = value;
			return this;
		}

		public function get NumPlayers():int
		{
			return nNumPlayers;
		}

		public function set NumPlayers(value:int):HoldEmInfo
		{
			nNumPlayers = value;
			return this;
		}

		public function get MinBlind():Number
		{
			return nMinBlind;
		}

		public function set MinBlind(value:Number):HoldEmInfo
		{
			nMinBlind = value;
			return this;
		}

		public function get MaxBlind():Number
		{
			return nMaxBlind;
		}

		public function set MaxBlind(value:Number):HoldEmInfo
		{
			nMaxBlind = value;
			return this;
		}


	}
}