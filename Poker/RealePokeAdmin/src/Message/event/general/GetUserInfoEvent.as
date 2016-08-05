package Message.event.general {

	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSObject;

	public class GetUserInfoEvent extends SFSGameEvent {
		protected var m_username: String;		
		protected var m_displayName: String;
		protected var m_chipInGame: Number;
		

		public function GetUserInfoEvent(){		
			super(GENERAL_EVENT_NAME.GET_USER_INFO);
		}

		override public function GetEventName():String
		{
			// TODO Auto Generated method stub
			return GENERAL_EVENT_NAME.GET_USER_INFO;
		}
		///sfse  is ExtensionReponse Event
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != "MSG_GET_USER_INFO"){
				throw new Error("Can't parse from " + sfse.type + " to GetUserInfoEvent");			
			}
			var param : SFSObject = sfse.params.params as SFSObject;
			if(param == null){
				throw new Error("GetUserInfoEvent::FromSFSEvent Error");			
			}
			m_username = param.getUtfString("username");
			m_displayName = param.getUtfString("displayName");
			m_chipInGame = param.getDouble("chipInGame");
		
			return this;
		}
		
		

		
	} // end class
} // end package