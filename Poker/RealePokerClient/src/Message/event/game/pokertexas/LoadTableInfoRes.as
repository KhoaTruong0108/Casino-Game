package Message.event.game.pokertexas
{
	import Message.SFSGameEvent;
	import Message.event.game.pokertexas.POKER_RESPONSE_NAME;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import de.polygonal.ds.HashMap;
	
	import entity.game_Entity.Desk;
	import entity.game_Entity.ICard;
	import entity.game_Entity.Poker.PokerCardHand;
	
	import flash.events.Event;
	
	import mx.collections.ArrayList;

	public class LoadTableInfoRes extends SFSGameEvent
	{
		private var m_isGameStart: Boolean;
		private var m_isPrestart: Boolean;
		private var m_prestartTime: int;
		private var m_listDesk: ArrayList//ArrayList<Desk>
		private var m_listUserSitOut: ArrayList;//ArrayList<String>
		private var m_listUser: ArrayList;//ArrayList<String>
		private var m_listUserPlaying: ArrayList;//ArrayList<String>
		private var m_listHandCard: ArrayList; //ArrayList<ArrayList<Integer>>
		private var m_listBetChip: ArrayList; //ArrayList<Double>
		private var m_listCommunityCard: ArrayList; //ArrayList<Integer>
		private var m_potChip: Number;
		private var m_dealer: String;
		private var m_smallBlind: String;
		private var m_bigBlind: String;

		public function LoadTableInfoRes()
		{
			super(POKER_RESPONSE_NAME.LOAD_TABLE_INFO_RES);
		}
		

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_RESPONSE_NAME.LOAD_TABLE_INFO_RES){
				throw new Error("Can't parse from " + sfse.type + " to LoadTableInfoRes");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(POKER_RESPONSE_NAME.LOAD_TABLE_INFO_RES) as SFSObject;
			if(param == null){
				throw new Error("LoadTableInfoRes::FromSFSEvent Error");			
			}
			
			m_isGameStart = param.getBool("is_game_start");
			m_isPrestart = param.getBool("is_prestart");
			m_prestartTime = param.getInt("prestart_time");
			m_potChip = param.getDouble("pot_chip");

			m_dealer = param.getUtfString("dealer");
			m_smallBlind = param.getUtfString("small_blind");
			m_bigBlind = param.getUtfString("big_blind");
			
			var i: int = 0;
			var j: int = 0;
			
			var sfsListDesk: SFSArray = param.getSFSArray("list_desk") as SFSArray;
			m_listDesk = new ArrayList();
			for(i = 0; i< sfsListDesk.size(); i++){
				var desk: Desk = DeskFromSFSObject(sfsListDesk.getSFSObject(i) as SFSObject);
				m_listDesk.addItem(desk);
			}
			
			var sfsListSitOut: SFSArray = param.getSFSArray("list_user_sit_out") as SFSArray;
			m_listUserSitOut = new ArrayList();
			for (i = 0; i < sfsListSitOut.size(); i++) {
				m_listUserSitOut.addItem(sfsListSitOut.getUtfString(i)); 
			}
			

			var sfsListUser: SFSArray = param.getSFSArray("list_player") as SFSArray;
			m_listUser = new ArrayList();
			for(i = 0; i< sfsListUser.size(); i++){
				m_listUser.addItem(sfsListUser.getUtfString(i));
			}
			
			var sfsListUserPlaying: SFSArray = param.getSFSArray("list_user_playing") as SFSArray;
			m_listUserPlaying = new ArrayList();
			for(i = 0; i< sfsListUserPlaying.size(); i++){
				m_listUserPlaying.addItem(sfsListUserPlaying.getUtfString(i));
			}
			
			var sfsListHandCard: SFSArray = param.getSFSArray("list_Hand_Card") as SFSArray;
			m_listHandCard = new ArrayList();
			for(i = 0; i< sfsListHandCard.size(); i++){
				var sfsHandCards: SFSArray = sfsListHandCard.getSFSArray(i) as SFSArray;
				var handCards: ArrayList = new ArrayList();
				for(j = 0; j< sfsHandCards.size();j ++){
					handCards.addItem(sfsHandCards.getInt(j));
				}
				m_listHandCard.addItem(handCards);
			}
			
			
			var sfsListBetChip: SFSArray = param.getSFSArray("list_bet_chip") as SFSArray;
			m_listBetChip = new ArrayList();
			for(i = 0; i< sfsListBetChip.size(); i++){
				m_listBetChip.addItem(sfsListBetChip.getDouble(i));
			}
			
			var sfsListComCard: SFSArray = param.getSFSArray("list_comminity_card") as SFSArray;
			m_listCommunityCard = new ArrayList();
			for(i = 0; i< sfsListComCard.size(); i++){
				m_listCommunityCard.addItem(sfsListComCard.getInt(i));
			}
			
			return this;
			
		}
		
		public function DeskFromSFSObject(sfsObj: SFSObject):Desk{
			var desk: Desk = new Desk();
			desk.DeskId = sfsObj.getInt("deskID");
			desk.UserName =  sfsObj.getUtfString("userName");
			desk.deskState =  sfsObj.getUtfString("deskState");
			desk.UserChip =  sfsObj.getDouble("chip");
			return desk;
		}
		
		override public function GetEventName():String
		{
			return POKER_RESPONSE_NAME.LOAD_TABLE_INFO_RES;
		}
		
		override public function ToEvent():Event
		{
			return new Event(GetEventName());
		}

		public function get IsGameStart():Boolean
		{
			return m_isGameStart;
		}

		public function get ListUser():ArrayList
		{
			return m_listUser;
		}
		
		public function get ListHandCard():ArrayList
		{
			return m_listHandCard;
		}

		public function get ListDesk():ArrayList
		{
			return m_listDesk;
		}

		public function set ListDesk(value:ArrayList):void
		{
			m_listDesk = value;
		}

		public function get IsPrestart():Boolean
		{
			return m_isPrestart;
		}

		public function set IsPrestart(value:Boolean):void
		{
			m_isPrestart = value;
		}

		public function get PrestartTime():int
		{
			return m_prestartTime;
		}

		public function set PrestartTime(value:int):void
		{
			m_prestartTime = value;
		}

		public function get ListBetChip():ArrayList
		{
			return m_listBetChip;
		}

		public function set ListBetChip(value:ArrayList):void
		{
			m_listBetChip = value;
		}

		public function get ListCommunityCard():ArrayList
		{
			return m_listCommunityCard;
		}

		public function set ListCommunityCard(value:ArrayList):void
		{
			m_listCommunityCard = value;
		}

		public function get PotChip():Number
		{
			return m_potChip;
		}

		public function set PotChip(value:Number):void
		{
			m_potChip = value;
		}

		public function get Dealer():String
		{
			return m_dealer;
		}

		public function get SmallBlind():String
		{
			return m_smallBlind;
		}

		public function get BigBlind():String
		{
			return m_bigBlind;
		}

		public function get ListUserPlaying():ArrayList
		{
			return m_listUserPlaying;
		}

		public function get listUserSitOut():ArrayList
		{
			return m_listUserSitOut;
		}

		public function set listUserSitOut(value:ArrayList):void
		{
			m_listUserSitOut = value;
		}


	}
}