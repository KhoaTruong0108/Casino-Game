package Message.request.general
{
	import Message.SFSCustomRequest;
	import Message.SFSGameRequest;
	import Message.event.general.GENERAL_EVENT_NAME;
	
	import com.smartfoxserver.v2.requests.BaseRequest;

	public class GetListFreeUserRequest extends SFSCustomRequest
	{
		public function GetListFreeUserRequest()
		{
			super(GENERAL_REQUEST_NAME.GET_LIST_FREE_USER_REQ);
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
		
		override public function ToSFSRequest():BaseRequest
		{
			return super.ToSFSRequest();
		}
		
	}
}