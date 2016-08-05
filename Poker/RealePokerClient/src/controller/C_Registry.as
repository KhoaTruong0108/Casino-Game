package controller
{
	import Message.event.ConnectionEvent;
	import Message.event.ConnectionLostEvent;
	import Message.event.LoginErrorEvent;
	import Message.event.LoginEvent;
	import Message.event.general.GENERAL_EVENT_NAME;
	import Message.event.general.RegisterErrorEvent;
	import Message.event.web.REGISTER_RESPONSE_NAME;
	import Message.request.LoginRequest;
	import Message.request.general.RegisterRequest;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.User;
	
	import entity.UserEntity;
	
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	
	import model.M_Login;
	import model.M_Registry;
	
	import mx.events.ValidationResultEvent;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.validators.ValidationResult;
	
	import params.ResponseParams;
	import params.UserInfoParams;
	
	import spark.components.Application;
	
	import zUtilities.GameVariable;
	import zUtilities.MainController;
	import zUtilities.ServerController;
	
	public class C_Registry
	{
		private var m_mRegistry : M_Registry = M_Registry.getInstance();
		private var m_serverController : ServerController = ServerController.getInstance();
		private var m_cMain:MainController = MainController.getInstance();
		
		private var m_httpService : HTTPService = new HTTPService();
		
		protected var fileRef: FileReference; 
		
		public function C_Registry()
		{	
			fileRef = new FileReference();
			fileRef.addEventListener(Event.SELECT,fileSelectHandler);
			fileRef.addEventListener(Event.CANCEL, fileCancelHandler);
			fileRef.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			fileRef.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			fileRef.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorEvent);
			fileRef.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			fileRef.addEventListener(Event.COMPLETE, fileCompleteHandler);
			fileRef.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, fileDataCompleteHandler);
			
			//m_serverController.addEventListener(GENERAL_EVENT_NAME.REGISTER, onRegister);
			//m_serverController.addEventListener(GENERAL_EVENT_NAME.REGISTER_ERROR,onRegisterError);
			
			m_httpService.addEventListener("result", onRegisterResponse);
		}
		protected function fileSelectHandler(event: Event):void{
			//Finish Selected Image To Upload
			m_mRegistry.Avatar = fileRef.name;
		}
		protected function fileCancelHandler(event: Event):void{
		}
		protected function httpStatusHandler(event: HTTPStatusEvent):void{
			m_mRegistry.Status = event.status.toString();
			
		}
		protected function ioErrorHandler(event: IOErrorEvent):void{
			m_mRegistry.Status = event.text;
		}
		protected function securityErrorEvent(event: SecurityErrorEvent):void{
			m_mRegistry.Status = event.text;
		}
		protected function progressHandler(event: ProgressEvent):void{
			/*var percent : Number = 0;
			if(event.bytesTotal != 0){
				percent = event.bytesLoaded/event.bytesTotal*100;
				percent = Math.round(percent);
			}
			m_mRegistry.Status = percent.toString() + "%";*/
		}
		protected function fileCompleteHandler(event: Event):void{
			
		}
		protected function fileDataCompleteHandler(event: DataEvent):void{
			if(event.text == "true")
				//m_mRegistry.Status = "Upload Success";
				m_mRegistry.Status = "Registry successful!!!";	
			else if(event.text == "fail")
				m_mRegistry.Status = "Upload Fail";
			
		}
		protected function onRegisterResponse(event:ResultEvent):void
		{
			if(event.result){
				//m_mRegistry.Status = "Registry successful!!!";	
				handleAvatarUpload();
			}else{
				m_mRegistry.Status = "Registry false!!!";	
			}
		}
		
		protected function onRegisterFailResponse(evt: FaultEvent):void{
			m_mRegistry.Status = "HTTP FAULT";
			m_mRegistry.Status += evt.fault.message;
		}
		
		/*private function onRegisterError(event: Event):void
		{
			var evt: RegisterErrorEvent = event as RegisterErrorEvent;
			m_mRegistry.Status = evt.message;
		}
		
		private function onRegister(event: Event):void
		{
			m_mRegistry.Status = "Registry successful!!!";	
			m_cMain.gotoState_Start();
		}*/
		
		private function sendRegistryRequest():void{
			var request: RegisterRequest = new RegisterRequest();
			
			request.AddParam(RegisterRequest.USER_NAME, m_mRegistry.UserName);
			request.AddParam(RegisterRequest.PASSWORD, m_mRegistry.Password);
			request.AddParam(RegisterRequest.EMAIL, m_mRegistry.Email);
			
			m_serverController.SendCustomRequest(request);
		}
		
		private function sendRegistrerHttpRequest():void{
			m_httpService.url = "http://localhost:8008/register";
			m_httpService.method = "POST";
			
			
			var param: Object = new Object();
			param.userName = m_mRegistry.UserName;
			param.password = m_mRegistry.Password;
			param.email = m_mRegistry.Email;
			param.displayName = m_mRegistry.UserName;
			
			m_httpService.send(param);
		}
		
		public function handleSignUpButton_Click(event: Event):void{
			m_mRegistry.EmailValid = "";
			
			var isValid: Boolean = true;
			
			if(m_mRegistry.UserName == ""){
				m_mRegistry.UserNameValid = "Please input User name";
				isValid = false;
			}
			if(m_mRegistry.Password == ""){
				m_mRegistry.PasswordValid = "Please input Password";
				isValid = false;
			}
			if(m_mRegistry.ConfirmPass != m_mRegistry.Password){
				m_mRegistry.ConfirmPassValid = "Confirm pass not match with Password";
				isValid = false;
			}
			if(isValid == true && m_mRegistry.isEmailValid == true){
				//sendRegistryRequest();
				sendRegistrerHttpRequest();
				//m_cMain.gotoState_Start();
			}
		}
		
		public function handleCancelButton_Click(event: Event):void{
			m_cMain.gotoState_Start();
		}
		
		public function emailInput_focusOut(evt: Event):void{
			m_mRegistry.isEmailValid = false;
			m_cMain.vMain.m_emailValidator.validate(m_mRegistry.Email);
		}
		
		public function emailValidator_valid(evt: ValidationResultEvent):void{
			m_mRegistry.isEmailValid = true;
		}
		
		public function emailValidator_invalid(evt: ValidationResultEvent):void{
			m_mRegistry.EmailValid = evt.message;
			m_mRegistry.isEmailValid = false;
		}
		
		protected function handleAvatarUpload():void
		{
			var UPLOAD_URL : String = "HTTP://localhost:8008/upload";
			//Upload Image
			if(fileRef != null && 	fileRef.name != null && fileRef.name.length > 0){
				fileRef.upload(new URLRequest(UPLOAD_URL), m_mRegistry.UserName);		
			}
		}
		public function HandleFileBrowser(event:MouseEvent):void
		{
			//browser file to upload
			var imgFilter : FileFilter = new FileFilter("Image Only(.jpg,.jpeg)", "*.jpg;*.jpeg;");
			fileRef.browse(new Array(imgFilter));				
		}
	}
}