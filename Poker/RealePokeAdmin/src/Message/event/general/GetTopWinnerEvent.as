package Message.event.general
{
	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import flash.events.Event;

	public class GetTopWinnerEvent extends SFSGameEvent
	{
		protected var m_topWinnerList: Array;
		public function GetTopWinnerEvent()
		{
			super(GENERAL_EVENT_NAME.GET_TOP_WINNER);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != GENERAL_EVENT_NAME.GET_TOP_WINNER){
				throw new Error("Can't parse from " + sfse.type + " to GetTopWinnerEvent");			
			}
			var param : SFSObject = sfse.params.params as SFSObject;
			if(param == null){
				throw new Error("GetTopWinnerEvent::FromSFSEvent Error");			
			}
			//m_topWinnerList = param.get(EVENT_PARAMS_NAME.TOP_WINNER_LIST);
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return GENERAL_EVENT_NAME.GET_TOP_WINNER;
		}
		
		override public function ToEvent():Event
		{
			return new Event(GetEventName());
		}
		
	}
}