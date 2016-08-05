package model
{	

	public class M_Registry
	{
		private var m_strUserName : String;
		private var m_strUserNameValid : String;
		private var m_strPassword: String;
		private var m_strPasswordValid: String;
		private var m_strConfirmPass: String;
		private var m_strConfirmPassValid: String;
		private var m_strEmail: String;
		private var m_strEmailValid: String;
		private var m_strStatus : String;
		private var m_strAvatar : String;
		private var m_isEmailValid : Boolean;
		
		private static var m_instance : M_Registry = null;
		private static var m_isAllowed : Boolean = false;
		public function M_Registry(){
			if(m_isAllowed == false)
				throw new Error("Please User GetInstance Method Instead");
			//Init value
			//m_strUserName = "u1";
			//m_strPassword = "123456";
			m_strStatus = "";
		}

		

		public static function getInstance():M_Registry{
			if(m_instance == null)
			{
				m_isAllowed = true;
				m_instance = new M_Registry();
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
		public function get ConfirmPass():String
		{
			return m_strConfirmPass;
		}

		public function set ConfirmPass(value:String):void
		{
			m_strConfirmPass = value;
		}

		[Bindable]
		public function get Email():String
		{
			return m_strEmail;
		}

		public function set Email(value:String):void
		{
			m_strEmail = value;
		}

		[Bindable]
		public function get ConfirmPassValid():String
		{
			return m_strConfirmPassValid;
		}

		public function set ConfirmPassValid(value:String):void
		{
			m_strConfirmPassValid = value;
		}

		[Bindable]
		public function get EmailValid():String
		{
			return m_strEmailValid;
		}

		public function set EmailValid(value:String):void
		{
			m_strEmailValid = value;
		}

		[Bindable]
		public function get UserNameValid():String
		{
			return m_strUserNameValid;
		}

		public function set UserNameValid(value:String):void
		{
			m_strUserNameValid = value;
		}

		[Bindable]
		public function get PasswordValid():String
		{
			return m_strPasswordValid;
		}

		public function set PasswordValid(value:String):void
		{
			m_strPasswordValid = value;
		}

		public function get isEmailValid():Boolean
		{
			return m_isEmailValid;
		}

		public function set isEmailValid(value:Boolean):void
		{
			m_isEmailValid = value;
		}

		[Bindable]
		public function get Avatar():String
		{
			return m_strAvatar;
		}

		public function set Avatar(value:String):void
		{
			m_strAvatar = value;
		}


	}
}