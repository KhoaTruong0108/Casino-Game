package zUtilities {
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.entities.invitation.Invitation;
	
	import entity.AdminEntity;

	public class GameVariable {

		protected var m_eUserInfo:AdminEntity;

		private static var m_instance : GameVariable = null;
		private static var m_isAllowed : Boolean = false;
		
		
		public function GameVariable() {
			if( m_isAllowed == false){
				throw new Error("Please Use GetInstance Method Instead");
			}
		}
		
		public static function GetInstance():GameVariable {
			if(m_instance == null){
				m_isAllowed = true;
				m_instance = new GameVariable();
				m_isAllowed = false;				 
			}
			return m_instance;
		}

		public function AddEntityChangeListener(entity_name:String, fnHandler:*):void {
			
		}

		public function DispatchEventEntityChange(event_name:String):void {
		}

		public function get UserInfo():AdminEntity
		{
			return m_eUserInfo;
		}

		public function set UserInfo(value:AdminEntity):void
		{
			m_eUserInfo = value;
		}

	} // end class
} // end package