package entity {
	import com.smartfoxserver.v2.entities.User;
	
	public class RoomEntity {

		protected var m_name: String;
		protected var m_DisplayName: String;
		protected var m_password: String;
		protected var m_maxUser: int;
		protected var m_betChip: Number;
		protected var m_smallBlind: Number;
		protected var m_bigBlind: Number;
		protected var m_maxBuyin: Number;
		protected var m_minBuyin: Number;
		protected var m_noLimit: Boolean;
		protected var m_status: String;
		protected var m_createBy: String;
		
		protected var m_sfsUser: User;
		
		public function RoomEntity() {
		}

		/*public static function FromUser(sfsuser: User): UserEntity {
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
		}*/

		public function get Name():String
		{
			return m_name;
		}

		public function set Name(value:String):void
		{
			m_name = value;
		}

		public function get DisplayName():String
		{
			return m_DisplayName;
		}

		public function set DisplayName(value:String):void
		{
			m_DisplayName = value;
		}

		public function get Password():String
		{
			return m_password;
		}

		public function set Password(value:String):void
		{
			m_password = value;
		}

		public function get maxUser():int
		{
			return m_maxUser;
		}

		public function set maxUser(value:int):void
		{
			m_maxUser = value;
		}

		public function get betChip():Number
		{
			return m_betChip;
		}

		public function set betChip(value:Number):void
		{
			m_betChip = value;
		}

		public function get smallBlind():Number
		{
			return m_smallBlind;
		}

		public function set smallBlind(value:Number):void
		{
			m_smallBlind = value;
		}

		public function get bigBlind():Number
		{
			return m_bigBlind;
		}

		public function set bigBlind(value:Number):void
		{
			m_bigBlind = value;
		}

		public function get maxBuyin():Number
		{
			return m_maxBuyin;
		}

		public function set maxBuyin(value:Number):void
		{
			m_maxBuyin = value;
		}

		public function get minBuyin():Number
		{
			return m_minBuyin;
		}

		public function set minBuyin(value:Number):void
		{
			m_minBuyin = value;
		}

		public function get status():String
		{
			return m_status;
		}

		public function set status(value:String):void
		{
			m_status = value;
		}

		public function get createBy():String
		{
			return m_createBy;
		}

		public function set createBy(value:String):void
		{
			m_createBy = value;
		}

		public function get noLimit():Boolean
		{
			return m_noLimit;
		}

		public function set noLimit(value:Boolean):void
		{
			m_noLimit = value;
		}


	} // end class
} // end package