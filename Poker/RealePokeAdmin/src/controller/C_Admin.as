package controller
{
	import Message.event.ConnectionEvent;
	import Message.event.ConnectionLostEvent;
	import Message.event.LoginErrorEvent;
	import Message.event.LoginEvent;
	import Message.event.admin.*;
	import Message.request.LoginRequest;
	import Message.request.admin.*;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.User;
	
	import entity.AdminEntity;
	import entity.TournamentEntity;
	
	import enum.ManagedObject;
	import enum.TournamentStatus;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import model.M_Admin;
	import model.M_Login;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	
	import spark.components.Application;
	
	import zUtilities.GameVariable;
	import zUtilities.ServerController;
	
	
	public class C_Admin
	{
		private var m_mAdmin : M_Admin = M_Admin.getInstance();
		private var m_serverController : ServerController = ServerController.getInstance();
		private var m_cMain:MainController = MainController.getInstance();
		
		private var m_cAddChip: C_AddChip = new C_AddChip();
		private var m_cDetailUser: C_DetailUser = new C_DetailUser();
		private var m_cDetailRoom: C_DetailRoom = new C_DetailRoom();
		private var m_cDetailTournament: C_DetailTournament = new C_DetailTournament();
		private var m_cDetailLevel: C_DetailLevel = new C_DetailLevel();
		
		private var m_cConfirmBox:C_ConfirmationBox = new C_ConfirmationBox();
		
		private var NUM_ROW: int = 30;
		
		private var m_pageCountRoom: int = 1;
		private var m_pageSize: int = 1;
		private var m_pageCountTour: int = 1;
		private var m_pageCountLevel: int = 1;
		private var m_pageCountTrans: int = 1;
		
		public function C_Admin()
		{	
			m_serverController.addEventListener(SFSEvent.USER_VARIABLES_UPDATE, onUserVariableUpdate);
			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.GET_LIST_ROOM_RES, onGetListRoomRes);
			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.GET_LIST_TOURNAMENT_RES,onGetListTournamentRes);
			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.GET_LIST_USER_RES, onGetListUserRes);
			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.GET_LIST_LEVEL_RES, onGetListLevelRes);
			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.GET_LEVEL_COLLECTION_RES, onGetLevelCollectionRes);
			
			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.DELETE_ERROR_RES, onDeleteErrorRes);
			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.DELETE_RES, onDeleteRes);

			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.UPDATE_TOUR_STATUS_RES, onActiveTourRes);

			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.GET_TRANSACTION_RES, onGetTransactionRes);
		}
		
		private function onUserVariableUpdate(event: Event):void
		{
			// TODO Auto Generated method stub
			
		}		
		
		/////******************************************************************////
		/////			LISTENER EVENT SECTION
		/////******************************************************************////
		private function onGetTransactionRes(event: Event):void
		{
			try{
				var response: GetTransactionRes = event as GetTransactionRes;
				
				m_mAdmin.arrTransaction = response.listTransaction;
			}catch(exc:Error){
				trace(exc.message);
			}
		}
		
		private function onActiveTourRes(event: Event):void
		{
			try{
				var response: UpdateTourStatusRes = event as UpdateTourStatusRes;
				m_mAdmin.updateTourStatus(response.name, response.status);
			}catch(exc:Error){
				trace(exc.message);
			}
			
		}
		
		private function onDeleteRes(event: Event):void
		{
			var response: DeleteRes = event as DeleteRes;
			if(response.ObjDeleted == ManagedObject.USER){
				m_mAdmin.StatusUser = response.Message;
				handleGetListUser();
			}else if(response.ObjDeleted == ManagedObject.ROOM){
				m_mAdmin.StatusRoom = response.Message;
				handleGetListRoom();
			}else if(response.ObjDeleted == ManagedObject.TOURNAMENT){
				m_mAdmin.StatusTournament = response.Message;
				handleGetListTournament();
			}else if(response.ObjDeleted == ManagedObject.LEVEL){
				m_mAdmin.StatusLevel = response.Message;
				handleGetListLevel();
			}
		}
		
		private function onDeleteErrorRes(event: Event):void
		{
			var response: DeleteErrorRes = event as DeleteErrorRes;
			if(response.ObjDeleted == ManagedObject.USER)
				m_mAdmin.StatusUser = response.Message;
			else if(response.ObjDeleted == ManagedObject.ROOM)
				m_mAdmin.StatusRoom = response.Message;
			else if(response.ObjDeleted == ManagedObject.TOURNAMENT)
				m_mAdmin.StatusTournament = response.Message;
			else if(response.ObjDeleted == ManagedObject.LEVEL)
				m_mAdmin.StatusLevel = response.Message;
		}
		
		private function onGetListUserRes(event: Event):void
		{
			var response: GetListUserRes = event as GetListUserRes;
			
			m_mAdmin.arrUser = response.listUser as ArrayCollection;
		}
		
		private function onGetListTournamentRes(event: Event):void
		{
			var response: GetListTournamentRes = event as GetListTournamentRes;
			
			m_mAdmin.arrTournament = response.listTournament as ArrayCollection;
		}
		
		private function onGetListLevelRes(event: Event):void
		{
			var response: GetListLevelRes = event as GetListLevelRes;
			
			m_mAdmin.arrLevel = response.listLevel as ArrayCollection;
		}
		
		private function onGetLevelCollectionRes(event: Event):void
		{
			var response: GetLevelCollectionRes = event as GetLevelCollectionRes;
			
			m_mAdmin.arrLevelCollection = response.listLevelCollection as ArrayCollection;
		}
		
		private function onGetListRoomRes(event: Event):void
		{
			var response: GetListRoomRes = event as GetListRoomRes;
			
			m_mAdmin.arrRoom = response.listRoom as ArrayCollection;
		}
		
		
		/////******************************************************************////
		/////			USER SECTION
		/////******************************************************************////
		public function handleCreateUser():void{
			m_cDetailUser.showUserDetailBox(null);
		}
		public function handleUpdateUser():void{
			if(m_mAdmin.oSelectedUser != null)
				m_cDetailUser.showUserDetailBox(m_mAdmin.oSelectedUser);
		}
		public function handleAddChip():void{
			if(m_mAdmin.oSelectedUser != null)
				m_cAddChip.showUserDetailBox(m_mAdmin.oSelectedUser);
		}
		public function handleDeleteUser():void{
			if(m_mAdmin.oSelectedUser != null){
				var request: DeleteUserRequest = new DeleteUserRequest();
				request.AddParam("user_name", m_mAdmin.oSelectedUser.UserName);
				m_serverController.SendCustomRequest(request);
				
				m_mAdmin.StatusUser = "";
			}
		}
		
		public function handleGetListUser():void{
			m_pageSize = 1;
			findUser("");
		}
		public function handleGetMoreUser():void{
			m_pageSize++;
			findUser(m_mAdmin.findUserName);
		}
		public function findUser(name: String):void{
			var request: GetListUserRequest = new GetListUserRequest();
			request.AddParam("name", name);
			request.AddParam("index", 0);
			request.AddParam("num_row", NUM_ROW * m_pageSize);
			m_serverController.SendCustomRequest(request);
		}
		
		/////******************************************************************////
		/////			ROOM SECTION
		/////******************************************************************////
		
		public function handleCreateRoom():void{
			m_cDetailRoom.showRoomDetailBox(null);
		}
		public function handleUpdateRoom():void{
			if(m_mAdmin.oSelectedRoom != null)
				m_cDetailRoom.showRoomDetailBox(m_mAdmin.oSelectedRoom);
		}
		public function handleDeleteRoom():void{
			if(m_mAdmin.oSelectedRoom != null){
				var request: DeleteRoomRequest = new DeleteRoomRequest();
				request.AddParam("name", m_mAdmin.oSelectedRoom.Name);
				m_serverController.SendCustomRequest(request);
				
			}
			m_mAdmin.StatusRoom = "";
		}
		
		public function handleGetListRoom():void{
			m_pageCountRoom = 1;
			findRoom("");
		}
		public function handleGetMoreRoom():void{
			m_pageCountRoom++;
			findRoom("");
		}
		public function findRoom(name: String):void{
			var request: GetListRoomRequest = new GetListRoomRequest();
			request.AddParam("name", name);
			request.AddParam("index", 0);
			request.AddParam("num_row", NUM_ROW * m_pageCountRoom);
			m_serverController.SendCustomRequest(request);
		}
		
		
		/////******************************************************************////
		/////			TOURNAMENT SECTION
		/////******************************************************************////
			
		public function handleCreateTour():void{
			m_cDetailTournament.showTourDetailBox(null);
		}
		public function handleUpdateTour():void{
			if(m_mAdmin.oSelectedTour != null)
				m_cDetailTournament.showTourDetailBox(m_mAdmin.oSelectedTour);
		}
		public function handleDeleteTour():void{
			if(m_mAdmin.oSelectedTour != null){
				var request: DeleteTourRequest = new DeleteTourRequest();
				request.AddParam("name", m_mAdmin.oSelectedTour.name);
				m_serverController.SendCustomRequest(request);
			}
			m_mAdmin.StatusTournament = "";
		}
		
		public function handleActiveTour():void{
			if(m_mAdmin.oSelectedTour != null){
				var isActive: Boolean;
				/*if(m_mAdmin.oSelectedTour.status == TournamentStatus.STOPPING){
					isActive = true;
				}else if(m_mAdmin.oSelectedTour.status == TournamentStatus.WAITING){
					isActive = false;
				}else{
					return;
				}*/
				if(m_mAdmin.oSelectedTour.status == TournamentStatus.STOPPING){
					isActive = true;
				}else {
					isActive = false;
				}
				
				if(isActive == false){
					var msg: String = "Do you want to stop tournament " + m_mAdmin.oSelectedTour.name + " .";
					var title: String = "Warning";
					m_cConfirmBox.showMessageBox(function():void{sendRequestActiveTour(isActive);}
						,null
						, msg, title, 0);
				}else{
					sendRequestActiveTour(isActive);
				}
			}
			m_mAdmin.StatusRoom = "";
		}
		
		public function sendRequestActiveTour(isActive: Boolean):void{
			var request: UpdateTourStatusRequest = new UpdateTourStatusRequest();
			request.AddParam("name", m_mAdmin.oSelectedTour.name);
			request.AddParam("is_active", isActive);
			m_serverController.SendCustomRequest(request);
		}
		
		public function handleGetListTournament():void{
			m_pageCountTour = 1;
			findTour("");
		}
		public function handleGetMoreTour():void{
			m_pageCountTour++;
			findTour("");
		}
		public function findTour(name: String):void{
			var request: GetListTourRequest = new GetListTourRequest();
			request.AddParam("name", name);
			request.AddParam("index", 0);
			request.AddParam("num_row", NUM_ROW * m_pageSize);
			m_serverController.SendCustomRequest(request);
		}
		
		/////******************************************************************////
		/////			LEVEL SECTION
		/////******************************************************************////
		
		public function handleCreateLevel():void{
			if(m_mAdmin.oSelectedLevelCollection != null)
				m_cDetailLevel.showLevelDetailBox(null, m_mAdmin.oSelectedLevelCollection.data, m_mAdmin.oSelectedLevelCollection.label);
		}
		public function handleUpdateLevel():void{
			if(m_mAdmin.oSelectedLevelCollection != null && m_mAdmin.oSelectedLevel != null)
				m_cDetailLevel.showLevelDetailBox(m_mAdmin.oSelectedLevel,m_mAdmin.oSelectedLevelCollection.data, m_mAdmin.oSelectedLevelCollection.label);
		}
		public function handleDeleteLevel():void{
			if(m_mAdmin.oSelectedLevel != null){
				var request: DeleteLevelRequest = new DeleteLevelRequest();
				request.AddParam("id", m_mAdmin.oSelectedLevel.id);
				m_serverController.SendCustomRequest(request);
			}
			m_mAdmin.StatusLevel = "";
		}
		
		public function handleGetListLevel():void{
			m_pageCountLevel = 1;
			var type: int = parseInt(m_mAdmin.oSelectedLevelCollection.data);
			findLevel(type);
		}
		public function handleGetMoreLevel():void{
			m_pageCountLevel++;
			var type: int = parseInt(m_mAdmin.oSelectedLevelCollection.data);
			findLevel(type);
		}
		public function findLevel(levelType: int):void{
			var request: GetListLevelRequest = new GetListLevelRequest();
			request.AddParam("level_type", levelType);
			request.AddParam("index", 0);
			request.AddParam("num_row", NUM_ROW * m_pageSize);
			m_serverController.SendCustomRequest(request);
		}
		
		public function handleGetLevelCollection():void{
			var request: GetLevelCollectionRequest = new GetLevelCollectionRequest();
			m_serverController.SendCustomRequest(request);
		}
		/////******************************************************************////
		/////			TRANSACTION SECTION
		/////******************************************************************////
		
		public function handleDeleteTrans():void{
			
		}
		public function handleGetTransaction():void{
			m_pageCountTrans = 1;
			findTrans("","","","");
		}
		public function handleGetMoreTrans():void{
			m_pageCountTrans++;
			findTrans("","","","");
		}
		public function findTrans(userName: String, adminName: String, fromDate: String, toDate: String):void{
			var request: GetTransactionRequest = new GetTransactionRequest();
			request.AddParam("user_name", userName);
			request.AddParam("by_admin", adminName);
			request.AddParam("from_date", fromDate);
			request.AddParam("to_date", toDate);
			request.AddParam("index", 0);
			request.AddParam("num_row", NUM_ROW * m_pageSize);
			m_serverController.SendCustomRequest(request);
		}
	}
}