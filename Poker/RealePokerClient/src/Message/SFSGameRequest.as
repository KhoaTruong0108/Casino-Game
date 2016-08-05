package Message {
	import com.smartfoxserver.v2.*;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.requests.BaseRequest;
	import com.smartfoxserver.v2.requests.ExtensionRequest;
	import com.smartfoxserver.v2.requests.IRequest;
	
	
	public class SFSGameRequest implements IGameRequest{
		protected var m_request : BaseRequest;
		protected var m_name : String;
		
		public function SFSGameRequest(){						
		}

		public function GetRequestName():String
		{			
			return m_name;
		}
		
		public function ToSFSRequest():BaseRequest{
			return m_request;
		}
	} // end class
} // end package