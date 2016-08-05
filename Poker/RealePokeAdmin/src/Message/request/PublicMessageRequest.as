package Message.request {

	import Message.SFSGameRequest;
	
	import com.smartfoxserver.v2.requests.BaseRequest;
	import com.smartfoxserver.v2.requests.PublicMessageRequest;

	public class PublicMessageRequest extends SFSGameRequest {
		protected var m_msg: String;
		public function PublicMessageRequest(message:String) {
			m_msg = message;
			m_request = new com.smartfoxserver.v2.requests.PublicMessageRequest(message);
			m_name = SFS_REQUEST_NAME.PUBLIC_MSG_REQUEST;
		}

		override public function GetRequestName():String
		{
			return SFS_REQUEST_NAME.PUBLIC_MSG_REQUEST;
		}
		override public function ToSFSRequest():BaseRequest
		{
			return m_request;
		}
		
	} // end class
} // end package