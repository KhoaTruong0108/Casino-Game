package Message.event.general
{
	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import flash.events.Event;

	public class InvitationCusEvent extends SFSGameEvent
	{
		protected var m_userInvite: String; 
		protected var m_roomId: int; 
		protected var m_message: String; 
		
		public function InvitationCusEvent()
		{
			super(GENERAL_EVENT_NAME.INVITATION_RES);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != GENERAL_EVENT_NAME.INVITATION_RES){
				throw new Error("Can't parse from " + sfse.type + " to InvitationEvent");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(GENERAL_EVENT_NAME.INVITATION_RES) as SFSObject;			
			
			if(param == null){
				throw new Error("InvitationEvent::FromSFSEvent Error");			
			}
			m_userInvite = param.getUtfString("user_invite");
			m_roomId = param.getInt("room_id");
			m_message = param.getUtfString("message");
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return GENERAL_EVENT_NAME.INVITATION_RES;
		}
		
		override public function ToEvent():Event
		{
			return new Event(GetEventName());
		}

		public function get UserInvite():String
		{
			return m_userInvite;
		}

		public function set UserInvite(value:String):void
		{
			m_userInvite = value;
		}

		public function get RoomId():int
		{
			return m_roomId;
		}

		public function set RoomId(value:int):void
		{
			m_roomId = value;
		}

		public function get Message():String
		{
			return m_message;
		}

		public function set Message(value:String):void
		{
			m_message = value;
		}

		
	}
}