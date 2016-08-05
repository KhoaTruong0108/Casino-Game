package Message.event {

	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	
	import flash.events.Event;

	public class ConnectionLostEvent extends SFSGameEvent {

		protected var m_reason:String;

		public function ConnectionLostEvent() {
			super(SFSEvent.CONNECTION_LOST);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			m_reason = sfse.params.reason;
			return this;
		}
		
		override public function ToEvent():Event {
			return new Event(GetEventName());
		}
		
		override public function GetEventName():String
		{
			// TODO Auto Generated method stub
			return SFSEvent.CONNECTION_LOST;
		}

		public function get Reason():String
		{
			return m_reason;
		}

		public function set Reason(value:String):void
		{
			m_reason = value;
		}

	} // end class
} // end package