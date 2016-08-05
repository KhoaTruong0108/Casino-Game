package Message.event.game.PokerTournament
{
	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import mx.collections.ArrayList;

	public class RegistrationRes extends SFSGameEvent
	{
		private var m_userName: String;
		private var m_tourName: String;
		private var m_fee: Number;
		
		public function RegistrationRes() {
			super(POKER_TOUR_RESPONSE_NAME.REGISTRATION);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_TOUR_RESPONSE_NAME.REGISTRATION){
				throw new Error("Can't parse from " + sfse.type + " to REGISTRATION");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(POKER_TOUR_RESPONSE_NAME.REGISTRATION) as SFSObject;
			if(param == null){
				throw new Error("REGISTRATION::FromSFSEvent Error");			
			}
			
			m_userName = param.getUtfString("user_name");
			m_tourName = param.getUtfString("tour_name");
			m_fee = param.getDouble("fee");
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_TOUR_RESPONSE_NAME.REGISTRATION;
		}

		public function get UserName():String
		{
			return m_userName;
		}
		
		public function get TourName():String
		{
			return m_tourName;
		}

		public function get fee():Number
		{
			return m_fee;
		}


	}
}