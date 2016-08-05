package model
{	
	import components._comp_detailUser;
	
	import mx.collections.ArrayCollection;

	public class M_DetailUser
	{
		private var m_name: String;
		private var m_displayName: String;
		private var m_password: String;
		private var m_email: String;
		private var m_chip: String;
		private var m_location: String;
		
		private var m_status: String;
		
		private var m_isCreate: Boolean;
		
		private var m_vDetailUser:_comp_detailUser = null;
		
		private static var m_instance : M_DetailUser = null;
		private static var m_isAllowed : Boolean = false;
		public function M_DetailUser(){
			if(m_isAllowed == false)
				throw new Error("Please User GetInstance Method Instead");
		}

		

		public static function getInstance():M_DetailUser{
			if(m_instance == null)
			{
				m_isAllowed = true;
				m_instance = new M_DetailUser();
				m_isAllowed = false;
			}
			return m_instance;
		}
		
		public function clearAll():void{
			name = "";
			displayName = "";
			password = "";
			email = "";
			chip = "";
			location = "";
			location = "";
			status = "";
		}

		[Bindable]
		public function get name():String
		{
			return m_name;
		}

		public function set name(value:String):void
		{
			m_name = value;
		}

		[Bindable]
		public function get displayName():String
		{
			return m_displayName;
		}

		public function set displayName(value:String):void
		{
			m_displayName = value;
		}

		[Bindable]
		public function get password():String
		{
			return m_password;
		}

		public function set password(value:String):void
		{
			m_password = value;
		}

		[Bindable]
		public function get email():String
		{
			return m_email;
		}

		public function set email(value:String):void
		{
			m_email = value;
		}

		[Bindable]
		public function get chip():String
		{
			return m_chip;
		}

		public function set chip(value:String):void
		{
			m_chip = value;
		}

		[Bindable]
		public function get location():String
		{
			return m_location;
		}

		public function set location(value:String):void
		{
			m_location = value;
		}

		public function get vDetailUser():_comp_detailUser
		{
			return m_vDetailUser;
		}

		public function set vDetailUser(value:_comp_detailUser):void
		{
			m_vDetailUser = value;
		}

		public function get isCreate():Boolean
		{
			return m_isCreate;
		}

		public function set isCreate(value:Boolean):void
		{
			m_isCreate = value;
		}

		[Bindable]
		public function get status():String
		{
			return m_status;
		}

		public function set status(value:String):void
		{
			m_status = value;
		}


		/** GETTER & SETTER **/
		

	}
}