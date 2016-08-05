package model
{	
	import mx.collections.ArrayCollection;

	public class M_Admin
	{
		private var m_arrManager:ArrayCollection;
		
		private var m_arrUser:ArrayCollection;
		private var m_oSelectedUser:Object;
		private var m_StatusUser: String;
		
		private var m_arrTournament:ArrayCollection;
		private var m_oSelectedTour:Object;
		private var m_StatusTournament: String;
		
		private var m_arrLevel:ArrayCollection;
		private var m_oSelectedLevel:Object;
		private var m_StatusLevel: String;
		
		private var m_arrLevelCollection:ArrayCollection;
		private var m_oSelectedLevelCollection:Object;
		
		private var m_arrRoom:ArrayCollection;
		private var m_oSelectedRoom:Object;
		private var m_StatusRoom: String;
		
		private var m_arrTransaction:ArrayCollection;
		private var m_oSelectedTrans:Object;
		private var m_StatusTrans: String;
		
		private var m_findUserName: String = "";
		private var m_findTourName: String = "";
		private var m_findRoomName: String = "";
		
		private static var m_instance : M_Admin = null;
		private static var m_isAllowed : Boolean = false;
		public function M_Admin(){
			if(m_isAllowed == false)
				throw new Error("Please User GetInstance Method Instead");
		}

		

		public static function getInstance():M_Admin{
			if(m_instance == null)
			{
				m_isAllowed = true;
				m_instance = new M_Admin();
				m_isAllowed = false;
			}
			return m_instance;
		}

		public function updateTourStatus(name: String, status: String):void{
			for(var i: int = 0; i< m_arrTournament.length; i++){
				var item: Object = m_arrTournament[i];
				if(item.name == name){
					item.status = status;
					m_arrTournament[i] = item;
				}
			}
		}
		
		[Bindable]
		public function get arrManager():ArrayCollection
		{
			return m_arrManager;
		}

		public function set arrManager(value:ArrayCollection):void
		{
			m_arrManager = value;
		}

		[Bindable]
		public function get arrUser():ArrayCollection
		{
			return m_arrUser;
		}

		public function set arrUser(value:ArrayCollection):void
		{
			m_arrUser = value;
		}

		[Bindable]
		public function get arrTournament():ArrayCollection
		{
			return m_arrTournament;
		}

		public function set arrTournament(value:ArrayCollection):void
		{
			m_arrTournament = value;
		}

		[Bindable]
		public function get arrRoom():ArrayCollection
		{
			return m_arrRoom;
		}

		public function set arrRoom(value:ArrayCollection):void
		{
			m_arrRoom = value;
		}

		[Bindable]
		public function get oSelectedUser():Object
		{
			return m_oSelectedUser;
		}

		public function set oSelectedUser(value:Object):void
		{
			m_oSelectedUser = value;
		}

		[Bindable]
		public function get oSelectedTour():Object
		{
			return m_oSelectedTour;
		}

		public function set oSelectedTour(value:Object):void
		{
			m_oSelectedTour = value;
		}

		[Bindable]
		public function get oSelectedRoom():Object
		{
			return m_oSelectedRoom;
		}

		public function set oSelectedRoom(value:Object):void
		{
			m_oSelectedRoom = value;
		}

		[Bindable]
		public function get StatusUser():String
		{
			return m_StatusUser;
		}

		public function set StatusUser(value:String):void
		{
			m_StatusUser = value;
		}

		[Bindable]
		public function get StatusTournament():String
		{
			return m_StatusTournament;
		}

		public function set StatusTournament(value:String):void
		{
			m_StatusTournament = value;
		}

		[Bindable]
		public function get StatusRoom():String
		{
			return m_StatusRoom;
		}

		public function set StatusRoom(value:String):void
		{
			m_StatusRoom = value;
		}

		public function get findUserName():String
		{
			return m_findUserName;
		}

		public function set findUserName(value:String):void
		{
			m_findUserName = value;
		}

		public function get findTourName():String
		{
			return m_findTourName;
		}

		public function set findTourName(value:String):void
		{
			m_findTourName = value;
		}

		public function get findRoomName():String
		{
			return m_findRoomName;
		}

		public function set findRoomName(value:String):void
		{
			m_findRoomName = value;
		}

		[Bindable]
		public function get arrTransaction():ArrayCollection
		{
			return m_arrTransaction;
		}

		public function set arrTransaction(value:ArrayCollection):void
		{
			m_arrTransaction = value;
		}

		[Bindable]
		public function get oSelectedTrans():Object
		{
			return m_oSelectedTrans;
		}

		public function set oSelectedTrans(value:Object):void
		{
			m_oSelectedTrans = value;
		}

		[Bindable]
		public function get StatusTrans():String
		{
			return m_StatusTrans;
		}

		public function set StatusTrans(value:String):void
		{
			m_StatusTrans = value;
		}

		[Bindable]
		public function get arrLevel():ArrayCollection
		{
			return m_arrLevel;
		}

		public function set arrLevel(value:ArrayCollection):void
		{
			m_arrLevel = value;
		}

		[Bindable]
		public function get oSelectedLevel():Object
		{
			return m_oSelectedLevel;
		}

		public function set oSelectedLevel(value:Object):void
		{
			m_oSelectedLevel = value;
		}

		[Bindable]
		public function get StatusLevel():String
		{
			return m_StatusLevel;
		}

		public function set StatusLevel(value:String):void
		{
			m_StatusLevel = value;
		}

		[Bindable]
		public function get arrLevelCollection():ArrayCollection
		{
			return m_arrLevelCollection;
		}

		public function set arrLevelCollection(value:ArrayCollection):void
		{
			m_arrLevelCollection = value;
		}

		[Bindable]
		public function get oSelectedLevelCollection():Object
		{
			return m_oSelectedLevelCollection;
		}

		public function set oSelectedLevelCollection(value:Object):void
		{
			m_oSelectedLevelCollection = value;
		}


		/** GETTER & SETTER **/
		

	}
}