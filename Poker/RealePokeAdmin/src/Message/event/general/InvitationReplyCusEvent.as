package Message.event.general
{
	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import flash.events.Event;

	public class InvitationReplyCusEvent extends SFSGameEvent
	{
		private var m_invitationReply: int; //0: ACCEPT; 1: REFUSE
		private var m_userReply: String;
		
		public function InvitationReplyCusEvent()
		{
			super(GENERAL_EVENT_NAME.INVITATION_REPLY_RES);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != GENERAL_EVENT_NAME.INVITATION_REPLY_RES){
				throw new Error("Can't parse from " + sfse.type + " to InvitationReplyEvent");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(GENERAL_EVENT_NAME.INVITATION_RES) as SFSObject;			
			
			if(param == null){
				throw new Error("InvitationReplyEvent::FromSFSEvent Error");			
			}
			m_invitationReply = param.getInt("invitation_reply");
			m_userReply = param.getUtfString("user_reply");
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return GENERAL_EVENT_NAME.INVITATION_REPLY_RES;
		}
		
		override public function ToEvent():Event
		{
			return new Event(GetEventName());
		}

		public function get InvitationReply():int
		{
			return m_invitationReply;
		}

		public function set InvitationReply(value:int):void
		{
			m_invitationReply = value;
		}

		public function get UserReply():String
		{
			return m_userReply;
		}

		public function set UserReply(value:String):void
		{
			m_userReply = value;
		}

		
	}
}