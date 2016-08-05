package Message.event.game.pokertexas {

	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import mx.collections.ArrayList;

	public class Notify_ShowDown extends SFSGameEvent {

		private var m_listUser: ArrayList;//ArrayList<String>
		private var m_listCard: ArrayList;//ArrayList<ArrayList<Integer>>
		private var m_listComCard: ArrayList;//ArrayList<Integer>
		private var m_currentGameTurn: String;
		
		public function Notify_ShowDown() {
			super(POKER_RESPONSE_NAME.SHOW_DOWN_RES);
		}

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_RESPONSE_NAME.SHOW_DOWN_RES){
				throw new Error("Can't parse from " + sfse.type + " to SHOW_DOWN_RES");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(POKER_RESPONSE_NAME.SHOW_DOWN_RES) as SFSObject;
			if(param == null){
				throw new Error("SHOW_DOWN_RES::FromSFSEvent Error");			
			}
			
			m_currentGameTurn = param.getUtfString("current_game_turn");
			
			var i: int;
			m_listUser = new ArrayList();
			var sfsUsers: SFSArray = param.getSFSArray("list_user") as SFSArray;
			for(i = 0; i < sfsUsers.size(); i++){
				m_listUser.addItem(sfsUsers.getUtfString(i));
			}
			
			m_listCard = new ArrayList();
			var sfsListCard: SFSArray = param.getSFSArray("list_card") as SFSArray;
			for(i = 0; i < sfsListCard.size(); i++){
				var sfsCards: SFSArray  = sfsListCard.getSFSArray(i) as SFSArray;
				var cards: ArrayList = new ArrayList();
				for(var j: int = 0; j < sfsCards.size(); j++){
					cards.addItem(sfsCards.getInt(j));
				}
				m_listCard.addItem(cards);
			}
			
			m_listComCard = new ArrayList();
			var sfsComCards: SFSArray = param.getSFSArray("list_community_card") as SFSArray;
			for(i = 0; i < sfsComCards.size(); i++){
				m_listComCard.addItem(sfsComCards.getInt(i));
			}
			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_RESPONSE_NAME.SHOW_DOWN_RES;
		}

		public function get ListUser():ArrayList
		{
			return m_listUser;
		}

		public function get ListCard():ArrayList
		{
			return m_listCard;
		}

		public function get ListComCard():ArrayList
		{
			return m_listComCard;
		}

		public function get CurrentGameTurn():String
		{
			return m_currentGameTurn;
		}


	} // end class
} // end package