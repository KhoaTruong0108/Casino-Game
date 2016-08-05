package controller
{
	import Configuration.config;
	
	import Message.event.ConnectionEvent;
	import Message.event.ConnectionLostEvent;
	import Message.event.LoginErrorEvent;
	import Message.event.LoginEvent;
	import Message.event.admin.*;
	import Message.request.LoginRequest;
	import Message.request.admin.*;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	
	import components._comp_detailTournament;
	
	import entity.AdminEntity;
	
	import enum.ManagedObject;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import model.M_Admin;
	import model.M_DetailTournament;
	import model.M_Login;
	
	import mx.collections.ArrayCollection;
	import mx.managers.PopUpManager;
	import mx.utils.StringUtil;
	
	import spark.components.Application;
	
	import zUtilities.GameVariable;
	import zUtilities.ServerController;
	
	
	public class C_DetailTournament
	{
		private var m_mDetail : M_DetailTournament = M_DetailTournament.getInstance();
		private var m_serverController : ServerController = ServerController.getInstance();
		private var m_cMain:MainController = MainController.getInstance();
		
		
		public function C_DetailTournament()
		{	
			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.CREATE_RES, onCreateTournamentRes);
			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.CREATE_ERROR_RES,onCreateTournamentErrorRes);
			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.UPDATE_RES, onUpateTournamentRes);
			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.UPDATE_ERROR_RES,onUpateTournamentErrorRes);
			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.GET_LEVEL_COLLECTION_RES, onGetLevelCollectionRes);
			
		}
		
		private function onGetLevelCollectionRes(event: Event):void
		{
			var response: GetLevelCollectionRes = event as GetLevelCollectionRes;
			
			m_mDetail.arrLevelCollection = response.listLevelCollection as ArrayCollection;
			
			for(var i: int = 0; i< m_mDetail.arrLevelCollection.length; i++){
				var item: Object = m_mDetail.arrLevelCollection.getItemAt(i);
				if(item.data == m_mDetail.levelType){
					m_mDetail.oSelectedLevelCollection = item;
					break;
				}
			}
		}
		
		private function onUpateTournamentErrorRes(evt: Event):void
		{
			var response: UpdateErrorRes = evt as UpdateErrorRes;
			m_mDetail.statusMsg = response.Message;
		}
		
		private function onUpateTournamentRes(evt: Event):void
		{
			var response: UpdateRes = evt as UpdateRes;
			if(response.ObjUpdated == ManagedObject.TOURNAMENT)
				m_mDetail.statusMsg = response.Message;
		}
		
		private function onCreateTournamentErrorRes(evt: Event):void
		{
			var response: CreateErrorRes = evt as CreateErrorRes;
			m_mDetail.statusMsg = response.Message;
		}
		
		private function onCreateTournamentRes(evt: Event):void
		{
			var response: CreateRes = evt as CreateRes;
			if(response.ObjCreated == ManagedObject.TOURNAMENT){
				m_mDetail.statusMsg = response.Message;
			}
		}
		
		public function checkInput():Boolean{
			var result: Boolean = true;
			if(m_mDetail.name == null || m_mDetail.name.replace(/\s+/g, '') == ""){
				/*m_mDetail.statusMsg = "Please input Name";
				return false;*/
				var tourIndex: int = Math.random() * 1000;
				m_mDetail.name = config.TOURNAMENT_NAME_DEFFAULT_VALUE + tourIndex;
				result = false;
			}
			if(m_mDetail.displayName == null || m_mDetail.displayName.replace(/\s+/g, '') == ""){
				/*m_mDetail.statusMsg = "Please input Display Name";
				return false;*/
				m_mDetail.displayName = config.TOURNAMENT_DISPLAY_NAME_DEFFAULT_VALUE;
				result = false;
			}
			if(m_mDetail.fee == null || m_mDetail.fee.replace(/\s+/g, '') == ""){
				/*m_mDetail.statusMsg = "Please input fee";
				return false;*/
				m_mDetail.fee = config.TOURNAMENT_FEE_DEFFAULT_VALUE;
				result = false;
			}
			if(m_mDetail.startingChip == null || m_mDetail.startingChip.replace(/\s+/g, '') == ""){
				/*m_mDetail.statusMsg = "Please input startingChip";
				return false;*/
				m_mDetail.startingChip = config.TOURNAMENT_STARTING_CHIP_DEFFAULT_VALUE;
				result = false;
			}
			if(m_mDetail.oSelectedLevelCollection == null){
				m_mDetail.oSelectedLevelCollection = m_mDetail.arrLevelCollection.getItemAt(0);
				result = false;
			}
			if(m_mDetail.beginLevel == null || m_mDetail.beginLevel.replace(/\s+/g, '') == ""){
				/*m_mDetail.statusMsg = "Please input begin Level";
				return false;*/
				m_mDetail.beginLevel = config.TOURNAMENT_BEGIN_LEVEL_DEFFAULT_VALUE;
				result = false;
			}
			if(m_mDetail.endLevel == null || m_mDetail.endLevel.replace(/\s+/g, '') == ""){
				/*m_mDetail.statusMsg = "Please input end Level";
				return false;*/
				m_mDetail.endLevel = config.TOURNAMENT_END_LEVEL_DEFFAULT_VALUE;
				result = false;
			}
			if(m_mDetail.capacity == null || m_mDetail.capacity.replace(/\s+/g, '') == ""){
				/*m_mDetail.statusMsg = "Please input capacity";
				return false;*/
				m_mDetail.capacity = config.TOURNAMENT_CAPACITY_DEFFAULT_VALUE;
				result = false;
			}
			if(m_mDetail.firstPrize == null || m_mDetail.firstPrize.replace(/\s+/g, '') == ""){
				/*m_mDetail.statusMsg = "Please input first Prize";
				return false;*/
				m_mDetail.firstPrize = config.TOURNAMENT_FIRST_PRIZE_DEFFAULT_VALUE;
				result = false;
			}
				
			return result;
		}
		
		public function handleUpdate():void{
			try{
				var request: UpdateTourRequest = new UpdateTourRequest();
				
				if(checkInput() == false){
					return;
				}
				
				var fee: Number = 0;
				if(m_mDetail.fee != "")
					fee = parseInt(m_mDetail.fee);
				
				var startingChip: Number = 0;
				if(m_mDetail.startingChip != "")
					startingChip = parseFloat(m_mDetail.startingChip);
				
				var firstPrize: Number = 0;
				if(m_mDetail.firstPrize != "")
					firstPrize = parseFloat(m_mDetail.firstPrize);
				
				var secondPrize: Number = 0;
				if(m_mDetail.secondPrize != "")
					secondPrize = parseFloat(m_mDetail.secondPrize);
				
				var thirdPrize: Number = 0;
				if(m_mDetail.thirdPrize != "")
					thirdPrize = parseFloat(m_mDetail.thirdPrize);
				
				var capacity: int = 0;
				if(m_mDetail.capacity != "")
					capacity = parseInt(m_mDetail.capacity);
				
				var levelType: int = m_mDetail.levelType;
				
				var beginLevel: int = 0;
				if(m_mDetail.beginLevel != "")
					beginLevel = parseInt(m_mDetail.beginLevel);
				
				var endLevel: int = 0;
				if(m_mDetail.endLevel != "")
					endLevel = parseInt(m_mDetail.endLevel);
				
				request.AddParam("name", m_mDetail.name);
				request.AddParam("display_name", m_mDetail.displayName);
				request.AddParam("fee", fee);
				request.AddParam("starting_chip", startingChip);
				request.AddParam("level_type", levelType);
				request.AddParam("begin_level", beginLevel);
				request.AddParam("end_level", endLevel);
				request.AddParam("capacity", capacity);
				request.AddParam("frist_prize", firstPrize);
				request.AddParam("second_prize", secondPrize);
				request.AddParam("third_prize", thirdPrize);
				
				m_serverController.SendCustomRequest(request);
				
				m_mDetail.status = "";
			}catch(err:Error){
			}
		}
		
		public function handleCreate():void{
			try{
				var request: CreateTourRequest = new CreateTourRequest();
				
				if(checkInput() == false){
					return;
				}
				
				var fee: Number = 0;
				if(m_mDetail.fee != "")
					fee = parseInt(m_mDetail.fee);
				
				var startingChip: Number = 0;
				if(m_mDetail.startingChip != "")
					startingChip = parseFloat(m_mDetail.startingChip);
				
				var firstPrize: Number = 0;
				if(m_mDetail.firstPrize != "")
					firstPrize = parseFloat(m_mDetail.firstPrize);
				
				var secondPrize: Number = 0;
				if(m_mDetail.secondPrize != "")
					secondPrize = parseFloat(m_mDetail.secondPrize);
				
				var thirdPrize: Number = 0;
				if(m_mDetail.thirdPrize != "")
					thirdPrize = parseFloat(m_mDetail.thirdPrize);
				
				var capacity: int = 0;
				if(m_mDetail.capacity != "")
					capacity = parseInt(m_mDetail.capacity);
				
				var levelType: int = m_mDetail.levelType;
				
				var beginLevel: int = 0;
				if(m_mDetail.beginLevel != "")
					beginLevel = parseInt(m_mDetail.beginLevel);
				
				var endLevel: int = 0;
				if(m_mDetail.endLevel != "")
					endLevel = parseInt(m_mDetail.endLevel);
				
				request.AddParam("name", m_mDetail.name);
				request.AddParam("display_name", m_mDetail.displayName);
				request.AddParam("fee", fee);
				request.AddParam("starting_chip", startingChip);
				request.AddParam("level_type", levelType);
				request.AddParam("begin_level", beginLevel);
				request.AddParam("end_level", endLevel);
				request.AddParam("capacity", capacity);
				request.AddParam("frist_prize", firstPrize);
				request.AddParam("second_prize", secondPrize);
				request.AddParam("third_prize", thirdPrize);
				
				m_serverController.SendCustomRequest(request);
				
				m_mDetail.status = "";
			}catch(err:Error){
			}
		}
		
		public function showTourDetailBox(tour: Object):void{
			m_mDetail.vDetailUser = new _comp_detailTournament();
			m_mDetail.clearAll();
			
			if(tour != null){
				m_mDetail.name = tour.name;
				m_mDetail.displayName = tour.displayName;
				m_mDetail.fee = tour.fee;
				m_mDetail.startingChip = tour.startingChip;
				m_mDetail.capacity = tour.capacity;
				m_mDetail.status = tour.status;
				m_mDetail.startingChip = tour.startingChip;
				m_mDetail.levelType = tour.levelType;
				m_mDetail.beginLevel = tour.beginLevel;
				m_mDetail.endLevel = tour.endLevel;
				m_mDetail.firstPrize = tour.firstPrize;
				m_mDetail.secondPrize = tour.secondPrize;
				m_mDetail.thirdPrize = tour.thirdPrize;
				
				m_mDetail.isCreate = false;
			}else{
				m_mDetail.isCreate = true;
			}
			
			loadLevelCollection();
			
			PopUpManager.addPopUp(m_mDetail.vDetailUser, m_cMain.vMain, true);
			PopUpManager.centerPopUp(m_mDetail.vDetailUser);
		}
		
		public function hideTourDetailBox():void{
			PopUpManager.removePopUp(m_mDetail.vDetailUser);
		}
		
		public function loadLevelCollection():void{
			var request: GetLevelCollectionRequest = new GetLevelCollectionRequest();
			m_serverController.SendCustomRequest(request);
		}
		
	}
}