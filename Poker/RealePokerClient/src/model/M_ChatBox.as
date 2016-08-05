package model
{
	import mx.collections.ArrayCollection;
	
	import zUtilities.GameVariable;
	import zUtilities.MainController;

	public class M_ChatBox
	{
		private static var m_instance:M_ChatBox = null;
		private static var m_isAllowed:Boolean = false;
		
		private var m_strChatMessage:String = "";
		
		private var m_cMain:MainController = MainController.getInstance();
		
		public function M_ChatBox()
		{
			if(m_isAllowed == false){
				throw new Error("------");
			}
		}
		
		public static function getInstance():M_ChatBox{
			if(m_instance == null){
				m_isAllowed = true;
				m_instance = new M_ChatBox();
				m_isAllowed = false;				
			}
			return m_instance;
		}

		/*public function addChatMessage(senderName:String, msg:String):void{
			if(senderName == m_globalVar.myUsername){				
				m_cMain.vMain.m_comChat.myMessage(senderName, msg);
			}
			else{
				m_cMain.vMain.m_comChat.userMessage(senderName, msg);
			}			
		}*/
		public function addChatMessage(senderName:String, msg:String):void{
			if(senderName == GameVariable.GetInstance().UserInfo.UserName){				
				m_cMain.vMain.m_comChat.myMessage(senderName, msg);
			}
			else{
				m_cMain.vMain.m_comChat.userMessage(senderName, msg);
			}			
		}
		
		public function addSysMessage(msg:String):void{
			m_cMain.vMain.m_comChat.sysMessage(msg);
		}
		
		public function clearAll():void{
			m_cMain.vMain.m_comChat.clearAll();
		}
		
		[Bindable]
		public function get strChatMessage():String
		{
			return m_strChatMessage;
		}

		public function set strChatMessage(value:String):void
		{
			m_strChatMessage = value;
		}
		
		
	}
}