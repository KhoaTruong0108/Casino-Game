package entity {
	import com.smartfoxserver.v2.entities.User;
	
	public class AdminEntity {

		protected var m_strUserName: String;
		protected var m_strPassword: String;
		
		protected var m_sfsUser: User;
		
		public function AdminEntity() {
		}

		public static function FromUser(sfsuser: User): AdminEntity {
			var userEntity: AdminEntity = new AdminEntity();
			
			userEntity.UserName = sfsuser.name;
			userEntity.sfsUser = sfsuser;
			
			return userEntity;
		}

		public function get UserName():String
		{
			return m_strUserName;
		}

		public function set UserName(value:String):void
		{
			m_strUserName = value;
		}

		public function get sfsUser():User
		{
			return m_sfsUser;
		}

		public function set sfsUser(value:User):void
		{
			m_sfsUser = value;
		}


		
	} // end class
} // end package