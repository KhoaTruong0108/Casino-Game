package Message.event.general {

	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSObject;

	public class RegisterErrorEvent extends SFSGameEvent {

		private var m_message: String;
		
		public function RegisterErrorEvent() {
			super(GENERAL_EVENT_NAME.REGISTER_ERROR);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != GENERAL_EVENT_NAME.REGISTER_ERROR){
				throw new Error("Can't parse from " + sfse.type + " to REGISTER_ERROR");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(GENERAL_EVENT_NAME.REGISTER_ERROR) as SFSObject;
			if(param == null){
				throw new Error("REGISTER_ERROR::FromSFSEvent Error");			
			}
			
			m_message = param.getUtfString("message");
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return GENERAL_EVENT_NAME.REGISTER_ERROR;
		}

		public function get message():String
		{
			return m_message;
		}

		public function set message(value:String):void
		{
			m_message = value;
		}


	} // end class
} // end package