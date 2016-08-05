package Message.request {

	import Message.SFSGameRequest;
	
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.requests.BaseRequest;
	import com.smartfoxserver.v2.requests.SetRoomVariablesRequest;

	public class SetRoomVariablesRequest extends SFSGameRequest {
		
		public function SetRoomVariablesRequest(roomVariables:Array, room:Room = null) {
			m_request = new com.smartfoxserver.v2.requests.SetRoomVariablesRequest(roomVariables, room);
			m_name = SFS_REQUEST_NAME.SET_ROOM_VARIABLE_REQUEST;
		}
		
		override public function GetRequestName():String
		{
			return SFS_REQUEST_NAME.SET_ROOM_VARIABLE_REQUEST;
		}
		
		override public function ToSFSRequest():BaseRequest{
			return m_request;
		}
	} // end class
} // end package