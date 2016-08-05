package Message.request.game.pokertexas {

	import Message.SFSCustomRequest;
	import Message.SFSGameRequest;
	
	import com.smartfoxserver.v2.requests.BaseRequest;

	public class GoingAllInRequest extends SFSCustomRequest
	{
		public function GoingAllInRequest()
		{
			super(POKER_REQUEST_NAME.GOING_ALL_REQ);
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
		
	} // end class
} // end package