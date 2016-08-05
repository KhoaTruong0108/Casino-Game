package Message.event {

	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	
	import flash.events.Event;

	public class ConfigLoadSuccessEvent extends SFSGameEvent {

		public function ConfigLoadSuccessEvent() {
			super(SFSEvent.CONFIG_LOAD_SUCCESS);
		}
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent {
			return this;
		}
		override public function ToEvent():Event {
			return new Event(GetEventName());
		}
		
		override public function GetEventName(): String{
			return SFSEvent.CONFIG_LOAD_SUCCESS;
		}
	} // end class
} // end package