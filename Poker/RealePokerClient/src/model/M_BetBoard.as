package model
{
	import zUtilities.Logger;
	import zUtilities.MainController;

	public class M_BetBoard
	{
		private static var m_instance:M_BetBoard = null;
		private static var m_isAllowed:Boolean = false;
		
		private var m_cMain:MainController = MainController.getInstance();
		
		private var m_strRaiseLabel:String = "";
		private var m_iRaiseValue:Number = 0;
		private var m_strRaiseValue:String = "";
		private var m_minnimum:Number = 0;
		private var m_maximum:Number = 0;
		private var m_isVisibled:Boolean = false;
		
		private var m_logger: Logger = new Logger();
		
		public function M_BetBoard()
		{
			if(m_isAllowed == false){
				throw new Error("");
			}
		}
		
		public static function getInstance():M_BetBoard{
			if(m_instance == null){
				m_isAllowed = true;
				m_instance = new M_BetBoard();
				m_isAllowed = false;
			}
			return m_instance;
		}

		public function getRaise():Number{
			return Number(m_strRaiseValue);
		}
		
		public function setValue(min:Number, max:Number):void{
		}
		
		public function setVisibled(v:Boolean):void{
			m_isVisibled = v;
		}
		
		public function setRaiseToBeRaise():void{
			strRaiseLabel = "RAISE";
		}
		public function setRaiseToBeBet():void{
			strRaiseLabel = "BET";
		}
		
		public function resetAll():void{
			minnimum = 0;
			maximum = 0;
			iRaiseValue = 0;
			strRaiseValue = "0";
		}
		
		/********************* GETTER && SETTER *******************/
		[Bindable]
		public function get strRaiseValue():String
		{
			return m_strRaiseValue;
		}

		public function set strRaiseValue(value:String):void
		{
			m_strRaiseValue = value;
		}

		[Bindable]
		public function get iRaiseValue():Number
		{			
			return m_iRaiseValue;
		}

		public function set iRaiseValue(value:Number):void
		{
			//m_strRaiseValue = value.toString();
			m_iRaiseValue = value;
		}

		[Bindable]
		public function get minnimum():Number
		{
			return m_minnimum;
		}

		public function set minnimum(value:Number):void
		{
			m_minnimum = value;
		}

		[Bindable]
		public function get maximum():Number
		{
			return m_maximum;
		}

		public function set maximum(value:Number):void
		{
			m_maximum = value;
		}

		[Bindable]
		public function get isVisibled():Boolean
		{
			/*if(m_isVisibled){
				m_logger.Log("btnRaise: " + m_cMain.vMain.m_btnRaise.visible);
				m_logger.Log("txtRaise: " + m_cMain.vMain.m_txtRaise.visible);
				m_logger.Log("btnRaise1: " + m_cMain.vMain.m_btnRaise1.visible);
			}*/
			return m_isVisibled;
		}

		public function set isVisibled(value:Boolean):void
		{
			m_isVisibled = value;
		}

		[Bindable]
		public function get strRaiseLabel():String
		{
			return m_strRaiseLabel;
		}

		public function set strRaiseLabel(value:String):void
		{
			m_strRaiseLabel = value;
		}

		
		/********************* END GETTER && SETTER *******************/
	}
}