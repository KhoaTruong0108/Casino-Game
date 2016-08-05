package Message.event.game.pokertexas {

	import Message.SFSGameEvent;
	import Message.event.game.pokertexas.POKER_RESPONSE_NAME;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import mx.collections.ArrayList;

	public class Notify_UserReady extends SFSGameEvent {
		protected var m_username:String;
		
		public function Notify_UserReady() {
			super(POKER_RESPONSE_NAME.USER_READY_RES);
		}

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			var sfstemp: SFSObject;
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_RESPONSE_NAME.USER_READY_RES){
				throw new Error("Can't parse from " + sfse.type + " to Notify_UserReady");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject)
				.getSFSObject(POKER_RESPONSE_NAME.USER_READY_RES) as SFSObject;
			if(param == null){
				throw new Error("Notify_UserReady::FromSFSEvent Error");			
			}
			m_username = param.getUtfString("user_name");
			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_RESPONSE_NAME.USER_READY_RES;
		}
		
		public function get UserName():String
		{
			return m_username;
		}

	} // end class
} // end package