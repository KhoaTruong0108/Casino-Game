package model
{	
	import components._comp_detailTournament;
	
	import mx.collections.ArrayCollection;

	public class M_DetailTournament
	{
		private var m_arrLevelCollection:ArrayCollection;
		private var m_oSelectedLevelCollection:Object;
		
		private var m_name: String;
		private var m_displayName: String;
		private var m_fee: String;
		private var m_capacity: String;
		private var m_status: String;
		private var m_startingChip: String;
		private var m_levelType: int;
		private var m_beginLevel: String;
		private var m_endLevel: String;
		private var m_firstPrize: String;
		private var m_secondPrize: String;
		private var m_thirdPrize: String;
		
		private var m_statusMsg: String;
		
		private var m_isCreate: Boolean;
		
		private var m_vDetailUser:_comp_detailTournament = null;
		
		
		private static var m_instance : M_DetailTournament = null;
		private static var m_isAllowed : Boolean = false;
		public function M_DetailTournament(){
			if(m_isAllowed == false)
				throw new Error("Please User GetInstance Method Instead");
		}

		

		public static function getInstance():M_DetailTournament{
			if(m_instance == null)
			{
				m_isAllowed = true;
				m_instance = new M_DetailTournament();
				m_isAllowed = false;
			}
			return m_instance;
		}

		public function clearAll():void{
			name = "";
			displayName = "";
			capacity = "";
			startingChip = "";
			fee = "";
			beginLevel = "";
			endLevel = "";
			firstPrize = "";
			secondPrize = "";
			thirdPrize = "";
			status = "";
			statusMsg = "";
			oSelectedLevelCollection = null;
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
			
			if(value != null)
				levelType = value.data as int;
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
		public function get fee():String
		{
			return m_fee;
		}

		public function set fee(value:String):void
		{
			m_fee = value;
		}

		[Bindable]
		public function get capacity():String
		{
			return m_capacity;
		}

		public function set capacity(value:String):void
		{
			m_capacity = value;
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
		public function get startingChip():String
		{
			return m_startingChip;
		}

		public function set startingChip(value:String):void
		{
			m_startingChip = value;
		}

		[Bindable]
		public function get firstPrize():String
		{
			return m_firstPrize;
		}

		public function set firstPrize(value:String):void
		{
			m_firstPrize = value;
		}

		[Bindable]
		public function get secondPrize():String
		{
			return m_secondPrize;
		}

		public function set secondPrize(value:String):void
		{
			m_secondPrize = value;
		}

		[Bindable]
		public function get thirdPrize():String
		{
			return m_thirdPrize;
		}

		public function set thirdPrize(value:String):void
		{
			m_thirdPrize = value;
		}

		/*[Bindable]
		public function get betChip():String
		{
			return m_betChip;
		}

		public function set betChip(value:String):void
		{
			m_betChip = value;
		}*/

		public function get vDetailUser():_comp_detailTournament
		{
			return m_vDetailUser;
		}

		public function set vDetailUser(value:_comp_detailTournament):void
		{
			m_vDetailUser = value;
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

		public function get isCreate():Boolean
		{
			return m_isCreate;
		}

		public function set isCreate(value:Boolean):void
		{
			m_isCreate = value;
		}

		[Bindable]
		public function get levelType():int
		{
			return m_levelType;
		}

		public function set levelType(value:int):void
		{
			m_levelType = value;
		}

		[Bindable]
		public function get endLevel():String
		{
			return m_endLevel;
		}

		public function set endLevel(value:String):void
		{
			m_endLevel = value;
		}

		[Bindable]
		public function get beginLevel():String
		{
			return m_beginLevel;
		}

		public function set beginLevel(value:String):void
		{
			m_beginLevel = value;
		}


		/** GETTER & SETTER **/
		

	}
}