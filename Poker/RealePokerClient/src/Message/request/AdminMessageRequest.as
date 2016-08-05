package Message.request {
	import Message.SFSGameRequest;
	
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.requests.AdminMessageRequest;
	import com.smartfoxserver.v2.requests.BaseRequest;
	import com.smartfoxserver.v2.requests.MessageRecipientMode;

	public class AdminMessageRequest extends SFSGameRequest{

		public function AdminMessageRequest(message:String, recipientMode:MessageRecipientMode, params:ISFSObject = null) {
			m_request = new com.smartfoxserver.v2.requests.AdminMessageRequest(message, recipientMode, params);
			m_name = SFS_REQUEST_NAME.ADMIN_MESSAGE_REQUEST;
		}
		
		override public function GetRequestName():String
		{
			// TODO Auto Generated method stub
			return SFS_REQUEST_NAME.ADMIN_MESSAGE_REQUEST;
		}
		
		override public function ToSFSRequest():BaseRequest{
			return m_request;
		}

	} // end class
} // end package