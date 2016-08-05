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
	import entity.UserEntity;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	
	public class GetListRoomRes extends SFSGameEvent {
		protected var m_listRoom: ArrayCollection; 
		
		public function GetListRoomRes() {
			super(ADMIN_RESPONSE_NAME.GET_LIST_ROOM_RES);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != ADMIN_RESPONSE_NAME.GET_LIST_ROOM_RES){
				throw new Error("Can't parse from " + sfse.type + " to GetListRoomRes");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject)
				.getSFSObject(ADMIN_RESPONSE_NAME.GET_LIST_ROOM_RES) as SFSObject;
			if(param == null){
				throw new Error("GetListRoomRes::FromSFSEvent Error");			
			}
			
			var sfsArrRooms: ISFSArray = param.getSFSArray("list_room");
			m_listRoom = new ArrayCollection();
			for(var i: int = 0; i< sfsArrRooms.size(); i++){
				var item: ISFSObject = sfsArrRooms.getSFSObject(i);
				var room: RoomEntity = new RoomEntity();
				room.Name = item.getUtfString("name");
				room.DisplayName = item.getUtfString("displayname");
				room.Password = item.getUtfString("password");
				room.maxUser = item.getInt("maxuser");
				room.betChip = parseFloat(item.getUtfString("betchip"));
				room.smallBlind = parseFloat(item.getUtfString("smallblind"));
				room.bigBlind = parseFloat(item.getUtfString("bigblind"));
				room.maxBuyin = parseFloat(item.getUtfString("maxbuyin"));
				room.minBuyin = parseFloat(item.getUtfString("minbuyin"));
				room.noLimit = item.getInt("nolimit");
				if(room.noLimit)
					room.maxBuyin = 0;
				room.status = item.getUtfString("status");
				room.createBy = item.getUtfString("createby");
				m_listRoom.addItem(room);
			}
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return ADMIN_RESPONSE_NAME.GET_LIST_ROOM_RES;
		}

		public function get listRoom():ArrayCollection
		{
			return m_listRoom;
		}

	} 
}