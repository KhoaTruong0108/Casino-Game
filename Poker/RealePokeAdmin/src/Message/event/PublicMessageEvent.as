package Message.event {

	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import entity.AdminEntity;

	public class PublicMessageEvent extends SFSGameEvent {

		
		protected var m_sender:User;
		protected var m_message:String;
		protected var m_room: Room;
		

		public function PublicMessageEvent() {
			super(SFSEvent.PUBLIC_MESSAGE);
		}

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent{
			m_message = sfse.params.message;
			m_sender = sfse.params.sender;
			m_room = sfse.params.room as Room;
			return this;
		}
		
		override public function GetEventName():String
		{
			return SFSEvent.PUBLIC_MESSAGE;
		}

		public function get Message():String
		{
			return m_message;
		}

		public function set Message(value:String):void
		{
			m_message = value;
		}

		public function get Sender():User
		{
			return m_sender;
		}

		public function set Sender(value:User):void
		{
			m_sender = value;
		}

		public function get RoomInfo():Room
		{
			return m_room;
		}

		
	} // end class
} // end package