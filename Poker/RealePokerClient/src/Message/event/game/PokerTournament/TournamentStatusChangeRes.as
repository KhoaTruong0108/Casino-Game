package Message.event.game.PokerTournament
{
	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import mx.collections.ArrayList;

	public class TournamentStatusChangeRes extends SFSGameEvent
	{
		private var _Name: String;
		private var _Status: String;
		
		public function TournamentStatusChangeRes() {
			super(POKER_TOUR_RESPONSE_NAME.TOURNAMENT_STATUS_CHANGE_RES);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_TOUR_RESPONSE_NAME.TOURNAMENT_STATUS_CHANGE_RES){
				throw new Error("Can't parse from " + sfse.type + " to TOURNAMENT_STATUS_CHANGE_RES");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(POKER_TOUR_RESPONSE_NAME.TOURNAMENT_STATUS_CHANGE_RES) as SFSObject;
			if(param == null){
				throw new Error("TOURNAMENT_STATUS_CHANGE_RES::FromSFSEvent Error");			
			}
			
			_Name = param.getUtfString("name");
			_Status = param.getUtfString("status");
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_TOUR_RESPONSE_NAME.TOURNAMENT_STATUS_CHANGE_RES;
		}

		public function get Name():String
		{
			return _Name;
		}


		public function get Status():String
		{
			return _Status;
		}
	}
}