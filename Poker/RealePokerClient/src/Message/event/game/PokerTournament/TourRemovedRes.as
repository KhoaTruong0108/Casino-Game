package Message.event.game.PokerTournament
{
	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import entity.PokerTournamentEntity;
	
	import mx.collections.ArrayList;

	public class TourRemovedRes extends SFSGameEvent
	{
		private var _name: String;		
		
		public function TourRemovedRes() {
			super(POKER_TOUR_RESPONSE_NAME.TOUR_DELETE_RES);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_TOUR_RESPONSE_NAME.TOUR_DELETE_RES){
				throw new Error("Can't parse from " + sfse.type + " to TOUR_DELETE_RES");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(POKER_TOUR_RESPONSE_NAME.TOUR_DELETE_RES) as SFSObject;
			if(param == null){
				throw new Error("TOUR_DELETE_RES::FromSFSEvent Error");			
			}
			
			_name = param.getUtfString("name");
			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_TOUR_RESPONSE_NAME.TOUR_DELETE_RES;
		}


		public function get name():String
		{
			return _name;
		}
	}
}