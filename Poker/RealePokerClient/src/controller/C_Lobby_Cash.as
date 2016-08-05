package controller
{
	import Enum.RoomVariableDetail;
	
	import Message.event.RoomAddEvent;
	import Message.event.RoomJoinErrorEvent;
	import Message.event.RoomJoinEvent;
	import Message.event.RoomRemoveEvent;
	import Message.event.RoomVariableUpdateEvent;
	import Message.event.UserCountChangeEvent;
	import Message.request.JoinRoomRequest;
	import Message.request.QuickJoinGameRequest;
	
	import com.smartfoxserver.v2.bitswarm.Message;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.entities.match.*;
	import com.smartfoxserver.v2.entities.match.MatchExpression;
	import com.smartfoxserver.v2.entities.match.StringMatch;
	import com.smartfoxserver.v2.entities.variables.RoomVariable;
	import com.smartfoxserver.v2.exceptions.SFSError;
	
	import entity.RoomEntity;
	
	import flash.events.Event;
	
	import model.M_BetBoard;
	import model.M_Game;
	import model.M_JoinTable;
	import model.M_Lobby_Cash;
	import model.M_Login;
	
	import params.RoomVarParams;
	
	import zUtilities.GameVariable;
	import zUtilities.Logger;
	import zUtilities.MainController;
	import zUtilities.ServerController;

	public class C_Lobby_Cash
	{
		private var m_mLobby_Cash:M_Lobby_Cash = M_Lobby_Cash.getInstance();
		private var m_mJoinTable:M_JoinTable = M_JoinTable.getInstance();
		private var m_mGame:M_Game = M_Game.getInstance();
		
		private var m_server:ServerController = ServerController.getInstance();
		private var m_cJoinTable:C_JoinTable = new C_JoinTable();
		private var m_cMain:MainController = MainController.getInstance();
		
		private var m_cMessageBox:C_MessageBox = new C_MessageBox();
		
		private var m_mBetBoard:M_BetBoard = M_BetBoard.getInstance();
		
		private var m_logger: Logger = new Logger();
		
		public function C_Lobby_Cash()
		{
			m_server.addEventListener(SFSEvent.ROOM_JOIN, onJoinRoom);
			m_server.addEventListener(SFSEvent.ROOM_JOIN_ERROR, onJoinRoomError);
			m_server.addEventListener(SFSEvent.ROOM_ADD, onRoomAdded);
			m_server.addEventListener(SFSEvent.ROOM_REMOVE, onRoomRemoved);
			m_server.addEventListener(SFSEvent.ROOM_VARIABLES_UPDATE, onRoomVariablesUpdate);
			m_server.addEventListener(SFSEvent.USER_COUNT_CHANGE, onUserCountChange);
		}
		
		
		/*************** HANDLE EVENT LISTENER ******************/
		//khoatd edited
		/*private function onJoinRoom(event:Event):void{			
			//var room:Room = event.params.room;
			var joinEvt: RoomJoinEvent = event as RoomJoinEvent;
			var room:Room = joinEvt.RoomInfo;
			// if(room is not cash) return;
			GameVariable.GetInstance().CurrentRoom = room;
			//m_globalVar.myPos = -1;
			m_mGame.setGameInfo();	
			m_mGame.isSittingOut = false;
			m_cMain.gotoState_Game();			
			m_mGame.isReady = true;
		}*/
		private function onJoinRoom(event:Event):void{			
			m_logger.Log("enter onJoinRoom ");
			var joinEvt: RoomJoinEvent = event as RoomJoinEvent;
			var room:Room = joinEvt.RoomInfo;
			
			var roomEntity: RoomEntity = RoomEntity.FromRoom(room);
			m_mJoinTable.setTableInfo(room.id, room.name,  roomEntity.DisplayName,
				roomEntity.BetChip, roomEntity.BetChip * 2, roomEntity.MinChip,
				roomEntity.MaxChip, room.userCount, room.maxUsers, roomEntity.NoLimit);			
			
			GameVariable.GetInstance().CurrentRoom = room;
			GameVariable.GetInstance().myPos = -1;	
			m_mGame.setGameInfo();	
			m_mGame.isSittingOut = false;
			m_mGame.isCanAutoFold = false;
			m_mGame.isAutoFold = false;
			m_cMain.gotoState_Game();			
			m_mGame.isReady = true;
			m_mGame.isSitting = false;
			
		}
		private function onJoinRoomError(event:Event):void
		{
			var joinEvt: RoomJoinErrorEvent = event as RoomJoinErrorEvent;
			m_cMessageBox.showMessageBox(joinEvt.ErrorMessage);
		}
		
		
		//khoatd edited
		/*private function onRoomVariablesUpdate(event:Event):void{
			var changedVars:Array = event.params.changedVars as Array;			
			var room:Room = event.params.room as Room;
			if(changedVars.indexOf(RoomVarParams.STATUS) != -1){				
				var status:String = room.getVariable(RoomVarParams.STATUS).getStringValue();
				m_mLobby_Cash.changeStatus(room.name, status);
			}
		}*/
		private function onRoomVariablesUpdate(event:Event):void{
			var updateEvt: RoomVariableUpdateEvent = event as RoomVariableUpdateEvent;
			m_mLobby_Cash.handleRoomVariableUpdate(updateEvt.RoomInfo, updateEvt.ChangedVars);
		}
		
		//khoatd edited
		/*private function onUserCountChange(event:Event):void{
			var room:Room = event.params.room as Room;
			m_mLobby_Cash.changePlayerCount(room.name, room.userCount);
		}*/
		private function onUserCountChange(event:Event):void{
			var countEvt: UserCountChangeEvent = event as UserCountChangeEvent;
			var room: Room = countEvt.RoomInfo;
			m_mLobby_Cash.changePlayerCount(room.name, room.userCount);
		}
		
		//khoatd edited
		/*private function onRoomAdded(event:Event):void{
			var addEvt: RoomAddEvent = event as RoomAddEvent;
			var room:Room = addEvt.RoomInfo;
			var id:int = room.id;
			var name:String = room.name;
			var sBlind:Number = room.getVariable(RoomVarParams.SMALL_BLIND).getDoubleValue();
			var bBlind:Number = room.getVariable(RoomVarParams.BIG_BLIND).getDoubleValue();
			var pCount:int = room.userCount;
			var mPlayer:int = room.maxUsers;
			var min:int = room.getVariable(RoomVarParams.MIN_BUY_IN).getDoubleValue();
			var max:int = room.getVariable(RoomVarParams.MAX_BUY_IN).getDoubleValue();
			var status:String = room.getVariable(RoomVarParams.STATUS).getStringValue();
			var noLimit:Boolean = room.getVariable(RoomVarParams.NO_LIMIT).getBoolValue();
			
			m_mLobby_Cash.addItem(room.id, room.name, sBlind, bBlind, pCount, mPlayer, min, max, status, noLimit);
		}*/
		private function onRoomAdded(event:Event):void{
			var addEvt: RoomAddEvent = event as RoomAddEvent;
			var room:Room = addEvt.RoomInfo;
			var roomEntity: RoomEntity = RoomEntity.FromRoom(room);
			var id:int = room.id;
			var name:String = room.name;
			var displayName:String = roomEntity.DisplayName;
			var sBlind:Number = roomEntity.BetChip;
			var bBlind:Number = roomEntity.BetChip * 2;
			var pCount:int = room.userCount;
			var mPlayer:int = room.maxUsers;
			var min:int = roomEntity.MinChip;
			var max:int = roomEntity.MaxChip;
			var status:String = roomEntity.Status;
			var noLimit:Boolean = roomEntity.NoLimit;
			
			m_mLobby_Cash.addItem(room.id, room.name, displayName, sBlind, bBlind, pCount, mPlayer, min, max, status, noLimit);
		}
		
		private function onRoomRemoved(event:Event):void{
			var removeEvt: RoomRemoveEvent = event as RoomRemoveEvent;
			var room:Room = removeEvt.RoomInfo;
			m_mLobby_Cash.removeItem(room.name);
		}
		
		/*************** END HANDLE EVENT LISTENER ******************/
		
		/*************** HANDLE GUI EVENT ******************/
		public function handleBtnJoin(event:Event):void{
			// join selected table
			joinSelectedTable();
		}
		
		public function handleList_doubleClick(event:Event):void{
			joinSelectedTable();
		}
		
		//khoatd edited
		/*public function handleLobbyCash_enterState(event:Event):void{
			var listRoom:Array = m_server.getRoomList();
			m_mLobby_Cash.clearItem();
			for each(var room:Room in listRoom){
				var status:String = room.getVariable(RoomVarParams.STATUS).getStringValue();				
				var id:int = room.id;
				var name:String = room.name;
				var sBlind:Number = room.getVariable(RoomVarParams.SMALL_BLIND).getDoubleValue();
				var bBlind:Number = room.getVariable(RoomVarParams.BIG_BLIND).getDoubleValue();
				var pCount:int = room.userCount;
				var mPlayer:int = room.maxUsers;
				var min:int = room.getVariable(RoomVarParams.MIN_BUY_IN).getDoubleValue();
				var max:int = room.getVariable(RoomVarParams.MAX_BUY_IN).getDoubleValue();
				var noLimit:Boolean = room.getVariable(RoomVarParams.NO_LIMIT).getBoolValue();
				m_mLobby_Cash.addItem(room.id, room.name, sBlind, bBlind, pCount, mPlayer, min, max, status, noLimit);
			}
		}*/
		public function handleLobbyCash_enterState(event:Event):void{
			var listRoom:Array = m_server.getRoomList();
			m_mLobby_Cash.clearItem();
			for each(var room:Room in listRoom){
				var roomEntity: RoomEntity = RoomEntity.FromRoom(room);
				var id:int = room.id;
				var name:String = room.name;
				var displayName:String = roomEntity.DisplayName;
				var sBlind:Number = roomEntity.BetChip
				var bBlind:Number = roomEntity.BetChip * 2;
				var pCount:int = room.userCount;
				var mPlayer:int = room.maxUsers;
				var min:Number = roomEntity.MinChip;
				var max:Number = roomEntity.MaxChip;
				var status:String = roomEntity.Status;
				var noLimit:Boolean = roomEntity.NoLimit;
				m_mLobby_Cash.addItem(room.id, room.name, displayName, sBlind, bBlind, pCount, mPlayer, min, max, status, noLimit);
			}
		}
		/*************** END HANDLE GUI EVENT ******************/
		
		//khoatd edited
		/*private function joinSelectedTable():void{
			var tableId:int = m_mLobby_Cash.getSelectedTableId();
			if(tableId == -1){
				return;
			}
			var item:Object = m_mLobby_Cash.oSelectedItem;
			if(item.status == "Closed"){
				var box:C_MessageBox = new C_MessageBox;
				box.showMessageBox("This room is closed!");
				return;
			}
			m_mJoinTable.setTableInfo(tableId, item.tableName,  
				item.smallBlind, item.bigBlind, item.minBuyIn,
				item.maxBuyIn, item.playerCount, item.numPlayer, item.noLimit);			
			m_server.sendRequest(new JoinRoomRequest(m_mJoinTable.tableId));
		}*/
		private function joinSelectedTable():void{
			var tableId:int = m_mLobby_Cash.getSelectedTableId();
			if(tableId == -1){
				handleQuickJoinRoom();
				//return;
			}else{
				var item:Object = m_mLobby_Cash.oSelectedItem;
				var box:C_MessageBox = new C_MessageBox;
				if(item.status == "Closed"){
					box.showMessageBox("This room is closed!");
					return;
				}
				
				var userChip: Number = GameVariable.GetInstance().UserInfo.Chip;
				if(item.minBuyIn > userChip){
					box.showMessageBox("You're chip: " + userChip + ". Not enough chip to play this room!");
					return;
				}

				
				m_server.sendRequest(new JoinRoomRequest(tableId));
			}
		}
		//***************************** Handle Quick Join Room *******************************************************
		public function handleQuickJoinRoom():void{		
			//if(m_listAllRoom.length > 0){
			var userChip: Number = GameVariable.GetInstance().UserInfo.Chip;
			var exp:MatchExpression = new MatchExpression(RoomVariableDetail.MAX_CHIP,NumberMatch.GREATER_THAN_OR_EQUAL_TO, userChip)
				.and(RoomVariableDetail.MIN_CHIP,NumberMatch.LESS_THAN_OR_EQUAL_TO, userChip)
				.and(RoomVariableDetail.PASSWORD,StringMatch.EQUALS,"");		
			m_server.sendRequest(new QuickJoinGameRequest(exp, ["game_poker"]));
			//}
		}
		
	}
}