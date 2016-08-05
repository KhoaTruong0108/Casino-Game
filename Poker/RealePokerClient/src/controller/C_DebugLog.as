package controller
{
	import components._comp_Confirmation_Box;
	import components._comp_Message_Box;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import model.M_ConfirmationBox;
	import model.M_DebugLog;
	
	import mx.managers.PopUpManager;
	
	import zUtilities.MainController;

	public class C_DebugLog
	{
		private var m_mDebugLog:M_DebugLog = M_DebugLog.getInstance();
		
		public function C_DebugLog()
		{
		}
		
		public function addText(msg: String):void{
		if(m_mDebugLog.strText == null)
			m_mDebugLog.strText = "";
		
		m_mDebugLog.strText = msg + "\n" + m_mDebugLog.strText;
		
		//if(m_cMain.vMain != null)
		//m_cMain.vMain.m_txtDebugLog.text = m_strText;
		}
	}
}