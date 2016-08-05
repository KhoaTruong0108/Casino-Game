package Message.request.general {

	import Message.SFSCustomRequest;
	import Message.SFSGameRequest;
	import Message.event.general.GENERAL_EVENT_NAME;
	
	import com.smartfoxserver.v2.requests.BaseRequest;

	public class RegisterRequest extends SFSCustomRequest
	{
		
		public static var USER_NAME: String = "user_name";
		public static var PASSWORD: String = "password";
		public static var EMAIL: String = "email";
		
		public function RegisterRequest()
		{
			super(GENERAL_REQUEST_NAME.REGISTER_REQ);
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