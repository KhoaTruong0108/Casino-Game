package Message.event {

	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.entities.data.ISFSObject;

	public class AdminMessage extends SFSGameEvent {

		protected var m_sender: User;
		protected var m_message: String;
		protected var m_data: ISFSObject;
		
		public function AdminMessage() {
			super(SFSEvent.ADMIN_MESSAGE);
		}

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			m_sender = sfse.params.sender;
			m_message = sfse.params.message;
			m_data = sfse.params.data;
			return this;
		}
		
		override public function GetEventName():String
		{
			return SFSEvent.ADMIN_MESSAGE;
		}

		public function get Sender():User
		{
			return m_sender;
		}

		public function set Sender(value:User):void
		{
			m_sender = value;
		}

		public function get Message():String
		{
			return m_message;
		}

		public function set Message(value:String):void
		{
			m_message = value;
		}

		public function get Data():ISFSObject
		{
			return m_data;
		}

		public function set Data(value:ISFSObject):void
		{
			m_data = value;
		}

		
	} // end class
} // end package