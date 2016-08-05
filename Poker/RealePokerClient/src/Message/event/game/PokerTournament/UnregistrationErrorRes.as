package Message.event.game.PokerTournament
{
	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import mx.collections.ArrayList;

	public class UnregistrationErrorRes extends SFSGameEvent
	{
		private var m_message: String;
		
		public function UnregistrationErrorRes() {
			super(POKER_TOUR_RESPONSE_NAME.UNREGISTRATION_ERROR);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_TOUR_RESPONSE_NAME.UNREGISTRATION_ERROR){
				throw new Error("Can't parse from " + sfse.type + " to UNREGISTRATION_ERROR");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(POKER_TOUR_RESPONSE_NAME.UNREGISTRATION_ERROR) as SFSObject;
			if(param == null){
				throw new Error("UNREGISTRATION_ERROR::FromSFSEvent Error");			
			}
			
			m_message = param.getUtfString("message");

			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_TOUR_RESPONSE_NAME.UNREGISTRATION_ERROR;
		}

		public function get Message():String
		{
			return m_message;
		}

		public function set Message(value:String):void
		{
			m_message = value;
		}

	}
}