package entity
{
	public class SitGoInfo
	{
		private var strTourName: String;
		private var nFee: Number;
		private var nNumPlayers: int;
		private var strStatus: String;
		private var nStartChip: Number;
		private var n1stPrize: Number;
		private var n2ndPrize: Number;
		private var n3rdPrize: Number;
		
		public function SitGoInfo()
		{
		}

		public function get TourName():String
		{
			return strTourName;
		}

		public function set TourName(value:String):SitGoInfo
		{
			strTourName = value;
			return this;
		}

		public function get Fee():Number
		{
			return nFee;
		}

		public function set Fee(value:Number):SitGoInfo
		{
			nFee = value;
			return this;
		}

		public function get NumPlayers():int
		{
			return nNumPlayers;
		}

		public function set NumPlayers(value:int):SitGoInfo
		{
			nNumPlayers = value;
			return this;
		}

		public function get Status():String
		{
			return strStatus;
		}

		public function set Status(value:String):SitGoInfo
		{
			strStatus = value;
			return this;
		}

		public function get StartChip():Number
		{
			return nStartChip;
		}

		public function set StartChip(value:Number):SitGoInfo
		{
			nStartChip = value;
			return this;
		}

		public function get FirstPrize():Number
		{
			return n1stPrize;
		}

		public function set FirstPrize(value:Number):SitGoInfo
		{
			n1stPrize = value;
			return this;
		}

		public function get SecondPrize():Number
		{
			return n2ndPrize;
		}

		public function set SecondPrize(value:Number):SitGoInfo
		{
			n2ndPrize = value;
			return this;
		}

		public function get ThirdPrize():Number
		{
			return n3rdPrize;
		}

		public function set ThirdPrize(value:Number):SitGoInfo
		{
			n3rdPrize = value;
			return this;
		}


	}
}