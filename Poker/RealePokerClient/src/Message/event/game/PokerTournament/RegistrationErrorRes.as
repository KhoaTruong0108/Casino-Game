package Message.event.game.PokerTournament
{
	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import mx.collections.ArrayList;

	public class RegistrationErrorRes extends SFSGameEvent
	{
		private var m_message: String;
		
		public function RegistrationErrorRes() {
			super(POKER_TOUR_RESPONSE_NAME.REGISTRATION_ERROR);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_TOUR_RESPONSE_NAME.REGISTRATION_ERROR){
				throw new Error("Can't parse from " + sfse.type + " to REGISTRATION_ERROR");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(POKER_TOUR_RESPONSE_NAME.REGISTRATION_ERROR) as SFSObject;
			if(param == null){
				throw new Error("REGISTRATION_ERROR::FromSFSEvent Error");			
			}
			
			m_message = param.getUtfString("message");

			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_TOUR_RESPONSE_NAME.REGISTRATION_ERROR;
		}

		public function get Message():String
		{
			return m_message;
		}

	}
}