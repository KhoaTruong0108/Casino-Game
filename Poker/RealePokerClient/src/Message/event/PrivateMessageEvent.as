package Message.event {

	import Message.SFSGameEvent;
	import entity.UserEntity;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	
	import flash.events.Event;

	public class PrivateMessageEvent extends SFSGameEvent {

		protected var m_sender:UserEntity;

		protected var m_message:String;

		protected var m_data:ISFSObject;


		public function PrivateMessageEvent() {
			super(SFSEvent.PRIVATE_MESSAGE);
		}
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent {
			m_sender = sfse.params.sender;
			m_message = sfse.params.message;
			m_data = sfse.params.data;
			return this;
		}
		
		override public function ToEvent():Event {
			return new Event(GetEventName());
		}
		
		override public function GetEventName(): String{
			return SFSEvent.PRIVATE_MESSAGE;
		}
		
		public function get Sender():UserEntity
		{
			return m_sender;
		}
		
		public function set Sender(value:UserEntity):void
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