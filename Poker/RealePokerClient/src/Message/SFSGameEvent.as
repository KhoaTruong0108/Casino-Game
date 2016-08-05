package Message {
	import Message.event.general.GENERAL_EVENT_NAME;
	import zUtilities.*;
	
	import com.smartfoxserver.v2.core.BaseEvent;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class SFSGameEvent extends Event implements IGameEvent{
		
		public function SFSGameEvent(type :String ){
			super(type);
			
		}
		public function GetEventName():String
		{
			return GENERAL_EVENT_NAME.CHARGE_CARD_RES;
		}
		public function FromSFSEvent(sfse: SFSEvent): SFSGameEvent{
			return this;
		}
		public function ToEvent(): Event{
			return this;
		}
		
	} // end class
} // end package