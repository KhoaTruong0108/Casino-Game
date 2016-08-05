package Message.event.admin
{
	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.ISFSArray;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import entity.AdminEntity;
	import entity.LevelEntity;
	import entity.RoomEntity;
	import entity.TournamentEntity;
	import entity.UserEntity;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	
	public class GetLevelCollectionRes extends SFSGameEvent {
		protected var m_listLevelCollection: ArrayCollection; 
		
		public function GetLevelCollectionRes() {
			super(ADMIN_RESPONSE_NAME.GET_LEVEL_COLLECTION_RES);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != ADMIN_RESPONSE_NAME.GET_LEVEL_COLLECTION_RES){
				throw new Error("Can't parse from " + sfse.type + " to GetLevelCollectionRes");
			}
			var param : SFSObject = (sfse.params.params as SFSObject)
				.getSFSObject(ADMIN_RESPONSE_NAME.GET_LEVEL_COLLECTION_RES) as SFSObject;
			if(param == null){
				throw new Error("GetLevelCollectionRes::FromSFSEvent Error");			
			}
			
			var sfsArrLevels: ISFSArray = param.getSFSArray("list_level_collection");
			m_listLevelCollection = new ArrayCollection();
			for(var i: int = 0; i< sfsArrLevels.size(); i++){
				var item: ISFSObject = sfsArrLevels.getSFSObject(i);
				var lc: Object = new Object();
				lc.label = item.getUtfString("description");
				lc.data = item.getInt("id");
				
				m_listLevelCollection.addItem(lc);
			}
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return ADMIN_RESPONSE_NAME.GET_LEVEL_COLLECTION_RES;
		}

		public function get listLevelCollection():ArrayCollection
		{
			return m_listLevelCollection;
		}


	} 
}