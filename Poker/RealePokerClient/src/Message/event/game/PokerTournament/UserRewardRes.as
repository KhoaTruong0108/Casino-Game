package Message.event.game.PokerTournament
{
	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import mx.collections.ArrayList;

	public class UserRewardRes extends SFSGameEvent
	{
		private var m_prize: Number;
		private var m_tourName: String;
		
		public function UserRewardRes() {
			super(POKER_TOUR_RESPONSE_NAME.USER_REWARD_RES);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_TOUR_RESPONSE_NAME.USER_REWARD_RES){
				throw new Error("Can't parse from " + sfse.type + " to USER_REWARD_RES");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(POKER_TOUR_RESPONSE_NAME.USER_REWARD_RES) as SFSObject;
			if(param == null){
				throw new Error("USER_REWARD_RES::FromSFSEvent Error");			
			}
			
			m_prize = param.getDouble("prize");
			m_tourName = param.getUtfString("tour_name");
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_TOUR_RESPONSE_NAME.USER_REWARD_RES;
		}

		public function get Prize():Number
		{
			return m_prize;
		}

		public function get TourName():String
		{
			return m_tourName;
		}


	}
}