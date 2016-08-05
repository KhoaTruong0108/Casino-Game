package Message.request {

	import Message.SFSGameRequest;
	
	import com.smartfoxserver.v2.requests.BaseRequest;
	import com.smartfoxserver.v2.requests.CreateRoomRequest;
	import com.smartfoxserver.v2.requests.RoomSettings;
	import com.smartfoxserver.v2.requests.game.CreateSFSGameRequest;
	import com.smartfoxserver.v2.requests.game.SFSGameSettings;

	public class CreateGameRequest extends SFSGameRequest {

		public function CreateGameRequest(settings:SFSGameSettings) {
			m_request = new CreateSFSGameRequest(settings);
			m_name = SFS_REQUEST_NAME.CREATE_GAME_REQUEST;
		}
		
		override public function GetRequestName():String
		{
			return SFS_REQUEST_NAME.CREATE_GAME_REQUEST;
		}
		
		override public function ToSFSRequest():BaseRequest{
			return m_request;
		}

	} // end class
} // end package