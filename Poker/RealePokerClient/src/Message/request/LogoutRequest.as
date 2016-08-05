package Message.request {

	import Message.SFSGameRequest;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.requests.BaseRequest;
	import com.smartfoxserver.v2.requests.LogoutRequest;

	public class LogoutRequest extends SFSGameRequest {

		public function LogoutRequest() {
			m_request = new com.smartfoxserver.v2.requests.LogoutRequest();
			m_name = SFS_REQUEST_NAME.LOGOUT_REQUEST;
		}

		override public function GetRequestName():String
		{
			return SFS_REQUEST_NAME.LOGOUT_REQUEST;
		}
		
		override public function ToSFSRequest():BaseRequest
		{
			return m_request;
		}
		
	} // end class
} // end package