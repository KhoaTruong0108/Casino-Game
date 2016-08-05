package Message.event {

	import Message.SFSGameEvent;
	import entity.RoomEntity;
	import entity.UserEntity;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.entities.User;
	
	import flash.events.Event;

	public class UserExitRoomEvent extends SFSGameEvent {

		protected var m_user:User;

		protected var m_room:Room;


		public function UserExitRoomEvent() {
			super(SFSEvent.USER_EXIT_ROOM);
		}
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent {
			m_room = sfse.params.room;
			m_user = sfse.params.user;
			return this;
		}
		
		override public function ToEvent():Event {
			return new Event(GetEventName());
		}
		
		override public function GetEventName(): String{
			return SFSEvent.USER_EXIT_ROOM;
		}

		public function get UserInfo():User
		{
			return m_user;
		}

		public function set UserInfo(value:User):void
		{
			m_user = value;
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