package Message.event.game.PokerTournament
{
	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.ISFSArray;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import entity.PokerTournamentEntity;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	
	public class GetListTournamentRes extends SFSGameEvent {
		protected var m_listTournament: ArrayCollection; 
		private var m_isRegistried: Boolean;
		private var m_tourName: String;
		public function GetListTournamentRes() {
			super(POKER_TOUR_RESPONSE_NAME.GET_LIST_TOUR);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_TOUR_RESPONSE_NAME.GET_LIST_TOUR){
				throw new Error("Can't parse from " + sfse.type + " to GetListTournamentRes");
			}
			var param : SFSObject = (sfse.params.params as SFSObject)
				.getSFSObject(POKER_TOUR_RESPONSE_NAME.GET_LIST_TOUR) as SFSObject;
			if(param == null){
				throw new Error("GetListTournamentRes::FromSFSEvent Error");			
			}
			
			m_isRegistried = param.getBool("is_registried");
			m_tourName = param.getUtfString("tour_name");
			
			var sfsArrRooms: ISFSArray = param.getSFSArray("list_tournament");
			m_listTournament = new ArrayCollection();
			for(var i: int = 0; i< sfsArrRooms.size(); i++){
				var item: ISFSObject = sfsArrRooms.getSFSObject(i);
				var tour: PokerTournamentEntity = new PokerTournamentEntity();
				tour.name = item.getUtfString("name");
				tour.displayName = item.getUtfString("displayname");
				tour.fee = parseFloat(item.getUtfString("fee"));
				tour.playerCount = item.getInt("playeringame");
				tour.capacity = item.getInt("capacity");
				tour.levelType = item.getInt("leveltype");
				tour.beginLevel = item.getInt("beginlevel");
				tour.endLevel = item.getInt("endlevel");
				tour.status = item.getUtfString("status");
				tour.startingChip = parseFloat(item.getUtfString("startingchip"));
				tour.firstPrize = parseFloat(item.getUtfString("firstprize"));
				tour.secondPrize = parseFloat(item.getUtfString("secondprize"));
				tour.thirdPrize = parseFloat(item.getUtfString("thirdprize"));
				tour.smallBlind = parseFloat(item.getUtfString("smallblind"));
				tour.bigBlind = parseFloat(item.getUtfString("bigblind"));
				m_listTournament.addItem(tour);
			}
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_TOUR_RESPONSE_NAME.GET_LIST_TOUR;
		}

		public function get listTournament():ArrayCollection
		{
			return m_listTournament;
		}

		public function get isRegistried():Boolean
		{
			return m_isRegistried;
		}

		public function get tourName():String
		{
			return m_tourName;
		}


	} 
}