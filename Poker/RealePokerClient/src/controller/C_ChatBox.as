package controller
{
	import Message.event.PublicMessageEvent;
	import Message.request.PublicMessageRequest;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.entities.User;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import model.M_ChatBox;
	
	import zUtilities.GameVariable;
	import zUtilities.ServerController;

	public class C_ChatBox
	{
		private static var m_isAllowed:Boolean = false;
		private static var m_instance:C_ChatBox = null;
		
		
		private var m_mChatBox:M_ChatBox = M_ChatBox.getInstance();
		private var m_server:ServerController = ServerController.getInstance();
		
		private var m_chatTimer:Timer = null;
		private var m_isBusy:Boolean = false;
		
		
		public function C_ChatBox()
		{
			if(m_isAllowed == false){
				throw new Error("------");
			}
			m_server.addEventListener(SFSEvent.PUBLIC_MESSAGE, onPublicMessage);
		}
		
		public static function getInstance():C_ChatBox{
			if(m_instance == null){
				m_isAllowed = true;
				m_instance = new C_ChatBox();
				m_isAllowed = false;				
			}
			return m_instance;
		}
		
		public function handleBtnSendChat_click(event:Event):void{
			if(m_mChatBox.strChatMessage == ""){
				return;
			}
			if(m_isBusy == false){
				m_server.sendRequest(new PublicMessageRequest(m_mChatBox.strChatMessage));
				m_mChatBox.strChatMessage = "";
			}
			else{
				m_mChatBox.addSysMessage("Do not enter so fast!");
			}
		}
		
		private function startChatTimer():void{
			if(m_isBusy == false){
				m_isBusy = true;
				var timer:Timer = new Timer(3000, 1);				
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, function(event:TimerEvent):void{
					m_isBusy = false;
				});
				timer.start();
			}
		}
		
		public function logGameAction(msg: String):void{
			if(msg != null){
				m_mChatBox.addSysMessage(msg);
			}
		}
		
		public function clearAll():void{
			m_mChatBox.clearAll();
		}
		
		//khoatd edited
		/*private function onPublicMessage(event:SFSEvent):void{
			var room:Room = event.params.room as Room;
			var sender:User = event.params.sender as User;
			var message:String = event.params.message as String;
			if(room.name == m_globalVar.curTable.name){
				m_mChatBox.addChatMessage(sender.name,message);
			}
		}*/
		private function onPublicMessage(event:Event):void{
			var evt: PublicMessageEvent = event as PublicMessageEvent;
			var room:Room = evt.RoomInfo;
			var sender:User = evt.Sender;
			var message:String = evt.Message;
			if(room.name == GameVariable.GetInstance().CurrentRoom.name){
				m_mChatBox.addChatMessage(sender.name,message);
			}
		}
	}
}