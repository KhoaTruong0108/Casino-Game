package Message
{
	import com.smartfoxserver.v2.entities.data.ISFSArray;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.requests.BaseRequest;
	import com.smartfoxserver.v2.requests.ExtensionRequest;
	
	import mx.states.OverrideBase;

	public class SFSCustomRequest extends SFSGameRequest
	{
		protected var m_obj : SFSObject;
		public function SFSCustomRequest(name: String = null)
		{
			m_name = name;	
			m_obj = new SFSObject();
		}
		public function SetName(name: String): SFSCustomRequest{
			m_name = name;
			return this;
		}
		//Tạm thời chỉ hỗ trợ value kiểu: int, string, number, value, SFSArray, SFSObject
		public function AddParam(key:String,value:*):SFSCustomRequest{
			if(value is Number){
				m_obj.putDouble(key,value);
			}else if(value is int){
				m_obj.putInt(key,value);
			}else if(value is String){
				m_obj.putUtfString(key,value);
			}else if(value is Boolean){
				m_obj.putBool(key,value);
			}else if(value is ISFSArray){
				m_obj.putSFSArray(key, value);
			}else if(value is ISFSObject){
				m_obj.putSFSObject(key,value);
			}
			else{
			m_obj.putClass(key,value);
			}
			return this;
		}
		override public function ToSFSRequest():BaseRequest
		{
			if(m_request == null)
				m_request = new ExtensionRequest(m_name, m_obj);
			return m_request;
		}
	}
}