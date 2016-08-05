package Message.event.admin
{
	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.ISFSArray;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import entity.AdminEntity;
	import entity.UserEntity;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	
	public class GetListUserRes extends SFSGameEvent {
		protected var m_listUser: ArrayCollection; 
		
		public function GetListUserRes() {
			super(ADMIN_RESPONSE_NAME.GET_LIST_USER_RES);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != ADMIN_RESPONSE_NAME.GET_LIST_USER_RES){
				throw new Error("Can't parse from " + sfse.type + " to GetListUserRes");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject)
				.getSFSObject(ADMIN_RESPONSE_NAME.GET_LIST_USER_RES) as SFSObject;
			if(param == null){
				throw new Error("GetListUserRes::FromSFSEvent Error");			
			}
			
			var sfsArrUsers: ISFSArray = param.getSFSArray("list_user");
			m_listUser = new ArrayCollection();
			for(var i: int = 0; i< sfsArrUsers.size(); i++){
				var item: ISFSObject = sfsArrUsers.getSFSObject(i);
				var user: UserEntity = new UserEntity();
				user.UserName = item.getUtfString("username");
				user.DisplayName = item.getUtfString("displayname");
				user.Password = item.getUtfString("password");
				user.Email = item.getUtfString("email");
				user.Chip = parseFloat(item.getUtfString("chip"));
				//user.LastJoinedDate = item.getUtfString("LastJoinedDate");
				//user.RegisterDate = item.getUtfString("DateRegister");
				user.TotalPlayedMatch = item.getInt("totalplayedmatch");
				user.TotalWinMatch = item.getInt("totalwinmatch");
				user.Location = item.getUtfString("location");
				
				m_listUser.addItem(user);
			}
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return ADMIN_RESPONSE_NAME.GET_LIST_USER_RES;
		}

		public function get listUser():ArrayCollection
		{
			return m_listUser;
		}

	} 
}