package model
{
	import components._comp_Confirmation_Box;
	import components._comp_Message_Box;
	
	import flash.utils.Timer;
	
	import zUtilities.MainController;

	public class M_DebugLog
	{
		
		private static var m_instance:M_DebugLog = null;
		private static var m_isAllowed:Boolean = false;
		
		private var m_strText:String;
		private var m_isVisible: Boolean;
		
		public function M_DebugLog()
		{
			if(m_isAllowed == false){
				throw new Error("");
			}
		}
		
		public static function getInstance():M_DebugLog{
			if(m_instance == null){
				m_isAllowed = true;
				m_instance = new M_DebugLog();
				m_isAllowed = false;
			}
			return m_instance;
		}
		
		

		[Bindable]
		public function get strText():String
		{
			return m_strText;
		}

		public function set strText(value:String):void
		{
			m_strText = value;
		}

		[Bindable]
		public function get isVisible():Boolean
		{
			return m_isVisible;
		}

		public function set isVisible(value:Boolean):void
		{
			m_isVisible = value;
		}


	}
}