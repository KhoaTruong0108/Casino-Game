package model
{
	import com.greensock.easing.Back;
	
	import components._comp_TournamentDetail;
	
	import mx.skins.wireframe.windowChrome.MinimizeButtonSkin;
	
	import zUtilities.GameVariable;
	import zUtilities.NumberFormat;

	public class M_TournamentDetail
	{
		
		private static var m_instance:M_TournamentDetail = null;
		private static var m_isAllowed:Boolean = false;
		
		
		private var m_strName:String = "";
		private var m_strDisplayName:String = "";
		private var m_strFee:String = "";
		private var m_strPlayerCount:String = "";
		private var m_strCapacity:String = "";
		private var m_strStatus:String = "";
		private var m_strStartingChip:String = "";
		private var m_strBetChip:String = "";
		private var m_strFirstPrize:String = "";
		private var m_strSecondPrize:String = "";
		private var m_strThridPrize:String = "";
		
		private var m_strRegistierLabel: String = "";
		private var m_isRegistied: Boolean;
		
		private var m_strStatusMsg: String = "";
		
		private var m_vTournament: _comp_TournamentDetail = null;
		
		public function M_TournamentDetail()
		{
			if(m_isAllowed == false){
				throw new Error("");
			}
		}
		
		public static function getInstance():M_TournamentDetail{
			if(m_instance == null){
				m_isAllowed = true;
				m_instance = new M_TournamentDetail();
				m_isAllowed = false;
			}
			return m_instance;
		}
		public function setTournamentInfo(registied: Boolean, name: String, displayName: String, fee: Number, capacity: int, playerCount: int 
										  ,status: String, startingChip: Number, betChip: Number
										   ,firstPrize: Number,secondPrize: Number,thirdPrize: Number):void{
			isRegistied = registied;
			
			setLabelBtnOk(registied);
			m_strName = name;
			m_strDisplayName = displayName;
			m_strFee = fee.toString();
			m_strCapacity = capacity.toString();
			m_strPlayerCount = playerCount.toString();
			m_strStatus = status;
			m_strStartingChip = startingChip.toString();
			m_strBetChip = betChip.toString();
			m_strFirstPrize = firstPrize.toString();
			m_strSecondPrize = secondPrize.toString();
			m_strThridPrize = thirdPrize.toString();
		}
		
		public function setLabelBtnOk(registied: Boolean):void{
			if(registied){
				strRegistierLabel = " Unres";
			}else{
				strRegistierLabel = "Register";
			}
		}
		
		public function clearAll():void{
			m_strName = "";
			m_strFee = "";
			m_strCapacity = "";
			m_strPlayerCount = "";
			m_strStatus = "";
			m_strStartingChip = "";
			m_strBetChip = "";
			m_strFirstPrize = "";
			m_strSecondPrize = "";
			m_strThridPrize = "";
			m_strStatusMsg = "";
		}
		
		
		/****************** GETTER && SETTER ***********************/
		[Bindable]
		public function get strName():String
		{
			return m_strName;
		}
		
		public function set strName(value:String):void
		{
			m_strName = value;
		}
		
		[Bindable]
		public function get strFee():String
		{
			return m_strFee;
		}
		
		public function set strFee(value:String):void
		{
			m_strFee = value;
		}
		
		[Bindable]
		public function get strCapacity():String
		{
			return m_strCapacity;
		}
		
		public function set strCapacity(value:String):void
		{
			m_strCapacity = value;
		}
		
		[Bindable]
		public function get strStatus():String
		{
			return m_strStatus;
		}
		
		public function set strStatus(value:String):void
		{
			m_strStatus = value;
		}
		
		[Bindable]
		public function get strStartingChip():String
		{
			return m_strStartingChip;
		}
		
		public function set strStartingChip(value:String):void
		{
			m_strStartingChip = value;
		}
		
		[Bindable]
		public function get strBetChip():String
		{
			return m_strBetChip;
		}
		
		public function set strBetChip(value:String):void
		{
			m_strBetChip = value;
		}
		
		[Bindable]
		public function get strFirstPrize():String
		{
			return m_strFirstPrize;
		}
		
		public function set strFirstPrize(value:String):void
		{
			m_strFirstPrize = value;
		}
		
		[Bindable]
		public function get strSecondPrize():String
		{
			return m_strSecondPrize;
		}
		
		public function set strSecondPrize(value:String):void
		{
			m_strSecondPrize = value;
		}
		
		[Bindable]
		public function get strThridPrize():String
		{
			return m_strThridPrize;
		}
		
		public function set strThridPrize(value:String):void
		{
			m_strThridPrize = value;
		}

		[Bindable]
		public function get strPlayerCount():String
		{
			return m_strPlayerCount;
		}

		public function set strPlayerCount(value:String):void
		{
			m_strPlayerCount = value;
		}

		public function get vTournament():_comp_TournamentDetail
		{
			return m_vTournament;
		}

		public function set vTournament(value:_comp_TournamentDetail):void
		{
			m_vTournament = value;
		}

		[Bindable]
		public function get strRegistierLabel():String
		{
			return m_strRegistierLabel;
		}

		public function set strRegistierLabel(value:String):void
		{
			m_strRegistierLabel = value;
		}

		[Bindable]
		public function get isRegistied():Boolean
		{
			return m_isRegistied;
		}

		public function set isRegistied(value:Boolean):void
		{
			m_isRegistied = value;
		}

		[Bindable]
		public function get strStatusMsg():String
		{
			return m_strStatusMsg;
		}

		public function set strStatusMsg(value:String):void
		{
			m_strStatusMsg = value;
		}

		[Bindable]
		public function get strDisplayName():String
		{
			return m_strDisplayName;
		}

		public function set strDisplayName(value:String):void
		{
			m_strDisplayName = value;
		}


		/****************** END GETTER && SETTER ***********************/
	}
}