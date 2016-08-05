package Message.event {

	import Message.SFSGameEvent;
	import entity.AdminEntity;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	
	import flash.events.Event;

	public class LoginEvent extends SFSGameEvent {

		protected var m_user:User;
		protected var m_data: ISFSObject;


		public function LoginEvent() {
			super(SFSEvent.LOGIN);
		}

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			m_user = sfse.params.user;
			m_data = sfse.params.data;
			return this;			
		}
		
		override public function GetEventName():String
		{
			return SFSEvent.LOGIN;
		}
		override public function ToEvent():Event{
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