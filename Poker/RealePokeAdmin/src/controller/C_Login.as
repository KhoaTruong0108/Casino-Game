package controller
{
	import Message.event.ConnectionEvent;
	import Message.event.ConnectionLostEvent;
	import Message.event.LoginErrorEvent;
	import Message.event.LoginEvent;
	import Message.request.LoginRequest;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import entity.AdminEntity;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import model.M_Login;
	
	import spark.components.Application;
	
	import zUtilities.GameVariable;
	import zUtilities.ServerController;
	
	
	public class C_Login
	{
		private var m_mLogin : M_Login = M_Login.getInstance();
		private var m_serverController : ServerController = ServerController.getInstance();
		private var m_cMain:MainController = MainController.getInstance();
		
		
		public function C_Login()
		{	
			m_serverController.addEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, onLoadConfigSuccess);
			m_serverController.addEventListener(SFSEvent.CONFIG_LOAD_FAILURE,onLoadConfigFail);
			m_serverController.addEventListener(SFSEvent.CONNECTION, onConnection);
			m_serverController.addEventListener(SFSEvent.CONNECTION_LOST, onConnectionLost);			
			m_serverController.addEventListener(SFSEvent.LOGIN, onLogin);
			m_serverController.addEventListener(SFSEvent.LOGIN_ERROR, onLoginError);
			m_serverController.addEventListener(SFSEvent.LOGOUT, onLogout);
			
			// load client config
			m_serverController.loadConfig();
		}
		
		public function HandleLogin(event: Event):void{			
			if(m_mLogin.UserName == ""){
				m_mLogin.Status = "Please input username";
				return;
			}	
			
			if(m_mLogin.Password == ""){
				m_mLogin.Status = "Please input password";
				return;
			}
			if(m_serverController.isConnected())
				login();
			else{
				m_serverController.connect();
				login();
			}
		}
		
		public function logout():void{
			m_serverController.disconnect();
		}
		
		private function onLoadConfigSuccess(evt: Event):void{
			m_mLogin.Status = "Waiting for connect ...";
			m_serverController.connect();
		}
		
		private function onLoadConfigFail(evt: Event):void{
			m_mLogin.Status = "Loading config fail!";
			
		}
		
		private function onConnection(evt: Event):void{
			//var success:Boolean = Boolean(sfsEvent.params.success);
			var connectEvt: ConnectionEvent = evt as ConnectionEvent;
			if(connectEvt.Success){				
				m_mLogin.isConnected = true;
				m_mLogin.Status = "Connect success!";
				
				m_mLogin.UserName = "admin";
				m_mLogin.Password = "admin";
				//login();
			}
			else{
				m_mLogin.Status = "Cannot connect to server!";				
			}
		}
		
		private function login():void{
			m_mLogin.Status = "Waitting for login ...";		
			if(m_mLogin.UserName != null && m_mLogin.Password != null){
				var param:SFSObject = new SFSObject();
				param.putUtfString("role", "admin");
				m_serverController.sendRequest(new LoginRequest(m_mLogin.UserName, m_mLogin.Password, null, param));
			}
		}
		
		private function onConnectionLost(evt: Event):void{
			var connectLostEvt: ConnectionLostEvent = evt as ConnectionLostEvent;
			m_mLogin.isConnected = false;
			m_cMain.gotoState_Login();
			m_mLogin.Status = "Connection lost, reason: " + connectLostEvt.Reason;
			m_serverController.connect();
		}
		
		private function onLogin(evt: Event):void{
			try{
				var loginEvt: LoginEvent = evt as LoginEvent;
				GameVariable.GetInstance().UserInfo = AdminEntity.FromUser(loginEvt.UserInfo);
				
				m_cMain.gotoState_Admin();
			}
			catch(err:Error){
				m_mLogin.Status = err.message;
			}
		}
		
		private function onLoginError(evt: Event):void{		
			var loginErrorEvt: LoginErrorEvent = evt as LoginErrorEvent;
			m_mLogin.UserName = "";
			m_mLogin.Password = "";
			m_mLogin.Status = loginErrorEvt.ErrorMessage;
			m_serverController.connect();
			
			////login automatically
			/*loginIndex++;
			m_mLogin.UserName = "user" + loginIndex;
			m_mLogin.Password = "1";
			login();*/
		}
		
		private function onLogout(event: Event):void{
			m_cMain.gotoState_Login();
		}
		
		/*private var loginIndex: int = 0;
		public function handleLoginAutomatic():void{
			m_mLogin.UserName = "user" + loginIndex;
			m_mLogin.Password = "1";
			login();
		}*/
	}
}