package model
{
	import Configuration.config;
	
	import components._comp_joinTable;
	
	import mx.skins.wireframe.windowChrome.MinimizeButtonSkin;
	
	import zUtilities.GameVariable;
	import zUtilities.NumberFormat;

	public class M_JoinTable
	{
		
		private static var m_instance:M_JoinTable = null;
		private static var m_isAllowed:Boolean = false;
		
		
		private var m_tableId:int = 0;
		private var m_strTableName:String = "";
		private var m_strDisplayName:String = "";
		private var m_strSmallBlind:String = "";
		private var m_strBigBlind:String = "";
		private var m_strMinBuyIn:String = "";
		private var m_strMaxBuyIn:String = "";
		private var m_strNumPlayer:String = "";
		private var m_strMaxPlayer:String = "";
		private var m_strBuyIn:String = "";
		private var m_sitPos:int;
		private var m_noLimit:Boolean = false;
		
		private var m_vJoinTable:_comp_joinTable = null;
		
		public function M_JoinTable()
		{
			if(m_isAllowed == false){
				throw new Error("");
			}
		}
		
		public function get sitPos():int
		{
			return m_sitPos;
		}

		public function set sitPos(value:int):void
		{
			m_sitPos = value;
		}

		public static function getInstance():M_JoinTable{
			if(m_instance == null){
				m_isAllowed = true;
				m_instance = new M_JoinTable();
				m_isAllowed = false;
			}
			return m_instance;
		}
		
		/*public function setTableInfo(id:int, name:String, smallBlind:Number, bigBlind:Number,  
									 minBuyIn:Number, maxBuyIn:Number, numPLayer:int, maxPlayer:int, _noLimit:Boolean):void{
			m_tableId = id;
			m_strTableName = name;
			strSmallBlind = NumberFormat.getDecimalFormat(smallBlind);
			strBigBlind = NumberFormat.getDecimalFormat(bigBlind);
			strMinBuyIn = NumberFormat.getDecimalFormat(minBuyIn);
			noLimit = _noLimit;
			if(noLimit == true){
				strMaxBuyIn = "No limit";
			}
			else{
				strMaxBuyIn = NumberFormat.getDecimalFormat(maxBuyIn);
			}
			strNumPlayer = numPLayer.toString();
			strMaxPlayer = maxPlayer.toString();
			if(maxBuyIn > m_globalVar.myFish || noLimit == true){
				strBuyIn = int(m_globalVar.myFish).toString();
			}
			else{
				strBuyIn = maxBuyIn.toString();
			}
		}*/
		public function setTableInfo(id:int, name:String, displayName: String, smallBlind:Number, bigBlind:Number,  
									 minBuyIn:Number, maxBuyIn:Number, numPLayer:int, maxPlayer:int, _noLimit:Boolean):void{
			m_tableId = id;
			m_strTableName = name;
			m_strDisplayName = displayName;
			strSmallBlind = NumberFormat.getDecimalFormat(smallBlind);
			strBigBlind = NumberFormat.getDecimalFormat(bigBlind);
			strMinBuyIn = NumberFormat.getDecimalFormat(minBuyIn);
			noLimit = _noLimit;
			if(noLimit == true){
				strMaxBuyIn = "No limit";
			}
			else{
				strMaxBuyIn = NumberFormat.getDecimalFormat(maxBuyIn);
			}
			strNumPlayer = numPLayer.toString();
			strMaxPlayer = maxPlayer.toString();
			var myChip: Number = GameVariable.GetInstance().UserInfo.Chip;
			if(maxBuyIn > myChip || noLimit == true){
				strBuyIn = int(myChip).toString();
			}
			else{
				strBuyIn = maxBuyIn.toString();
			}
		}
		
		/*public function getBuyIn():Number{			
			if(Boolean(m_strBuyIn) == false ){
				return -1;
			}
			var buyIn:Number = int(strBuyIn);
			var minBuyIn:Number = NumberFormat.getNumber(strMinBuyIn);
			var maxBuyIn:Number = NumberFormat.getNumber(strMaxBuyIn);
			var userChip: Number = GameVariable.GetInstance().UserInfo.Chip;
			if(buyIn < minBuyIn || buyIn > maxBuyIn || buyIn > userChip){
				return -1;
			}
			return buyIn;
		}*/
		public function getBuyIn():Number{			
			if(Boolean(m_strBuyIn) == false ){
				return -1;
			}
			var buyIn:Number = int(strBuyIn);
			var minBuyIn:Number = NumberFormat.getNumber(strMinBuyIn);
			var maxBuyIn:Number = NumberFormat.getNumber(strMaxBuyIn);
			var userChip: Number = GameVariable.GetInstance().UserInfo.Chip;
			
			if(buyIn < minBuyIn){
				strBuyIn = strMinBuyIn.replace(config.CURRENCY, "");
				return -1;
			}
			if(buyIn > maxBuyIn || buyIn > userChip){
				if(maxBuyIn < userChip){
					strBuyIn = strMaxBuyIn.replace(config.CURRENCY, "");
				}else{
					strBuyIn = userChip.toString();
				}
				return -1;
			}
			return buyIn;
		}
		
		public function checkValidate():Boolean{
			var buyIn:Number = Number(m_strBuyIn);
			var min:Number = Number(m_strMinBuyIn);
			var max:Number = Number(m_strMaxBuyIn);
			if(buyIn < min || buyIn > max){
				return false;
			}
			return true;
		}

		/****************** GETTER && SETTER ***********************/
		[Bindable]
		public function get strTableName():String
		{
			return m_strTableName;
		}

		public function set strTableName(value:String):void
		{
			m_strTableName = value;
		}

		[Bindable]
		public function get strMinBuyIn():String
		{
			return m_strMinBuyIn;
		}

		public function set strMinBuyIn(value:String):void
		{
			m_strMinBuyIn = value;
		}

		[Bindable]
		public function get strMaxBuyIn():String
		{
			return m_strMaxBuyIn;
		}

		public function set strMaxBuyIn(value:String):void
		{
			m_strMaxBuyIn = value;
		}

		[Bindable]
		public function get strNumPlayer():String
		{
			return m_strNumPlayer;
		}

		public function set strNumPlayer(value:String):void
		{
			m_strNumPlayer = value;
		}

		[Bindable]
		public function get strMaxPlayer():String
		{
			return m_strMaxPlayer;
		}

		public function set strMaxPlayer(value:String):void
		{
			m_strMaxPlayer = value;
		}

		[Bindable]
		public function get strBuyIn():String
		{
			return m_strBuyIn;
		}

		public function set strBuyIn(value:String):void
		{
			m_strBuyIn = value;
		}

		public function get vJoinTable():_comp_joinTable
		{
			return m_vJoinTable;
		}

		public function set vJoinTable(value:_comp_joinTable):void
		{
			m_vJoinTable = value;
		}

		public function get tableId():int
		{
			return m_tableId;
		}

		public function set tableId(value:int):void
		{
			m_tableId = value;
		}

		[Bindable]
		public function get strSmallBlind():String
		{
			return m_strSmallBlind;
		}

		public function set strSmallBlind(value:String):void
		{
			m_strSmallBlind = value;
		}

		[Bindable]
		public function get strBigBlind():String
		{
			return m_strBigBlind;
		}

		public function set strBigBlind(value:String):void
		{
			m_strBigBlind = value;
		}

		public function get noLimit():Boolean
		{
			return m_noLimit;
		}

		public function set noLimit(value:Boolean):void
		{
			m_noLimit = value;
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