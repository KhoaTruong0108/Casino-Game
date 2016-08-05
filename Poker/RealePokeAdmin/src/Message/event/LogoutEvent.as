package Message.event {

	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	
	import flash.events.Event;

	public class LogoutEvent extends SFSGameEvent {
                                                                                                  
		public function LogoutEvent() {
			super(SFSEvent.LOGOUT);
		}

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			// TODO Auto Generated method stub
			return this;
		}
		
		override public function GetEventName():String
		{
			// TODO Auto Generated method stub
			return SFSEvent.LOGOUT;
		}
		
		override public function ToEvent():Event
		{
			// TODO Auto Generated method stub
			return this as Event;
		}
		
	} // end class
} // end package