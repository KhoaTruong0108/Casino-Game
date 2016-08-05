package model
{	
	import components._comp_detailLevel;
	
	import mx.collections.ArrayCollection;

	public class M_DetailLevel
	{
		private var m_id: int;
		private var m_levelType: int;
		private var m_level: String;
		private var m_levelTypeDes: String;
		private var m_smallBlind: String;
		private var m_bigBlind: String;
		private var m_ante: String;
		private var m_timeLife: String;
		
		private var m_status: String;
		
		private var m_isCreate: Boolean;
		
		private var m_vDetailLevel:_comp_detailLevel = null;
		
		private static var m_instance : M_DetailLevel = null;
		private static var m_isAllowed : Boolean = false;
		public function M_DetailLevel(){
			if(m_isAllowed == false)
				throw new Error("Please  GetInstance Method Instead");
		}

		

		public static function getInstance():M_DetailLevel{
			if(m_instance == null)
			{
				m_isAllowed = true;
				m_instance = new M_DetailLevel();
				m_isAllowed = false;
			}
			return m_instance;
		}
		
		public function clearAll():void{
			level = "";
			levelTypeDes = "";
			smallBlind = "";
			bigBlind = "";
			ante = "";
			timeLife = "";
			status = "";
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

		[Bindable]
		public function get level():String
		{
			return m_level;
		}

		public function set level(value:String):void
		{
			m_level = value;
		}

		[Bindable]
		public function get levelTypeDes():String
		{
			return m_levelTypeDes;
		}

		public function set levelTypeDes(value:String):void
		{
			m_levelTypeDes = value;
		}

		[Bindable]
		public function get smallBlind():String
		{
			return m_smallBlind;
		}

		public function set smallBlind(value:String):void
		{
			m_smallBlind = value;
		}

		[Bindable]
		public function get bigBlind():String
		{
			return m_bigBlind;
		}

		public function set bigBlind(value:String):void
		{
			m_bigBlind = value;
		}

		[Bindable]
		public function get ante():String
		{
			return m_ante;
		}

		public function set ante(value:String):void
		{
			m_ante = value;
		}

		[Bindable]
		public function get timeLife():String
		{
			return m_timeLife;
		}

		public function set timeLife(value:String):void
		{
			m_timeLife = value;
		}

		public function get id():int
		{
			return m_id;
		}

		public function set id(value:int):void
		{
			m_id = value;
		}

		public function get levelType():int
		{
			return m_levelType;
		}

		public function set levelType(value:int):void
		{
			m_levelType = value;
		}

		public function get vDetailLevel():_comp_detailLevel
		{
			return m_vDetailLevel;
		}

		public function set vDetailLevel(value:_comp_detailLevel):void
		{
			m_vDetailLevel = value;
		}


		/** GETTER & SETTER **/
		

	}
}