package zUtilities
{
	import Message.*;
	import Message.SFSGameEvent;
	import Message.event.*;
	import Message.event.UserCountChangeEvent;
	import Message.event.admin.*;
	import Message.event.admin.ADMIN_RESPONSE_NAME;
	import Message.event.general.*;
	
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
		
		private var m_EventDispatcher:EventDispatcher = new EventDispatcher();
		
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
			/*m_smartfox.addEventListener(SFSEvent.USER_ENTER_ROOM, onUserEnterRoom);
			m_smartfox.addEventListener(SFSEvent.USER_EXIT_ROOM, onUserExitRoom);*/
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
			Logger.Log("+ New EventListener Added : " + strEventName);			
			m_eventDispatcher.addEventListener(strEventName,fnHandler);
		}
		public function RemoveEventListener(strEventName:String, fnHandler:Function):void {
			Logger.Log("+ Remove EventListener : " + strEventName);			
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
			Logger.Log("Send Custom Request: " + cRequest.GetRequestName());//GetMessage().id);
			m_smartfox.send(cRequest.ToSFSRequest());
		}
		
		public function getRoomList():Array{
			//return m_smartfox.roomList;
			return m_smartfox.getRoomListFromGroup("game_poker");
		}
		
		public function addResponseHandler(type:String, listener:Function):void{
			m_EventDispatcher.addEventListener(type, listener);
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
				}else if(event.params.cmd == GENERAL_EVENT_NAME.GET_LIST_FREE_USER_RES){
					evt = new GetListFreeUserEvent();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == GENERAL_EVENT_NAME.INVITATION_REPLY_RES){
					evt = new InvitationReplyCusEvent();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == GENERAL_EVENT_NAME.INVITATION_RES){
					evt = new InvitationCusEvent();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == ADMIN_RESPONSE_NAME.GET_LIST_ROOM_RES){
					evt = new GetListRoomRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == ADMIN_RESPONSE_NAME.GET_LIST_USER_RES){
					evt = new GetListUserRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == ADMIN_RESPONSE_NAME.GET_LIST_TOURNAMENT_RES){
					evt = new GetListTournamentRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == ADMIN_RESPONSE_NAME.GET_LIST_LEVEL_RES){
					evt = new GetListLevelRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == ADMIN_RESPONSE_NAME.GET_LEVEL_COLLECTION_RES){
					evt = new GetLevelCollectionRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == ADMIN_RESPONSE_NAME.CREATE_RES){
					evt = new CreateRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == ADMIN_RESPONSE_NAME.CREATE_ERROR_RES){
					evt = new CreateErrorRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == ADMIN_RESPONSE_NAME.UPDATE_RES){
					evt = new UpdateRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == ADMIN_RESPONSE_NAME.UPDATE_ERROR_RES){
					evt = new UpdateErrorRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == ADMIN_RESPONSE_NAME.DELETE_RES){
					evt = new DeleteRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == ADMIN_RESPONSE_NAME.DELETE_ERROR_RES){
					evt = new DeleteErrorRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == ADMIN_RESPONSE_NAME.UPDATE_TOUR_STATUS_RES){
					evt = new UpdateTourStatusRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == ADMIN_RESPONSE_NAME.ADD_CHIP_FOR_USER_RES){
					evt = new AddChipRes();
					evt.FromSFSEvent(event);
				}else if(event.params.cmd == ADMIN_RESPONSE_NAME.GET_TRANSACTION_RES){
					evt = new GetTransactionRes();
					evt.FromSFSEvent(event);
				}
				
				if(evt != null){
					//m_smartfox.dispatchEvent(evt);
					DispatchSFSGameEvent(evt);
					Logger.Log(evt.type);
				}
				
			}catch(error: Error){
				throw error;
			}
		}
		
		protected function DispatchSFSGameEvent(evt: SFSGameEvent):void{
			Logger.Dump2(evt);
			m_eventDispatcher.dispatchEvent(evt);
		}
		
		protected function onLoadSuccess(evt: SFSEvent): void{
			Logger.Log("load config success ");
			connect();
		}
		protected function onConnectSuccess(evt: SFSEvent): void{
			Logger.Log("Enter onConnectSuccess");
			Logger.Dump(evt);
			var connectEvt: SFSGameEvent = new ConnectionEvent();
			if(connectEvt.FromSFSEvent(evt) != null){
				DispatchSFSGameEvent(connectEvt);
			}
		}
		protected function onConnectLost(evt: SFSEvent): void{
			Logger.Log("Enter onConnectLost");
			Logger.Dump(evt);
			var connectLostEvt: SFSGameEvent = new ConnectionLostEvent();
			if(connectLostEvt.FromSFSEvent(evt) != null){
				DispatchSFSGameEvent(connectLostEvt);
			}
		}
		protected function onLoadFail(evt: SFSEvent): void{
			Logger.Log("load config fails ");
		}
		protected function onLogin(evt: SFSEvent): void{
			Logger.Log("Enter onLogin");
			Logger.Dump(evt);
			var loginEvt: SFSGameEvent = new LoginEvent();
			if(loginEvt.FromSFSEvent(evt) != null){
				DispatchSFSGameEvent(loginEvt);
			}
			
		}
		protected function onLoginError(evt: SFSEvent): void{
			Logger.Log("Enter onLoginError");
			Logger.Dump(evt);
			var loginErrorEvt: SFSGameEvent = new LoginErrorEvent();
			if(loginErrorEvt.FromSFSEvent(evt) != null){
				DispatchSFSGameEvent(loginErrorEvt);
			}
			
		}
		protected function onRoomJoin(evt: SFSEvent): void{
			Logger.Log("Enter onRoomJoin");
			Logger.Dump(evt);
			var roomJoinEvt: SFSGameEvent = new RoomJoinEvent();
			if(roomJoinEvt.FromSFSEvent(evt) != null){
				DispatchSFSGameEvent(roomJoinEvt);
			}
			
		}
		protected function onRoomAdd(evt: SFSEvent): void{
			Logger.Log("Enter onRoomAdd");
			Logger.Dump(evt);
			var roomAddEvt: SFSGameEvent = new RoomAddEvent();
			
			if(roomAddEvt.FromSFSEvent(evt) != null){
				DispatchSFSGameEvent(roomAddEvt);
			}
			
		}
		protected function onRoomRemove(event:SFSEvent):void
		{
			Logger.Log("Enter Room REmove Evt");
			Logger.Dump(event);
			var evt : SFSGameEvent = new RoomRemoveEvent();
			if(evt.FromSFSEvent(event) != null){
				DispatchSFSGameEvent(evt);
			}
		}	
		protected function onRoomCreateError(evt: SFSEvent): void{
			Logger.Log("Enter onRoomCreateError");
			Logger.Dump(evt);
			var roomCreateErrorEvt: SFSGameEvent = new RoomCreationErrorEvent();
			if(roomCreateErrorEvt.FromSFSEvent(evt) != null){
				DispatchSFSGameEvent(roomCreateErrorEvt);
			}
			
		}
		protected function onRoomJoinError(evt: SFSEvent): void{
			Logger.Log("Enter onRoomJoinError");
			Logger.Dump(evt);
			var roomJoinErrorEvt: SFSGameEvent = new RoomJoinErrorEvent();
			if(roomJoinErrorEvt.FromSFSEvent(evt) != null){
				DispatchSFSGameEvent(roomJoinErrorEvt);
			}
			
		}
		protected function onRoomVariableUpdate(event:SFSEvent):void
		{
			Logger.Log("Enter onRoomVariableUpdate");
			Logger.Dump(event);
			var evt: SFSGameEvent = new RoomVariableUpdateEvent();
			if(evt.FromSFSEvent(event) != null){
				DispatchSFSGameEvent(evt);
			}
		}	
		
		protected function onLogout(evt:SFSEvent):void{
			Logger.Log("Enter onLogout");
			Logger.Dump(evt);
			var logoutEvt: SFSGameEvent = new LogoutEvent();
			if(logoutEvt.FromSFSEvent(evt) != null){
				DispatchSFSGameEvent(logoutEvt);
			}
		}
		/*protected function onUserEnterRoom(evt:SFSEvent):void{
			Logger.Log("Enter onUserEnterRoom");
			Logger.Dump(evt);
			var enterRoomEvt: SFSGameEvent = new UserEnterRoomEvent();
			if(enterRoomEvt.FromSFSEvent(evt) != null){
				DispatchSFSGameEvent(enterRoomEvt);
			}
			
		}
		protected function onUserExitRoom(evt:SFSEvent):void{
			Logger.Log("Enter onUserExitRoom");
			Logger.Dump(evt);
			var exitRoomEvt: SFSGameEvent = new UserExitRoomEvent();
			if(exitRoomEvt.FromSFSEvent(evt) != null){
				DispatchSFSGameEvent(exitRoomEvt);
			}
		}*/
		protected function onUserVariablesUpdate(evt:SFSEvent):void {
			Logger.Log("Enter onUserVariablesUpdate");
			Logger.Dump(evt);
			var userVarUpdateEvt: SFSGameEvent = new UserVariableUpdateEvent();
			if (userVarUpdateEvt.FromSFSEvent(evt) != null) {
				DispatchSFSGameEvent(userVarUpdateEvt);
			}
		}
		protected function onPublicMessage(event:SFSEvent):void
		{
			Logger.Log("Enter onPublicMessage");
			Logger.Dump(event);
			var chatEvt: SFSGameEvent = new PublicMessageEvent();
			if(chatEvt.FromSFSEvent(event) != null){
				DispatchSFSGameEvent(chatEvt);
			}
		}
		protected function onInvitation(event:SFSEvent):void
		{
			Logger.Log("Enter onInvitation");
			Logger.Dump(event);
			var inviteEvt: SFSGameEvent = new InvitationEvent();
			if(inviteEvt.FromSFSEvent(event) != null){
				DispatchSFSGameEvent(inviteEvt);
			}
		}
		protected function onInvitationReply(event:SFSEvent):void
		{
			Logger.Log("Enter onInvitationReply");
			Logger.Dump(event);
			var inviteReplyEvt: SFSGameEvent = new InvitationReplyEvent();
			if(inviteReplyEvt.FromSFSEvent(event) != null){
				DispatchSFSGameEvent(inviteReplyEvt);
			}
		}
		protected function onInvitationReplyError(event:SFSEvent):void
		{
			Logger.Log("Enter onInvitationReplyError");
			Logger.Dump(event);
			var replyErrorEvt: SFSGameEvent = new InvitationReplyErrorEvent();
			if(replyErrorEvt.FromSFSEvent(event) != null){
				DispatchSFSGameEvent(replyErrorEvt);
			}
		}
		protected function onUserCountChange(event:SFSEvent):void{
			Logger.Log("Enter onUserCountChange");
			Logger.Dump(event);
			var uCountChangEvt: SFSGameEvent = new UserCountChangeEvent();
			if(uCountChangEvt.FromSFSEvent(event) != null){
				DispatchSFSGameEvent(uCountChangEvt);
			}
		}
	}
}
