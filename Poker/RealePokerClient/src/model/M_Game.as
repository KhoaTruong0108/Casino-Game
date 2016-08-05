package model
{
	import com.smartfoxserver.v2.entities.Room;
	
	import components._comp_User_Info;
	import components._comp_comCard;
	
	import controller.C_Chip;
	
	import entity.LevelDetailEntity;
	import entity.RoomEntity;
	
	import flash.utils.Dictionary;
	
	import params.ResponseParams;
	import params.RoomVarParams;
	
	import zUtilities.GameVariable;
	import zUtilities.MainController;
	import zUtilities.NumberFormat;

	public class M_Game
	{
		
		private static var m_instance:M_Game = null;
		private static var m_isAllowed:Boolean = false;
		
		private var m_strSmallBlind:String = "";
		private var m_strBigBlind:String = "";
		private var m_strTableName:String = "";
		private var m_strNumPlayer:String = "";
		private var m_strMaxPLayer:String = "";
		
		private var m_countSitOut:int = 0;
		private var m_isCanSitOut:Boolean = true;
		private var m_isCanAutoFold:Boolean = true;
		private var m_isSittingOut:Boolean = false;
		private var m_isAutoFold:Boolean = false;
		[Bindable]
		private var m_isPlaying:Boolean = false;
		
		private var m_isSitting: Boolean = false;
		
		private var m_strPot:String = "";
		private var m_isReady:Boolean = true;
		
		//list component user info.
		private var m_listUserInfo:Array = new Array();
		private var m_cMain:MainController = MainController.getInstance();
		private var m_mapUserPos:Dictionary = new Dictionary();
		private var m_comComCard:_comp_comCard = null;
		
		private var m_mBetBoard:M_BetBoard = M_BetBoard.getInstance();
		
		private var m_cChip:C_Chip = new C_Chip();
		
		private var m_nextLevel: LevelDetailEntity = new LevelDetailEntity();
		private var m_isTurnNextLvl: Boolean;
		private var m_strLevelTimer: String;
		private var m_bettingChip: Number;
		
		public function M_Game(){
			if(m_isAllowed == false){
				throw new Error("Cannot create an instance of a singleton class!");
			}
		}
		
		public static function getInstance():M_Game{
			if(m_instance == null){
				m_isAllowed = true;
				m_instance = new M_Game();
				m_isAllowed = false;
			}
			return m_instance;
		}
		
		public function setGameInfo():void{
			var room:Room = GameVariable.GetInstance().CurrentRoom;
			var roomEntity: RoomEntity = RoomEntity.FromRoom(GameVariable.GetInstance().CurrentRoom);
			if(room == null){
				return;
			}
			strTableName = roomEntity.DisplayName;//room.name;
			strSmallBlind = NumberFormat.getDecimalFormat(roomEntity.BetChip);
			strBigBlind = NumberFormat.getDecimalFormat(roomEntity.BetChip * 2);
			strNumPlayer = room.userCount.toString();
			strMaxPLayer = room.maxUsers.toString();
			isTurnNextLvl = false;
		}
		
		public function refreshNumPlayer():void{
			/*var room:Room = m_globalVar.curTable;
			if(room == null){
				return;
			}
			m_strNumPlayer = room.userCount.toString();*/
		}
		
		public function userBet(userName:String, amount:Number, type:String):void{			
			incUserRaise(userName, amount);
			var strBet:String = getBetText(userName, type, amount);
			incPot(amount);
			descUserFish(userName, amount);
			
			if(userName == GameVariable.GetInstance().UserInfo.UserName){
				//GameVariable.GetInstance().UserInfo.GameChip -= amount;
				GameVariable.GetInstance().UserInfo.BuyIn -= amount;
			}

		}

		public function addUser(userName:String, pos:int, fish:Number, avatar: String):void{
			m_mapUserPos[userName] = pos;
			setUserVisibled(userName, true);			
			setUserInfo(userName, fish, avatar);
			updateSitVisibled();
		}
		
		public function removeUser(userName:String):void{			
			var userCom:_comp_User_Info = getUserCom(userName);
			userCom.setHide();
			m_mapUserPos[userName] = null;
		}
		
		private function getBetText(userName:String, type:String, amount:Number):String{
			if(type == ResponseParams.USER_FOLD){
				return userName + " fold";
			}
			else if(type == ResponseParams.USER_CHECK){
				return userName + " check";
			}
			else if(type == ResponseParams.USER_ALL_IN){
				return userName + " show hand";
			}
			else if(type == ResponseParams.USER_RAISE){
				return userName + " raise " + NumberFormat.getDecimalFormat(amount);
			}
			else if(type == ResponseParams.USER_BET){
				return userName + " bet " + NumberFormat.getDecimalFormat(amount);
			}
			else if(type == ResponseParams.USER_CALL){
				return userName + " call";
			}
			return "";
		}
		
		private function setUserInfo(userName:String, userFish:Number, avatar: String):void{
			var userCom:_comp_User_Info = getUserCom(userName);
			userCom.setUserInfo(userName, userFish, avatar);
		}
		
		public function setUserOpenCard(userName:String, card1:int, card2:int):void{
			var userCom:_comp_User_Info = getUserCom(userName);
			if(userCom.isFold == true){
				return;
			}
			userCom.setUserOpenCard(card1.toString(), card2.toString());			
		}		
		
		public function dealCard(userName:String, card1:int, card2:int):void{
			//Deal Close Card to All user except sitout user
			var delay:Number = 0;			
			for each(var item1:_comp_User_Info in m_listUserInfo){
				
				if(item1.isVisibled == true){
					if(item1.isSitingOut == true){
						continue;
					}
					if(item1.strUserName != userName){
						item1.dealCard("999", delay);
					}
					else{
						
						item1.dealCard(card1.toString(), delay);
					}
					delay += 0.2;
				}				
			}
			for each(var item2:_comp_User_Info in m_listUserInfo){				
				if(item2.isVisibled == true){
					if(item2.isSitingOut == true){
						continue;
					}
					if(item2.strUserName != userName){
						item2.dealCard("999", delay);
					}
					else{
						item2.dealCard(card2.toString(), delay);
					}
					delay += 0.2;
				}				
			}			
		}
		
		public function setUserCloseCard(userName:String):void{
			for each(var item:_comp_User_Info in m_listUserInfo){
				if(item.isVisibled == true && item.strUserName == userName){
					item.setUserCloseCard();
				}
			}
		}
		
		public function clearUserRaise(userName:String):void{
			var userCom:_comp_User_Info = getUserCom(userName);
			userCom.clear();
		}
		
		public function set3ComCard(card1:String, card2:String, card3:String):void{
			m_comComCard.set3ComCard(card1, card2, card3);
		}
		
		public function setComCard4th(card4:String):void{
			m_comComCard.setComCard4th(card4);
		}
		
		public function setComCard5th(card5:String):void{
			m_comComCard.setComCard5th(card5);
		}
		
		public function set5ComCard(card1:String, card2:String, card3:String, card4:String, card5:String):void{
			m_comComCard.set5ComCard(card1, card2, card3, card4, card5);
		}
		public function set2LastComCard(card4:String, card5:String):void{
			m_comComCard.set2LastComCard(card4, card5);
		}
		
		public function setPokerHandType(userName:String, type:String):void{
			var userCom:_comp_User_Info = getUserCom(userName);
			if(userCom.isFold == true){
				return;
			}
			userCom.setPokerHandType(type);
		}

		public function setUserFold(userName:String):void{
			var userCom:_comp_User_Info = getUserCom(userName);
			userCom.setUserFold();
		}
		
		public function resetAllWinnerMoney():void{
			try
			{
				for each (var userCom:_comp_User_Info in m_listUserInfo){
					userCom.resetWinnerMoney();
				}
			} 
			catch(error:Error) 
			{
				
			}

		}

		public function setIncreaseChipForUser(userName:String, amount:Number):void{
			var userCom:_comp_User_Info = getUserCom(userName);
			userCom.setWinnerMoney(amount);
			if(amount > 0){
				userCom.incUserFish(amount);//khoatd
			}
		}
		
		public function setUserFish(userName:String, fish:Number):void{
			try{
				var userCom:_comp_User_Info = getUserCom(userName);
				userCom.setUserFish(fish);
			}
			catch(err:Error){}			
		}
		
		public function setResult(userName:String, result:String):void{
			try
			{
				var userCom:_comp_User_Info = getUserCom(userName);
				userCom.setResult(result);
			} 
			catch(error:Error) 
			{
				trace(error);
			}
		}
		
		public function startTimer(userName:String):void{
			try
			{
				var userCom:_comp_User_Info = getUserCom(userName);
				userCom.startTimer();
			} 
			catch(error:Error) 
			{
				trace(error);
			}
		}
		
		public function stopTimer(userName:String):void{
			try
			{
				var userCom:_comp_User_Info = getUserCom(userName);
				userCom.stopTimer();
			} 
			catch(error:Error) 
			{
				trace(error);
			}
		}
		
		public function setUserSitOut(userName:String, sitOut:Boolean):void{
			try
			{
				var userCom:_comp_User_Info = getUserCom(userName);
				userCom.setSitOut(sitOut);
				//m_cMain.vMain.m_cbSitOut.selected = sitOut;
				
			} 
			catch(error:Error) 
			{
				trace(error);
			}
		}
		
		public function stopAllTimer():void{
			try
			{
				for each (var userCom:_comp_User_Info in m_listUserInfo){
					userCom.stopTimer();
				}
			} 
			catch(error:Error) 
			{
				
			}
		}
		
		public function setDealer(userName:String):void{
			try
			{
				for each (var userCom:_comp_User_Info in m_listUserInfo){
					if(userCom.strUserName == userName){
						userCom.isDealer = true;
					}
					else{
						userCom.isDealer = false;
					}
				}
			} 
			catch(error:Error) 
			{
				
			}
		}
		
		public function setSmallBlind(userName:String):void{
			try
			{
				for each (var userCom:_comp_User_Info in m_listUserInfo){
					if(userCom.strUserName == userName){
						userCom.isSmallBlind = true;
					}
					else{
						userCom.isSmallBlind = false;
					}
				}
			} 
			catch(error:Error) 
			{
				
			}
		}

		public function setBigBlind(userName:String):void{
			try
			{
				for each (var userCom:_comp_User_Info in m_listUserInfo){
					if(userCom.strUserName == userName){
						userCom.isBigBlind = true;
					}
					else{
						userCom.isBigBlind = false;
					}
				}
			} 
			catch(error:Error) 
			{
				
			}
		}
		
		public function updateSitVisibled():void{
			try
			{
				for each (var userCom:_comp_User_Info in m_listUserInfo){
					if(userCom.isVisibled == false && GameVariable.GetInstance().myPos == -1){
						userCom.isSitVisibled = true;
					}
					else{
						userCom.isSitVisibled = false;
					}
				}
				
			} 
			catch(error:Error) 
			{
				
			}
		}
		
		private function setUserVisibled(userName:String, visibled:Boolean):void{
			try{
				var userCom:_comp_User_Info = getUserCom(userName);
				userCom.setVisibled(visibled);
			}
			catch(err:Error){}			
		}
				
		private function incUserFish(userName:String, amount:Number):void{
			var userCom:_comp_User_Info = getUserCom(userName);
			userCom.incUserFish(amount);
		}
		
		private function descUserFish(userName:String, amount:Number):void{
			var userCom:_comp_User_Info = getUserCom(userName);
			userCom.descUserFish(amount);
		}
		
		public function incUserRaise(userName:String, amount:Number):void{
			var userCom:_comp_User_Info = getUserCom(userName);
			userCom.incUserRaise(amount);
		}
		
		//khoatd created base on incPot function 
		public function setcPot(pot:Number):void{
			strPot = NumberFormat.getDecimalFormat(pot);
			m_cChip.setChip(pot);
		}
		private function incPot(amount:Number):void{
			var pot:Number = 0;
			if(m_strPot != ""){
				pot = NumberFormat.getNumber(strPot);
			}
			strPot = NumberFormat.getDecimalFormat(pot + amount);
			m_cChip.setChip(pot + amount);
		}
		
		public function resetData():void{
			for each(var userCom:_comp_User_Info in m_listUserInfo){
				userCom.clear();
			}
			clear();
		}
		
		private function clear():void{
			m_comComCard.clearComCard();
			strPot = "";			
			m_mBetBoard.isVisibled = false;
		}
		public function ClearTableView():void{
			for each(var userCom:_comp_User_Info in m_listUserInfo){
				try
				{	
					userCom.clear();				
				} 
				catch(error:Error) {}				
			}
		}
		public function removeAll():void{
			for each(var userCom:_comp_User_Info in m_listUserInfo){
				try
				{	
					userCom.setHide();				
				} 
				catch(error:Error) {}
				m_cMain.vMain.m_mChipContainer.removeAllElements();
			}
			clear();
			countSitOut = 0;
		}
		
		private function getUserCom(userName:String):_comp_User_Info{
			return (m_listUserInfo[getUserPos(userName)] as _comp_User_Info);
		}
		
		private function getUserPos(userName:String):int{
			return int(m_mapUserPos[userName]);
		}
		
		public function setUserReady(userName:String, img:String):void{
			var userCom:_comp_User_Info = getUserCom(userName);
			userCom.setTickReady(img);
		}
		
		public function setFSH(userName:String, bettype:String):void{
			var userCom:_comp_User_Info = getUserCom(userName);
			userCom.setFSH(bettype);
		}
		
		public function initUI():void{			
			ClearTableView();
			m_listUserInfo[0] = m_cMain.vMain.m_comUser01;
			m_listUserInfo[1] = m_cMain.vMain.m_comUser02;
			m_listUserInfo[2] = m_cMain.vMain.m_comUser03;
			m_listUserInfo[3] = m_cMain.vMain.m_comUser04;
			m_listUserInfo[4] = m_cMain.vMain.m_comUser05;
			m_listUserInfo[5] = m_cMain.vMain.m_comUser06;
			m_listUserInfo[6] = m_cMain.vMain.m_comUser07;
			m_listUserInfo[7] = m_cMain.vMain.m_comUser08;
			m_listUserInfo[8] = m_cMain.vMain.m_comUser09;
			m_listUserInfo[9] = m_cMain.vMain.m_comUser10;
			m_comComCard = m_cMain.vMain.m_comComCard;
			isCanSitOut = false;
			isSittingOut = false;
			
		}	
		
		
		
		/****************** GETTER && SETTER ******************/
		[Bindable]
		public function get strSmallBlind():String
		{
			return m_strSmallBlind;
		}

		public function set strSmallBlind(value:String):void
		{
			m_strSmallBlind = value;
		}

		[Bindable]
		public function get strBigBlind():String
		{
			return m_strBigBlind;
		}

		public function set strBigBlind(value:String):void
		{
			m_strBigBlind = value;
		}

		[Bindable]
		public function get strTableName():String
		{
			return m_strTableName;
		}

		public function set strTableName(value:String):void
		{
			m_strTableName = value;
		}

		[Bindable]
		public function get strNumPlayer():String
		{
			return m_strNumPlayer;
		}

		public function set strNumPlayer(value:String):void
		{
			m_strNumPlayer = value;
		}

		[Bindable]
		public function get strMaxPLayer():String
		{
			return m_strMaxPLayer;
		}

		public function set strMaxPLayer(value:String):void
		{
			m_strMaxPLayer = value;
		}

		
		[Bindable]
		public function get isPlaying():Boolean
		{
			return m_isPlaying;
		}

		public function set isPlaying(value:Boolean):void
		{
			m_isPlaying = value;
		}

		[Bindable]
		public function get strPot():String
		{
			return m_strPot;
		}

		public function set strPot(value:String):void
		{
			m_strPot = value;
		}

		[Bindable]
		public function get isReady():Boolean
		{
			return m_isReady;
		}

		public function set isReady(value:Boolean):void
		{
			m_isReady = value;
		}
		
		[Bindable]
		public function get countSitOut():int
		{
			return m_countSitOut;
		}

		public function set countSitOut(value:int):void
		{
			m_countSitOut = value;
		}

		[Bindable]
		public function get isCanSitOut():Boolean
		{
			return m_isCanSitOut;
		}

		public function set isCanSitOut(value:Boolean):void
		{
			trace("Is Can SitOUt = " + m_isCanSitOut + " " + value);
			m_isCanSitOut = value;
		}

		[Bindable]
		public function get isSittingOut():Boolean
		{
			return m_isSittingOut;
		}

		public function set isSittingOut(value:Boolean):void
		{
			m_isSittingOut = value;
		}

		public function get isSitting():Boolean
		{
			return m_isSitting;
		}

		public function set isSitting(value:Boolean):void
		{
			m_isSitting = value;
		}

		[Bindable]
		public function get isAutoFold():Boolean
		{
			return m_isAutoFold;
		}

		public function set isAutoFold(value:Boolean):void
		{
			m_isAutoFold = value;
		}

		[Bindable]
		public function get isCanAutoFold():Boolean
		{
			return m_isCanAutoFold;
		}

		public function set isCanAutoFold(value:Boolean):void
		{
			m_isCanAutoFold = value;
		}

		public function get nextLevel():LevelDetailEntity
		{
			return m_nextLevel;
		}

		public function set nextLevel(value:LevelDetailEntity):void
		{
			m_nextLevel = value;
		}

		public function get isTurnNextLvl():Boolean
		{
			return m_isTurnNextLvl;
		}

		public function set isTurnNextLvl(value:Boolean):void
		{
			m_isTurnNextLvl = value;
		}

		[Bindable]
		public function get strLevelTimer():String
		{
			return m_strLevelTimer;
		}

		public function set strLevelTimer(value:String):void
		{
			m_strLevelTimer = value;
		}

		public function get BettingChip():Number
		{
			return m_bettingChip;
		}

		public function set BettingChip(value:Number):void
		{
			m_bettingChip = value;
		}

		
		/****************** END GETTER && SETTER ******************/
		
		
	}
}