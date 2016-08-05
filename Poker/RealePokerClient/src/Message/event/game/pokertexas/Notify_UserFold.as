package Message.event.game.pokertexas {

	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSObject;

	public class Notify_UserFold extends SFSGameEvent {

		private var m_userName: String;

		public function Notify_UserFold() {
			super(POKER_RESPONSE_NAME.USER_FOLD_RES);
		}

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_RESPONSE_NAME.USER_FOLD_RES){
				throw new Error("Can't parse from " + sfse.type + " to USER_FOLD_RES");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(POKER_RESPONSE_NAME.USER_FOLD_RES) as SFSObject;
			if(param == null){
				throw new Error("USER_FOLD_RES::FromSFSEvent Error");			
			}
			
			m_userName = param.getUtfString("user_name");
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_RESPONSE_NAME.USER_FOLD_RES;
		}

		public function get UserName():String
		{
			return m_userName;
		}
	} // end class
} // end package