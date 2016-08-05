package entity {
	
	////******************************ROOM_ENTITY******************************//////////
	//		just using in view to show on datagrid
	////**********************************************************************//////////
	
	import Enum.RoomVariableDetail;
	
	import com.smartfoxserver.v2.entities.Room;
	
	import mx.collections.ArrayCollection;
	
	import zUtilities.ServerController;

	public class RoomEntity {

		protected var m_displayName:String;
		protected var m_playerInRoom:String;
		protected var m_userCreate:String;
		protected var m_betChip:Number;
		protected var m_status:String;
		//isPassword is updated automatically follow changing value of password (set) 
		//and isPassword don't have "set" property (only get)
		protected var m_isPassword: Boolean;
		protected var m_password: String;
		protected var m_room: Room;
		protected var m_minChip: Number;
		protected var m_maxChip: Number;
		protected var m_noLimit: Boolean;
		
		private static var m_instance : RoomEntity = null;
		private static var m_isAllow : Boolean = false;
		protected var m_server : RoomEntity = null;		
		

		public function RoomEntity() {
		}

		public static function FromRoom(room: Room):RoomEntity{
			var roomEntity: RoomEntity = new RoomEntity();
			roomEntity.RoomInfo = room;
			var roomVariables: Array = room.getVariables();
			
			if(room.getVariable(RoomVariableDetail.DISPLAY_NAME) != null)
				roomEntity.DisplayName = room.getVariable(RoomVariableDetail.DISPLAY_NAME).getStringValue();
			
			if(room.getVariable(RoomVariableDetail.BET_CHIP) != null)
				roomEntity.BetChip = room.getVariable(RoomVariableDetail.BET_CHIP).getDoubleValue();
			if(room.getVariable(RoomVariableDetail.USER_CREATE) != null)
				roomEntity.UserCreate = room.getVariable(RoomVariableDetail.USER_CREATE).getStringValue();
			if(room.getVariable(RoomVariableDetail.PASSWORD) != null)
				roomEntity.Password = room.getVariable(RoomVariableDetail.PASSWORD).getStringValue();
			else
				roomEntity.Password = "";
			
			if(room.getVariable(RoomVariableDetail.MIN_CHIP) != null)
				roomEntity.MinChip = room.getVariable(RoomVariableDetail.MIN_CHIP).getDoubleValue();
			else
				roomEntity.MinChip = 0;
			
			if(room.getVariable(RoomVariableDetail.MAX_CHIP) != null)
				roomEntity.MaxChip = room.getVariable(RoomVariableDetail.MAX_CHIP).getDoubleValue();
			else
				roomEntity.MaxChip = Number.MAX_VALUE;
			
			if(room.getVariable(RoomVariableDetail.NO_LIMIT) != null)
				roomEntity.NoLimit = room.getVariable(RoomVariableDetail.NO_LIMIT).getBoolValue();
			else
				roomEntity.NoLimit = true;
			
			if(room.getVariable(RoomVariableDetail.STATUS) != null)
				roomEntity.Status = room.getVariable(RoomVariableDetail.STATUS).getStringValue();
			else
				roomEntity.Status = "";
			
			roomEntity.PlayerInRoom = room.userCount.toString() +"/"+ room.maxUsers.toString();
			
			return roomEntity;
		}
		public function get PlayerInRoom():String
		{
			return m_playerInRoom;
		}
		
		public function get BetChip():Number
		{
			return m_betChip;
		}
				
		public function set PlayerInRoom(value:String):void
		{
			m_playerInRoom = value;
		}
		
		
		public function set BetChip(value:Number):void
		{
			m_betChip = value;
		}
		
		public function get RoomInfo():Room
		{
			return m_room;
		}
		
		public function set RoomInfo(value:Room):void
		{
			m_room = value;
		}

		public function get UserCreate():String
		{
			return m_userCreate;
		}

		public function set UserCreate(value:String):void
		{
			m_userCreate = value;
		}

		public function get Status():String
		{
			return m_status;
		}

		public function set Status(value:String):void
		{
			m_status = value;
		}

		public function get isPassword():Boolean
		{
			return m_isPassword;
		}

		public function get Password():String
		{
			return m_password;
		}

		public function set Password(value:String):void
		{
			m_password = value;
			if(m_password == "" || m_password == null)
				m_isPassword = false;
			else
				m_isPassword = true;
		}

		public function get MinChip():Number
		{
			return m_minChip;
		}

		public function set MinChip(value:Number):void
		{
			m_minChip = value;
		}

		public function get MaxChip():Number
		{
			return m_maxChip;
		}

		public function set MaxChip(value:Number):void
		{
			m_maxChip = value;
		}

		public function get NoLimit():Boolean
		{
			return m_noLimit;
		}

		public function set NoLimit(value:Boolean):void
		{
			m_noLimit = value;
		}

		public function get DisplayName():String
		{
			return m_displayName;
		}

		public function set DisplayName(value:String):void
		{
			m_displayName = value;
		}


	} // end class
} // end package