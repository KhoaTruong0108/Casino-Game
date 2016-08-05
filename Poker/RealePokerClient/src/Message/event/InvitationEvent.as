//
//
package Message.event {

	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.invitation.Invitation;
	
	import flash.events.Event;

	public class InvitationEvent extends SFSGameEvent {

		protected var m_invitation:Invitation;


		public function InvitationEvent() {
			super(SFSEvent.INVITATION);
		}

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent {
			m_invitation = sfse.params.invitation;
			return this;
		}
		
		override public function ToEvent():Event {
			return new Event(GetEventName());
		}
		
		override public function GetEventName(): String{
			return SFSEvent.INVITATION;
		}

		public function get InvitationInfo():Invitation
		{
			return m_invitation;
		}


	} // end class
} // end package