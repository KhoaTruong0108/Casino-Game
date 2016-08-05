package Message.event.game.PokerTournament
{
	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import mx.collections.ArrayList;

	public class UnregistrationRes extends SFSGameEvent
	{
		private var m_userName: String;
		private var m_tourName: String;
		private var m_tourStatus: String;
		private var m_fee: Number;
		
		public function UnregistrationRes() {
			super(POKER_TOUR_RESPONSE_NAME.UNREGISTRATION);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_TOUR_RESPONSE_NAME.UNREGISTRATION){
				throw new Error("Can't parse from " + sfse.type + " to UNREGISTRATION");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(POKER_TOUR_RESPONSE_NAME.UNREGISTRATION) as SFSObject;
			if(param == null){
				throw new Error("UNREGISTRATION::FromSFSEvent Error");			
			}

			m_userName = param.getUtfString("user_name");
			m_tourName = param.getUtfString("tour_name");
			m_tourStatus = param.getUtfString("tour_status");
			m_fee = param.getDouble("fee");
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_TOUR_RESPONSE_NAME.UNREGISTRATION;
		}

		public function get UserName():String
		{
			return m_userName;
		}

		public function get TourName():String
		{
			return m_tourName;
		}

		public function get TourStatus():String
		{
			return m_tourStatus;
		}

		public function get fee():Number
		{
			return m_fee;
		}


	}
}