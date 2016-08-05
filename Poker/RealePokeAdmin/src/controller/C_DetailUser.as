package controller
{
	import Message.event.ConnectionEvent;
	import Message.event.ConnectionLostEvent;
	import Message.event.LoginErrorEvent;
	import Message.event.LoginEvent;
	import Message.event.admin.*;
	import Message.event.admin.ADMIN_RESPONSE_NAME;
	import Message.request.LoginRequest;
	import Message.request.admin.*;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.User;
	
	import components._comp_detailUser;
	
	import entity.AdminEntity;
	import enum.ManagedObject;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import model.M_Admin;
	import model.M_DetailUser;
	import model.M_Login;
	
	import mx.collections.ArrayCollection;
	import mx.managers.PopUpManager;
	
	import spark.components.Application;
	
	import zUtilities.GameVariable;
	import zUtilities.ServerController;
	
	
	public class C_DetailUser
	{
		private var m_mDetail : M_DetailUser = M_DetailUser.getInstance();
		private var m_serverController : ServerController = ServerController.getInstance();
		private var m_cMain:MainController = MainController.getInstance();
		
		public function C_DetailUser()
		{	
			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.CREATE_RES, onCreateUserRes);
			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.CREATE_ERROR_RES,onCreateUserErrorRes);
			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.UPDATE_RES, onUpateUserRes);
			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.UPDATE_ERROR_RES,onUpateUserErrorRes);
		}
		
		private function onUpateUserErrorRes(evt: Event):void
		{
			var response: UpdateErrorRes = evt as UpdateErrorRes;
			m_mDetail.status = response.Message;
		}
		
		private function onUpateUserRes(evt: Event):void
		{
			var response: UpdateRes = evt as UpdateRes;
			if(response.ObjUpdated == ManagedObject.USER)
				m_mDetail.status = response.Message;
		}
		
		private function onCreateUserErrorRes(evt: Event):void
		{
			var response: CreateErrorRes = evt as CreateErrorRes;
			m_mDetail.status = response.Message;
		}
		
		private function onCreateUserRes(evt: Event):void
		{
			var response: CreateRes = evt as CreateRes;
			if(response.ObjCreated == ManagedObject.USER){
				m_mDetail.status = response.Message;
			}
		}
		
		public function handleUpdate():void{
			var request: UpdateUserRequest = new UpdateUserRequest();
			
			var chip: Number = 0;
			if(m_mDetail.chip != "")
				chip = parseFloat(m_mDetail.chip);
			
			request.AddParam("user_name", m_mDetail.name);
			request.AddParam("display_name", m_mDetail.displayName);
			request.AddParam("password", m_mDetail.password);
			request.AddParam("email", m_mDetail.email);
			request.AddParam("chip", chip);
			request.AddParam("location", m_mDetail.location);
			request.AddParam("tour_chip", 0.0);
			request.AddParam("buy_in", 0.0);
			request.AddParam("avartar", "");
			
			m_serverController.SendCustomRequest(request);
			
			m_mDetail.status = "";
		}
		
		public function handleCreate():void{
			var request: CreateUserRequest = new CreateUserRequest();
			
			var chip: Number = 0;
			if(m_mDetail.chip != "")
				chip = parseFloat(m_mDetail.chip);
			
			request.AddParam("user_name", m_mDetail.name);
			request.AddParam("display_name", m_mDetail.displayName);
			request.AddParam("password", m_mDetail.password);
			request.AddParam("email", m_mDetail.email);
			request.AddParam("chip", chip);
			request.AddParam("location", m_mDetail.location);
			request.AddParam("tour_chip", 0.0);
			request.AddParam("buy_in", 0.0);
			request.AddParam("avartar", "");
			
			m_serverController.SendCustomRequest(request);
			
			m_mDetail.status = "";
		}
		
		public function showUserDetailBox(user: Object):void{
			m_mDetail.vDetailUser = new _comp_detailUser();
			m_mDetail.clearAll();
			
			if(user != null){
				m_mDetail.name = user.UserName;
				m_mDetail.displayName = user.DisplayName;
				m_mDetail.email = user.Email;
				m_mDetail.location = user.Location;
				m_mDetail.password = user.Password;
				m_mDetail.chip = user.Chip;
				
				m_mDetail.isCreate = false;
			}else{
				m_mDetail.isCreate = true;
			}
			
			PopUpManager.addPopUp(m_mDetail.vDetailUser, m_cMain.vMain, true);
			PopUpManager.centerPopUp(m_mDetail.vDetailUser);
		}
		
		public function hideUserDetailBox():void{
			PopUpManager.removePopUp(m_mDetail.vDetailUser);
		}
		
	}
}