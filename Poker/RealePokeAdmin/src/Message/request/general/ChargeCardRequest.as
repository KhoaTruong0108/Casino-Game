package Message.request.general
{
	import Message.SFSCustomRequest;
	import Message.SFSGameRequest;
	import Message.event.general.GENERAL_EVENT_NAME;
	
	import com.smartfoxserver.v2.requests.BaseRequest;

	public class ChargeCardRequest extends SFSCustomRequest
	{
		public static var SERIAL_NUMBER: String = "serial_number";
		public static var CARD_PASS: String = "card_pass";
		public function ChargeCardRequest()
		{
			super(GENERAL_REQUEST_NAME.CHARGE_CARD_REQ);
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