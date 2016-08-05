package Message.event.game.PokerTournament
{
	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import entity.PokerTournamentEntity;
	
	import mx.collections.ArrayList;

	public class TourAddedRes extends SFSGameEvent
	{
		private var _tourInfo: PokerTournamentEntity;		
		
		public function TourAddedRes() {
			super(POKER_TOUR_RESPONSE_NAME.TOUR_ADDED_RES);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_TOUR_RESPONSE_NAME.TOUR_ADDED_RES){
				throw new Error("Can't parse from " + sfse.type + " to TOUR_ADDED_RES");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(POKER_TOUR_RESPONSE_NAME.TOUR_ADDED_RES) as SFSObject;
			if(param == null){
				throw new Error("TOUR_ADDED_RES::FromSFSEvent Error");			
			}
			
			_tourInfo = new PokerTournamentEntity();
			_tourInfo.name = param.getUtfString("name");
			_tourInfo.displayName = param.getUtfString("display_name");
			_tourInfo.capacity = param.getInt("capacity");
			//tourObj.betChip = sfsTour.getDouble("bet_chip");
			_tourInfo.levelType = param.getDouble("level_type");
			_tourInfo.beginLevel = param.getDouble("begin_level");
			_tourInfo.endLevel = param.getDouble("end_level");
			_tourInfo.fee = param.getDouble("fee");
			_tourInfo.startingChip = param.getDouble("starting_chip");
			_tourInfo.firstPrize = param.getDouble("first_prize");
			_tourInfo.secondPrize = param.getDouble("second_prize");
			_tourInfo.thirdPrize = param.getDouble("third_prize");
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_TOUR_RESPONSE_NAME.TOUR_ADDED_RES;
		}

		public function get tourInfo():PokerTournamentEntity
		{
			return _tourInfo;
		}

		public function set tourInfo(value:PokerTournamentEntity):void
		{
			_tourInfo = value;
		}

	}
}