package entity.game_Entity.Poker
{
	import Enum.DeskState;
	import config.Configuration;
	import entity.UserInfo;
	import entity.game_Entity.Desk;
	import entity.game_Entity.Poker.PokerCardFactory;
	import zUtilities.Logger;
	
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.entities.data.ISFSArray;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import de.polygonal.ds.HashMap;
	
	import mx.collections.ArrayList;

	public class PokerTableInfo{
		protected var m_isGameStart:Boolean = false;
		protected var m_isPrestart:Boolean = false;
		//Tiền cược của phòng
		private var m_betGameChip: Number;
		//tiền cược trong 1 vòng
		private var m_bettingChip: Number;
		private var m_bettingUser: String;
		
		private var m_potChip: Number;
		//Hiện tại đang đến lượt user nào
		protected var m_currentUser: String;
		protected var m_currentGameTurn: String;
		//Danh Sách Các Ghế ( vị trí) trong bàn chơi   
		protected var m_listDesk: ArrayList;//ArrayList<Desk>
		//Danh Sach UserName Trong Game
		protected var m_listActiveUserName: ArrayList;//ArrayList<String>
		//Danh Sach UserName Trong Game
		protected var m_listUserName: ArrayList;//ArrayList<String>
		//Danh Sác User Trong Game
		protected var m_listUser: ArrayList;//ArrayList<UserInfo>
		protected var m_cardFactory: PokerCardFactory;
		// Map User - Ghế
		protected var m_mapUserDesk: HashMap;//HashMap<String, Desk>
		// Danh Sách lá bài người chơi hiện tại, player ko có trong mapUserCard HashMap<String userName, ArrayList listCardId>
		protected var m_mapUserCard: HashMap;
		//Danh sách lá bài chung
		protected var m_listCommunityCard: ArrayList;
		
		protected var m_isAutoCheck:Boolean;
		protected var m_isAutoSitOn:Boolean;
		
		//protected var m_isSitting: Boolean;
		
		public var PRE_START_TIME: int = 10 * 1000; //10s
		public var GET_NEXT_CARD_TIME: int = 10 * 1000;//10s
		public var SHOW_CARD_TIME: int = 10 * 1000; // 10s
		
		public function PokerTableInfo()
		{
			m_listDesk = new ArrayList();
			m_mapUserDesk = new HashMap();
			m_listDesk = new ArrayList();
			m_listCommunityCard = new ArrayList();
			m_listUserName = new ArrayList();
			m_listUser = new ArrayList();
			m_cardFactory = PokerCardFactory.getInstance();
			m_mapUserCard = new HashMap();
			//Init Desk
			for (var i: int = 0; i < Configuration.NUMBER_OF_DESK; ++i) {
				var desk:Desk = new Desk();
				desk.DeskState = DeskState.EMPTY;
				desk.DeskId = i;
				desk.UserName = null;
				desk.UserAvatar = null;
				desk.UserChip = 0;
				//khoatd
				ListDesk.addItemAt(desk, i);
			}
			//Init Game Variable
			m_currentUser = "";
			m_isGameStart = false;
			m_isPrestart = false;
			m_betGameChip = 0;
			m_potChip = 0;
			
			m_isAutoCheck = false;
			m_isAutoSitOn = false;
		}
		//*******************************************************************************
		//			SangDN: Dua 1 User Vao 
		//			Case: Khi server thong bao 1 user vao game
		//*******************************************************************************
		public function SitAUserOn(user: UserInfo, deskInfo:Desk, betChip: Number):Boolean{
			var desk: Desk  = ListDesk.getItemAt(deskInfo.DeskId) as Desk;
			if (desk.deskState == DeskState.EMPTY) {
				//put user here
				//Update Deskstate	
				desk.deskState = DeskState.WAITING;
				desk.UserName = user.UserName;
				/*desk.UserAvatar(user.);*/
				desk.UserChip = deskInfo.UserChip;
				desk.TotalBetChip = betChip;
				
				//update dependence variable
				m_mapUserDesk.set(user.UserName, desk);
				
				//khoatd
				m_mapUserCard.set(user.UserName,  new ArrayList());
				
				m_listUserName.removeItem(user.UserName);
				m_listUser.removeItem(user);
				
				m_listUserName.addItem(user.UserName);
				m_listUser.addItem(user);
				return true;
			}
			return false;
		}
		//*******************************************************************************
		//			SangDN: Bo 1 UserRa
		//			Case: Khi Server thong bao 1 user out game
		//*******************************************************************************
		public function LeaveAUserOut(user: UserInfo):Boolean{
			var username: String  = user.UserName;
			StandUserUp(user.UserName);
			
			m_listUserName.removeItem(username);
			m_listUser.removeItem(user);
			return true;
		}
		
		public function StandUserUp(userName: String): void{
			var desk: Desk  = m_mapUserDesk.get(userName) as Desk;
			//Leave User
			//Incase: Player Is Playing
			if(desk != null){
				if (desk.deskState == DeskState.PLAYING || desk.deskState == DeskState.WAITING
					||desk.deskState == DeskState.READY) {
					//Just remove the user, not need to use stop playing now.
					//desk.setDeskState(DeskState.STOP_PLAYING);
					desk.deskState = DeskState.EMPTY;
					desk.UserName = null;
					desk.UserAvatar = null;
					desk.UserChip = 0;
					m_mapUserDesk.remove(desk);
					
					//khoatd
					var listCardId: ArrayList = m_mapUserCard.get(userName) as ArrayList;
					m_mapUserCard.remove(listCardId);
				} 
			}
		}
		
		public function RenewInfo():void {
			
			m_mapUserDesk.clear();
			
			m_listUserName.removeAll();
			m_listUser.removeAll();
			
			m_mapUserCard.clear();
			//Init Desk
			m_listDesk.removeAll();
			for (var i:int = 0; i < Configuration.NUMBER_OF_DESK; ++i) {
				var desk: Desk = new Desk();
				desk.DeskState = DeskState.EMPTY;
				desk.DeskId = i;
				desk.UserName = null;
				desk.UserAvatar = null;
				desk.UserChip = 0;
				//khoatd
				m_listDesk.addItemAt(desk, i);
			}
			m_cardFactory = new PokerCardFactory();
			
			this.IsGameStart = false;
			this.CurrentUser = "";
			this.m_betGameChip = 0;
		}
		
		public function ReplayGame():void{
			m_cardFactory = new PokerCardFactory();
			m_potChip = 0;
			m_listCommunityCard.removeAll();

			//because m_mapUserCard is setted in onStartGame();
			clearMapCard(m_mapUserCard);
			
			for(var i: int = 0; i< m_listDesk.length; i++){
				var desk: Desk = m_listDesk.getItemAt(i) as Desk;
				if(desk.deskState == DeskState.PLAYING){
					desk.deskState = DeskState.WAITING;
					desk.TotalBetChip = 0;
				}
			}
		}
		protected function clearMapCard(map: HashMap):void{
			for(var i: int = 0; i< map.toKeyArray().length; i++){
				var key: String = map.toKeyArray()[i] as String;
				map.remap(key, new ArrayList());
			}
		}
		
		public function addCommunityCard(cardId: int):void{
			m_listCommunityCard.addItem(cardId);
		}
		
		//return totalbetChip
		public function processUserBet(userName: String, betChip: Number): Number{
			m_bettingChip = betChip;
			m_bettingUser = userName;
			m_potChip += betChip;
			
			var desk: Desk = m_mapUserDesk.get(userName) as Desk;
			desk.TotalBetChip += betChip;
			desk.UserChip -= betChip;
			
			return desk.TotalBetChip;
		}
		
		public function getTotalBetChip(userName: String):Number{
			var desk: Desk = m_mapUserDesk.get(userName) as Desk;
			if(desk != null){
				return desk.TotalBetChip;
			}else{
				return -1;
			}
		}
		
		public function processGameTurn(gameTurn: String):void{
			m_currentGameTurn = gameTurn;
			m_bettingUser = null;
		}
		
		public function getPreviousPlayerName(fromUser: String): String{
			Logger.Log("[PokerTableInfo][getPreviousPlayerName] " );
			var previousUserName: String= null;
			var fromDesk: Desk = m_mapUserDesk.get(fromUser) as Desk;
			var i:int;
			if (fromDesk != null) {
				i = fromDesk.DeskId - 1;
			} 
			
			var icount:int = 1;
			while (icount < Configuration.NUMBER_OF_DESK) {
				if (i < 0) {
					i += Configuration.NUMBER_OF_DESK;
				}
				
				var previousDesk: Desk = m_listDesk.getItemAt(i) as Desk;
				if ((previousDesk.DeskState == DeskState.PLAYING || previousDesk.DeskState == DeskState.READY)
					&& previousDesk.UserName != null) {
					previousUserName = previousDesk.UserName;
					break;
				}
				i--;
				icount++;
			}
			return previousUserName;
		}
		
		public function handleStartGame(mainUser: String, listCard: ArrayList, smallBlind: String, bigBlind: String, currentUser: String):void{
			m_mapUserCard.remap(mainUser, listCard);
			m_currentUser = currentUser;
			var mainDesk: Desk = m_mapUserDesk.get(mainUser) as Desk;
			if(mainDesk == null)
				return;
			mainDesk.deskState = DeskState.PLAYING;
			
			m_isPrestart = false;
			m_isGameStart = true;
			
			var smallDesk: Desk = m_mapUserDesk.get(smallBlind) as Desk;
			if(smallDesk == null)
				return;
			smallDesk.deskState = DeskState.PLAYING;
			smallDesk.UserChip -= m_betGameChip;
			smallDesk.TotalBetChip = m_betGameChip;
			
			var bigDesk: Desk = m_mapUserDesk.get(bigBlind) as Desk;
			if(bigDesk == null)
				return;
			bigDesk.deskState = DeskState.PLAYING;
			bigDesk.UserChip -= m_betGameChip * 2;
			bigDesk.TotalBetChip = m_betGameChip * 2;
			
			m_potChip = m_betGameChip * 3;
			
			m_listCommunityCard.removeAll();
			
			for(var i: int = 0 ;i < m_listUserName.length; i++){
				var userName: String = m_listUserName.getItemAt(i).toString();
				if(userName != smallBlind && userName != bigBlind){
					var userDesk: Desk = m_mapUserDesk.get(userName) as Desk;
					if(userDesk != null)
						userDesk.deskState = DeskState.PLAYING;
				}
			}
		}
		
		public function getUserChip(userName: String):Number{
			var desk: Desk = m_mapUserDesk.get(userName) as Desk;
			if(desk.UserName != null)
				return desk.UserChip;
			
			return -1;
		}
		
		public function getPreviousPlayer(userName: String):String{
			var desk: Desk = m_mapUserDesk.get(userName) as Desk;
			var previousId: int = desk.DeskId - 1;
			var icount: int = 1;
			while(icount < Configuration.NUMBER_OF_DESK){
				if(previousId < 0)
					previousId = Configuration.NUMBER_OF_DESK - 1;
				
				var previsousDesk: Desk = m_listDesk.getItemAt(previousId) as Desk;
				if(previsousDesk.UserName != null)
					return previsousDesk.UserName;
				icount++;
				previousId--;
			}
			return null;
		}
		public function getRandomCard(listCardId: ArrayList):int{
			var randomId: int = Math.abs(Math.round(Math.random() * (listCardId.length - 1))) as int;
			var randCardId: int = -1;
			if(randomId < listCardId.length){
				randCardId = listCardId.getItemAt(randomId) as int;
			}
			return randCardId;
		}
		//get 3 random card on user hand.
		public function getRandomListHandCard(userName: String):ArrayList{
			var listCardId: ArrayList = m_mapUserCard.get(userName) as ArrayList;
			
			var listRandomCard: ArrayList = new ArrayList();
			for(var i: int = 0; i< 3; i++){
				var randomId: int = getRandomCard(listCardId);
				listRandomCard.addItem(randomId);
			}
			return listRandomCard;
		}
		
		public function isUserSitting(userName: String): Boolean{
			var desk: Desk = m_mapUserDesk.get(userName) as Desk;
			if(desk == null){
				return false;
			}else{
				return true;
			}
		}
		
		public function activeAutoCheck(isActive: Boolean = true):void{
			m_isAutoCheck = isActive;
		}
		public function activeAutoSitOn(isActive: Boolean = true):void{
			m_isAutoSitOn = isActive;
		}
		
		public function checkExistComCard(cardId: int):Boolean{
			for(var i: int = 0; i< m_listCommunityCard.length; i++){
				if(m_listCommunityCard.getItemAt(i) as int == cardId){
					return true;
				}
			}
			return false;
		}
		
		public function get IsGameStart():Boolean
		{
			return m_isGameStart;
		}

		public function set IsGameStart(value:Boolean):void
		{
			m_isGameStart = value;
		}


		public function get CurrentUser():String
		{
			return m_currentUser;
		}

		public function set CurrentUser(value:String):void
		{
			m_currentUser = value;
		}

		public function get ListDesk():ArrayList
		{
			return m_listDesk;
		}

		public function set ListDesk(value:ArrayList):void
		{
			m_listDesk = value;
		}

		public function get ListUserName():ArrayList
		{
			return m_listUserName;
		}

		public function set ListUserName(value:ArrayList):void
		{
			m_listUserName = value;
		}

		public function get ListUser():ArrayList
		{
			return m_listUser;
		}

		public function set ListUser(value:ArrayList):void
		{
			m_listUser = value;
		}

		public function get MapUserCard():HashMap
		{
			return m_mapUserCard;
		}

		public function set MapUserCard(value:HashMap):void
		{
			m_mapUserCard = value;
		}


		public function get IsPrestart():Boolean
		{
			return m_isPrestart;
		}

		public function set IsPrestart(value:Boolean):void
		{
			m_isPrestart = value;
		}

		public function get MapUserDesk():HashMap
		{
			return m_mapUserDesk;
		}

		public function set MapUserDesk(value:HashMap):void
		{
			m_mapUserDesk = value;
		}

		public function get BetGameChip():Number
		{
			return m_betGameChip;
		}

		public function set BetGameChip(value:Number):void
		{
			m_betGameChip = value;
		}

		public function get ListCommunityCard():ArrayList
		{
			return m_listCommunityCard;
		}

		public function get BettingChip():Number
		{
			return m_bettingChip;
		}

		public function get CurrentGameTurn():String
		{
			return m_currentGameTurn;
		}

		public function set CurrentGameTurn(value:String):void
		{
			m_currentGameTurn = value;
		}

		public function get PotChip():Number
		{
			return m_potChip;
		}

		public function get IsAutoCheck():Boolean
		{
			return m_isAutoCheck;
		}

		public function set IsAutoCheck(value:Boolean):void
		{
			m_isAutoCheck = value;
		}

		public function get IsAutoSitOn():Boolean
		{
			return m_isAutoSitOn;
		}

		public function set IsAutoSitOn(value:Boolean):void
		{
			m_isAutoSitOn = value;
		}


	}
}