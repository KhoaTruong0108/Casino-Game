package Message.event {

	import Message.SFSGameEvent;
	import entity.RoomEntity;
	import entity.UserEntity;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.entities.SFSRoom;
	import com.smartfoxserver.v2.entities.SFSUser;
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import flash.events.Event;

	public class UserEnterRoomEvent extends SFSGameEvent {
		protected var m_user: User;
		protected var m_room: Room;
		public function UserEnterRoomEvent() {
			super(SFSEvent.USER_ENTER_ROOM);
		}

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			m_room = sfse.params.room as SFSRoom;
			m_user = sfse.params.user as SFSUser;
			return this;
		}
		
		override public function GetEventName():String
		{
			return SFSEvent.USER_ENTER_ROOM;
		}
		
		override public function ToEvent():Event
		{
			return new Event(GetEventName());
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