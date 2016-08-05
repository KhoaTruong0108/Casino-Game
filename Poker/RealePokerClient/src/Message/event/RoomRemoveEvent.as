package Message.event {

	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.Room;
	
	import flash.events.Event;

	public class RoomRemoveEvent extends SFSGameEvent {

		protected var m_room : Room;


		public function RoomRemoveEvent() {
			super(SFSEvent.ROOM_REMOVE);
		}

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent {
			m_room = sfse.params.room;
			return this;
		}
		
		override public function ToEvent():Event {
			return new Event(GetEventName());
		}
		
		override public function GetEventName(): String{
			return SFSEvent.ROOM_REMOVE;
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