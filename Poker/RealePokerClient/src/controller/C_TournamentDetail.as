package controller
{
	import Message.event.RoomJoinEvent;
	import Message.event.game.PokerTournament.POKER_TOUR_RESPONSE_NAME;
	import Message.event.game.PokerTournament.RegistrationErrorRes;
	import Message.event.game.PokerTournament.RegistrationRes;
	import Message.event.game.PokerTournament.TournamentStatusChangeRes;
	import Message.event.game.PokerTournament.UnregistrationErrorRes;
	import Message.event.game.PokerTournament.UnregistrationRes;
	import Message.event.game.PokerTournament.UserCountChangeRes;
	import Message.request.LeaveRoomRequest;
	import Message.request.game.pokerTournament.*;
	import Message.request.game.pokertexas.SitOnRequest;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.requests.ExtensionRequest;
	import com.smartfoxserver.v2.requests.JoinRoomRequest;
	
	import components._comp_TournamentDetail;
	
	import flash.events.Event;
	
	import model.M_Game;
	import model.M_JoinTable;
	import model.M_TournamentDetail;
	
	import mx.managers.PopUpManager;
	
	import params.RequestParams;
	import params.RoomVarParams;
	
	import zUtilities.GameVariable;
	import zUtilities.MainController;
	import zUtilities.ServerController;

	public class C_TournamentDetail
	{
		private static var m_instance:C_TournamentDetail = null;
		private static var m_isAllowed:Boolean = false;
		
		private var m_mTounamentDetail:M_TournamentDetail = M_TournamentDetail.getInstance();
		private var m_mGame:M_Game = M_Game.getInstance();
		private var m_cMain:MainController = MainController.getInstance();
		private var m_server:ServerController = ServerController.getInstance();
		
		
		public function C_TournamentDetail()
		{
			if(m_isAllowed == false){
				throw new Error("");
			}
			m_server.addEventListener(SFSEvent.ROOM_JOIN, onUserJoinRoom);
			
			m_server.addEventListener(POKER_TOUR_RESPONSE_NAME.REGISTRATION, onRegistrationTour);
			m_server.addEventListener(POKER_TOUR_RESPONSE_NAME.REGISTRATION_ERROR, onRegistrationErrorTour);
			m_server.addEventListener(POKER_TOUR_RESPONSE_NAME.UNREGISTRATION, onUnregistrationTour);
			m_server.addEventListener(POKER_TOUR_RESPONSE_NAME.UNREGISTRATION_ERROR, onUnregistrationErrorTour);
			
			m_server.addEventListener(POKER_TOUR_RESPONSE_NAME.TOURNAMENT_STATUS_CHANGE_RES, onTournamentStatusChange);
			m_server.addEventListener(POKER_TOUR_RESPONSE_NAME.USER_COUNT_CHANGE_RES, onUserCountChange);

		}
		
		public static function getInstance():C_TournamentDetail{
			if(m_instance == null){
				m_isAllowed = true;
				m_instance = new C_TournamentDetail();
				m_isAllowed = false;
			}
			return m_instance;
		}
		
		protected function onUserJoinRoom(event:Event):void{
			//var evt: RoomJoinEvent = event as RoomJoinEvent;
			hideBox();
		}
		
		private function formatTourStatus(status: String): String{
			var temp: String = status.toLowerCase();
			var firstChar: String = temp.charAt(0);
			return temp.replace(firstChar, firstChar.toUpperCase());
		}
		private function onTournamentStatusChange(event: Event):void
		{
			try{
				var evt: TournamentStatusChangeRes = event as TournamentStatusChangeRes;
				
				m_mTounamentDetail.strStatus = formatTourStatus(evt.Status);
			}catch(err:Error){
				trace(err.message);
			}
		}
		
		private function onUserCountChange(evt: Event):void
		{
			try{
				var res: UserCountChangeRes = evt as UserCountChangeRes;
				
				m_mTounamentDetail.strPlayerCount = res.UserCount.toString();
			}catch(error: Error){
				trace(error.message);
			}
		}
		
		private function onRegistrationErrorTour(evt: Event):void
		{
			try{
				var cusEvent: RegistrationErrorRes = evt as RegistrationErrorRes;
				m_mTounamentDetail.strStatusMsg = cusEvent.Message;
			}catch(error: Error){
				trace(error.message);
			}
		}
		
		private function onRegistrationTour(evt: Event):void
		{
			try{
				var cusEvent: RegistrationRes = evt as RegistrationRes;
				
				m_mTounamentDetail.strStatusMsg = "Register success!";
				m_mTounamentDetail.isRegistied = true;
				m_mTounamentDetail.setLabelBtnOk(true);
			}catch(error: Error){
				trace(error.message);
			}
		}
		private function onUnregistrationErrorTour(evt: Event):void
		{
			try{
				var cusEvent: UnregistrationErrorRes = evt as UnregistrationErrorRes;
				
				m_mTounamentDetail.strStatusMsg = cusEvent.Message;
			}catch(error: Error){
				trace(error.message);
			}
		}
		
		private function onUnregistrationTour(evt: Event):void
		{
			try{
				var cusEvent: UnregistrationRes = evt as UnregistrationRes;
				
				m_mTounamentDetail.strStatusMsg = "Unregister success!";
				m_mTounamentDetail.isRegistied = false;
				m_mTounamentDetail.setLabelBtnOk(false);
			}catch(error: Error){
				trace(error.message);
			}
		}
		/********* HANDLE GUI EVENT ***********/
		public function handleBtnOK_click(event:Event):void{
			if(m_mTounamentDetail.isRegistied){
				handleUnregistryRequest();
			}else{
				handleRegisterRequest();
			}
			//hideBox();
		}
		public function handleBtnCancel_click(event:Event):void{
			hideBox();
		}
		/********* END HANDLE GUI EVENT ***********/
		
		
		public function showTourDetail():void{
			m_mTounamentDetail.vTournament = new _comp_TournamentDetail();
			PopUpManager.addPopUp(m_mTounamentDetail.vTournament, m_cMain.vMain, true);
			PopUpManager.centerPopUp(m_mTounamentDetail.vTournament);
		}
		
		private function hideBox():void{
			m_mTounamentDetail.clearAll();
			PopUpManager.removePopUp(m_mTounamentDetail.vTournament);
		}
		
		public function handleReplyInviteRequest(isAccept: Boolean):void{
			try{
				var request: ReplyInviteTourRequest = new ReplyInviteTourRequest();
				
				request.AddParam(ReplyInviteTourRequest.TOUR_NAME, m_mTounamentDetail.strName);
				request.AddParam(ReplyInviteTourRequest.IS_ACCEPT, isAccept);
				m_server.SendCustomRequest(request);
			}catch(error: Error){
				trace(error.message);
			}
		}
		
		public function handleGetDetailTournamentRequest():void{
			try{
				var request: GetDetailTourRequest = new GetDetailTourRequest();
				
				request.AddParam(GetDetailTourRequest.TOUR_NAME, m_mTounamentDetail.strName);
				m_server.SendCustomRequest(request);
			}catch(error: Error){
				trace(error.message);
			}
		}
		
		private function handleRegisterRequest():void{
			var tourName: String = m_mTounamentDetail.strName;
			var regisReq: RegistryTourRequest = new RegistryTourRequest();
			regisReq.AddParam(RegistryTourRequest.TOUR_NAME ,tourName);
			
			m_server.SendCustomRequest(regisReq);
		}
		
		public function handleUnregistryRequest():void{
			try{
				var request: UnregistryTourRequest = new UnregistryTourRequest();
				
				request.AddParam(RegistryTourRequest.TOUR_NAME, m_mTounamentDetail.strName);
				m_server.SendCustomRequest(request);
			}catch(error: Error){
				trace(error.message);
			}
		}
	}
}