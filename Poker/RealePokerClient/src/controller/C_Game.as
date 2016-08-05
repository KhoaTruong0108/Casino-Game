package controller
{
	import Configuration.config;
	
	import Enum.PokerActionType;
	import Enum.PokerGameTurn;
	
	import Message.event.RoomRemoveEvent;
	import Message.event.UserCountChangeEvent;
	import Message.event.UserExitRoomEvent;
	import Message.event.UserVariableUpdateEvent;
	import Message.event.game.pokertexas.*;
	import Message.event.game.pokertexas.POKER_RESPONSE_NAME;
	import Message.request.LeaveRoomRequest;
	import Message.request.LogoutRequest;
	import Message.request.game.pokertexas.ConfirmReadyGameRequest;
	import Message.request.game.pokertexas.SitOutRequest;
	import Message.request.game.pokertexas.StandUpRequest;
	
	import com.greensock.TweenMax;
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.entities.variables.UserVariable;
	
	import components._comp_comCard;
	
	import entity.LevelDetailEntity;
	import entity.UserEntity;
	import entity.game_Entity.Desk;
	import entity.game_Entity.Poker.PokerHandType;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.globalization.DateTimeFormatter;
	import flash.utils.Timer;
	
	import flashx.textLayout.elements.TabElement;
	import flashx.textLayout.events.UpdateCompleteEvent;
	
	import model.M_BetBoard;
	import model.M_Cashier;
	import model.M_Game;
	import model.M_Login;
	
	import mx.collections.ArrayList;
	import mx.events.Request;
	
	import params.RequestParams;
	import params.ResponseParams;
	import params.RoomVarParams;
	import params.UserInfoParams;
	
	import spark.components.Label;
	
	import zUtilities.*;

	public class C_Game
	{
		private var m_mGame:M_Game = M_Game.getInstance();
		private var m_server:ServerController = ServerController.getInstance();
		private var m_cMain:MainController = MainController.getInstance();
		private var m_mBetBoard:M_BetBoard = M_BetBoard.getInstance();
		private var m_mCashier: M_Cashier = M_Cashier.getInstance();
		
		private var m_cChat: C_ChatBox = C_ChatBox.getInstance();
		
		private var m_cBetBoard:C_BetBoard = new C_BetBoard();
		
		
		private var m_cJoinTable:C_JoinTable = new C_JoinTable();
		
		private var m_cMessageBox:C_MessageBox = new C_MessageBox();
		
		private var m_logger: Logger = new Logger();
		
		public function C_Game(){
			
			m_server.addEventListener(SFSEvent.USER_EXIT_ROOM, onUserLeaveGame);
			m_server.addEventListener(SFSEvent.ROOM_REMOVE, onRoomRemove);
			m_server.addEventListener(SFSEvent.USER_COUNT_CHANGE, onUserCountChange);
			
			m_server.addEventListener(POKER_RESPONSE_NAME.KICK_USER_RES, onKickOut);
			m_server.addEventListener(POKER_RESPONSE_NAME.STAND_UP_RES, onUserStandUp);
			m_server.addEventListener(POKER_RESPONSE_NAME.USER_SIT_ON_RES, onUserSitDown);
			m_server.addEventListener(POKER_RESPONSE_NAME.USER_SIT_OUT_RES, onUserSitOut);
			m_server.addEventListener(POKER_RESPONSE_NAME.LOAD_TABLE_INFO_RES, onLoadTableInfo);
			m_server.addEventListener(POKER_RESPONSE_NAME.PRE_START, onPrestartGame);
			m_server.addEventListener(POKER_RESPONSE_NAME.START, onStartGame);
			m_server.addEventListener(POKER_RESPONSE_NAME.USER_CALL_RES, onUserCall);
			m_server.addEventListener(POKER_RESPONSE_NAME.USER_RAISE_RES, onUserRaise);
			m_server.addEventListener(POKER_RESPONSE_NAME.USER_FOLD_RES, onUserfold);
			m_server.addEventListener(POKER_RESPONSE_NAME.USER_GOING_ALL_RES, onUserAllIn);
			m_server.addEventListener(POKER_RESPONSE_NAME.GAME_TURN_RES, onGameTurn);
			m_server.addEventListener(POKER_RESPONSE_NAME.USER_TURN_RES, onUserTurn);
			m_server.addEventListener(POKER_RESPONSE_NAME.SHOW_DOWN_RES, onShowDown);
			m_server.addEventListener(POKER_RESPONSE_NAME.FINISH_GAME_RES, onFinishGame);
			m_server.addEventListener(POKER_RESPONSE_NAME.LEVEL_TURN_RES, onLevelTurn);
			m_server.addEventListener(POKER_RESPONSE_NAME.PAY_ANTE_RES, onPayAnte);
		}
		
		
		/******************* HANDLE EVENT LISTENER *****************/
		private function onRoomRemove(event:Event):void{
			try{
				var evt: RoomRemoveEvent = event as RoomRemoveEvent;
				if(GameVariable.GetInstance().CurrentRoom != null &&
					GameVariable.GetInstance().CurrentRoom.name == evt.RoomInfo.name){
					
					processMainUserExitRoom();
				}
				
			}catch(err:Error){
				m_logger.LogError(err);
			}
		}
		private function onUserLeaveGame(event:Event):void{
			try{
				var exitEvt: UserExitRoomEvent = event as UserExitRoomEvent;
				var userName:String = exitEvt.UserInfo.name;
				m_logger.Log("enter onUserLeaveGame " + userName);
				if(GameVariable.GetInstance().CurrentRoom != null &&
					GameVariable.GetInstance().CurrentRoom.name == exitEvt.RoomInfo.name){
					
					m_mGame.removeUser(userName);				
					m_mGame.setUserSitOut(userName, false);
					if(userName == GameVariable.GetInstance().UserInfo.UserName){	
						processMainUserExitRoom();
					}else{
						m_cChat.logGameAction(userName + " left the table");
					}
				}
				
				m_mGame.updateSitVisibled();
				
				hideLevelTimer();
			}catch(err:Error){
				m_logger.LogError(err);
			}
		}
		
		private function processMainUserExitRoom():void{
			if(GameVariable.GetInstance().IsRegisTour == false){
				//var myBuyIn: Number = GameVariable.GetInstance().UserInfo.GameChip;
				var myBuyIn: Number = GameVariable.GetInstance().UserInfo.BuyIn;
				if(myBuyIn > 0){
					GameVariable.GetInstance().UserInfo.Chip += myBuyIn;
					//GameVariable.GetInstance().UserInfo.GameChip = 0;
					GameVariable.GetInstance().UserInfo.BuyIn = 0;
					
					m_mCashier.updateUseInfo();
				}
			}
			
			GameVariable.GetInstance().myPos = -1;
			GameVariable.GetInstance().CurrentRoom = null;
			m_mBetBoard.isVisibled = false;
			
			//m_mGame.stopAllTimer();
			m_mGame.isPlaying = false;
			m_mGame.isReady = true;		
			
			m_mGame.isCanSitOut = false;
			m_mGame.isSittingOut = false;
			m_mGame.isCanAutoFold = false;
			m_mGame.isAutoFold = false;
			
			m_cChat.clearAll();
			
			m_cMain.gotoState_Lobby_Cash();
		}
		
		//isFirstOne param indicate this user bet is a first one -> "raise" btn -> "bet" btn
		private function processBet(userName:String, betAmount:Number, isFirstOne: Boolean):void{
			m_logger.Log("processBet for user: " + userName + " Amount: " + betAmount);
			if(betAmount > 0.0){
				var betA:String = NumberFormat.getShortDecimal(betAmount);
				if(betA.length > 8){
					m_cMain.vMain.m_btnCheck.setStyle("fontSize", 11);
				}
				else{
					m_cMain.vMain.m_btnCheck.setStyle("fontSize", 13);
				}
				m_cMain.vMain.m_btnCheck.label = "CALL(" + betA + ")";				
			}
			else{
				m_cMain.vMain.m_btnCheck.label = "CHECK";
			}
			/*if(betAmount < GameVariable.GetInstance().UserInfo.GameChip){
				m_mBetBoard.maximum = GameVariable.GetInstance().UserInfo.BuyIn;
				m_mBetBoard.minnimum = betAmount;
			}*/
			m_mBetBoard.maximum = GameVariable.GetInstance().UserInfo.BuyIn;
			if(betAmount < GameVariable.GetInstance().UserInfo.BuyIn){
				m_mBetBoard.minnimum = betAmount;
			}
			else{
				m_mBetBoard.minnimum = GameVariable.GetInstance().UserInfo.BuyIn - 1;
			}
			m_mBetBoard.strRaiseValue = m_mBetBoard.minnimum.toString();
			m_mBetBoard.iRaiseValue = m_mBetBoard.minnimum;
			m_logger.Log("-- maximun: " + m_mBetBoard.maximum + ", minnimum" + m_mBetBoard.minnimum +
			", iRaiseValue: " + m_mBetBoard.iRaiseValue);
			
			m_mGame.stopAllTimer();
			m_mGame.startTimer(userName);
			
			if(userName == GameVariable.GetInstance().UserInfo.UserName){
				m_logger.Log("show bet board");
				m_mBetBoard.isVisibled = true;
				m_cBetBoard.showBetBoard();
				
				if(isFirstOne){
					m_mBetBoard.setRaiseToBeBet();
				}else{
					m_mBetBoard.setRaiseToBeRaise();
				}
				
				if(m_mGame.isAutoFold){
					m_cBetBoard.handleFoldRequest();
					m_cBetBoard.hideBetBoard();
				}
			}
		}
		
		//khoatd edited
		/*private function onResUserBet(event:SFSEvent):void{
			// param:
			//		ResponseParams.BET_AMOUNT	: Number
			//		UserInfoParams.USER_NAME	: String
			//		ResponseParams.BET_TYPE		: String
			try{
				var param:ISFSObject = event.params as ISFSObject;
				var betAmount:Number = param.getDouble(ResponseParams.BET_AMOUNT);
				var userName:String = param.getUtfString(UserInfoParams.USER_NAME);
				var betType:String = param.getUtfString(ResponseParams.BET_TYPE);				
				m_mGame.userBet(userName, betAmount, betType);
				m_mBetBoard.isVisibled = false;
				m_mGame.stopAllTimer();
				m_mGame.setFSH(userName, betType);
			}catch(err:Error){
				throw err;
			}
		}*/
		//khoatd edited base on onResUserBet
		private function processUserBet(userName:String, betAmount:Number, betType:String):void{
			try{
				m_mGame.userBet(userName, betAmount, betType);
				m_mBetBoard.isVisibled = false;
				m_mGame.stopAllTimer();
				m_mGame.setFSH(userName, betType);
				
				if(betAmount > 0){
					m_mGame.BettingChip = betAmount;
				}
				
				//play sound;
				if(betType == PokerActionType.FOLD){
					SoundController.playSound("user_fold");
				}else{
					SoundController.playSound("user_bet");
					if(betAmount > 0){
						SoundController.playSound("throw_chip");
					}
				}
			}catch(err:Error){
				m_logger.LogError(err);
			}
		}
		
		private function onUserCall(event:Event):void{
			try{
				var callEvt: Notify_UserCall = event as Notify_UserCall;
				
				var actionType:String;
				if(callEvt.Chip > 0){
					actionType = ResponseParams.USER_CALL;
					m_cChat.logGameAction(callEvt.UserName + " called ");
				}else{
					actionType = ResponseParams.USER_CHECK;
					m_cChat.logGameAction(callEvt.UserName + " checked ");
				}
				processUserBet(callEvt.UserName, callEvt.Chip, actionType);

			}catch(err:Error){
				m_logger.LogError(err);
			}
		}
		private function onUserRaise(event:Event):void{
			try{
				var evt: Notify_UserRaise = event as Notify_UserRaise;
				
				var actionType: String = "";
				if(m_mGame.BettingChip > 0){
					actionType = ResponseParams.USER_RAISE;
					m_cChat.logGameAction(evt.UserName + " raised ");
				}else{
					actionType = ResponseParams.USER_BET;
					m_cChat.logGameAction(evt.UserName + " betted ");
				}
				processUserBet(evt.UserName, evt.Chip, actionType);
				
			}catch(err:Error){
				m_logger.LogError(err);
			}
		}
		private function onUserAllIn(event:Event):void
		{
			try{
				var evt: Notify_UserGoingAllIn = event as Notify_UserGoingAllIn;
				
				processUserBet(evt.UserName, evt.Chip, ResponseParams.USER_ALL_IN);
				
				if(evt.UserName == GameVariable.GetInstance().UserInfo.UserName
					&& !isPlayingSitnGo){
					
					m_mGame.isCanSitOut = true;
				}
				
				m_cChat.logGameAction(evt.UserName + " is all in");
			}catch(err:Error){
				m_logger.LogError(err);
			}
		}
		
		private function onUserfold(event:Event):void
		{
			try{
				var evt: Notify_UserFold = event as Notify_UserFold;
				
				processUserBet(evt.UserName, 0, ResponseParams.USER_FOLD);
				
				if(evt.UserName == GameVariable.GetInstance().UserInfo.UserName
					&& !isPlayingSitnGo){
					m_mGame.isCanSitOut = true;
				}
				
				m_cChat.logGameAction(evt.UserName + " folded");
			}catch(err:Error){
				m_logger.LogError(err);
			}
		}		
		
		//khoatd edited base on onResDealCard
		private function dealCard(type:int, card1:int, card2:int, card3:int, card4:int, card5:int):void{
			try{
				// 2 private card
				if(type == 2){					
					var p_card2:int = card2;
					m_mGame.dealCard(GameVariable.GetInstance().UserInfo.UserName, card1, p_card2);
				}
					
					// 3 com card
				else if(type == 3){
					m_mGame.set3ComCard(card1.toString(), card2.toString(), card3.toString());
				}
					
					// com card 4th
				else if(type == 4){
					m_mGame.setComCard4th(card4.toString());
				}
					
					// com card 5th
				else if(type == 5){
					m_mGame.setComCard5th(card5.toString());
				}
				
				//5 com card
				else if(type == 6){
					m_mGame.set5ComCard(card1.toString(),card2.toString(),card3.toString(),card4.toString(),card5.toString());
				}
					//2 last com card
				else if(type == 7){
					m_mGame.set2LastComCard(card4.toString(),card5.toString());
				}	
			}catch(err:Error){
				m_logger.LogError(err);
			}
		}
		
		//khoatd edited base on onResGameResult
		private function onFinishGame(event:Event):void{
			try{
				m_mGame.isPlaying = false;
				if(isPlayingSitnGo) m_mGame.isCanSitOut = false;
				else m_mGame.isCanSitOut = true;
				
				var evt: Notify_FinishGame = event as Notify_FinishGame;
				
				var strPlayerName : String = M_Login.getInstance().UserName;
				var i:int;
				for(i = 0; i < evt.ListUser.length; i++){
					var userName:String = evt.ListUser.getItemAt(i).toString();
					
					if(evt.ListPokerHand.length > i){
						var pokerHandType:String = evt.ListPokerHand.getItemAt(i).toString();
						if(Boolean(pokerHandType) == true){
							m_mGame.setPokerHandType(userName, pokerHandType);
						}
					}else{
						m_logger.Log("ERROR: onFinishGame:: list users is much than list poker hand");
					}
					
					//show chip effect
					m_cMain.vMain.m_mChipContainer.removeAllElements();					
					var amount:Number = parseFloat(evt.ListChip.getItemAt(i).toString());
					m_mGame.setIncreaseChipForUser(userName, amount);
					
					var isWinner:Boolean = isWinner(evt.ListWinner, userName);
					if(isWinner == true){	
						m_mGame.setResult(userName, "win");
						
						//log game action.
						logGameResult(userName, pokerHandType, evt.ListPokerHandCard, amount);
					}
					else{
						m_mGame.setResult(userName, "lose");
						
						if(userName == GameVariable.GetInstance().UserInfo.UserName){
							SoundController.playSound("user_loose");
						}
					}
					
					if(userName == GameVariable.GetInstance().UserInfo.UserName 
						&& amount > 0){
						GameVariable.GetInstance().UserInfo.BuyIn += amount;
					}
					
					
					if(GameVariable.GetInstance().myPos != -1){
						m_mGame.isReady = false;
					}
					m_mBetBoard.isVisibled = false;
					m_mBetBoard.resetAll();
						
					m_mGame.stopAllTimer();	
				}
				
			}catch(err:Error){
				m_logger.LogError(err);
			}
		}
		
		private function logGameResult(userName: String, pokerHand: String, listWinCard: ArrayList, winChip: Number):void{
			var log: String = userName + " won the pot with ";
			log += getLogWinCard(pokerHand, listWinCard);
			log += " and " + winChip +" chips";
			
			m_cChat.logGameAction(log);
		}
		
		private function getLogWinCard(pokerHand: String, listWinCard: ArrayList):String{
			var log: String = "";
			if(pokerHand == PokerHandType.FOUR_OF_KIND){
				log = "four of kind of " + getCardNameById(parseInt(listWinCard.getItemAt(0).toString()));
			}else if(pokerHand == PokerHandType.THREE_OF_KIND){
				log = "three of kind of " + getCardNameById(parseInt(listWinCard.getItemAt(0).toString()));
			}else if(pokerHand == PokerHandType.PAIR){
				log = "pair of " + getCardNameById(parseInt(listWinCard.getItemAt(0).toString()));
			}else if(pokerHand == PokerHandType.TWO_PAIRS){
				var card1: int = parseInt(listWinCard.getItemAt(0).toString());
				var card2: int = getCardKhongDongChat(card1, listWinCard);
				log = "two pair of " + getCardNameById(card1) + "," + getCardNameById(card2); 
			}else if(pokerHand == PokerHandType.FULL_HOUSE){
				var card1: int = parseInt(listWinCard.getItemAt(0).toString());
				var card2: int = getCardKhongDongChat(card1, listWinCard);
				log = "full house of " + getCardNameById(card1) + "," + getCardNameById(card2); 
			}else if(pokerHand == PokerHandType.ROYAL_FLUSH){
				log = "royal flush of " + getLogListCard(listWinCard);
			}else if(pokerHand == PokerHandType.STRAIGHT_FLUSH){
				log = "straight flush of " + getLogListCard(listWinCard);
			}else if(pokerHand == PokerHandType.STRAIGHT){
				log = "straight of " + getLogListCard(listWinCard);
			}else if(pokerHand == PokerHandType.FLUSH){
				log = " flush of " + getLogListCard(listWinCard);
			}else if(pokerHand == PokerHandType.HIGH_CARD){
				log = "high card of " + getCardNameById(parseInt(listWinCard.getItemAt(0).toString()));
			}
			return log;
		}
		private function getCardKhongDongChat(card1:int, listWinCard: ArrayList):int{
			for(var i: int = 0; i< listWinCard.length; i++){
				var card2: int = parseInt(listWinCard.getItemAt(i).toString());
				if(Math.abs(card1 - card2) >= 10){
					return card2;
				}
			}
			return -1;
		}
		private function getLogListCard(listWinCard: ArrayList):String{
			var str: String = "";
			if(listWinCard.length > 0){
				str = getCardNameById(parseInt(listWinCard.getItemAt(0).toString()));
				for(var i: int = 1; i< listWinCard.length; i++){
					var card: String = getCardNameById(parseInt(listWinCard.getItemAt(i).toString()));
					str += "," + card;
				}
			}
			return str;
		}
		private function getCardNameById(cardID: int):String{
			if(cardID > 130 && cardID < 135){
				return "K";
			}else if(cardID > 120 && cardID < 125){
				return "Q";
			}else if(cardID > 110 && cardID < 115){
				return "J";
			}else if((cardID > 10 && cardID < 15)||(cardID > 135)){
				return "A";
			}else if(cardID != -1){
				var i:int = (cardID / 10);
				return i.toString();
			}
			return "";
		}
		
		private function isWinner(listWinner: ArrayList, userName: String): Boolean{
			for(var i:int = 0; i < listWinner.length; i++){
				if(userName == listWinner.getItemAt(i).toString()){
					return true;
				}
			}
			return false;
		}
		
		private function onShowDown(event:Event):void{
			try{
				var evt: Notify_ShowDown = event as Notify_ShowDown;
				
				var comCard1: int;
				var comCard2: int;
				var comCard3: int;
				var comCard4: int;
				var comCard5: int;
				if(evt.CurrentGameTurn == PokerGameTurn.BETTING){
					comCard1 = parseInt(evt.ListComCard.getItemAt(0).toString());
					comCard2 = parseInt(evt.ListComCard.getItemAt(1).toString());
					comCard3 = parseInt(evt.ListComCard.getItemAt(2).toString());
					//dealCard(3, comCard1, comCard2, comCard3);
					comCard4 = parseInt(evt.ListComCard.getItemAt(3).toString());
					//dealCard(4, comCard4, -1, -1);
					
					comCard5 = parseInt(evt.ListComCard.getItemAt(4).toString());
					//dealCard(5, comCard5, -1, -1);
					
					dealCard(6, comCard1, comCard2, comCard3, comCard4, comCard5);
					
				} else if(evt.CurrentGameTurn == PokerGameTurn.FLOP){
					comCard4 = parseInt(evt.ListComCard.getItemAt(3).toString());
					//dealCard(4, comCard4, -1, -1);
					
					comCard5 = parseInt(evt.ListComCard.getItemAt(4).toString());
					//dealCard(5, comCard5, -1, -1);
					
					dealCard(7, -1, -1, -1, comCard4, comCard5);
				} else if(evt.CurrentGameTurn == PokerGameTurn.TURN){
					comCard5 = parseInt(evt.ListComCard.getItemAt(4).toString());
					dealCard(5, -1, -1, -1, -1, comCard5);
				}
					
				
				
				for(var i:int = 0; i < evt.ListUser.length; i++){
					var userName:String = evt.ListUser.getItemAt(i).toString();
					var userCards: ArrayList = evt.ListCard.getItemAt(i) as ArrayList;
					if(userName != GameVariable.GetInstance().UserInfo.UserName){
						var card1:int = parseInt(userCards.getItemAt(0).toString());
						var card2:int = parseInt(userCards.getItemAt(1).toString());
						
						m_mGame.setUserOpenCard(userName, card1, card2);
					}
					//m_cMain.vMain.m_mChipContainer.removeAllElements();					
				}
			}catch(err:Error){
				m_logger.LogError(err);
			}
		}
		private function onUserSitDown(event:Event):void{
			// param: 
			// 		UserInfoParams.USER_NAME	: String
			// 		ResponseParams.SIT_POS		: int
			try{
				var userSitEvt: Notify_UserSitOn = event as Notify_UserSitOn;
				var userName:String = userSitEvt.UserName;
				m_logger.Log("enter onUserSitDown: " + userName);
				var sitPos:int = userSitEvt.DeskId;				
				var fish:Number = userSitEvt.UserChip;
				var buyIn:Number = userSitEvt.BuyIn;
				
				var userEntity: UserEntity = UserEntity.FromUser(m_server.getUserByName(userName));
				var avatar = userEntity.Avatar;
				m_mGame.addUser(userName, sitPos, buyIn, avatar);
				m_mGame.updateSitVisibled();
				
				//log game action.
				m_cChat.logGameAction(userName + " joines the table");
			}catch(err:Error){
				m_logger.LogError(err);
			}
		}
		
		private function onUserSitOut(event:Event):void
		{
			try{
				var evt: Notify_UserSitOut = event as Notify_UserSitOut;
				
				m_mGame.setUserSitOut(evt.UserName, evt.isSitOut);
				
				//update sitout checkbox if user is sitted out from server.
				if(evt.UserName == GameVariable.GetInstance().UserInfo.UserName
					&& m_mGame.isSittingOut != evt.isSitOut){
					m_mGame.isSittingOut = evt.isSitOut;
				}
			}catch(err:Error){
				m_logger.LogError(err);
			}
		}		
		
		
		
		private function onUserStandUp(event: Event):void{
			try{
				var evt: Notify_StandUp = event as Notify_StandUp;
				var userName:String = evt.UserName;
					
				m_mGame.removeUser(userName);				
				m_mGame.setUserSitOut(userName, false);
				if(userName == GameVariable.GetInstance().UserInfo.UserName){	
					
					if(GameVariable.GetInstance().IsRegisTour == false){
						//var myBuyIn: Number = GameVariable.GetInstance().UserInfo.GameChip;
						var myBuyIn: Number = GameVariable.GetInstance().UserInfo.BuyIn;
						GameVariable.GetInstance().UserInfo.Chip += myBuyIn;
						//GameVariable.GetInstance().UserInfo.GameChip = 0;
						GameVariable.GetInstance().UserInfo.BuyIn = 0;
						
						m_mCashier.updateUseInfo();
					}
					GameVariable.GetInstance().myPos = -1;
					m_mBetBoard.isVisibled = false;
					//m_cBetBoard.hideBetBoard();
					m_mGame.isPlaying = false;
					m_mGame.isReady = true;		
					
					//m_mGame.isCanSitOut = false;
					m_mGame.isCanSitOut = false;
					m_mGame.isSittingOut = false;
					m_mGame.isCanAutoFold = false;
					m_mGame.isAutoFold = false;
					
				}else{
					m_cChat.logGameAction(userName + " left game");
				}
				m_mGame.updateSitVisibled();
			}catch(err:Error){
				m_logger.LogError(err);
			}
		}
		
		private function onAskForBuyChip(event:Event):void{
			try{
				m_cJoinTable.showJoinTableBox();
			}catch(err:Error){
				m_logger.LogError(err);
			}
		}
		
		//create base on C_Game.onResTableInfo
		private function onLoadTableInfo(event:Event):void{
			m_logger.Log("enter onLoadTableInfo");
			var sitEvt: LoadTableInfoRes = event as LoadTableInfoRes;
			//Clear Game Table
			m_mGame.ClearTableView();
			/*m_mBetBoard.isVisibled = false;*/
			
			var isPlaying:Boolean = sitEvt.IsGameStart;
			m_mGame.isPlaying = isPlaying;
				
			//add user
			for(var i:int = 0; i < sitEvt.ListUser.length; i++){
				try{
					var desk: Desk = sitEvt.ListDesk.getItemAt(i) as Desk;
					var userName:String = sitEvt.ListUser.getItemAt(i).toString();
					var sitPos:int = desk.DeskId;						
					var buyIn:Number = desk.UserChip;
					var userEntity: UserEntity = UserEntity.FromUser(m_server.getUserByName(userName));
					var avatar = userEntity.Avatar;
					
					m_mGame.addUser(userName, sitPos, buyIn, avatar);
					
					if(isPlaying == true){
						var bet:Number = parseFloat(sitEvt.ListBetChip.getItemAt(i).toString());
						m_mGame.incUserRaise(userName, bet);
					}
					
					if(userName == GameVariable.GetInstance().UserInfo.UserName){
						//GameVariable.GetInstance().UserInfo.GameChip = buyIn;
						GameVariable.GetInstance().UserInfo.BuyIn = buyIn;
						if(GameVariable.GetInstance().IsRegisTour == false){
							GameVariable.GetInstance().UserInfo.Chip -= buyIn;
						}
						
						processMainUserSitOn(userName, sitPos, buyIn);
						m_mGame.isSitting = true;
					}
				} catch(err:Error){
					m_logger.LogError(err);
				}
			}
			
			for (var j:int = 0; j < sitEvt.listUserSitOut.length; j++) {
				m_mGame.setUserSitOut(sitEvt.listUserSitOut.getItemAt(j).toString(), true);
			}
			
			
			//show prestart timer
			if(sitEvt.IsPrestart){
				var seconds: int = sitEvt.PrestartTime/1000;
				showTimerRestart(seconds);
			}
			
			if(isPlaying){
				for(i = 0; i < sitEvt.ListUserPlaying.length; i++){
					userName = sitEvt.ListUserPlaying.getItemAt(i).toString();
					if(userName != GameVariable.GetInstance().UserInfo.UserName){
						m_mGame.setUserCloseCard(userName);
					}
				}
				
				var nComCard:int = sitEvt.ListCommunityCard.length;
				
				if(nComCard >= 3){
					var card1:int = parseInt(sitEvt.ListCommunityCard.getItemAt(0).toString());
					var card2:int = parseInt(sitEvt.ListCommunityCard.getItemAt(1).toString());
					var card3:int = parseInt(sitEvt.ListCommunityCard.getItemAt(2).toString());
					m_mGame.set3ComCard(card1.toString(), card2.toString(), card3.toString());
				}
				
				if(nComCard >= 4){
					var card4:int = parseInt(sitEvt.ListCommunityCard.getItemAt(3).toString());
					m_mGame.setComCard4th(card4.toString());
				}
				
				if(nComCard >= 5){
					var card5:int = parseInt(sitEvt.ListCommunityCard.getItemAt(4).toString());
					m_mGame.setComCard5th(card5.toString());
				}
				
				//deal hidden card for other user.
				//dealCard(2, -1, -1, -1);
				
				//set pot for game
				m_mGame.setcPot(sitEvt.PotChip);
				
				var dName:String = sitEvt.Dealer;
				var sbName:String = sitEvt.SmallBlind;
				var bbName:String = sitEvt.BigBlind;
				
				if(dName != "")
					m_mGame.setDealer(dName);
				if(sbName != "")
					m_mGame.setSmallBlind(sbName);		
				if(bbName != "")
					m_mGame.setBigBlind(bbName);
			}
		}
		protected function processMainUserSitOn(userName:String, sitPos:int, fish:Number): void{
			try{
				GameVariable.GetInstance().myPos = sitPos;
				m_mGame.isReady = false;
				m_mGame.isCanAutoFold = true;
				m_mGame.isAutoFold = false;
				m_mGame.updateSitVisibled();
				
				if(isPlayingSitnGo()) m_mGame.isCanSitOut = false;
				else m_mGame.isCanSitOut = true;
				
			}catch(err:Error){
				m_logger.LogError(err);
			}
		}
		
		private function onUserReady(event:Event):void{
			try
			{
				var evt: Notify_UserReady = event as Notify_UserReady;
				var userName:String = evt.UserName;
				m_mGame.setUserReady(userName, "tickReady");
			} 
			catch(err:Error){
				m_logger.LogError(err);
			}
		}
			
		//khoatd edited
		/*private function onUserCountChange(event:Event):void{
			try
			{
				var room:Room = event.params.room as Room;
				if(m_globalVar.curTable.name == room.name){
//					m_mGame.refreshNumPlayer();
					m_mGame.strNumPlayer = room.userCount.toString();
					
				}				
			} 
			catch(error:Error){}
		}*/
		private function onUserCountChange(event:Event):void{
			try
			{
				var evt: UserCountChangeEvent = event as UserCountChangeEvent;
				var room:Room = evt.RoomInfo;
				if(GameVariable.GetInstance().CurrentRoom != null 
					&& GameVariable.GetInstance().CurrentRoom.name == room.name){
					
					m_mGame.strNumPlayer = room.userCount.toString();
				}				
			} 
			catch(err:Error){
				m_logger.LogError(err);
			}
		}
		
		private function onUserKicked(event:Event):void{
			var evt: Notify_KickUser = event as Notify_KickUser;
			
			//user is kicked out when lose all chip in tournament.
			if(GameVariable.GetInstance().IsRegisTour == true
				&& GameVariable.GetInstance().TourName != ""){
				
				GameVariable.GetInstance().IsRegisTour = false;
				GameVariable.GetInstance().TourName = "";
			}
			
			//m_cMessageBox.showMessageBox(reason);
			m_cJoinTable.leaveCurrentGame();
		}
		
		private function onPrestartGame(event:Event):void{
			var evt: Notify_PreStart = event as Notify_PreStart;
			var second:int = evt.Time / 1000;
			
			m_mGame.resetData();
			
			// remove second = 0 if show count down
			//second = 0;	
			if(evt.IsPrestart){
				if(second > 0){
					showTimerRestart(second);				
				} else{
					var lb:Label = new Label();
					lb.setStyle("fontSize","20");
					lb.setStyle("fontColor","#ef0f0f");
					lb.text = "Please wait for another player!";
					m_cMain.vMain.m_mChipContainer.removeAllElements();
					m_cMain.vMain.m_mChipContainer.addElement(lb);
				}
			}
			
			
			//send sit out request to server to avoid user be time out.
			if(m_mGame.isSittingOut == true){
				var req: SitOutRequest = new SitOutRequest();
				req.AddParam(SitOutRequest.IS_SIT_OUT, true);
				m_server.SendCustomRequest(req);
			}
		}
		
		private function onStartGame(event:Event):void{
			try{
				m_logger.Log("onStartGame");
				var evt: Notify_Start = event as Notify_Start;
				var userName: String = evt.CurrentUser;
				
				if(evt.ListCard.length > 0){
					//just user playing have 2 card.
					var userCard1: int = parseInt(evt.ListCard.getItemAt(0).toString());
					var userCard2: int = parseInt(evt.ListCard.getItemAt(1).toString());
					dealCard(2, userCard1, userCard2, -1, -1, -1);
				}else{
					//main user is a spectator or sitting our user.
					for(var i: int = 0; i< evt.ListActiveUserName.length; i++){
						var name: String = evt.ListActiveUserName.getItemAt(i).toString();
						if(name != GameVariable.GetInstance().UserInfo.UserName){
							m_mGame.setUserCloseCard(name);
						}
					}
				}
				
				var dName:String = evt.Dealer;
				var sbName:String = evt.SmallBlind;
				var bbName:String = evt.BigBlind;
				
				m_mGame.setDealer(dName);
				m_mGame.setSmallBlind(sbName);				
				m_mGame.setBigBlind(bbName);
				
				m_mGame.userBet(sbName, evt.BetChipGame, "");
				m_mGame.userBet(bbName, evt.BetChipGame * 2, "");

				var betChip: Number;
				if(userName == sbName){
					betChip = evt.BetChipGame;
				}else{
					betChip = evt.BetChipGame * 2;
				}
				
				m_mGame.BettingChip = betChip;
				
				processBet(userName, betChip, false);
				
				if(m_mGame.isSitting){
					if(m_mGame.isSittingOut){
						m_mGame.isCanSitOut = true;
					}else{
						m_mGame.isCanSitOut = false;
					}
				}
				
				//log game action
				m_cChat.logGameAction(config.CHAT_LOG_START_GAME);
				
				//level section
				if(evt.isTurnNextLevel){
					m_mGame.strSmallBlind = NumberFormat.getDecimalFormat(m_mGame.nextLevel.smallBlind);
					m_mGame.strBigBlind = NumberFormat.getDecimalFormat(m_mGame.nextLevel.bigBlind);
					//show level time.
					showLevelTimer(evt.levelTimeLife);
					//notify turn to next level
					var msg: String = " CURRENT BLIND:  " + m_mGame.nextLevel.smallBlind
						+ " / " + m_mGame.nextLevel.bigBlind;
					m_cMessageBox.showMessageBox(msg, "Turn next level");
				}
			} 
			catch(err: Error){
				m_logger.LogError(err);
			}
		}
		
		private function onGameTurn(evt: Event):void
		{
			try{
				var turnEvt: Notify_GameTurn = evt as Notify_GameTurn;
				
				var comCard1: int = parseInt(turnEvt.ListCommunityCard.getItemAt(0).toString());
				var comCard2: int;
				var comCard3: int;
				if(turnEvt.CurrentGameTurn == PokerGameTurn.FLOP){
					comCard2 = parseInt(turnEvt.ListCommunityCard.getItemAt(1).toString());
					comCard3 = parseInt(turnEvt.ListCommunityCard.getItemAt(2).toString());
					dealCard(3, comCard1, comCard2, comCard3, -1, -1);
				} else if(turnEvt.CurrentGameTurn == PokerGameTurn.TURN){
					dealCard(4, -1, -1, -1, comCard1, -1);
				} else if(turnEvt.CurrentGameTurn == PokerGameTurn.RIVER){
					dealCard(5, -1, -1, -1, -1, comCard1);
				}
				
				m_mGame.BettingChip = 0;
				
				processBet(turnEvt.CurrentUser, 0, true);
				
				//log game action
				m_cChat.logGameAction("The game is being " + turnEvt.CurrentGameTurn);
			}catch(err: Error){
				m_logger.LogError(err);
			}
		}
		
		private function onUserTurn(evt: Event):void
		{
			try{
				var turnEvt: Notify_UserTurn = evt as Notify_UserTurn;
				
				var isFirstOne: Boolean = false;
				if(m_mGame.BettingChip > 0){
					isFirstOne = false;
				}else{
					isFirstOne = true;
				}
				processBet(turnEvt.UserName, turnEvt.BettingChip, isFirstOne);
			}catch(err: Error){
				m_logger.LogError(err);
			}
		}	
		
		private function onPayAnte(evt: Event):void{
			try{
				var turnEvt: Notify_PayAnte = evt as Notify_PayAnte;
				
				var ante: Number = turnEvt.ante;
				for (var i:int = 0; i < turnEvt.listUser.length; i++) {
					var userName: String = turnEvt.listUser.getItemAt(i).toString();
					
					m_mGame.userBet(userName, ante, "");
				}
			}catch(err: Error){
				m_logger.LogError(err);
			}
		}
		
		private function onLevelTurn(evt: Event):void
		{
			try{
				var turnEvt: Notify_LevelTurn = evt as Notify_LevelTurn;
				
				var lvl: LevelDetailEntity = new LevelDetailEntity();
				lvl.ante = turnEvt.ante;
				lvl.bigBlind = turnEvt.bigBlind;
				lvl.level = turnEvt.level;
				lvl.smallBlind = turnEvt.smallBlind;
				lvl.time = turnEvt.Time;
				
				m_mGame.isTurnNextLvl = true;
				m_mGame.nextLevel = lvl;
				
			}catch(err: Error){
				m_logger.LogError(err);
			}
		}		
		
		/******************* END HANDLE EVENT LISTENER *****************/
		
		/***************** HANDLE GUI EVENT *******************/		
		public function handleBtnLeaveGame_click(event:Event):void{
			// leave game
			if(m_mGame.isPlaying == true){
				return;
			}
			standUp();
		}
		
		//khoatd edited
		/*public function standUp():void{
			try{
				var param:ISFSObject = new SFSObject();
				param.putUtfString(RoomVarParams.NAME, m_globalVar.curTable.name);
				m_server.sendRequest(new ExtensionRequest(CustomRequest.USER_STAND_UP, param));
			}catch(err:Error){
				trace(err);
			}
		}*/
		public function standUp():void{
			try{
				var request: StandUpRequest = new StandUpRequest();
				
				m_server.SendCustomRequest(request);
			}catch(err:Error){
				m_logger.LogError(err);
			}
		}
		
		protected function isPlayingSitnGo():Boolean{
			if(GameVariable.GetInstance().CurrentRoom != null){
				if(GameVariable.GetInstance().CurrentRoom.name.search("tour_") == -1){
					return false;
				}else{
					return true;
				}
			}else{
				return false;
			}
		}
		
		public function handleBtnLogout_click(event:Event):void{
			try
			{
				m_server.sendRequest(new LogoutRequest());
			} 
			catch(err:Error) 
			{
				m_logger.LogError(err);
			}
		}
		
		
		public function handleBtnGotoLobby_click(event:Event):void{
			// go to lobby only when no playing
			m_cJoinTable.leaveCurrentGame();
		}
				
		public function handleBtnReady_click(event:Event):void{
			try{
				handleConfirmReady();
				m_mGame.isReady = true;
			}catch(err:Error){
				m_logger.LogError(err);
			}
		}
		public function handleConfirmReady():void{
			try{
				var readyReq: ConfirmReadyGameRequest = new ConfirmReadyGameRequest();
				m_server.SendCustomRequest(readyReq);
			}catch(err: Error){
				m_logger.LogError(err);
			}
		}
		
		
		
		public function handleAutoFold_change(event:Event):void{
			
		}
		
		public function handleSitOut_change(event:Event):void{
			try{
				var req: SitOutRequest = new SitOutRequest();
				req.AddParam(SitOutRequest.IS_SIT_OUT, m_mGame.isSittingOut);
				m_server.SendCustomRequest(req);
			}catch(err: Error){
				m_logger.LogError(err);
			}
		}
		
		
		private function onKickOut(evt: Event):void
		{
			try{
				var kickEvt: Notify_KickUser = evt as Notify_KickUser;
				
				m_cJoinTable.leaveCurrentGame();
			}catch(err: Error){
				m_logger.LogError(err);
			}
		}
		/***************** END HANDLE GUI EVENT *******************/
		private function showLevelTimer(minutes: int):void{
			m_logger.Log("showLevelTimer");
			var second: int = minutes * 60;
			
			var timer:Timer = new Timer(1000, second);
			var lb:Label = new Label();
			lb.setStyle("fontSize","16");
			lb.setStyle("fontColor","#ffffff");
			m_cMain.vMain.m_mTimerContainer2.removeAllElements();
			m_cMain.vMain.m_mTimerContainer2.addElement(lb);
			lb.text = "Level up in: " + caculateTime(second);
			timer.addEventListener(TimerEvent.TIMER, function(event:TimerEvent):void{
				second--;
				lb.text = "Level up in: " + caculateTime(second);
			});
			
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, function(event:TimerEvent):void{
				lb.text = "Level up in next game.";
			});
			timer.start();
		}
		private function hideLevelTimer():void{
			m_cMain.vMain.m_mTimerContainer2.removeAllElements();
		}
		
		private function caculateTime(second: int):String{
			var h: int = second / 3600;
			second = second - (h * 3600);
			var m: int = second / 60;
			second = second - (m * 60);
			var s: int = second;
			
			return h.toString() + ": " + m.toString() + ": " + s.toString();
		}
		
		private function showTimerRestart(second:int):void{
			var timer:Timer = new Timer(1000, second);
			var lb:Label = new Label();
			lb.setStyle("fontSize","20");
			lb.setStyle("fontColor","#ef0f0f");
			m_cMain.vMain.m_mChipContainer.removeAllElements();
			m_cMain.vMain.m_mTimerContainer.removeAllElements();
			m_cMain.vMain.m_mTimerContainer.addElement(lb);
			lb.text = "Game start after " + second + " second(s)!";
			timer.addEventListener(TimerEvent.TIMER, function(event:TimerEvent):void{
				second--;
				lb.text = "Game start after " + second.toString() + " second(s)!";
				if(second < 0){
					m_cMain.vMain.m_mTimerContainer.removeAllElements();
				}
			});
			
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, function(event:TimerEvent):void{
				lb.text = "";
				lb.visible = false;			
				//m_mGame.isCanSitOut = false;
			});
			timer.start();
		}
	}
}