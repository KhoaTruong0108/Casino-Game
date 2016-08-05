package Message.request.game.pokertexas {

	import Message.SFSCustomRequest;
	import Message.SFSGameRequest;
	
	import com.smartfoxserver.v2.requests.BaseRequest;

	public class StandUpRequest extends SFSCustomRequest
	{
		public function StandUpRequest()
		{
			super(POKER_REQUEST_NAME.STAND_UP_REQ);
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