package model
{	
	import components._comp_detailRoom;
	
	import mx.collections.ArrayCollection;

	public class M_DetailRoom
	{
		private var m_name: String;
		private var m_displayName: String;
		private var m_password: String;
		private var m_maxUser: String;
		private var m_betChip: String;
		private var m_maxBuyin: String;
		private var m_minBuyin: String;
		private var m_noLimit: Boolean;
		private var m_status: String;
		private var m_createBy: String;
		
		private var m_statusMsg: String;
		
		private var m_isCreate: Boolean;
		
		private var m_vDetailRoom:_comp_detailRoom = null;
		
		private static var m_instance : M_DetailRoom = null;
		private static var m_isAllowed : Boolean = false;
		public function M_DetailRoom(){
			if(m_isAllowed == false)
				throw new Error("Please User GetInstance Method Instead");
		}

		

		public static function getInstance():M_DetailRoom{
			if(m_instance == null)
			{
				m_isAllowed = true;
				m_instance = new M_DetailRoom();
				m_isAllowed = false;
			}
			return m_instance;
		}
		
		public function clearAll():void{
			name = "";
			displayName = "";
			password = "";
			maxUser = "";
			betChip = "";
			maxBuyin = "";
			minBuyin = "";
			status = "";
			noLimit = false;
			createBy = "";
			
			statusMsg = "";
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
		public function get maxUser():String
		{
			return m_maxUser;
		}

		public function set maxUser(value:String):void
		{
			m_maxUser = value;
		}

		[Bindable]
		public function get betChip():String
		{
			return m_betChip;
		}

		public function set betChip(value:String):void
		{
			m_betChip = value;
		}

		[Bindable]
		public function get maxBuyin():String
		{
			return m_maxBuyin;
		}

		public function set maxBuyin(value:String):void
		{
			m_maxBuyin = value;
		}

		[Bindable]
		public function get minBuyin():String
		{
			return m_minBuyin;
		}

		public function set minBuyin(value:String):void
		{
			m_minBuyin = value;
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

		[Bindable]
		public function get createBy():String
		{
			return m_createBy;
		}

		public function set createBy(value:String):void
		{
			m_createBy = value;
		}

		public function get isCreate():Boolean
		{
			return m_isCreate;
		}

		public function set isCreate(value:Boolean):void
		{
			m_isCreate = value;
		}

		public function get vDetailRoom():_comp_detailRoom
		{
			return m_vDetailRoom;
		}

		public function set vDetailRoom(value:_comp_detailRoom):void
		{
			m_vDetailRoom = value;
		}

		[Bindable]
		public function get statusMsg():String
		{
			return m_statusMsg;
		}

		public function set statusMsg(value:String):void
		{
			m_statusMsg = value;
		}

		[Bindable]
		public function get noLimit():Boolean
		{
			return m_noLimit;
		}

		public function set noLimit(value:Boolean):void
		{
			m_noLimit = value;
		}


		/** GETTER & SETTER **/
		

	}
}