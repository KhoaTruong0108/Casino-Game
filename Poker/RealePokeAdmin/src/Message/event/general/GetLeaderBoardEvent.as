package Message.event.general
{
	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import flash.events.Event;

	public class GetLeaderBoardEvent extends SFSGameEvent
	{
		protected var m_leaderBoardList: Array;
		public function GetLeaderBoardEvent()
		{
			super(GENERAL_EVENT_NAME.GET_LEADER_BOARD);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != GENERAL_EVENT_NAME.GET_LEADER_BOARD){
				throw new Error("Can't parse from " + sfse.type + " to GetLeaderBoardEvent");			
			}
			var param : SFSObject = sfse.params.params as SFSObject;
			if(param == null){
				throw new Error("GetTopWinnerEvent::FromSFSEvent Error");			
			}
			m_leaderBoardList = param.getDouble(EVENT_PARAMS_NAME.TOP_WINNER_LIST);
			
			return this;
		}
		
		override public function GetEventName():String
		{
			// TODO Auto Generated method stub
			return GENERAL_EVENT_NAME.GET_LEADER_BOARD;
		}
		
		override public function ToEvent():Event
		{
			// TODO Auto Generated method stub
			return new Event(GetEventName);
		}
		
	}
}