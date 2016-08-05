package Message.event.game.PokerTournament
{
	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import mx.collections.ArrayList;

	public class UserCountChangeRes extends SFSGameEvent
	{
		private var _tourName: String;
		private var _userCount: int;
		
		public function UserCountChangeRes() {
			super(POKER_TOUR_RESPONSE_NAME.USER_COUNT_CHANGE_RES);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_TOUR_RESPONSE_NAME.USER_COUNT_CHANGE_RES){
				throw new Error("Can't parse from " + sfse.type + " to USER_COUNT_CHANGE_RES");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(POKER_TOUR_RESPONSE_NAME.USER_COUNT_CHANGE_RES) as SFSObject;
			if(param == null){
				throw new Error("USER_COUNT_CHANGE_RES::FromSFSEvent Error");			
			}
			
			_tourName = param.getUtfString("tour_name");
			_userCount = param.getInt("user_count");

			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_TOUR_RESPONSE_NAME.USER_COUNT_CHANGE_RES;
		}

		public function get TourName():String
		{
			return _tourName;
		}

		public function get UserCount():int
		{
			return _userCount;
		}


	}
}