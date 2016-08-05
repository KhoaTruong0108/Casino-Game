package Message.request {

	import Message.SFSGameRequest;
	
	import com.smartfoxserver.v2.requests.BaseRequest;
	import com.smartfoxserver.v2.requests.JoinRoomRequest;

	public class JoinRoomRequest extends SFSGameRequest {

		public function JoinRoomRequest(id:*, pass:String = "", roomIdToLeave:Number = NaN, asSpect:Boolean = false) {
			m_request = new com.smartfoxserver.v2.requests.JoinRoomRequest(id);
			m_name = SFS_REQUEST_NAME.JOIN_ROOM_REQUEST;
		}
		
		override public function GetRequestName():String
		{
			return SFS_REQUEST_NAME.JOIN_ROOM_REQUEST;
		}
		
		override public function ToSFSRequest():BaseRequest{
			return m_request;
		}

	} // end class
} // end package