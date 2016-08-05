package Message.event {

	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.invitation.Invitation;
	
	import flash.events.Event;

	public class InvitationReplyErrorEvent extends SFSGameEvent {

		protected var m_errorMessage :String;
		protected var m_errorCode :int;


		public function InvitationReplyErrorEvent() {
			super(SFSEvent.INVITATION_REPLY_ERROR);
		}

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent {
			m_errorMessage = sfse.params.errorMessage;
			m_errorCode = sfse.params.errorCode;
			return this;
		}
		
		override public function ToEvent():Event {
			return new Event(GetEventName());
		}
		
		override public function GetEventName(): String{
			return SFSEvent.INVITATION_REPLY_ERROR;
		}

		public function get ErrorMessage():String
		{
			return m_errorMessage;
		}

		public function get ErrorCode():int
		{
			return m_errorCode;
		}


	} // end class
} // end package