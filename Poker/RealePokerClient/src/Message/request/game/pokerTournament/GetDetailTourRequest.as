package Message.request.game.pokerTournament
{
	import Message.SFSCustomRequest;
	
	import com.smartfoxserver.v2.requests.BaseRequest;

	public class GetDetailTourRequest extends SFSCustomRequest
	{
		public static var TOUR_NAME: String = "tour_name";
		public function GetDetailTourRequest()
		{
			super(POKER_TOUR_REQUEST_NAME.GET_DETAIL_TOUR);
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