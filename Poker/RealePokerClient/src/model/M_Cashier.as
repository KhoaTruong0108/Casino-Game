package model
{
	import com.smartfoxserver.v2.requests.PublicMessageRequest;
	
	import mx.collections.ArrayCollection;
	
	import zUtilities.GameVariable;
	import zUtilities.NumberFormat;

	public class M_Cashier
	{
		private static var m_instance:M_Cashier = null;
		private static var m_isAllowed:Boolean = false;
		
		
		private var m_strUsername:String;
		private var m_strFish:String; 
		private var m_arrCashier:ArrayCollection;		
		
		public function M_Cashier(){
			if(m_isAllowed == false){
				throw new Error("");
			}
			m_arrCashier = new ArrayCollection();
			updateUseInfo();
		}
		
		public static function getInstance():M_Cashier{
			if(m_instance == null){
				m_isAllowed = true;
				m_instance = new M_Cashier();
				m_isAllowed = false;
			}
			return m_instance;		
		}

		/*public function updateUseInfo():void{
			m_strUsername = m_globalVar.myUsername;
			m_strFish = m_globalVar.myFish.toString();
		}*/
		public function updateUseInfo():void{
			if(GameVariable.GetInstance().UserInfo != null){
				strUsername = GameVariable.GetInstance().UserInfo.UserName;
				var chip: Number = GameVariable.GetInstance().UserInfo.Chip;
				strFish = NumberFormat.getDecimalFormat(chip);
			}
		}
		
		public function addCashier(date:Number, action:String, amount:Number, by:String):void{
			var item:Object = new Object();
			item.date = NumberFormat.getFormatDate(date);
			item.action = action;
			item.amount = NumberFormat.getDecimalFormat(amount);
			item.by = by;
			m_arrCashier.addItem(item);
		}
		
		public function clearCashier():void{
			m_arrCashier.removeAll();
		}
		
		[Bindable]
		public function get strFish():String
		{
			return m_strFish;
		}

		public function set strFish(value:String):void
		{
			m_strFish = value;
		}

		[Bindable]
		public function get strUsername():String
		{
			return m_strUsername;
		}

		public function set strUsername(value:String):void
		{
			m_strUsername = value;
		}

		[Bindable]
		public function get arrCashier():ArrayCollection
		{
			return m_arrCashier;
		}

		public function set arrCashier(value:ArrayCollection):void
		{
			m_arrCashier = value;
		}


	}
}