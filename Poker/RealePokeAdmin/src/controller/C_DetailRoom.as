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
	import com.smartfoxserver.v2.entities.Room;
	
	import components._comp_detailRoom;
	
	import entity.AdminEntity;
	
	import enum.ManagedObject;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import model.M_Admin;
	import model.M_DetailRoom;
	import model.M_Login;
	
	import mx.collections.ArrayCollection;
	import mx.managers.PopUpManager;
	
	import spark.components.Application;
	
	import zUtilities.GameVariable;
	import zUtilities.ServerController;
	
	
	public class C_DetailRoom
	{
		private var m_mDetail : M_DetailRoom = M_DetailRoom.getInstance();
		private var m_serverController : ServerController = ServerController.getInstance();
		private var m_cMain:MainController = MainController.getInstance();
		
		
		public function C_DetailRoom()
		{	
			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.CREATE_RES, onCreateRoomRes);
			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.CREATE_ERROR_RES,onCreateRoomErrorRes);
			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.UPDATE_RES, onUpateRoomRes);
			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.UPDATE_ERROR_RES,onUpateRoomErrorRes);
		}
		
		private function onUpateRoomErrorRes(evt: Event):void
		{
			var response: UpdateErrorRes = evt as UpdateErrorRes;
			m_mDetail.status = response.Message;
		}
		
		private function onUpateRoomRes(evt: Event):void
		{
			var response: UpdateRes = evt as UpdateRes;
			if(response.ObjUpdated == ManagedObject.ROOM)
				m_mDetail.status = response.Message;
		}
		
		private function onCreateRoomErrorRes(evt: Event):void
		{
			var response: CreateErrorRes = evt as CreateErrorRes;
			m_mDetail.status = response.Message;
		}
		
		private function onCreateRoomRes(evt: Event):void
		{
			var response: CreateRes = evt as CreateRes;
			if(response.ObjCreated == ManagedObject.ROOM){
				m_mDetail.status = response.Message;
			}
		}
		
		public function handleUpdate():void{
			var request: UpdateRoomRequest = new UpdateRoomRequest();
			
			var betChip: Number = 0;
			if(m_mDetail.betChip != "")
				betChip = parseFloat(m_mDetail.betChip);
			
			var maxRoom: Number = 0;
			if(m_mDetail.maxUser != "")
				maxRoom = parseInt(m_mDetail.maxUser);
			
			var minChip: Number = 0;
			if(m_mDetail.minBuyin != "")
				minChip = parseFloat(m_mDetail.minBuyin);
			
			var maxChip: Number = 0;
			if(m_mDetail.maxBuyin != "")
				maxChip = parseFloat(m_mDetail.maxBuyin);
			
			request.AddParam("name", m_mDetail.name);
			request.AddParam("display_name", m_mDetail.displayName);
			request.AddParam("password", m_mDetail.password);
			request.AddParam("bet_chip", betChip);
			request.AddParam("max_user", maxRoom);
			request.AddParam("min_buy_in", minChip);
			request.AddParam("max_buy_in", maxChip);
			request.AddParam("no_limit", m_mDetail.noLimit);
			request.AddParam("status", "");
			request.AddParam("small_blind", betChip);
			request.AddParam("big_blind", betChip * 2);
			request.AddParam("create_by", "");
			
			m_serverController.SendCustomRequest(request);
			
			m_mDetail.status = "";
		} 
		
		public function handleCreate():void{
			var request: CreateRoomRequest = new CreateRoomRequest();
			
			var betChip: Number = 0;
			if(m_mDetail.betChip != "")
				betChip = parseFloat(m_mDetail.betChip);
			
			var maxUser: Number = 0;
			if(m_mDetail.maxUser != "")
				maxUser = parseInt(m_mDetail.maxUser);
			
			var minChip: Number = 0;
			if(m_mDetail.minBuyin != "")
				minChip = parseFloat(m_mDetail.minBuyin);
			
			var maxChip: Number = 0;
			if(m_mDetail.maxBuyin != "")
				maxChip = parseFloat(m_mDetail.maxBuyin);
			
			request.AddParam("name", m_mDetail.name);
			request.AddParam("display_name", m_mDetail.displayName);
			request.AddParam("password", m_mDetail.password);
			request.AddParam("bet_chip", betChip);
			request.AddParam("max_user", maxUser);
			request.AddParam("min_buy_in", minChip);
			request.AddParam("max_buy_in", maxChip);
			request.AddParam("no_limit", m_mDetail.noLimit);
			request.AddParam("status", "");
			request.AddParam("small_blind", betChip);
			request.AddParam("big_blind", betChip * 2);
			request.AddParam("create_by", GameVariable.GetInstance().UserInfo.UserName);
			
			m_serverController.SendCustomRequest(request);
			
			m_mDetail.status = "";
		}
		
		public function showRoomDetailBox(Room: Object):void{
			m_mDetail.vDetailRoom = new _comp_detailRoom();
			m_mDetail.clearAll();
			
			if(Room != null){
				m_mDetail.name = Room.Name;
				m_mDetail.displayName = Room.DisplayName;
				m_mDetail.password = Room.Password;
				m_mDetail.maxUser = Room.maxUser;
				m_mDetail.betChip = Room.betChip;
				m_mDetail.maxBuyin = Room.maxBuyin;
				m_mDetail.minBuyin = Room.minBuyin;
				m_mDetail.noLimit = Room.noLimit;
				
				m_mDetail.isCreate = false;
			}else{
				m_mDetail.isCreate = true;
			}
			
			PopUpManager.addPopUp(m_mDetail.vDetailRoom, m_cMain.vMain, true);
			PopUpManager.centerPopUp(m_mDetail.vDetailRoom);
		}
		
		public function hideRoomDetailBox():void{
			PopUpManager.removePopUp(m_mDetail.vDetailRoom);
		}
		
	}
}