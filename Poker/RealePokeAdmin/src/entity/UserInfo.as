package entity
{
	

	public class UserInfo
	{
		protected var strUserName: String;
		protected var strEmail: String;
		protected var strDisplayName: String;
		protected var chip: Number;		
		protected var lastJoinedDate: Date;
		protected var registerDate: Date;
		protected var totalDeposit: Number;		
		protected var totalPlayedMatch: int;
		protected var totalWinMatch: int;
		protected var totalLostMatch: int;
		protected var location: String;		
		public function UserInfo() {
			
		}
		
		

		public function get UserName():String
		{
			return strUserName;
		}

		public function set UserName(value:String):UserInfo
		{
			strUserName = value;
			return this;
		}

		public function get Email():String
		{
			return strEmail;
		}

		public function set Email(value:String):UserInfo
		{
			strEmail = value;
			return this;
		}

		public function get DisplayName():String
		{
			return strDisplayName;
		}

		public function set DisplayName(value:String):UserInfo
		{
			strDisplayName = value;
			return this;
		}

		public function get Chip():Number
		{
			return chip;
		}

		public function set Chip(value:Number):UserInfo
		{
			chip = value;
			return this;
		}

		public function get LastJoinedDate():Date
		{
			return lastJoinedDate;
		}

		public function set LastJoinedDate(value:Date):UserInfo
		{
			lastJoinedDate = value;
			return this;
		}

		public function get RegisterDate():Date
		{
			return registerDate;
		}

		public function set RegisterDate(value:Date):UserInfo
		{
			registerDate = value;
			return this;
		}

		public function get TotalDeposit():Number
		{
			return totalDeposit;
		}

		public function set TotalDeposit(value:Number):UserInfo
		{
			totalDeposit = value;
			return this;
		}

		public function get TotalPlayedMatch():int
		{
			return totalPlayedMatch;
		}

		public function set TotalPlayedMatch(value:int):UserInfo
		{
			totalPlayedMatch = value;
			return this;
		}

		public function get TotalWinMatch():int
		{
			return totalWinMatch;
		}

		public function set TotalWinMatch(value:int):UserInfo
		{
			totalWinMatch = value;
			return this;
		}

		public function get TotalLostMatch():int
		{
			return totalLostMatch;
		}

		public function set TotalLostMatch(value:int):UserInfo
		{
			totalLostMatch = value;
			return this;
		}

		public function get Location():String
		{
			return location;
		}

		public function set Location(value:String):UserInfo
		{
			location = value;
			return this;
		}


	}
}