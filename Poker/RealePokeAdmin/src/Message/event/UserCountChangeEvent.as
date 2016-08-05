package Message.event {

	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.Room;
	
	import flash.events.Event;

	public class UserCountChangeEvent extends SFSGameEvent {

		protected var m_room:Room;

		protected var m_sCount:int;

		protected var m_uCount:int;


		public function UserCountChangeEvent() {
			super(SFSEvent.USER_COUNT_CHANGE);
		}

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent {
			m_room = sfse.params.room;
			m_sCount = sfse.params.sCount;
			m_uCount = sfse.params.uCount;
			return this;
		}
		
		override public function ToEvent():Event {
			return new Event(GetEventName());
		}
		
		override public function GetEventName(): String{
			return SFSEvent.USER_COUNT_CHANGE;
		}

		public function get sCount():int
		{
			return m_sCount;
		}

		public function set sCount(value:int):void
		{
			m_sCount = value;
		}

		public function get uCount():int
		{
			return m_uCount;
		}

		public function set uCount(value:int):void
		{
			m_uCount = value;
		}

		public function get RoomInfo():Room
		{
			return m_room;
		}

		public function set RoomInfo(value:Room):void
		{
			m_room = value;
		}


	} // end class
} // end package