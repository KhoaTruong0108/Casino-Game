package controller
{
	import components._comp_Confirmation_Box;
	import components._comp_Message_Box;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import model.M_ConfirmationBox;
	
	import mx.managers.PopUpManager;
	
	import zUtilities.MainController;

	public class C_ConfirmationBox
	{
		private var m_mConfirmBox:M_ConfirmationBox = M_ConfirmationBox.getInstance();
		
		private var m_cMain:MainController = MainController.getInstance();
		
		private var _countDown: int
		
		public function C_ConfirmationBox()
		{
		}
		//*******************************************************************
		//				Timer section
		//*******************************************************************
		public function startTimer(time: int, listener: Function):void {
			stopTimer();
			_countDown = time / 1000 - 2;
			m_mConfirmBox.timer = new Timer(1000);
			m_mConfirmBox.timer.addEventListener(TimerEvent.TIMER, listener);
			m_mConfirmBox.timer.start();
		}
		public function stopTimer():void {
			if(m_mConfirmBox.timer != null)
				m_mConfirmBox.timer.stop();
		}
		public function resetTimer():void {
			m_mConfirmBox.timer.reset();
		}
		
		public function onUpdateTime(evt:TimerEvent):void{
			try{
				m_mConfirmBox.strSecond = _countDown.toString();
				if(_countDown <= 0){
					stopTimer();
					m_mConfirmBox.fnCancel();
					closeBox();
				}
				_countDown--;
			}catch(error: Error){
				trace(error.message);
			}
		}
		//*******************************************************************
		public function showMessageBox(fnOk: Function, fnCancel: Function, message:String, title:String = "", second: int = -1):void{
			m_mConfirmBox.strMessage = message;
			
			if(title == ""){
				title = "INFOMATION";
			}
			m_mConfirmBox.strTitle = title;
			m_mConfirmBox.vConfirmBox = new _comp_Confirmation_Box();
			
			if(second > 0){
				m_mConfirmBox.strSecond = (second / 1000 - 2).toString();
				startTimer(second, onUpdateTime)
			}
			
			m_mConfirmBox.fnOk = fnOk;
			m_mConfirmBox.fnCancel = fnCancel;
			
			PopUpManager.addPopUp(m_mConfirmBox.vConfirmBox, m_cMain.vMain, true);
			PopUpManager.centerPopUp(m_mConfirmBox.vConfirmBox);
		}
		
		public function closeBox():void{
			PopUpManager.removePopUp(m_mConfirmBox.vConfirmBox);
		}
		
		public function handleOkButton_Click(event:Event):void{
			stopTimer();
			m_mConfirmBox.fnOk();
			closeBox();
		}
		
		public function handleCancelButton_Click(event:Event):void{
			stopTimer();
			m_mConfirmBox.fnCancel();
			closeBox();
		}
	}
}