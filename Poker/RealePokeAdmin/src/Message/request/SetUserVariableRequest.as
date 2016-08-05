package Message.request {

	import Message.SFSGameRequest;
	
	import com.smartfoxserver.v2.requests.BaseRequest;

	public class SetUserVariableRequest extends SFSGameRequest {
		
		public function SetRoomVariablesRequest(userVariables:Array) {
			m_request = new com.smartfoxserver.v2.requests.SetUserVariablesRequest	(userVariables);
		}
		
		override public function GetRequestName():String
		{
			// TODO Auto Generated method stub
			return SFS_REQUEST_NAME.SET_ROOM_VARIABLE_REQUEST;
		}
		
		override public function ToSFSRequest():BaseRequest{
			return m_request;
		}
	} // end class
} // end package