package Message.event.general
{
	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import flash.events.Event;
	
	import mx.collections.ArrayList;

	public class GetListFreeUserEvent extends SFSGameEvent
	{
		private var m_listUser: ArrayList; 
		
		public function GetListFreeUserEvent()
		{
			super(GENERAL_EVENT_NAME.GET_LIST_FREE_USER_RES);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != GENERAL_EVENT_NAME.GET_LIST_FREE_USER_RES){
				throw new Error("Can't parse from " + sfse.type + " to GetListFreeUserEvent");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(GENERAL_EVENT_NAME.GET_LIST_FREE_USER_RES) as SFSObject;			
			if(param == null){
				throw new Error("GetListFreeUserEvent::FromSFSEvent Error");			
			}
			
			m_listUser = new ArrayList();
			var sfsArray: SFSArray = param.getSFSArray("list_free_user") as SFSArray;
			for(var i: int = 0; i< sfsArray.size(); i++){
				m_listUser.addItem(sfsArray.getUtfString(i));
			}
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return GENERAL_EVENT_NAME.GET_LIST_FREE_USER_RES;
		}
		
		override public function ToEvent():Event
		{
			return new Event(GetEventName());
		}

		public function get ListUser():ArrayList
		{
			return m_listUser;
		}

		public function set ListUser(value:ArrayList):void
		{
			m_listUser = value;
		}

		
	}
}