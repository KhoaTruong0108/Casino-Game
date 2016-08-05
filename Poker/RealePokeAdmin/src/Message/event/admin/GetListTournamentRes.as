package Message.event.admin
{
	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.ISFSArray;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import entity.AdminEntity;
	import entity.RoomEntity;
	import entity.TournamentEntity;
	import entity.UserEntity;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	
	public class GetListTournamentRes extends SFSGameEvent {
		protected var m_listTournament: ArrayCollection; 
		
		public function GetListTournamentRes() {
			super(ADMIN_RESPONSE_NAME.GET_LIST_TOURNAMENT_RES);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != ADMIN_RESPONSE_NAME.GET_LIST_TOURNAMENT_RES){
				throw new Error("Can't parse from " + sfse.type + " to GetListTournamentRes");
			}
			var param : SFSObject = (sfse.params.params as SFSObject)
				.getSFSObject(ADMIN_RESPONSE_NAME.GET_LIST_TOURNAMENT_RES) as SFSObject;
			if(param == null){
				throw new Error("GetListTournamentRes::FromSFSEvent Error");			
			}
			
			var sfsArrRooms: ISFSArray = param.getSFSArray("list_tournament");
			m_listTournament = new ArrayCollection();
			for(var i: int = 0; i< sfsArrRooms.size(); i++){
				var item: ISFSObject = sfsArrRooms.getSFSObject(i);
				var tour: TournamentEntity = new TournamentEntity();
				tour.name = item.getUtfString("name");
				tour.displayName = item.getUtfString("displayname");
				tour.fee = parseFloat(item.getUtfString("fee"));
				tour.capacity = item.getInt("capacity");
				tour.levelType = item.getInt("leveltype");
				tour.levelTypeDes = item.getUtfString("description");
				tour.beginLevel = item.getInt("beginlevel");
				tour.endLevel = item.getInt("endlevel");
				tour.status = item.getUtfString("status");
				tour.startingChip = parseFloat(item.getUtfString("startingchip"));
				tour.firstPrize = parseFloat(item.getUtfString("firstprize"));
				tour.secondPrize = parseFloat(item.getUtfString("secondprize"));
				tour.thirdPrize = parseFloat(item.getUtfString("thirdprize"));
				m_listTournament.addItem(tour);
			}
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return ADMIN_RESPONSE_NAME.GET_LIST_TOURNAMENT_RES;
		}

		public function get listTournament():ArrayCollection
		{
			return m_listTournament;
		}

	} 
}