package model
{
	import entity.PokerTournamentEntity;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class M_Lobby_Tournament
	{
		
		private static var m_instance:M_Lobby_Tournament = null;
		private static var m_isAllowed:Boolean = false;
		
		public function M_Lobby_Tournament(){
			if(m_isAllowed == false){
				throw new Error("Cannot create an instance of a singleton class!");
			}
			m_arrCash = new ArrayCollection();
		}
		
		public static function getInstance():M_Lobby_Tournament{
			if(m_instance == null){
				m_isAllowed = true;
				m_instance = new M_Lobby_Tournament();
				m_isAllowed = false;
			}
			return m_instance;
		}
		
		
		private var m_arrCash:ArrayCollection;
		private var m_oSelectedItem:Object;
		
		public function clearItem():void{
			m_arrCash.removeAll();
		}
		
		public function updateItem(name: String, displayName: String, fee: Number, capacity: int, playerCount: int 
								   , startingChip: Number, stakes: String,firstPrize: Number,secondPrize: Number,thirdPrize: Number):void{
			for(var i : int = 0; i < m_arrCash.length; ++i){
				var item: Object = m_arrCash[i];
				if(item.name == name){
					item.displayName = displayName;
					item.fee = fee;
					item.capacity = capacity;
					item.playerCount = playerCount;
					item.startingChip = startingChip;
					item.stakes = stakes;
					item.prizes = firstPrize + "%-" + secondPrize + "%-" + thirdPrize + "%";
					m_arrCash[i] = item;
				}
			}
		}
		
		public function addItem(name: String, displayName: String, fee: Number, capacity: int, playerCount: int 
								,status: String, startingChip: Number, stakes: String
								,firstPrize: Number,secondPrize: Number,thirdPrize: Number):void{
			var item:Object = new Object();
			item.name = name;
			item.displayName = displayName;
			item.fee = fee;
			item.capacity = capacity;
			item.playerCount = playerCount;
			item.status = status;
			item.startingChip = startingChip;
			item.stakes = stakes;
			item.prizes = firstPrize + "%-" + secondPrize + "%-" + thirdPrize + "%";
			m_arrCash.addItem(item);
		}
		
		public function removeItem(name:String):void{
			for(var i:int; i < m_arrCash.length; i++){
				var item:Object = m_arrCash.getItemAt(i);
				if(item.name == name){
					m_arrCash.removeItemAt(i);
					break;
				}
			}
		}
		
		public function changePlayerCount(name:String, pCount:int):void{
			for(var i : int = 0; i < m_arrCash.length; ++i){
				var item: Object = m_arrCash[i];
				if(item.name == name){
					item.playerCount = pCount;
					m_arrCash[i] = item;
					break;
				}
			}
		}
		public function changePlayerCount2(name:String, pCount:int):void{
			for each(var item:Object in m_arrCash){
				if(item.name == name){
					item.playerCount = pCount;
					break;
				}
			}
		}
		
		public function increasePlayer(name:String):void{
			for(var i : int = 0; i < m_arrCash.length; ++i){
				var item: Object = m_arrCash[i];
				if(item.name == name){
					var playerCount: int = int(item.playerCount);
					item.playerCount = playerCount + 1;
					m_arrCash[i] = item;
					break;
				}
			}
		}
		
		public function decreasePlayer(name:String):void{
			for(var i : int = 0; i < arrCash.length; ++i){
				var item: Object = arrCash[i];
				if(item.name == name){
					var playerCount: int = int(item.playerCount);
					item.playerCount = playerCount - 1;
					arrCash[i] = item;
					break;
				}
			}
		}
		
		public function updateStatus(name:String, status: String):void{
			for(var i : int = 0; i < arrCash.length; ++i){
				var item: Object = arrCash[i];
				if(item.name == name){
					item.status = status;
					arrCash[i] = item;
					break;
				}
			}
		}
		
		public function getSelectedTourName(): String{
			if(m_oSelectedItem == null){
				return "";
			}
			return m_oSelectedItem.name;
		}
		
		public function getSelectedTourDetail(): PokerTournamentEntity{
			if(m_oSelectedItem == null){
				return null;
			}
			var tourEntity: PokerTournamentEntity = new PokerTournamentEntity();
			
			//tourEntity.betChip = m_oSelectedItem.betChip;
			tourEntity.levelType = m_oSelectedItem.levelType;
			tourEntity.beginLevel = m_oSelectedItem.beginLevel;
			tourEntity.endLevel = m_oSelectedItem.endLevel;
			tourEntity.capacity = m_oSelectedItem.capacity;
			tourEntity.fee = m_oSelectedItem.fee;
			tourEntity.name = m_oSelectedItem.name;
			tourEntity.playerCount = m_oSelectedItem.playerCount;
			tourEntity.startingChip = m_oSelectedItem.startingChip;
			tourEntity.status = m_oSelectedItem.status;
			
			var prize: String = m_oSelectedItem.prizes;
			var listPrize: Array = prize.split("-");
			tourEntity.firstPrize = parseFloat(listPrize[0].toString().replace("%",""));
			tourEntity.secondPrize = parseFloat(listPrize[1].toString().replace("%",""));
			tourEntity.thirdPrize = parseFloat(listPrize[2].toString().replace("%",""));
			
			return tourEntity;
		}
		
		/****************** HANDLE GUI EVENT ********************/
		public function handleBtnJoin(event:Event):void{
			if(m_oSelectedItem == null){
				return;
			}
			
			var roomName:String = m_oSelectedItem.name;
		}
		/****************** END HANDLE GUI EVENT ********************/
		
		/****************** GETTER && SETTER ********************/ 
		[Bindable]
		public function get arrCash():ArrayCollection
		{
			return m_arrCash;
		}
		
		public function set arrCash(value:ArrayCollection):void
		{
			m_arrCash = value;
		}
		
		[Bindable]
		public function get oSelectedItem():Object
		{
			return m_oSelectedItem;
		}
		
		public function set oSelectedItem(value:Object):void
		{
			m_oSelectedItem = value;
		}
		
		/****************** GETTER && SETTER ********************/
		
	}
}