package model
{	
	import components._comp_addChip;
	import components._comp_detailUser;
	
	import mx.collections.ArrayCollection;

	public class M_AddChip
	{
		private var m_name: String;
		private var m_chip: String;
		private var m_type: Object;
		
		private var m_status: String;
		
		private var m_vAddChip:_comp_addChip = null;
		
		private static var m_instance : M_AddChip = null;
		private static var m_isAllowed : Boolean = false;
		public function M_AddChip(){
			if(m_isAllowed == false)
				throw new Error("Please User GetInstance Method Instead");
		}

		

		public static function getInstance():M_AddChip{
			if(m_instance == null)
			{
				m_isAllowed = true;
				m_instance = new M_AddChip();
				m_isAllowed = false;
			}
			return m_instance;
		}
		
		public function clearAll():void{
			name = "";
			chip = "0";
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
		public function get chip():String
		{
			return m_chip;
		}

		public function set chip(value:String):void
		{
			m_chip = value;
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
		public function get type():Object
		{
			return m_type;
		}

		public function set type(value:Object):void
		{
			m_type = value;
		}

		public function get vAddChip():_comp_addChip
		{
			return m_vAddChip;
		}

		public function set vAddChip(value:_comp_addChip):void
		{
			m_vAddChip = value;
		}


		/** GETTER & SETTER **/
		

	}
}