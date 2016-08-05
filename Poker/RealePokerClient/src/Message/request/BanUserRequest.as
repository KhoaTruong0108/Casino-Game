package Message.request {
	import Message.SFSGameRequest;
	
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.requests.BanUserRequest;
	import com.smartfoxserver.v2.requests.BaseRequest;
	import com.smartfoxserver.v2.requests.MessageRecipientMode;
	
	public class BanUserRequest extends SFSGameRequest{
		
		public function BanUserRequest(userId:int, message:String = null, banMode:int = 1, delaySeconds:int = 5, durationHours:int = 24) {
			m_request = new com.smartfoxserver.v2.requests.BanUserRequest(userId:int, message, banMode, delaySeconds, durationHours);
			m_name = SFS_REQUEST_NAME.BAN_USER_REQUEST;
		}
		
		override public function GetRequestName():String
		{
			// TODO Auto Generated method stub
			return SFS_REQUEST_NAME.BAN_USER_REQUEST;
		}
		
		override public function ToSFSRequest():BaseRequest{
			return m_request;
		}

	} // end class
} // end package