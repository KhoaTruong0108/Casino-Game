package Message.request {

	import Message.SFSGameRequest;
	
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.requests.BaseRequest;
	import com.smartfoxserver.v2.requests.MessageRecipientMode;

	public class ModeratorMessageRequest  extends SFSGameRequest {
		
		public function ModeratorMessageRequest(message:String, recipientMode:MessageRecipientMode, params:ISFSObject = null) {
			m_request = new com.smartfoxserver.v2.requests.ModeratorMessageRequest(message, recipientMode, params);
			m_name = SFS_REQUEST_NAME.MOD_MESSAGE_REQUEST;
		}
		
		override public function GetRequestName():String
		{
			// TODO Auto Generated method stub
			return SFS_REQUEST_NAME.MOD_MESSAGE_REQUEST;
		}
		
		override public function ToSFSRequest():BaseRequest{
			return m_request;
		}
	} // end class
} // end package