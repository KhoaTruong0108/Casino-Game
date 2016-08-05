package model
{	

	public class M_Login
	{
		[Bindable]
		private var m_strUserName : String;
		[Bindable]
		private var m_strPassword: String;
		[Bindable]
		private var m_strStatus : String;
		private var m_isConnected:Boolean;
		
		private static var m_instance : M_Login = null;
		private static var m_isAllowed : Boolean = false;
		public function M_Login(){
			if(m_isAllowed == false)
				throw new Error("Please User GetInstance Method Instead");
			//Init value
			//m_strUserName = "u1";
			//m_strPassword = "123456";
			m_strStatus = "";
			m_isConnected = false;
		}

		

		public static function getInstance():M_Login{
			if(m_instance == null)
			{
				m_isAllowed = true;
				m_instance = new M_Login();
				m_isAllowed = false;
			}
			return m_instance;
		}
		/** GETTER & SETTER **/
		
		[Bindable]
		public function get UserName():String
		{
			return m_strUserName;
		}
		public function set UserName(value:String):void
		{
			m_strUserName = value;
		}
		
		[Bindable]
		public function get Password():String
		{
			return m_strPassword;
		}

		public function set Password(value:String):void
		{
			m_strPassword = value;
		}
		[Bindable]
		public function get Status():String
		{
			return m_strStatus;
		}

		public function set Status(value:String):void
		{
			m_strStatus = value;
		}

		[Bindable]
		public function get isConnected():Boolean
		{
			return m_isConnected;
		}

		public function set isConnected(value:Boolean):void
		{
			m_isConnected = value;
		}

	}
}