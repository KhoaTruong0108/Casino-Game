package Message.request {

	import Message.SFSGameRequest;
	
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.requests.BaseRequest;
	import com.smartfoxserver.v2.requests.PrivateMessageRequest;

	public class PrivateMessageRequest extends SFSGameRequest {

		public function PrivateMessageRequest(message:String, recipientId:int, params:ISFSObject) {
			m_request = new com.smartfoxserver.v2.requests.PrivateMessageRequest(message, recipientId, params);
			m_name = SFS_REQUEST_NAME.PRIVATE_MSG_REQUEST;
		}
		
		override public function GetRequestName():String
		{
			// TODO Auto Generated method stub
			return SFS_REQUEST_NAME.PRIVATE_MSG_REQUEST;
		}
		
		override public function ToSFSRequest():BaseRequest{
			return m_request;
		}
	} // end class
} // end package