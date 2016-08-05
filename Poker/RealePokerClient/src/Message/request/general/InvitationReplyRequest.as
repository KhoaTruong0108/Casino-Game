package Message.request.general
{
	import Message.SFSCustomRequest;
	import Message.SFSGameRequest;
	import Message.event.general.GENERAL_EVENT_NAME;
	
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.requests.BaseRequest;

	public class InvitationReplyRequest extends SFSCustomRequest
	{
		protected var m_invitationReply: int;
		protected var m_receiverName: String;
		
		public function InvitationReplyRequest()
		{
			super(GENERAL_REQUEST_NAME.INVITATION_REPLY_REQ);
		}
		
		override public function AddParam(key:String, value:*):SFSCustomRequest
		{
			return super.AddParam(key, value);
		}
		public function ToSFSObject():SFSObject{
			var obj: SFSObject = new SFSObject();
			
			obj.putInt("invitation_reply",m_invitationReply);
			obj.putUtfString("receiver_name",m_receiverName);
			
			return obj;
		}
		
		override public function SetName(name:String):SFSCustomRequest
		{
			m_name = name;
			return this;
		}
		
		override public function ToSFSRequest():BaseRequest
		{
			return super.ToSFSRequest();
		}

		public function get InvitationReply():int
		{
			return m_invitationReply;
		}

		public function set InvitationReply(value:int):void
		{
			m_invitationReply = value;
		}

		public function get ReceiverName():String
		{
			return m_receiverName;
		}

		public function set ReceiverName(value:String):void
		{
			m_receiverName = value;
		}

		
	}
}