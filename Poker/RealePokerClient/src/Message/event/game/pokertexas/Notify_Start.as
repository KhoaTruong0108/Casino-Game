package Message.event.game.pokertexas {

	import Message.SFSGameEvent;
	import Message.event.game.pokertexas.POKER_RESPONSE_NAME;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import mx.collections.ArrayList;

	public class Notify_Start extends SFSGameEvent {

		private var m_dealer: String;
		private var m_smallBlind: String;
		private var m_bigBlind: String;
		private var m_currentUser: String;
		private var m_userTime: int;//seconds
		private var m_listCard: ArrayList;
		private var m_listActiveUserName: ArrayList;
		private var m_betChipGame: Number;
		private var m_levelTimeLife: int;
		private var m_isTurnNextLevel: Boolean;

		public function Notify_Start() {
			super(POKER_RESPONSE_NAME.START);
		}

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_RESPONSE_NAME.START){
				throw new Error("Can't parse from " + sfse.type + " to START");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(POKER_RESPONSE_NAME.START) as SFSObject;
			if(param == null){
				throw new Error("START::FromSFSEvent Error");			
			}
			
			m_dealer = param.getUtfString("dealer");
			m_smallBlind = param.getUtfString("small_blind");
			m_bigBlind = param.getUtfString("big_blind");
			m_currentUser = param.getUtfString("current_user");
			m_userTime = param.getInt("user_time");
			m_betChipGame = param.getDouble("bet_chip_game");
			
			m_isTurnNextLevel = param.getBool("is_turn_next_level");
			if(param.containsKey("level_time_life")){
				m_levelTimeLife = param.getInt("level_time_life");
			}else{
				m_levelTimeLife = -1;
			}
			
			var i: int;
			var sfsCards: SFSArray = param.getSFSArray("list_card") as SFSArray;
			m_listCard = new ArrayList();
			for(i = 0; i < sfsCards.size(); i++){
				m_listCard.addItem(sfsCards.getInt(i));
			}
			
			var sfsActiveUsers: SFSArray = param.getSFSArray("list_active_user_name") as SFSArray;
			m_listActiveUserName = new ArrayList();
			for(i = 0; i < sfsActiveUsers.size(); i++){
				m_listActiveUserName.addItem(sfsActiveUsers.getUtfString(i));
			}
			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_RESPONSE_NAME.START;
		}

		public function get SmallBlind():String
		{
			return m_smallBlind;
		}

		public function get BigBlind():String
		{
			return m_bigBlind;
		}

		public function get CurrentUser():String
		{
			return m_currentUser;
		}

		public function get UserTime():int
		{
			return m_userTime;
		}

		public function get ListCard():ArrayList
		{
			return m_listCard;
		}

		public function get BetChipGame():Number
		{
			return m_betChipGame;
		}

		public function get ListActiveUserName():ArrayList
		{
			return m_listActiveUserName;
		}

		public function get Dealer():String
		{
			return m_dealer;
		}

		public function set Dealer(value:String):void
		{
			m_dealer = value;
		}

		public function get levelTimeLife():int
		{
			return m_levelTimeLife;
		}

		public function get isTurnNextLevel():Boolean
		{
			return m_isTurnNextLevel;
		}


	} // end class
} // end package