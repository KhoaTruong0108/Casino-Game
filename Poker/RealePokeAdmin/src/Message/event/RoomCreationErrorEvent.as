package Message.event {

	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	
	import flash.events.Event;

	public class RoomCreationErrorEvent extends SFSGameEvent {

		protected var m_errorMessage:String;

		protected var m_errorCode:int;


		public function RoomCreationErrorEvent() {
			super(SFSEvent.ROOM_CREATION_ERROR);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent {
			m_errorMessage = sfse.params.errorMessage;
			m_errorCode = sfse.params.errorCode;
			return this;
		}
		
		override public function ToEvent():Event {
			return new Event(GetEventName());
		}
		
		override public function GetEventName(): String{
			return SFSEvent.ROOM_CREATION_ERROR;
		}

		public function get ErrorMessage():String
		{
			return m_errorMessage;
		}

		public function set ErrorMessage(value:String):void
		{
			m_errorMessage = value;
		}

		public function get ErrorCode():int
		{
			return m_errorCode;
		}

		public function set ErrorCode(value:int):void
		{
			m_errorCode = value;
		}


	} // end class
} // end package