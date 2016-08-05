package controller
{
	import components._comp_Message_Box;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import model.M_MessageBox;
	
	import mx.managers.PopUpManager;
	
	import zUtilities.MainController;

	public class C_MessageBox
	{
		private var m_mMessageBox:M_MessageBox = M_MessageBox.getInstance();
		
		private var m_cMain:MainController = MainController.getInstance();
		
		private var _countDown: int;
		private var SHOW_TIME: int = 15 * 1000;
		
		public function C_MessageBox()
		{
		}
		
		//*******************************************************************
		//				Timer section
		//*******************************************************************
		public function startTimer(time: int):void {
			stopTimer();
			_countDown = time / 1000;
			m_mMessageBox.timer = new Timer(1000);
			m_mMessageBox.timer.addEventListener(TimerEvent.TIMER, onUpdateTime);
			m_mMessageBox.timer.start();
		}
		public function stopTimer():void {
			if(m_mMessageBox.timer != null)
				m_mMessageBox.timer.stop();
		}
		public function resetTimer():void {
			m_mMessageBox.timer.reset();
		}
		
		public function onUpdateTime(evt:TimerEvent):void{
			try{
				if(_countDown <= 0){
					stopTimer();
					closeBox();
				}
				_countDown--;
			}catch(error: Error){
				trace(error.message);
			}
		}
		
		public function showMessageBox(message:String, title:String=""):void{
			m_mMessageBox.strMessage = message;
			if(title == ""){
				title = "INFOMATION";
			}
			m_mMessageBox.strTitle = title;
			m_mMessageBox.vMessageBox = new _comp_Message_Box();
			PopUpManager.addPopUp(m_mMessageBox.vMessageBox, m_cMain.vMain, true);
			PopUpManager.centerPopUp(m_mMessageBox.vMessageBox);
			
			startTimer(SHOW_TIME);
		}
		
		public function closeBox():void{
			PopUpManager.removePopUp(m_mMessageBox.vMessageBox);
		}
	}
}