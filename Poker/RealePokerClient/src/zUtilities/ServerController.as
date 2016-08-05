package zUtilities
{
	import Message.*;
	import Message.SFSGameEvent;
	import Message.event.*;
	import Message.event.UserCountChangeEvent;
	import Message.event.game.PokerTournament.*;
	import Message.event.game.pokertexas.*;
	import Message.event.game.pokertexas.POKER_RESPONSE_NAME;
	import Message.event.general.*;
	import Message.request.general.GetTransactionByUserRequest;
	
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.requests.IRequest;
	
	import flash.events.EventDispatcher;

	public class ServerController
	{
		private static var m_instance : ServerController = null;
		private static var m_isAllowed : Boolean = false;
		private var m_smartfox : SmartFox;
		private var m_eventDispatcher : EventDispatcher;
		
		private var m_logger: Logger = new Logger();
		
		public function ServerController(){
			if( m_isAllowed == false){
				throw new Error("Please Use GetInstance Method Instead");
			}			
			m_smartfox  = new SmartFox(true);
			m_eventDispatcher = new EventDispatcher();
			//m_smartfox.addEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse);
			RegisterSFSEvent();
		}
		
		/// Regster all sfs event would be dispatch from SERVRE
		private function RegisterSFSEvent():void{
			// Config & Login Event
			m_smartfox.addEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, onLoadSuccess);
			m_smartfox.addEventListener(SFSEvent.CONFIG_LOAD_FAILURE, onLoadFail);
			m_smartfox.addEventListener(SFSEvent.CONNECTION, onConnectSuccess);
			m_smartfox.addEventListener(SFSEvent.CONNECTION_LOST, onConnectLost);
			m_smartfox.addEventListener(SFSEvent.LOGIN, onLogin);
			m_smartfox.addEventListener(SFSEvent.LOGIN_ERROR, onLoginError);
			m_smartfox.addEventListener(SFSEvent.LOGOUT, onLogout);
			//Room Event
			m_smartfox.addEventListener(SFSEvent.ROOM_ADD, onRoomAdd);
			m_smartfox.addEventListener(SFSEvent.ROOM_REMOVE, onRoomRemove);
			m_smartfox.addEventListener(SFSEvent.ROOM_CREATION_ERROR, onRoomCreateError);
			m_smartfox.addEventListener(SFSEvent.ROOM_JOIN, onRoomJoin);
			m_smartfox.addEventListener(SFSEvent.ROOM_JOIN_ERROR, onRoomJoinError);
			m_smartfox.addEventListener(SFSEvent.ROOM_VARIABLES_UPDATE, onRoomVariableUpdate);
			m_smartfox.addEventListener(SFSEvent.USER_COUNT_CHANGE, onUserCountChange);	
			//User Event
			m_smartfox.addEventListener(SFSEvent.USER_ENTER_ROOM, onUserEnterRoom);
			m_smartfox.addEventListener(SFSEvent.USER_EXIT_ROOM, onUserExitRoom);
			m_smartfox.addEventListener(SFSEvent.USER_VARIABLES_UPDATE, onUserVariablesUpdate);
			//Inivte Event
			m_smartfox.addEventListener(SFSEvent.INVITATION, onInvitation);
			m_smartfox.addEventListener(SFSEvent.INVITATION_REPLY, onInvitationReply);
			m_smartfox.addEventListener(SFSEvent.INVITATION_REPLY_ERROR, onInvitationReplyError);
			//Chat Event
			m_smartfox.addEventListener(SFSEvent.PUBLIC_MESSAGE, onPublicMessage);
			//Custom Event
			m_smartfox.addEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse);
			
		}
		public static function getInstance(): ServerController{
			if(m_instance == null){
				m_isAllowed = true;
				m_instance = new ServerController();
				m_isAllowed = false;				 
			}
			return m_instance;
		}
		/*public function addEventListener(type : String, HandlerFunction: Function):void{
						
			m_smartfox.addEventListener(type,HandlerFunction);
		}*/
		public function addEventListener(strEventName:String, fnHandler:Function):void {
			m_logger.Log("+ New EventListener Added : " + strEventName);			
			m_eventDispatcher.addEventListener(strEventName,fnHandler);
		}
		public function RemoveEventListener(strEventName:String, fnHandler:Function):void {
			m_logger.Log("+ Remove EventListener : " + strEventName);			
			m_eventDispatcher.removeEventListener(strEventName,fnHandler);
		}
		public function isConnected():Boolean {
			return m_smartfox.isConnected;
		}
		public function loadConfig():void{
			m_smartfox.loadConfig();			
		}
		public function connect():void{
			m_smartfox.connect(m_smartfox.config.host, m_smartfox.config.port);
		}
		public function sendRequest(request:SFSGameRequest):void{
			m_smartfox.send(request.ToSFSRequest());			
		}
		public function SendCustomRequest(cRequest:SFSCustomRequest):void {
			m_logger.Log("Send Custom Request: " + cRequest.GetRequestName());//GetMessage().id);
			m_smartfox.send(cRequest.ToSFSRequest());
		}

		public function getRoomList():Array{
			//return m_smartfox.roomList;
			return m_smartfox.getRoomListFromGroup("game_poker");
		}
		
		public function disconnect():void{
			m_smartfox.disconnect();			
		}
		
		public function getUserByName(userName:String):User{
			return m_smartfox.userManager.getUserByName(userName);
		}
				
		/*private function onExtensionResponse(event:SFSEvent):void{
			m_EventDispatcher.dispatchEvent(new SFSEvent(event.params.cmd, event.params.params));
		}*/
		private function onExtensionResponse(event: SFSEvent):void{
			try{
				var evt: SFSGameEvent;
				
				if(event.params.cmd == GENERAL_EVENT_NAME.GET_USER_INFO){
					evt = new GetUserInfoEvent();
					evt.FromSFSEvent(event);					
				}else if(event.params.cmd == GENERAL_EVENT_NAME.CHARGE_CARD_RES){
					evt = new ChargeCardEvent();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_RESPONSE_NAME.SIT_ON_RES){
					evt = new Notify_SitOn();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_RESPONSE_NAME.LOAD_TABLE_INFO_RES){
					evt = new LoadTableInfoRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_RESPONSE_NAME.STAND_UP_RES){
					evt = new Notify_StandUp();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_RESPONSE_NAME.USER_SIT_ON_RES){
					evt = new Notify_UserSitOn();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_RESPONSE_NAME.USER_SIT_OUT_RES){
					evt = new Notify_UserSitOut();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_RESPONSE_NAME.PRE_START){
					evt = new Notify_PreStart();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_RESPONSE_NAME.START){
					evt = new Notify_Start();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_RESPONSE_NAME.KICK_USER_RES){
					evt = new Notify_KickUser();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_RESPONSE_NAME.GAME_TURN_RES){
					evt = new Notify_GameTurn();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_RESPONSE_NAME.USER_TURN_RES){
					evt = new Notify_UserTurn();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_RESPONSE_NAME.USER_BET_RES){
					evt = new Notify_UserBet();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_RESPONSE_NAME.USER_CALL_RES){
					evt = new Notify_UserCall();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_RESPONSE_NAME.USER_CHECK_RES){
					evt = new Notify_UserCheck();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_RESPONSE_NAME.USER_FOLD_RES){
					evt = new Notify_UserFold();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_RESPONSE_NAME.USER_GOING_ALL_RES){
					evt = new Notify_UserGoingAllIn();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_RESPONSE_NAME.USER_RAISE_RES){
					evt = new Notify_UserRaise();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_RESPONSE_NAME.SHOW_DOWN_RES){
					evt = new Notify_ShowDown();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_RESPONSE_NAME.FINISH_GAME_RES){
					evt = new Notify_FinishGame();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_RESPONSE_NAME.USER_READY_RES){
					evt = new Notify_UserReady();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_RESPONSE_NAME.LEVEL_TURN_RES){
					evt = new Notify_LevelTurn();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_RESPONSE_NAME.PAY_ANTE_RES){
					evt = new Notify_PayAnte();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == GENERAL_EVENT_NAME.GET_LIST_FREE_USER_RES){
					evt = new GetListFreeUserEvent();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == GENERAL_EVENT_NAME.INVITATION_REPLY_RES){
					evt = new InvitationReplyCusEvent();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == GENERAL_EVENT_NAME.INVITATION_RES){
					evt = new InvitationCusEvent();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_TOUR_RESPONSE_NAME.GET_DETAIL_TOUR){
					evt = new GetDetailTourRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_TOUR_RESPONSE_NAME.GET_LIST_TOUR){
					evt = new GetListTournamentRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_TOUR_RESPONSE_NAME.REGISTRATION){
					evt = new RegistrationRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_TOUR_RESPONSE_NAME.REGISTRATION_ERROR){
					evt = new RegistrationErrorRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_TOUR_RESPONSE_NAME.UNREGISTRATION){
					evt = new UnregistrationRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_TOUR_RESPONSE_NAME.UNREGISTRATION_ERROR){
					evt = new UnregistrationErrorRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_TOUR_RESPONSE_NAME.INVITE_TOUR){
					evt = new InviteTourRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_TOUR_RESPONSE_NAME.USER_REWARD_RES){
					evt = new UserRewardRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_TOUR_RESPONSE_NAME.USER_COUNT_CHANGE_RES){
					evt = new UserCountChangeRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == GENERAL_EVENT_NAME.REGISTER){
					evt = new RegisterEvent();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == GENERAL_EVENT_NAME.REGISTER_ERROR){
					evt = new RegisterErrorEvent();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_TOUR_RESPONSE_NAME.TOUR_ADDED_RES){
					evt = new TourAddedRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_TOUR_RESPONSE_NAME.TOUR_DELETE_RES){
					evt = new TourRemovedRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_TOUR_RESPONSE_NAME.TOUR_UPDATE_RES){
					evt = new TourUpdatedRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_TOUR_RESPONSE_NAME.UPDATE_TOUR_STATUS_RES){
					evt = new UpdateTourStatusRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == POKER_TOUR_RESPONSE_NAME.TOURNAMENT_STATUS_CHANGE_RES){
					evt = new TournamentStatusChangeRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == GENERAL_EVENT_NAME.GET_TRANS_BY_USER_RES){
					evt = new GetTransByUserEvent();
					evt.FromSFSEvent(event);
				}
				
				if(evt != null){
					//m_smartfox.dispatchEvent(evt);
					DispatchSFSGameEvent(evt);
					m_logger.Log(evt.type);
				}
				
			}catch(error: Error){
				throw error;
			}
		}
		
		protected function DispatchSFSGameEvent(evt: SFSGameEvent):void{
			m_logger.Dump2(evt);
			m_eventDispatcher.dispatchEvent(evt);
		}
		
		protected function onLoadSuccess(evt: SFSEvent): void{
			m_logger.Log("load config success ");
			//m_smartfox.killConnection();
			m_smartfox.disconnect();
			connect();
		}
		protected function onConnectSuccess(evt: SFSEvent): void{
			
			m_logger.Log("Enter onConnectSuccess");
			m_logger.Dump(evt);
			var connectEvt: SFSGameEvent = new ConnectionEvent();
			if(connectEvt.FromSFSEvent(evt) != null){
				DispatchSFSGameEvent(connectEvt);
			}
		}
		protected function onConnectLost(evt: SFSEvent): void{
			m_logger.Log("Enter onConnectLost");
			m_logger.Dump(evt);
			var connectLostEvt: SFSGameEvent = new ConnectionLostEvent();
			if(connectLostEvt.FromSFSEvent(evt) != null){
				DispatchSFSGameEvent(connectLostEvt);
			}
		}
		protected function onLoadFail(evt: SFSEvent): void{
			m_logger.Log("load config fails ");
		}
		protected function onLogin(evt: SFSEvent): void{
			m_logger.Log("Enter onLogin");
			m_logger.Dump(evt);
			var loginEvt: SFSGameEvent = new LoginEvent();
			if(loginEvt.FromSFSEvent(evt) != null){
				DispatchSFSGameEvent(loginEvt);
			}
			
		}
		protected function onLoginError(evt: SFSEvent): void{
			m_logger.Log("Enter onLoginError");
			m_logger.Dump(evt);
			var loginErrorEvt: SFSGameEvent = new LoginErrorEvent();
			if(loginErrorEvt.FromSFSEvent(evt) != null){
				DispatchSFSGameEvent(loginErrorEvt);
			}
			
		}
		protected function onRoomJoin(evt: SFSEvent): void{
			m_logger.Log("Enter onRoomJoin");
			m_logger.Dump(evt);
			var roomJoinEvt: SFSGameEvent = new RoomJoinEvent();
			if(roomJoinEvt.FromSFSEvent(evt) != null){
				DispatchSFSGameEvent(roomJoinEvt);
			}
			
		}
		protected function onRoomAdd(evt: SFSEvent): void{
			m_logger.Log("Enter onRoomAdd");
			m_logger.Dump(evt);
			var roomAddEvt: SFSGameEvent = new RoomAddEvent();
			
			if(roomAddEvt.FromSFSEvent(evt) != null){
				DispatchSFSGameEvent(roomAddEvt);
			}
			
		}
		protected function onRoomRemove(event:SFSEvent):void
		{
			m_logger.Log("Enter Room REmove Evt");
			m_logger.Dump(event);
			var evt : SFSGameEvent = new RoomRemoveEvent();
			if(evt.FromSFSEvent(event) != null){
				DispatchSFSGameEvent(evt);
			}
		}	
		protected function onRoomCreateError(evt: SFSEvent): void{
			m_logger.Log("Enter onRoomCreateError");
			m_logger.Dump(evt);
			var roomCreateErrorEvt: SFSGameEvent = new RoomCreationErrorEvent();
			if(roomCreateErrorEvt.FromSFSEvent(evt) != null){
				DispatchSFSGameEvent(roomCreateErrorEvt);
			}
			
		}
		protected function onRoomJoinError(evt: SFSEvent): void{
			m_logger.Log("Enter onRoomJoinError");
			m_logger.Dump(evt);
			var roomJoinErrorEvt: SFSGameEvent = new RoomJoinErrorEvent();
			if(roomJoinErrorEvt.FromSFSEvent(evt) != null){
				DispatchSFSGameEvent(roomJoinErrorEvt);
			}
			
		}
		protected function onRoomVariableUpdate(event:SFSEvent):void
		{
			m_logger.Log("Enter onRoomVariableUpdate");
			m_logger.Dump(event);
			var evt: SFSGameEvent = new RoomVariableUpdateEvent();
			if(evt.FromSFSEvent(event) != null){
				DispatchSFSGameEvent(evt);
			}
		}	
		
		protected function onLogout(evt:SFSEvent):void{
			m_logger.Log("Enter onLogout");
			m_logger.Dump(evt);
			var logoutEvt: SFSGameEvent = new LogoutEvent();
			if(logoutEvt.FromSFSEvent(evt) != null){
				DispatchSFSGameEvent(logoutEvt);
			}
		}
		protected function onUserEnterRoom(evt:SFSEvent):void{
			m_logger.Log("Enter onUserEnterRoom");
			m_logger.Dump(evt);
			var enterRoomEvt: SFSGameEvent = new UserEnterRoomEvent();
			if(enterRoomEvt.FromSFSEvent(evt) != null){
				DispatchSFSGameEvent(enterRoomEvt);
			}
			
		}
		protected function onUserExitRoom(evt:SFSEvent):void{
			m_logger.Log("Enter onUserExitRoom");
			m_logger.Dump(evt);
			var exitRoomEvt: SFSGameEvent = new UserExitRoomEvent();
			if(exitRoomEvt.FromSFSEvent(evt) != null){
				DispatchSFSGameEvent(exitRoomEvt);
			}
		}
		protected function onUserVariablesUpdate(evt:SFSEvent):void {
			m_logger.Log("Enter onUserVariablesUpdate");
			m_logger.Dump(evt);
			var userVarUpdateEvt: SFSGameEvent = new UserVariableUpdateEvent();
			if (userVarUpdateEvt.FromSFSEvent(evt) != null) {
				DispatchSFSGameEvent(userVarUpdateEvt);
			}
		}
		protected function onPublicMessage(event:SFSEvent):void
		{
			m_logger.Log("Enter onPublicMessage");
			m_logger.Dump(event);
			var chatEvt: SFSGameEvent = new PublicMessageEvent();
			if(chatEvt.FromSFSEvent(event) != null){
				DispatchSFSGameEvent(chatEvt);
			}
		}
		protected function onInvitation(event:SFSEvent):void
		{
			m_logger.Log("Enter onInvitation");
			m_logger.Dump(event);
			var inviteEvt: SFSGameEvent = new InvitationEvent();
			if(inviteEvt.FromSFSEvent(event) != null){
				DispatchSFSGameEvent(inviteEvt);
			}
		}
		protected function onInvitationReply(event:SFSEvent):void
		{
			m_logger.Log("Enter onInvitationReply");
			m_logger.Dump(event);
			var inviteReplyEvt: SFSGameEvent = new InvitationReplyEvent();
			if(inviteReplyEvt.FromSFSEvent(event) != null){
				DispatchSFSGameEvent(inviteReplyEvt);
			}
		}
		protected function onInvitationReplyError(event:SFSEvent):void
		{
			m_logger.Log("Enter onInvitationReplyError");
			m_logger.Dump(event);
			var replyErrorEvt: SFSGameEvent = new InvitationReplyErrorEvent();
			if(replyErrorEvt.FromSFSEvent(event) != null){
				DispatchSFSGameEvent(replyErrorEvt);
			}
		}
		protected function onUserCountChange(event:SFSEvent):void{
			m_logger.Log("Enter onUserCountChange");
			m_logger.Dump(event);
			var uCountChangEvt: SFSGameEvent = new UserCountChangeEvent();
			if(uCountChangEvt.FromSFSEvent(event) != null){
				DispatchSFSGameEvent(uCountChangEvt);
			}
		}
	}
}
			