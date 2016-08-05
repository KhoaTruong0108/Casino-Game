package Message.request {

	import Message.SFSGameRequest;
	
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.requests.BaseRequest;
	import com.smartfoxserver.v2.requests.LoginRequest;

	public class LoginRequest extends SFSGameRequest {

		public function LoginRequest(userName:String, password:String, zoneName:String = null, param:SFSObject = null) {
			m_request = new com.smartfoxserver.v2.requests.LoginRequest(userName, password, zoneName,param);
			m_name = SFS_REQUEST_NAME.LOGIN_REQUEST;
		}
		
		override public function GetRequestName():String
		{
			return SFS_REQUEST_NAME.LOGIN_REQUEST;
		}
		
		override public function ToSFSRequest():BaseRequest{
			return m_request;
		}
	

	} // end class
} // end package