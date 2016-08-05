package Message.event {

	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.Room;
	
	import flash.events.Event;

	public class RoomVariableUpdateEvent extends SFSGameEvent {

		protected var m_room:Room;
	
		protected var m_changedVars:Array;


		public function RoomVariableUpdateEvent() {
			super(SFSEvent.ROOM_VARIABLES_UPDATE);
		}

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent {
			m_room = sfse.params.room as Room;
			m_changedVars = sfse.params.changedVars as Array;
			return this;
		}
		
		override public function ToEvent():Event {
			return new Event(GetEventName());
		}
		
		override public function GetEventName(): String{
			return SFSEvent.ROOM_VARIABLES_UPDATE;
		}

		public function get RoomInfo():Room
		{
			return m_room;
		}

		public function set RoomInfo(value:Room):void
		{
			m_room = value;
		}

		public function get ChangedVars():Array
		{
			return m_changedVars;
		}

		public function set ChangedVars(value:Array):void
		{
			m_changedVars = value;
		}


	} // end class
} // end package