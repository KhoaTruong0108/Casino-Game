package controller
{
	import Message.event.UserVariableUpdateEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.requests.ExtensionRequest;
	
	import entity.AdminEntity;
	
	import flash.events.Event;
	
	import view.RealePokeAdmin;
	
	import zUtilities.ServerController;

	public class MainController
	{
		public static const STATE_LOGIN:String = "Login";
		public static const STATE_ADMIN:String = "Admin";
		
		private static var m_bAllowed:Boolean = false;
		private static var m_instance:MainController = null;
		
		private var m_server:ServerController = ServerController.getInstance();
		
		
		private var m_Main:RealePokeAdmin;
		
		
		
		
		public function MainController(){
			if(m_bAllowed == false){
				throw new Error("Cannot create an instance of an singleton class!");
			}			
		}
		
		public static function getInstance():MainController{
			if(m_instance == null){
				m_bAllowed = true;
				m_instance = new MainController();
				m_bAllowed = false;
			}
			return m_instance;
		}
		
		public function setMain(m:RealePokeAdmin):void{
			m_Main = m;
		}
		
		public function getCurrentState():String {
			return this.m_Main.currentState;
		}
		
		public function gotoState_Login():void{
			this.m_Main.setCurrentState(STATE_LOGIN);
		}
		
		public function gotoState_Admin():void{
			this.m_Main.setCurrentState(STATE_ADMIN);
		}
		
		public function handleBtnLogout(event:Event):void{
			gotoState_Login();
		}		

		public function get vMain():RealePokeAdmin
		{
			return m_Main;
		}
		
	}
}