package model
{
	import components._comp_Confirmation_Box;
	import components._comp_Message_Box;
	
	import flash.utils.Timer;

	public class M_ConfirmationBox
	{
		
		private static var m_instance:M_ConfirmationBox = null;
		private static var m_isAllowed:Boolean = false;
		
		private var m_strTitle:String;
		private var m_strMessage:String;
		private var m_vConfirmBox:_comp_Confirmation_Box;
		private var m_strSecond: String;
		
		private var _fnOk: Function;
		private var _fnCancel: Function;
		
		private var _timer: Timer;
		
		public function M_ConfirmationBox()
		{
			if(m_isAllowed == false){
				throw new Error("");
			}
		}
		
		public static function getInstance():M_ConfirmationBox{
			if(m_instance == null){
				m_isAllowed = true;
				m_instance = new M_ConfirmationBox();
				m_isAllowed = false;
			}
			return m_instance;
		}

		[Bindable]
		public function get strTitle():String
		{
			return m_strTitle;
		}

		public function set strTitle(value:String):void
		{
			m_strTitle = value;
		}

		[Bindable]
		public function get strMessage():String
		{
			return m_strMessage;
		}

		public function set strMessage(value:String):void
		{
			m_strMessage = value;
		}

		[Bindable]
		public function get vConfirmBox():_comp_Confirmation_Box
		{
			return m_vConfirmBox;
		}

		public function set vConfirmBox(value:_comp_Confirmation_Box):void
		{
			m_vConfirmBox = value;
		}

		[Bindable]
		public function get strSecond():String
		{
			return m_strSecond;
		}

		public function set strSecond(value:String):void
		{
			m_strSecond = value;
		}

		public function get fnOk():Function
		{
			return _fnOk;
		}

		public function set fnOk(value:Function):void
		{
			_fnOk = value;
		}

		public function get fnCancel():Function
		{
			return _fnCancel;
		}

		public function set fnCancel(value:Function):void
		{
			_fnCancel = value;
		}

		public function get timer():Timer
		{
			return _timer;
		}

		public function set timer(value:Timer):void
		{
			_timer = value;
		}


	}
}