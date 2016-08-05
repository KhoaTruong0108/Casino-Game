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
	
	import components._comp_detailLevel;
	
	import entity.AdminEntity;
	
	import enum.ManagedObject;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import model.M_Admin;
	import model.M_DetailLevel;
	import model.M_Login;
	
	import mx.collections.ArrayCollection;
	import mx.managers.PopUpManager;
	
	import spark.components.Application;
	
	import zUtilities.GameVariable;
	import zUtilities.ServerController;
	
	
	public class C_DetailLevel
	{
		private var m_mDetail : M_DetailLevel = M_DetailLevel.getInstance();
		private var m_serverController : ServerController = ServerController.getInstance();
		private var m_cMain:MainController = MainController.getInstance();
		
		public function C_DetailLevel()
		{	
			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.CREATE_RES, onCreateLevelRes);
			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.CREATE_ERROR_RES,onCreateLevelErrorRes);
			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.UPDATE_RES, onUpateLevelRes);
			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.UPDATE_ERROR_RES,onUpateLevelErrorRes);
		}
		
		private function onUpateLevelErrorRes(evt: Event):void
		{
			var response: UpdateErrorRes = evt as UpdateErrorRes;
			m_mDetail.status = response.Message;
		}
		
		private function onUpateLevelRes(evt: Event):void
		{
			var response: UpdateRes = evt as UpdateRes;
			if(response.ObjUpdated == ManagedObject.LEVEL)
				m_mDetail.status = response.Message;
		}
		
		private function onCreateLevelErrorRes(evt: Event):void
		{
			var response: CreateErrorRes = evt as CreateErrorRes;
			m_mDetail.status = response.Message;
		}
		
		private function onCreateLevelRes(evt: Event):void
		{
			var response: CreateRes = evt as CreateRes;
			if(response.ObjCreated == ManagedObject.LEVEL){
				m_mDetail.status = response.Message;
			}
		}
		
		public function handleUpdate():void{
			var request: UpdateLevelRequest = new UpdateLevelRequest();
			
			var level: Number = 0;
			if(m_mDetail.level != "")
				level = parseInt(m_mDetail.level);
			var smallBlind: Number = 0;
			if(m_mDetail.smallBlind != "")
				smallBlind = parseFloat(m_mDetail.smallBlind);
			var bigBlind: Number = 0;
			if(m_mDetail.bigBlind != "")
				bigBlind = parseFloat(m_mDetail.bigBlind);
			var ante: Number = 0;
			if(m_mDetail.ante != "")
				ante = parseFloat(m_mDetail.ante);
			var timeLife: Number = 0;
			if(m_mDetail.timeLife != "")
				timeLife = parseInt(m_mDetail.timeLife);
			
			request.AddParam("id", m_mDetail.id);
			request.AddParam("level", level);
			request.AddParam("level_type", m_mDetail.levelType);
			request.AddParam("small_blind", smallBlind);
			request.AddParam("big_blind", bigBlind);
			request.AddParam("ante", ante);
			request.AddParam("time_life", timeLife);
			
			m_serverController.SendCustomRequest(request);
			
			m_mDetail.status = "";
		}
		
		public function handleCreate():void{
			var request: CreateLevelRequest = new CreateLevelRequest();
			
			var level: Number = 0;
			if(m_mDetail.level != "")
				level = parseInt(m_mDetail.level);
			var smallBlind: Number = 0;
			if(m_mDetail.smallBlind != "")
				smallBlind = parseFloat(m_mDetail.smallBlind);
			var bigBlind: Number = 0;
			if(m_mDetail.bigBlind != "")
				bigBlind = parseFloat(m_mDetail.bigBlind);
			var ante: Number = 0;
			if(m_mDetail.ante != "")
				ante = parseFloat(m_mDetail.ante);
			var timeLife: Number = 0;
			if(m_mDetail.timeLife != "")
				timeLife = parseInt(m_mDetail.timeLife);
			
			request.AddParam("level", level);
			request.AddParam("level_type", m_mDetail.levelType);
			request.AddParam("small_blind", smallBlind);
			request.AddParam("big_blind", bigBlind);
			request.AddParam("ante", ante);
			request.AddParam("time_life", timeLife);
			
			m_serverController.SendCustomRequest(request);
			
			m_mDetail.status = "";
		}
		
		public function showLevelDetailBox(Level: Object, levelType: int, description: String):void{
			m_mDetail.vDetailLevel = new _comp_detailLevel();
			m_mDetail.clearAll();
			
			if(Level != null){
				m_mDetail.id = Level.id;
				m_mDetail.level = Level.level;
				m_mDetail.smallBlind = Level.smallBlind;
				m_mDetail.bigBlind = Level.bigBlind;
				m_mDetail.ante = Level.ante;
				m_mDetail.timeLife = Level.timeLife;
				
				m_mDetail.isCreate = false;
			}else{
				m_mDetail.isCreate = true;
			}
			
			m_mDetail.levelType = levelType;
			m_mDetail.levelTypeDes = description;
			
			PopUpManager.addPopUp(m_mDetail.vDetailLevel, m_cMain.vMain, true);
			PopUpManager.centerPopUp(m_mDetail.vDetailLevel);
		}
		
		public function hideLevelDetailBox():void{
			PopUpManager.removePopUp(m_mDetail.vDetailLevel);
		}
		
	}
}