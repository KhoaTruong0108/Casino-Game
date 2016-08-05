package Message.event.game.pokertexas {

	import Message.SFSGameEvent;
	import Message.event.game.pokertexas.POKER_RESPONSE_NAME;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import mx.collections.ArrayList;

	public class Notify_GameTurn extends SFSGameEvent {

		protected var m_currentUser:String;
		protected var m_currentGameTurn:String;
		protected var m_listCommunityCard: ArrayList;
		protected var m_time:int;


		public function Notify_GameTurn() {
			super(POKER_RESPONSE_NAME.GAME_TURN_RES);
		}

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_RESPONSE_NAME.GAME_TURN_RES){
				throw new Error("Can't parse from " + sfse.type + " to TURN");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(POKER_RESPONSE_NAME.GAME_TURN_RES) as SFSObject;
			if(param == null){
				throw new Error("TURN::FromSFSEvent Error");			
			}
			
			m_currentUser = param.getUtfString("current_user");
			m_currentGameTurn = param.getUtfString("current_game_turn");
			m_time = param.getInt("time");
			
			m_listCommunityCard = new ArrayList();
			var sfsCards: SFSArray = param.getSFSArray("list_community_card") as SFSArray;
			for(var j: int = 0; j < sfsCards.size(); j++){
				m_listCommunityCard.addItem(sfsCards.getInt(j));
			}
			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_RESPONSE_NAME.GAME_TURN_RES;
		}

		public function get ListCommunityCard():ArrayList
		{
			return m_listCommunityCard;
		}

		public function set ListCommunityCard(value:ArrayList):void
		{
			m_listCommunityCard = value;
		}

		public function get CurrentUser():String
		{
			return m_currentUser;
		}

		public function get CurrentGameTurn():String
		{
			return m_currentGameTurn;
		}

		public function get Time():int
		{
			return m_time;
		}

		
	} // end class
} // end package