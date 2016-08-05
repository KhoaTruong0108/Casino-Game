package Message.request {

	import Message.SFSGameRequest;
	
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.invitation.Invitation;
	import com.smartfoxserver.v2.requests.game.InvitationReplyRequest;
	import com.smartfoxserver.v2.requests.BaseRequest;
	import com.smartfoxserver.v2.requests.MessageRecipientMode;
	

	public class InviteUserReplyRequest extends SFSGameRequest {

		public function InviteUserReplyRequest(invitation:Invitation, invitationReply:int, params:ISFSObject = null) {
			m_request = new com.smartfoxserver.v2.requests.game.InvitationReplyRequest(invitation, invitationReply, params);
			m_name = SFS_REQUEST_NAME.INVITE_USER_REPLY_REQUEST;
		}
		
		override public function GetRequestName():String
		{
			// TODO Auto Generated method stub
			return SFS_REQUEST_NAME.INVITE_USER_REPLY_REQUEST;
		}
		
		override public function ToSFSRequest():BaseRequest{
			return m_request;
		}
	} // end class
} // end package