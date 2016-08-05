package zUtilities
{
	import Message.event.UserVariableUpdateEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.requests.ExtensionRequest;
	
	import entity.UserEntity;
	
	import flash.events.Event;
	
	import params.UserInfoParams;
	
	import view.Main;

	public class MainController
	{
		public static const STATE_START:String = "Start";
		public static const STATE_REGISTRY:String = "Registry";
		public static const STATE_LOBBY_CASH:String = "Lobby_Cash";
		public static const STATE_LOBBY_TOURNAMENT:String = "Lobby_Tournament";
		public static const STATE_CASHIER:String = "Cashier";
		public static const STATE_TABLE:String = "Table";
		
		private static var m_bAllowed:Boolean = false;
		private static var m_instance:MainController = null;
		
		private var m_server:ServerController = ServerController.getInstance();
		
		
		private var m_Main:Main;
		
		
		
		
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
		
		public function setMain(m:Main):void{
			m_Main = m;
		}
		
		public function getCurrentState():String {
			return this.m_Main.currentState;
		}
		
		public function gotoState_Start():void{
			this.m_Main.setCurrentState(STATE_START);
		}
		
		public function gotoState_Registry():void{
			this.m_Main.setCurrentState(STATE_REGISTRY);
		}
		
		public function gotoState_Lobby_Cash():void{
			this.m_Main.setCurrentState(STATE_LOBBY_CASH);
		}
		
		public function gotoState_Lobby_Tournament():void{
			this.m_Main.setCurrentState(STATE_LOBBY_TOURNAMENT);			
		}
		
		public function gotoState_Cashier():void{
			// go to state Cashier
			this.m_Main.setCurrentState(STATE_CASHIER);
			
			// retrieve cashier list
			this.retrieveCashier();
		}
		
		public function gotoState_Game():void{
			this.m_Main.setCurrentState(STATE_TABLE);
		}
		
		public function handleBtnPoker(event:Event):void{
			gotoState_Lobby_Cash();
		}
		
		public function handleBtnTournament(event:Event):void{
			gotoState_Lobby_Tournament();
		}
		
		public function handleBtnCashier(event:Event):void{
			gotoState_Cashier();
		}
		
		public function handleBtnCashierLobby(event:Event):void{
			gotoState_Lobby_Cash();
		}
		
		public function handleBtnLogout(event:Event):void{
			gotoState_Start();
		}		

		public function get vMain():Main
		{
			return m_Main;
		}
		
		private function retrieveCashier():void{
			/*var param:ISFSObject = new SFSObject();
			m_server.sendRequest(new ExtensionRequest(CustomRequest.USER_RETRIEVE_CASHIER, param));*/
		}
		
		/*private function onUserVariableUpdate(event: Event):void{
			try{
				var changedVars:Array = event.params.changedVars as Array;			
				var user:User = event.params.user as User;
				
				if(changedVars.indexOf(UserInfoParams.BALANCE) != -1 
					&& user.name == m_globalVar.myUsername){
					m_globalVar.myFish = user.getVariable(UserInfoParams.BALANCE).getDoubleValue();					
				}
				
			}catch(err:Error){
				trace(err.message);
			}
		}*/
	}
}