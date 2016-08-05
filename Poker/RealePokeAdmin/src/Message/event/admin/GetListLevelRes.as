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
	
	public class GetListLevelRes extends SFSGameEvent {
		protected var m_listLevel: ArrayCollection; 
		
		public function GetListLevelRes() {
			super(ADMIN_RESPONSE_NAME.GET_LIST_LEVEL_RES);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != ADMIN_RESPONSE_NAME.GET_LIST_LEVEL_RES){
				throw new Error("Can't parse from " + sfse.type + " to GetListLevelRes");
			}
			var param : SFSObject = (sfse.params.params as SFSObject)
				.getSFSObject(ADMIN_RESPONSE_NAME.GET_LIST_LEVEL_RES) as SFSObject;
			if(param == null){
				throw new Error("GetListLevelRes::FromSFSEvent Error");			
			}
			
			var sfsArrLevels: ISFSArray = param.getSFSArray("list_level");
			m_listLevel = new ArrayCollection();
			for(var i: int = 0; i< sfsArrLevels.size(); i++){
				var item: ISFSObject = sfsArrLevels.getSFSObject(i);
				var level: LevelEntity = new LevelEntity();
				level.id = item.getInt("id");
				level.level = item.getInt("level");
				level.levelType = item.getInt("leveltype");
				level.smallBlind = parseFloat(item.getUtfString("smallblind"));
				level.bigBlind = parseFloat(item.getUtfString("bigblind"));
				level.ante = parseFloat(item.getUtfString("ante"));
				level.timeLife = item.getInt("timelife");
				
				m_listLevel.addItem(level);
			}
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return ADMIN_RESPONSE_NAME.GET_LIST_LEVEL_RES;
		}

		public function get listLevel():ArrayCollection
		{
			return m_listLevel;
		}


	} 
}