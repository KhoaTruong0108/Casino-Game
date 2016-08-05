package Message.event {

	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	
	import flash.events.Event;

	public class ConnectionEvent extends SFSGameEvent {

		protected var m_success: Boolean;
		
		public function ConnectionEvent() {
			super(SFSEvent.CONNECTION);
		}

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			m_success = sfse.params.success
			return this;
		}
		
		override public function ToEvent():Event {
			return new Event(GetEventName());
		}
		
		override public function GetEventName(): String{
			return SFSEvent.CONNECTION;
		}

		public function get Success():Boolean
		{
			return m_success;
		}

		public function set Success(value:Boolean):void
		{
			m_success = value;
		}

		
	} // end class
} // end package