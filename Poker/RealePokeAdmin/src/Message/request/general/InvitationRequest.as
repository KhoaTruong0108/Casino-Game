package Message.request.general
{
	import Message.SFSCustomRequest;
	import Message.SFSGameRequest;
	import Message.event.general.GENERAL_EVENT_NAME;
	
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.requests.BaseRequest;
	
	import mx.collections.ArrayList;

	public class InvitationRequest extends SFSCustomRequest
	{
		protected var m_listInviteUser: ArrayList;//ArrayList<String>
		protected var m_roomId: int;
		protected var m_message: String;
		
		public function InvitationRequest()
		{
			super(GENERAL_REQUEST_NAME.INVITATION_REQ);
		}
		
		override public function AddParam(key:String, value:*):SFSCustomRequest
		{
			return super.AddParam(key, value);
		}
		
		override public function SetName(name:String):SFSCustomRequest
		{
			m_name = name;
			return this;
		}
		public function ToSFSObject():SFSObject{
			var obj: SFSObject = new SFSObject();
			
			obj.putInt("room_id",m_roomId);
			obj.putUtfString("message",m_message);
			
			var sfsArray: SFSArray = new SFSArray();
			for(var i:int = 0; i< m_listInviteUser.length; i++){
				sfsArray.addUtfString(m_listInviteUser.getItemAt(i) as String);
			}
			obj.putSFSArray("list_invite_user", sfsArray);
			
			return obj;
		}
		override public function ToSFSRequest():BaseRequest
		{
			return super.ToSFSRequest();
		}

		public function get ListInviteUser():ArrayList
		{
			return m_listInviteUser;
		}

		public function set ListInviteUser(value:ArrayList):void
		{
			m_listInviteUser = value;
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