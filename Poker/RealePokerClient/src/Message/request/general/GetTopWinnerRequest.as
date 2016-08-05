package Message.request.general
{
	import Message.SFSCustomRequest;
	import Message.SFSGameRequest;
	import Message.event.general.GENERAL_EVENT_NAME;
	
	import com.smartfoxserver.v2.requests.BaseRequest;

	public class GetTopWinnerRequest extends SFSCustomRequest
	{
		public static var TOP_WINNER_QUANTITY: String = "top_winner_quantity";
		public function GetTopWinnerRequest()
		{
			super(GENERAL_REQUEST_NAME.GET_TOP_WINNER_REQ);
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