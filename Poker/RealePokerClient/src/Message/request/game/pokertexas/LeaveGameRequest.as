package Message.request.game.pokertexas {

	import Message.SFSCustomRequest;
	import Message.SFSGameRequest;
	import Message.request.SFS_REQUEST_NAME;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.requests.BaseRequest;
	import com.smartfoxserver.v2.requests.LeaveRoomRequest;

	public class LeaveGameRequest extends SFSCustomRequest
	{
		public function LeaveGameRequest()
		{
			super(POKER_REQUEST_NAME.LEAVE_GAME_REQUEST);
		}
		
		override public function AddParam(key:String, value:*):SFSCustomRequest
		{
			return super.AddParam(key, value);
		}
		
		override public function SetName(name:String):SFSCustomRequest
		{
			m_name = name;
			return this;
		}
		
		override public function ToSFSRequest():BaseRequest
		{
			return super.ToSFSRequest();
		}
		
	} // end class
} // end package