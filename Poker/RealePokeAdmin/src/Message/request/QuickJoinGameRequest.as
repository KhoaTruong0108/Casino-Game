package Message.request {

	import Message.SFSGameRequest;
	
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.entities.match.MatchExpression;
	import com.smartfoxserver.v2.entities.match.NumberMatch;
	import com.smartfoxserver.v2.entities.match.StringMatch;
	import com.smartfoxserver.v2.requests.BaseRequest;
	import com.smartfoxserver.v2.requests.game.QuickJoinGameRequest;

	public class QuickJoinGameRequest extends SFSGameRequest {

		public function QuickJoinGameRequest(exp:MatchExpression, whereToSearch:Array, roomToLeave:Room = null) {
			m_request = new com.smartfoxserver.v2.requests.game.QuickJoinGameRequest(exp, whereToSearch, roomToLeave);
			m_name = SFS_REQUEST_NAME.QUICK_GAME_JOIN_REQUEST;
		}
		
		override public function GetRequestName():String{
			return SFS_REQUEST_NAME.QUICK_GAME_JOIN_REQUEST;
		}
		
		override public function ToSFSRequest():BaseRequest{
			return m_request;
		}
	} // end class
} // end package