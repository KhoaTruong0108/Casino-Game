package Message.event.general {

	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSObject;

	public class RegisterEvent extends SFSGameEvent {

		public function RegisterEvent() {
			super(GENERAL_EVENT_NAME.REGISTER);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != GENERAL_EVENT_NAME.REGISTER){
				throw new Error("Can't parse from " + sfse.type + " to REGISTER");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(GENERAL_EVENT_NAME.REGISTER) as SFSObject;
			if(param == null){
				throw new Error("REGISTER::FromSFSEvent Error");			
			}
			
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return GENERAL_EVENT_NAME.REGISTER;
		}


	} // end class
} // end package