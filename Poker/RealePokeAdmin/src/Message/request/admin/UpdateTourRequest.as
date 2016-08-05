package Message.request.admin
{
	import Message.SFSCustomRequest;
	
	import com.smartfoxserver.v2.requests.BaseRequest;

	public class UpdateTourRequest extends SFSCustomRequest
	{
		public function UpdateTourRequest()
		{	
			super(ADMIN_REQUEST_NAME.UPDATE_TOUR_REQ);
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