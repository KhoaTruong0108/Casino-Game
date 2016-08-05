package Message.request {

	import Message.SFSGameRequest;
	
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.requests.BaseRequest;

	public class LeaveRoomRequest extends SFSGameRequest {
		
		public function LeaveRoomRequest(theRoom:Room = null) {
			m_request = new com.smartfoxserver.v2.requests.LeaveRoomRequest(theRoom);
			m_name = SFS_REQUEST_NAME.LEAVE_ROOM_REQUEST;
		}
		
		override public function GetRequestName():String
		{
			// TODO Auto Generated method stub
			return SFS_REQUEST_NAME.LEAVE_ROOM_REQUEST;
		}
		
		override public function ToSFSRequest():BaseRequest{
			return m_request;
		}
	} // end class
} // end package