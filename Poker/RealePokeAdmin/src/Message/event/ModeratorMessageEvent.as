package Message.event {

	import Message.SFSGameEvent;
	import entity.AdminEntity;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	
	import flash.events.Event;

	public class ModeratorMessageEvent extends SFSGameEvent {

		protected var m_sender:AdminEntity;

		protected var m_message:String;

		protected var m_data:ISFSObject;


		public function ModeratorMessageEvent() {
			super(SFSEvent.MODERATOR_MESSAGE);
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
			return SFSEvent.MODERATOR_MESSAGE;
		}

		public function get Sender():AdminEntity
		{
			return m_sender;
		}

		public function set Sender(value:AdminEntity):void
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