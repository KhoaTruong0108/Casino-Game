package Message.event {
	
	import Message.SFSGameEvent;
	import entity.UserInfo;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.entities.variables.UserVariable;
	
	import flash.events.Event;
	
	public class UserVariableUpdateEvent extends SFSGameEvent {
		
		protected var m_user:User;
		
		protected var m_changedVars:Array;
		
		
		public function UserVariableUpdateEvent() {
			super(SFSEvent.USER_VARIABLES_UPDATE);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent {
			m_user = sfse.params.user;
			m_changedVars = sfse.params.changedVars;
			
			return this;
		}
		
		override public function ToEvent():Event {
			return new Event(GetEventName());
		}
		
		override public function GetEventName(): String{
			return SFSEvent.USER_VARIABLES_UPDATE;
		}
		
		public function get userInfo():User
		{
			return m_user;
		}
		
		public function set userInfo(value:User):void
		{
			m_user = value;
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