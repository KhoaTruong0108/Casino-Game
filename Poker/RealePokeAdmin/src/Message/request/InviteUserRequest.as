package Message.request {

	import Message.SFSGameRequest;
	
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.requests.BaseRequest;
	import com.smartfoxserver.v2.requests.game.InviteUsersRequest;

	public class InviteUserRequest extends SFSGameRequest {
		
		public function InviteUserRequest(invitedUsers:Array, secondsForAnswer:int, params:ISFSObject) {
			m_request = new com.smartfoxserver.v2.requests.game.InviteUsersRequest(invitedUsers, secondsForAnswer, params);
		}
		
		override public function GetRequestName():String
		{
			// TODO Auto Generated method stub
			return SFS_REQUEST_NAME.INVITE_USER_REQUEST;
		}
		
		override public function ToSFSRequest():BaseRequest{
			return m_request;
		}
	} // end class
} // end package