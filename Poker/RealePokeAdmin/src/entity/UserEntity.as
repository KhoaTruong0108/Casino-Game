package entity {
	import com.smartfoxserver.v2.entities.User;
	
	public class UserEntity {

		protected var m_strUserName: String;
		protected var m_strEmail: String;
		protected var m_password: String;
		protected var m_strDisplayName: String;
		protected var m_chip: Number;
		protected var m_tourChip: Number;
		protected var m_buyIn: Number;
		protected var m_GameChip: Number;
		protected var m_ListFriend: Array;
		protected var m_LastJoinedDate: Date;
		protected var m_RegisterDate: Date;
		protected var m_TotalDeposit: Number;
		protected var m_strUserTitle: String;
		protected var m_strUserStatus: String;
		protected var m_TotalPlayedMatch: int;
		protected var m_TotalWinMatch: int;
		protected var m_TotalLostMatch: int;
		protected var m_Location: String;
		
		protected var m_sfsUser: User;
		
		public function UserEntity() {
		}

		public static function FromUser(sfsuser: User): UserEntity {
			//SangDN: Fix error incase don't have the variable name
			//khoatd edited
			
			var userEntity: UserEntity = new UserEntity();
			if(sfsuser.containsVariable("strUserName"))
				userEntity.UserName = sfsuser.getVariable("strUserName").getStringValue();
			if(sfsuser.containsVariable("strEmail"))
				userEntity.Email = sfsuser.getVariable("strEmail").getStringValue();
			if(sfsuser.containsVariable("strDisplayName"))
				userEntity.DisplayName = sfsuser.getVariable("strDisplayName").getStringValue();
			if(sfsuser.containsVariable("chip"))
				userEntity.Chip = sfsuser.getVariable("chip").getDoubleValue();
			if(sfsuser.containsVariable("TourChip"))
				userEntity.TourChip = sfsuser.getVariable("TourChip").getDoubleValue();
			if(sfsuser.containsVariable("BuyIn"))
				userEntity.BuyIn = sfsuser.getVariable("BuyIn").getDoubleValue();
			if(sfsuser.containsVariable("GameChip"))
				userEntity.GameChip = sfsuser.getVariable("GameChip").getDoubleValue();
			if(sfsuser.containsVariable("ListFriend"))
				userEntity.ListFriend = sfsuser.getVariable("ListFriend").getSFSArrayValue() as Array;
			if(sfsuser.containsVariable("LastJoinedDate"))
				userEntity.LastJoinedDate = sfsuser.getVariable("LastJoinedDate").getValue() as Date;
			if(sfsuser.containsVariable("RegisterDate"))
				userEntity.RegisterDate = sfsuser.getVariable("RegisterDate").getValue() as Date;
			if(sfsuser.containsVariable("TotalDeposit"))
				userEntity.TotalDeposit = sfsuser.getVariable("TotalDeposit").getDoubleValue();
			if(sfsuser.containsVariable("strUserTitle"))
				userEntity.UserTitle = sfsuser.getVariable("strUserTitle").getStringValue();
			if(sfsuser.containsVariable("strUserStatus"))
				userEntity.UserStatus = sfsuser.getVariable("strUserStatus").getStringValue();
			if(sfsuser.containsVariable("TotalPlayedMatch"))
				userEntity.TotalPlayedMatch = sfsuser.getVariable("TotalPlayedMatch").getIntValue();
			if(sfsuser.containsVariable("TotalWinMatch"))
				userEntity.TotalWinMatch = sfsuser.getVariable("TotalWinMatch").getIntValue();
			if(sfsuser.containsVariable("TotalLostMatch"))
				userEntity.TotalLostMatch = sfsuser.getVariable("TotalLostMatch").getIntValue();
			if(sfsuser.containsVariable("Location"))
				userEntity.Location = sfsuser.getVariable("Location").getStringValue();
			
			userEntity.UserName = sfsuser.name;
			userEntity.DisplayName = sfsuser.name;
			userEntity.sfsUser = sfsuser;
			
			return userEntity;
		}

		public function get UserName():String
		{
			return m_strUserName;
		}

		public function set UserName(value:String):void
		{
			m_strUserName = value;
		}

		public function get Email():String
		{
			return m_strEmail;
		}

		public function set Email(value:String):void
		{
			m_strEmail = value;
		}

		public function get DisplayName():String
		{
			return m_strDisplayName;
		}

		public function set DisplayName(value:String):void
		{
			m_strDisplayName = value;
		}

		public function get Chip():Number
		{
			return m_chip;
		}

		public function set Chip(value:Number):void
		{
			m_chip = value;
		}

		public function get GameChip():Number
		{
			return m_GameChip;
		}

		public function set GameChip(value:Number):void
		{
			m_GameChip = value;
		}

		public function get ListFriend():Array
		{
			return m_ListFriend;
		}

		public function set ListFriend(value:Array):void
		{
			m_ListFriend = value;
		}

		public function get LastJoinedDate():Date
		{
			return m_LastJoinedDate;
		}

		public function set LastJoinedDate(value:Date):void
		{
			m_LastJoinedDate = value;
		}

		public function get RegisterDate():Date
		{
			return m_RegisterDate;
		}

		public function set RegisterDate(value:Date):void
		{
			m_RegisterDate = value;
		}

		public function get TotalDeposit():Number
		{
			return m_TotalDeposit;
		}

		public function set TotalDeposit(value:Number):void
		{
			m_TotalDeposit = value;
		}

		public function get UserTitle():String
		{
			return m_strUserTitle;
		}

		public function set UserTitle(value:String):void
		{
			m_strUserTitle = value;
		}

		public function get UserStatus():String
		{
			return m_strUserStatus;
		}

		public function set UserStatus(value:String):void
		{
			m_strUserStatus = value;
		}

		public function get TotalPlayedMatch():int
		{
			return m_TotalPlayedMatch;
		}

		public function set TotalPlayedMatch(value:int):void
		{
			m_TotalPlayedMatch = value;
		}

		public function get TotalWinMatch():int
		{
			return m_TotalWinMatch;
		}

		public function set TotalWinMatch(value:int):void
		{
			m_TotalWinMatch = value;
		}

		public function get TotalLostMatch():int
		{
			return m_TotalLostMatch;
		}

		public function set TotalLostMatch(value:int):void
		{
			m_TotalLostMatch = value;
		}

		public function get Location():String
		{
			return m_Location;
		}

		public function set Location(value:String):void
		{
			m_Location = value;
		}

		public function get sfsUser():User
		{
			return m_sfsUser;
		}

		public function set sfsUser(value:User):void
		{
			m_sfsUser = value;
		}

		public function get TourChip():Number
		{
			return m_tourChip;
		}

		public function set TourChip(value:Number):void
		{
			m_tourChip = value;
		}

		public function get BuyIn():Number
		{
			return m_buyIn;
		}

		public function set BuyIn(value:Number):void
		{
			m_buyIn = value;
		}

		public function get Password():String
		{
			return m_password;
		}

		public function set Password(value:String):void
		{
			m_password = value;
		}

		
	} // end class
} // end package