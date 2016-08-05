package Message.event.game.pokertexas {

	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import mx.collections.ArrayList;

	public class Notify_FinishGame extends SFSGameEvent {

		private var m_listUser: ArrayList;
		//if chip < 0 => not process. 
		private var m_listChip: ArrayList;
		private var m_listPokerHandCard: ArrayList;
		private var m_listPokerHand: ArrayList;
		private var m_listWinner: ArrayList;
		
		public function Notify_FinishGame() {
			super(POKER_RESPONSE_NAME.FINISH_GAME_RES);
		}

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_RESPONSE_NAME.FINISH_GAME_RES){
				throw new Error("Can't parse from " + sfse.type + " to FINISH_GAME_RES");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(POKER_RESPONSE_NAME.FINISH_GAME_RES) as SFSObject;
			if(param == null){
				throw new Error("FINISH_GAME_RES::FromSFSEvent Error");			
			}
			
			/*m_listPokerHand = param.getUtfString("poker_hand");*/
			
			
			var i: int;
			m_listUser = new ArrayList();
			var sfsUsers: SFSArray = param.getSFSArray("list_user") as SFSArray;
			for(i = 0; i < sfsUsers.size(); i++){
				m_listUser.addItem(sfsUsers.getUtfString(i));
			}
			
			m_listPokerHand = new ArrayList();
			var sfsPokerHands: SFSArray = param.getSFSArray("list_poker_Hand") as SFSArray;
			for(i = 0; i < sfsPokerHands.size(); i++){
				m_listPokerHand.addItem(sfsPokerHands.getUtfString(i));
			}
			
			m_listChip = new ArrayList();
			var sfsChip: SFSArray = param.getSFSArray("list_chip") as SFSArray;
			for(i = 0; i < sfsChip.size(); i++){
				m_listChip.addItem(sfsChip.getDouble(i));
			}
			
			m_listPokerHandCard = new ArrayList();
			var sfsPokerHandCard: SFSArray = param.getSFSArray("list_poker_hand_card") as SFSArray;
			for(i = 0; i < sfsPokerHandCard.size(); i++){
				m_listPokerHandCard.addItem(sfsPokerHandCard.getInt(i));
			}
			
			m_listWinner = new ArrayList();
			var sfsWinners: SFSArray = param.getSFSArray("list_winner") as SFSArray;
			for(i = 0; i < sfsWinners.size(); i++){
				m_listWinner.addItem(sfsWinners.getUtfString(i));
			}
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_RESPONSE_NAME.FINISH_GAME_RES;
		}

		public function get ListUser():ArrayList
		{
			return m_listUser;
		}

		public function get ListChip():ArrayList
		{
			return m_listChip;
		}

		public function get ListPokerHandCard():ArrayList
		{
			return m_listPokerHandCard;
		}

		public function get ListPokerHand():ArrayList
		{
			return m_listPokerHand;
		}

		public function get ListWinner():ArrayList
		{
			return m_listWinner;
		}


	} // end class
} // end package