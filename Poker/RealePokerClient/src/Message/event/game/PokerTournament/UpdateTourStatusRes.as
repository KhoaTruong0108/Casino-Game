package Message.event.game.PokerTournament
{
	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import mx.collections.ArrayList;

	public class UpdateTourStatusRes extends SFSGameEvent
	{
		private var _name: String;
		private var _status: String;
		
		public function UpdateTourStatusRes() {
			super(POKER_TOUR_RESPONSE_NAME.UPDATE_TOUR_STATUS_RES);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_TOUR_RESPONSE_NAME.UPDATE_TOUR_STATUS_RES){
				throw new Error("Can't parse from " + sfse.type + " to ACTIVE_TOUR_RES");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(POKER_TOUR_RESPONSE_NAME.UPDATE_TOUR_STATUS_RES) as SFSObject;
			if(param == null){
				throw new Error("ACTIVE_TOUR_RES::FromSFSEvent Error");			
			}
			
			_name = param.getUtfString("name");
			_status = param.getUtfString("status");
			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_TOUR_RESPONSE_NAME.UPDATE_TOUR_STATUS_RES;
		}


		public function get name():String
		{
			return _name;
		}

		public function get status():String
		{
			return _status;
		}

	}
}