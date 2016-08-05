package Message.event.game.PokerTournament
{
	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import mx.collections.ArrayList;

	public class InviteTourRes extends SFSGameEvent
	{
		private var _tourName: String;
		private var _time: int;
		
		public function InviteTourRes() {
			super(POKER_TOUR_RESPONSE_NAME.INVITE_TOUR);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_TOUR_RESPONSE_NAME.INVITE_TOUR){
				throw new Error("Can't parse from " + sfse.type + " to INVITE_TOUR");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(POKER_TOUR_RESPONSE_NAME.INVITE_TOUR) as SFSObject;
			if(param == null){
				throw new Error("INVITE_TOUR::FromSFSEvent Error");			
			}
			
			_tourName = param.getUtfString("tour_name");
			_time = param.getInt("time");

			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_TOUR_RESPONSE_NAME.INVITE_TOUR;
		}

		public function get TourName():String
		{
			return _tourName;
		}

		public function get Time():int
		{
			return _time;
		}


	}
}