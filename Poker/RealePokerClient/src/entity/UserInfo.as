package entity
{
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	//import mx.controls.List;

	public class UserInfo
	{
		protected var strUserName: String;
		protected var strEmail: String;
		protected var strDisplayName: String;
		protected var chip: Number;
		protected var GameChip: Number;
		protected var ListFriend: Array;
		protected var LastJoinedDate: Date;
		protected var RegisterDate: Date;
		protected var TotalDeposit: Number;
		protected var strUserTitle: String;
		protected var strUserStatus: String;
		protected var TotalPlayedMatch: int;
		protected var TotalWinMatch: int;
		protected var TotalLostMatch: int;
		protected var Location: String;
		
		
		public function UserInfo() {
			
		}
		
		public function FromUser(sfsUser: com.smartfoxserver.v2.entities.User): UserInfo {
			//SangDN: Fix error incase don't have the variable name
			if(sfsUser.containsVariable("strUserName"))
				strUserName = sfsUser.getVariable("strUserName").getStringValue();
			if(sfsUser.containsVariable("strEmail"))
				strEmail = sfsUser.getVariable("strEmail").getStringValue();
			if(sfsUser.containsVariable("strDisplayName"))
				strDisplayName = sfsUser.getVariable("strDisplayName").getStringValue();
			if(sfsUser.containsVariable("chip"))
				chip = sfsUser.getVariable("chip").getDoubleValue();
			if(sfsUser.containsVariable("GameChip"))
				GameChip = sfsUser.getVariable("GameChip").getDoubleValue();
			if(sfsUser.containsVariable("ListFriend"))
				ListFriend = sfsUser.getVariable("ListFriend").getSFSArrayValue() as Array;
			if(sfsUser.containsVariable("LastJoinedDate"))
				LastJoinedDate = sfsUser.getVariable("LastJoinedDate").getValue() as Date;
			if(sfsUser.containsVariable("RegisterDate"))
				RegisterDate = sfsUser.getVariable("RegisterDate").getValue() as Date;
			if(sfsUser.containsVariable("TotalDeposit"))
				TotalDeposit = sfsUser.getVariable("TotalDeposit").getDoubleValue();
			if(sfsUser.containsVariable("strUserTitle"))
				strUserTitle = sfsUser.getVariable("strUserTitle").getStringValue();
			if(sfsUser.containsVariable("strUserStatus"))
				strUserStatus = sfsUser.getVariable("strUserStatus").getStringValue();
			if(sfsUser.containsVariable("TotalPlayedMatch"))
				TotalPlayedMatch = sfsUser.getVariable("TotalPlayedMatch").getIntValue();
			if(sfsUser.containsVariable("TotalWinMatch"))
				TotalWinMatch = sfsUser.getVariable("TotalWinMatch").getIntValue();
			if(sfsUser.containsVariable("TotalLostMatch"))
				TotalLostMatch = sfsUser.getVariable("TotalLostMatch").getIntValue();
			if(sfsUser.containsVariable("Location"))
				Location = sfsUser.getVariable("Location").getStringValue();
			
			strUserName = sfsUser.name;
			chip = 200;
			
			return this;
		}

		public function get Chip():Number
		{
			return chip;
		}

		public function set Chip(value:Number):void
		{
			chip = value;
		}

		public function get UserName():String
		{
			return strUserName;
		}

		public function set UserName(value:String):void
		{
			strUserName = value;
		}


	}
}