package zUtilities {
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.entities.invitation.Invitation;
	
	import entity.LeaderBoardInfo;
	import entity.UserEntity;
	import entity.game_Entity.Desk;

	public class GameVariable {

		protected var m_eUserInfo:UserEntity;

		protected var m_eLeaderBoardInfo:LeaderBoardInfo;
		//Current Room which user is joining
		protected var m_currentRoom : Room;
		protected var m_currentInvitation : Invitation;
		public var EntityName_UserInfo:String = "UserInfo";
		public var EntityName_LeaderBoard:String = "LeaderBoardInfo";
		
		protected var m_iMyPosition: int; 
		//protected var m_nMyByIn: Number;
		protected var m_bIsRegisTour: Boolean;
		protected var m_sTourName: String;
		
		private static var m_instance : GameVariable = null;
		private static var m_isAllowed : Boolean = false;
		
		
		public function GameVariable() {
			if( m_isAllowed == false){
				throw new Error("Please Use GetInstance Method Instead");
			}
			m_sTourName = "";
			m_bIsRegisTour = false;
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

		public function get CurrentRoom():Room
		{
			return m_currentRoom;
		}

		public function set CurrentRoom(value:Room):void
		{
			m_currentRoom = value;
		}

		public function get UserInfo():UserEntity
		{
			return m_eUserInfo;
		}

		public function set UserInfo(value:UserEntity):void
		{
			m_eUserInfo = value;
		}

		public function get CurrentInvitation():Invitation
		{
			return m_currentInvitation;
		}

		public function set CurrentInvitation(value:Invitation):void
		{
			m_currentInvitation = value;
		}

		public function get myPos():int
		{
			return m_iMyPosition;
		}

		public function set myPos(value:int):void
		{
			m_iMyPosition = value;
		}

		/*public function get myBuyIn():Number
		{
			return m_nMyByIn;
		}

		public function set myBuyIn(value:Number):void
		{
			m_nMyByIn = value;
		}*/

		public function get IsRegisTour():Boolean
		{
			return m_bIsRegisTour;
		}

		public function set IsRegisTour(value:Boolean):void
		{
			m_bIsRegisTour = value;
		}

		public function get TourName():String
		{
			return m_sTourName;
		}

		public function set TourName(value:String):void
		{
			m_sTourName = value;
		}


	} // end class
} // end package