package model
{
	import Enum.RoomVariableDetail;
	
	import com.smartfoxserver.v2.entities.Room;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import params.RoomVarParams;
	
	import zUtilities.ServerController;

	public class M_Lobby_Cash
	{
		
		private static var m_instance:M_Lobby_Cash = null;
		private static var m_isAllowed:Boolean = false;
		
		private var m_server:ServerController = ServerController.getInstance();
		
		public function M_Lobby_Cash(){
			if(m_isAllowed == false){
				throw new Error("Cannot create an instance of a singleton class!");
			}
			m_arrCash = new ArrayCollection();
		}
		
		public static function getInstance():M_Lobby_Cash{
			if(m_instance == null){
				m_isAllowed = true;
				m_instance = new M_Lobby_Cash();
				m_isAllowed = false;
			}
			return m_instance;
		}
		
		
		private var m_arrCash:ArrayCollection;
		private var m_oSelectedItem:Object;
		
		public function clearItem():void{
			m_arrCash.removeAll();
		}
		
		
		public function handleRoomVariableUpdate(room: Room,ChangedVars: Array):void{
			for(var i: int = 0; i < arrCash.length; ++i){
				var item: Object = arrCash[i];
				if(item.tableName == room.name){
					if(ChangedVars.indexOf(RoomVariableDetail.DISPLAY_NAME) != -1){				
						item.displayName = room.getVariable(RoomVariableDetail.DISPLAY_NAME).getStringValue();
					}
					if(ChangedVars.indexOf(RoomVariableDetail.BET_CHIP) != -1){				
						item.smallBlind = room.getVariable(RoomVariableDetail.BET_CHIP).getDoubleValue();
						item.bigBlind = item.smallBlind * 2;
					}
					if(ChangedVars.indexOf(RoomVariableDetail.MIN_CHIP) != -1){				
						item.minBuyIn = room.getVariable(RoomVariableDetail.MIN_CHIP).getDoubleValue();
					}
					if(ChangedVars.indexOf(RoomVariableDetail.MAX_CHIP) != -1){				
						item.maxBuyIn = room.getVariable(RoomVariableDetail.MAX_CHIP).getDoubleValue();
					}
					if(ChangedVars.indexOf(RoomVariableDetail.STATUS) != -1){				
						item.status = room.getVariable(RoomVariableDetail.STATUS).getStringValue();
					}
					arrCash[i] = item;
					break;
				}
			}
		}
		
		public function addItem(id:int, name:String, displayName: String, sBlind:Number, 
								bBlind:Number, pCount:int, nPlayer:int, 
								min:Number, max:Number, status:String, noLimit:Boolean):void{
			var item:Object = new Object();
			item.tableName = name;
			item.displayName = displayName;
			item.smallBlind = sBlind;
			item.bigBlind = bBlind;
			item.playerCount = pCount;
			item.numPlayer = nPlayer;
			item.minBuyIn = min;
			item.maxBuyIn = max;
			item.status = status;
			item.id = id;
			item.noLimit = noLimit;
			/*if(noLimit == true){
				item.maxBuyIn = 0;
			}*/
			m_arrCash.addItem(item);
		}
		
		//khoatd edited
		public function removeItem(name:String):void{
			for(var i:int; i < m_arrCash.length; i++){
				var item:Object = m_arrCash.getItemAt(i);
				if(item.tableName == name){
					m_arrCash.removeItemAt(i);
					break;
				}
			}
		}
		/*public function removeItem(id: int):void{
			for(var i:int; i < m_arrCash.length; i++){
				var item:Object = m_arrCash.getItemAt(i);
				if(item.id == id){
					m_arrCash.removeItemAt(i);
					break;
				}
			}
		}*/
		
		public function changeStatus(name:String, status:String):void{
			for(var i : int = 0; i < arrCash.length; ++i){
				var item: Object = arrCash[i];
				if(item.tableName == name){
					item.status = status;
					arrCash[i] = item;
					break;
				}
			}
			/*for each(var item:Object in arrCash){
				if(item.name == name){
					item.status = status;
					break;
				}
			}*/
//			removeItem(name);
//			if(status == "Waiting"){				
//				var listRoom:Array = m_server.getRoomList();
//				for each(var room:Room in listRoom){
//					if(room.name == name){
//						var status:String = room.getVariable(RoomVarParams.STATUS).getStringValue();
//						var id:int = room.id;
//						var name:String = room.name;
//						var sBlind:Number = room.getVariable(RoomVarParams.SMALL_BLIND).getDoubleValue();
//						var bBlind:Number = room.getVariable(RoomVarParams.BIG_BLIND).getDoubleValue();
//						var pCount:int = room.userCount;
//						var mPlayer:int = room.maxUsers;
//						var min:int = room.getVariable(RoomVarParams.MIN_BUY_IN).getDoubleValue();
//						var max:int = room.getVariable(RoomVarParams.MAX_BUY_IN).getDoubleValue();
//						addItem(room.id, room.name, sBlind, bBlind, pCount, mPlayer, min, max, status);
//					}
//				}
//			}
//			else{
//			}
		}
		
		public function changePlayerCount(name:String, pCount:int):void{
			for(var i: int = 0; i < arrCash.length; ++i){
				var item: Object = arrCash[i];
				if(item.tableName == name){
					item.playerCount = pCount;
					arrCash[i] = item;
					break;
				}
			}
			/*for each(var item:Object in m_arrCash){
				if(item.tableName == name){
					item.playerCount = pCount;
					break;
				}
			}*/
		}
		
		public function getSelectedTableId():int{
			if(m_oSelectedItem == null){
				return -1;
			}
			return int(m_oSelectedItem.id);
		}
		
		/****************** HANDLE GUI EVENT ********************/
		public function handleBtnJoin(event:Event):void{
			if(m_oSelectedItem == null){
				return;
			}
			
			var roomName:String = m_oSelectedItem.tableName;
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