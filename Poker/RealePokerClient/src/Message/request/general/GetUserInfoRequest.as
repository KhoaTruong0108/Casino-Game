package Message.request.general {

	import Message.SFSCustomRequest;
	import Message.SFSGameRequest;
	import Message.event.general.GENERAL_EVENT_NAME;
	import Message.request.SFS_REQUEST_NAME;
	
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.requests.BaseRequest;
	import com.smartfoxserver.v2.requests.ExtensionRequest;
	import com.smartfoxserver.v2.requests.LoginRequest;
	
	public class GetUserInfoRequest extends SFSCustomRequest
	{
		public static var USER_NAME: String = "user_name";
		public static var EMAIL: String = "email";
		public static var USER_STATUS: String = "user_status";
		public static var USER_TITLE: String = "user_title";   

		public function GetUserInfoRequest()
		{
			super(GENERAL_REQUEST_NAME.GET_USER_INFO_REQ);
		}
		
		override public function AddParam(key:String, value:*):SFSCustomRequest
		{
			return super.AddParam(key, value);
		}
		
		override public function SetName(name:String):SFSCustomRequest
		{
			m_name = name;
			return this;
		}
		
		override public function ToSFSRequest():BaseRequest
		{
			return super.ToSFSRequest();
		}
		
	} // end class
} // end package