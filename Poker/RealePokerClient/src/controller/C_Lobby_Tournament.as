package controller
{
	import Enum.RoomVariableDetail;
	import Enum.TournamentStatus;
	
	import Message.event.RoomAddEvent;
	import Message.event.RoomJoinEvent;
	import Message.event.RoomVariableUpdateEvent;
	import Message.event.UserCountChangeEvent;
	import Message.event.game.PokerTournament.*;
	import Message.event.game.PokerTournament.POKER_TOUR_RESPONSE_NAME;
	import Message.request.JoinRoomRequest;
	import Message.request.QuickJoinGameRequest;
	import Message.request.game.pokerTournament.GetDetailTourRequest;
	import Message.request.game.pokerTournament.GetListTourRequest;
	import Message.request.game.pokerTournament.RegistryTourRequest;
	import Message.request.game.pokerTournament.ReplyInviteTourRequest;
	
	import com.smartfoxserver.v2.bitswarm.Message;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.entities.match.*;
	import com.smartfoxserver.v2.entities.match.MatchExpression;
	import com.smartfoxserver.v2.entities.match.StringMatch;
	import com.smartfoxserver.v2.entities.variables.RoomVariable;
	import com.smartfoxserver.v2.exceptions.SFSError;
	
	import entity.PokerTournamentEntity;
	import entity.RoomEntity;
	
	import flash.events.Event;
	
	import model.M_Cashier;
	import model.M_Game;
	import model.M_JoinTable;
	import model.M_Lobby_Cash;
	import model.M_Lobby_Tournament;
	import model.M_TournamentDetail;
	
	import params.RoomVarParams;
	
	import zUtilities.GameVariable;
	import zUtilities.MainController;
	import zUtilities.ServerController;

	public class C_Lobby_Tournament
	{
		private var m_mLobby_Tournament: M_Lobby_Tournament = M_Lobby_Tournament.getInstance();
		private var m_mGame:M_Game = M_Game.getInstance();
		private var m_mTourDetail:M_TournamentDetail = M_TournamentDetail.getInstance();
		
		private var m_server:ServerController = ServerController.getInstance();
		private var m_cTourDetail:C_TournamentDetail = C_TournamentDetail.getInstance();
		private var m_cMain:MainController = MainController.getInstance();
		
		private var m_cMessageBox:C_MessageBox = new C_MessageBox();
		private var m_cConfirmBox:C_ConfirmationBox = new C_ConfirmationBox();
		private var m_cJoinTable:C_JoinTable = new C_JoinTable();
		private var m_mCashier:M_Cashier = M_Cashier.getInstance();
		
		public function C_Lobby_Tournament()
		{
			m_server.addEventListener(POKER_TOUR_RESPONSE_NAME.PRESTART_TOUR, onPrestartTour);
			m_server.addEventListener(POKER_TOUR_RESPONSE_NAME.GET_LIST_TOUR, onGetListTournament);
			m_server.addEventListener(POKER_TOUR_RESPONSE_NAME.GET_DETAIL_TOUR, onGetDetailTournament);
			m_server.addEventListener(POKER_TOUR_RESPONSE_NAME.REGISTRATION, onRegistrationTour);
			m_server.addEventListener(POKER_TOUR_RESPONSE_NAME.REGISTRATION_ERROR, onRegistrationErrorTour);
			m_server.addEventListener(POKER_TOUR_RESPONSE_NAME.UNREGISTRATION, onUnregistrationTour);
			m_server.addEventListener(POKER_TOUR_RESPONSE_NAME.UNREGISTRATION_ERROR, onUnregistrationErrorTour);
			m_server.addEventListener(POKER_TOUR_RESPONSE_NAME.INVITE_TOUR, onInviteTour);
			m_server.addEventListener(POKER_TOUR_RESPONSE_NAME.USER_REWARD_RES, onUserReward);
			m_server.addEventListener(POKER_TOUR_RESPONSE_NAME.USER_COUNT_CHANGE_RES, onUserCountChange);
			
			m_server.addEventListener(POKER_TOUR_RESPONSE_NAME.TOUR_ADDED_RES, onTourAddedRes);
			m_server.addEventListener(POKER_TOUR_RESPONSE_NAME.TOUR_DELETE_RES, onTourRemovedRes);
			m_server.addEventListener(POKER_TOUR_RESPONSE_NAME.TOUR_UPDATE_RES, onTourUpdatedRes);
			m_server.addEventListener(POKER_TOUR_RESPONSE_NAME.UPDATE_TOUR_STATUS_RES, onActiveTournamentRes);
			m_server.addEventListener(POKER_TOUR_RESPONSE_NAME.TOURNAMENT_STATUS_CHANGE_RES, onTournamentStatusChange);
		}
		
		private function onUserCountChange(evt: Event):void
		{
			try{
				var res: UserCountChangeRes = evt as UserCountChangeRes;
				
				m_mLobby_Tournament.changePlayerCount(res.TourName, res.UserCount);
			}catch(error: Error){
				trace(error.message);
			}
		}		
		
		public function handleRegistryRequest(tourName: String):void{
			try{
				var request: RegistryTourRequest = new RegistryTourRequest();
				request.AddParam(RegistryTourRequest.TOUR_NAME,tourName);
				m_server.SendCustomRequest(request);
			}catch(error: Error){
				trace(error.message);
			}
		}
		
		/*************** HANDLE EVENT LISTENER ******************/
		
		private function onPrestartTour(event: Event):void
		{
			/*var evt: GetListTourRes = event as GetListTourRes;
			
			m_mLobby_Tournament.updateStatus(cusEvent.TourName, "Registried");*/
		}
		
		private function onGetListTournament(event: Event):void{
			try{
				var evt: GetListTournamentRes = event as GetListTournamentRes;
				
				GameVariable.GetInstance().IsRegisTour = evt.isRegistried;
				GameVariable.GetInstance().TourName = evt.tourName;
				
				m_mLobby_Tournament.clearItem();
				
				for(var i: int = 0; i < evt.listTournament.length; i++){
					var tourEntity: PokerTournamentEntity = evt.listTournament.getItemAt(i) as PokerTournamentEntity;
					var status: String;
					if(evt.isRegistried && evt.tourName == tourEntity.name){
						status = "Registried";
					}else{
						status = formatTourStatus(tourEntity.status);
					}
					var stakes: String = tourEntity.smallBlind.toString() + "/" + tourEntity.bigBlind.toString();
					m_mLobby_Tournament.addItem(tourEntity.name, tourEntity.displayName, tourEntity.fee
						, tourEntity.capacity, tourEntity.playerCount, status, tourEntity.startingChip, stakes
						, tourEntity.firstPrize, tourEntity.secondPrize, tourEntity.thirdPrize);
				}
			}catch(err:Error){
				trace(err.message);
			}
		}
		
		private function onGetDetailTournament(event: Event):void{
			try{
				var evt: GetDetailTourRes = event as GetDetailTourRes;
				
				/*m_mTourDetail.strBetChip = evt.BetChip;
				m_mTourDetail.strCapacity = evt.Capacity;
				m_mTourDetail.strFee = evt.Fee;
				m_mTourDetail.strName = evt.Name;
				m_mTourDetail.strPlayerCount = evt.NumRegister;
				m_mTourDetail.strStartingChip = evt.StartingChip;
				m_mTourDetail.strStatus = evt.Status;
				m_mTourDetail.strFirstPrize = evt.FirstPrize;
				m_mTourDetail.strSecondPrize = evt.SecondPrize;
				m_mTourDetail.strThridPrize = evt.ThirdPrize;*/
				
				var isRegistied: Boolean = GameVariable.GetInstance().IsRegisTour;
				m_mTourDetail.setTournamentInfo(isRegistied, evt.Name, evt.displayName, evt.Fee, evt.Capacity
					, evt.NumRegister, evt.Status, evt.StartingChip, evt.BetChip
					, evt.FirstPrize, evt.SecondPrize, evt.ThirdPrize);
				m_cTourDetail.showTourDetail();
			}catch(err:Error){
				trace(err.message);
			}
		}
		
		private function onUnregistrationErrorTour(evt: Event):void
		{
			try{
				var cusEvent: UnregistrationErrorRes = evt as UnregistrationErrorRes;
				
			}catch(error: Error){
				trace(error.message);
			}
		}
		
		private function onUnregistrationTour(evt: Event):void
		{
			try{
				var cusEvent: UnregistrationRes = evt as UnregistrationRes;
				
				GameVariable.GetInstance().TourName = "";
				GameVariable.GetInstance().IsRegisTour = false;
				//return fee for user.
				GameVariable.GetInstance().UserInfo.Chip += cusEvent.fee;
				
				m_mLobby_Tournament.updateStatus(cusEvent.TourName, formatTourStatus(cusEvent.TourStatus));
				
				m_mCashier.updateUseInfo();
			}catch(error: Error){
				trace(error.message);
			}
		}
		
		private function formatTourStatus(status: String): String{
			var temp: String = status.toLowerCase();
			var firstChar: String = temp.charAt(0);
			return temp.replace(firstChar, firstChar.toUpperCase());
		}
		
		private function onRegistrationErrorTour(evt: Event):void
		{
			/*try{
				var cusEvent: RegistrationErrorRes = evt as RegistrationErrorRes;
				m_cMessageBox.showMessageBox(cusEvent.Message);
			}catch(error: Error){
				trace(error.message);
			}*/
		}
		
		private function onRegistrationTour(evt: Event):void
		{
			try{
				var cusEvent: RegistrationRes = evt as RegistrationRes;
				
				GameVariable.GetInstance().TourName = cusEvent.TourName;
				GameVariable.GetInstance().IsRegisTour = true;
				//apply fee for user
				GameVariable.GetInstance().UserInfo.Chip -= cusEvent.fee;
				
				m_mLobby_Tournament.updateStatus(cusEvent.TourName, "Registried");
			
				m_mCashier.updateUseInfo();
			}catch(error: Error){
				trace(error.message);
			}
		}
		
		private function onInviteTour(evt: Event):void
		{
			try{
				var cusEvent: InviteTourRes = evt as InviteTourRes;
				
				var msg: String = "Do you want to join " + cusEvent.TourName + " tournament.";
				var title: String = "Tournament Invitation";
				m_cConfirmBox.showMessageBox(function():void{replyInviteTour(cusEvent.TourName, true);}
					,function():void{replyInviteTour(cusEvent.TourName, false);}
					, msg, title, cusEvent.Time);
				
			}catch(error: Error){
				trace(error.message);
			}
		}
		
		private function onUserReward(evt: Event):void
		{
			try{
				var cusEvent: UserRewardRes = evt as UserRewardRes;
				
				GameVariable.GetInstance().UserInfo.Chip += cusEvent.Prize;
				
				var box:C_MessageBox = new C_MessageBox;
				box.showMessageBox("You received a prize: " + cusEvent.Prize + " from tournament " + cusEvent.TourName + "!");
			}catch(error: Error){
				trace(error.message);
			}
		}
		
		private function onActiveTournamentRes(evt: Event):void
		{
			try{
				var event: UpdateTourStatusRes = evt as UpdateTourStatusRes;
				
				var tourName: String = event.name;
				var status: String = event.status;
				
				if(status == TournamentStatus.STOPPING && GameVariable.GetInstance().TourName == tourName){
					GameVariable.GetInstance().TourName = "";
					GameVariable.GetInstance().IsRegisTour = false;
				}
				
				m_mLobby_Tournament.updateStatus(tourName, formatTourStatus(status));
			}catch(error: Error){
				trace(error.message);
			}	
		}	
		
		private function onTournamentStatusChange(event: Event):void
		{
			try{
				var evt: TournamentStatusChangeRes = event as TournamentStatusChangeRes;
				
				m_mLobby_Tournament.updateStatus(evt.Name, formatTourStatus(evt.Status));
			}catch(err:Error){
				trace(err.message);
			}
		}		
		
		private function onTourUpdatedRes(evt: Event):void
		{
			try{
				var event: TourUpdatedRes = evt as TourUpdatedRes;
				
				var tourEntity: PokerTournamentEntity = event.tourInfo;
				
				m_mLobby_Tournament.updateItem(tourEntity.name, tourEntity.displayName, tourEntity.fee, tourEntity.capacity
					, tourEntity.playerCount, tourEntity.startingChip, tourEntity.stakes
					, tourEntity.firstPrize, tourEntity.secondPrize, tourEntity.thirdPrize);
			}catch(error: Error){
				trace(error.message);
			}
		}
		
		
		private function onTourRemovedRes(evt: Event):void
		{
			try{
				var event: TourRemovedRes = evt as TourRemovedRes;
				m_mLobby_Tournament.removeItem(event.name);
			}catch(error: Error){
				trace(error.message);
			}
		}
		
		private function onTourAddedRes(evt: Event):void
		{
			try{
				var event: TourAddedRes = evt as TourAddedRes;
				
				var tourEntity: PokerTournamentEntity = event.tourInfo;
				
				m_mLobby_Tournament.addItem(tourEntity.name, tourEntity.displayName, tourEntity.fee, tourEntity.capacity
					, tourEntity.playerCount, tourEntity.status, tourEntity.startingChip, tourEntity.stakes
					, tourEntity.firstPrize, tourEntity.secondPrize, tourEntity.thirdPrize);
			}catch(error: Error){
				trace(error.message);
			}
		}		
		
		/*************** END HANDLE EVENT LISTENER ******************/
		
		private function sendRegistryTournament(tourName: String):void{
			var regisReq: RegistryTourRequest = new RegistryTourRequest();
			regisReq.AddParam(RegistryTourRequest.TOUR_NAME ,tourName);
			
			m_server.SendCustomRequest(regisReq);
		}
		/*private function processTournamentClick():void{
			if(GameVariable.GetInstance().IsRegisTour == false){
				//registry tour
				sendRegistryTournament(m_mLobby_Tournament.getSelectedTourName());
			}else {
				//show tournament detail
				var tourName: String = m_mLobby_Tournament.getSelectedTourName();
				if(GameVariable.GetInstance().TourName == tourName){
					var req: GetDetailTourRequest = new GetDetailTourRequest();
					
					req.AddParam(ReplyInviteTourRequest.TOUR_NAME, tourName);
					
					m_server.SendCustomRequest(req);
				}
			}
		}*/
		private function processTournamentClick():void{
			var tourName: String = m_mLobby_Tournament.getSelectedTourName();
			if(GameVariable.GetInstance().IsRegisTour == false
			|| GameVariable.GetInstance().TourName == tourName){
				//show tournament detail
				var req: GetDetailTourRequest = new GetDetailTourRequest();
				
				req.AddParam(ReplyInviteTourRequest.TOUR_NAME, tourName);
				
				m_server.SendCustomRequest(req);
			}
		}
		
		public function replyInviteTour(tourName: String, isAccept: Boolean):void{
			var req: ReplyInviteTourRequest = new ReplyInviteTourRequest();
		
			req.AddParam(ReplyInviteTourRequest.TOUR_NAME,tourName);
			req.AddParam(ReplyInviteTourRequest.IS_ACCEPT, isAccept);
			
			m_server.SendCustomRequest(req);
			
			processAfterReply(isAccept);
		}
		
		public function processAfterReply(isAccept: Boolean): void{
			if(isAccept){
				if(GameVariable.GetInstance().CurrentRoom != null){
					m_cJoinTable.leaveCurrentGame();
				}
				
				GameVariable.GetInstance().IsRegisTour = false;
				GameVariable.GetInstance().TourName = "";
			}
		}
		
		public function handleGetListTour(): void{
			var getTourReq: GetListTourRequest = new GetListTourRequest();
			
			m_server.SendCustomRequest(getTourReq);
		}
		
		public function handleLobbyTournament_enterState(event:Event):void{
			handleGetListTour();
		}
		
		public function handleList_doubleClick(event:Event):void{
			processTournamentClick();
		}
		public function handleJoinTournament_Click(event:Event):void{
			processTournamentClick();
		}
	}
}