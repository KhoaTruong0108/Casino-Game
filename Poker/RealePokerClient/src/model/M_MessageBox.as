package model
{
	import components._comp_Message_Box;
	
	import flash.utils.Timer;

	public class M_MessageBox
	{
		
		private static var m_instance:M_MessageBox = null;
		private static var m_isAllowed:Boolean = false;
		
		private var m_strTitle:String;
		private var m_strMessage:String;
		private var m_vMessageBox:_comp_Message_Box;
		
		private var _timer: Timer;
		
		public function M_MessageBox()
		{
			if(m_isAllowed == false){
				throw new Error("");
			}
		}
		
		public static function getInstance():M_MessageBox{
			if(m_instance == null){
				m_isAllowed = true;
				m_instance = new M_MessageBox();
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
		public function get vMessageBox():_comp_Message_Box
		{
			return m_vMessageBox;
		}

		public function set vMessageBox(value:_comp_Message_Box):void
		{
			m_vMessageBox = value;
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