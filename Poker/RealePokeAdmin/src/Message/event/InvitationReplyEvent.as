package Message.event {

	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	
	import flash.events.Event;

	public class InvitationReplyEvent extends SFSGameEvent {

		protected var m_invitee:User;

		protected var m_reply:int;

		protected var m_data:ISFSObject;


		public function InvitationReplyEvent() {
			super(SFSEvent.INVITATION_REPLY);
		}

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent {
			m_invitee = sfse.params.invitee;
			m_reply = sfse.params.reply;
			m_data = sfse.params.data;
			return this;
		}
		
		override public function ToEvent():Event {
			return new Event(GetEventName());
		}
		
		override public function GetEventName(): String{
			return SFSEvent.INVITATION_REPLY;
		}

		public function get Invitee():User
		{
			return m_invitee;
		}

		public function get Reply():int
		{
			return m_reply;
		}

		public function get Data():ISFSObject
		{
			return m_data;
		}


	} // end class
} // end package