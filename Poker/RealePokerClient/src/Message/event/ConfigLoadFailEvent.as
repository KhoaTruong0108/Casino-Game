package Message.event {

	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.exceptions.SFSError;
	
	import flash.events.Event;

	public class ConfigLoadFailEvent extends SFSGameEvent {

		public function ConfigLoadFailEvent() {
			super(SFSEvent.CONFIG_LOAD_FAILURE);
		}

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent {
			return this;
		}
		override public function ToEvent():Event {
			return new Event(GetEventName());
		}
		
		override public function GetEventName(): String{
			return SFSEvent.CONFIG_LOAD_FAILURE;
		}
	} // end class
} // end package