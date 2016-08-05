package controller
{
	import Message.request.LeaveRoomRequest;
	import Message.request.game.pokertexas.SitOnRequest;
	
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.requests.ExtensionRequest;
	import com.smartfoxserver.v2.requests.JoinRoomRequest;
	
	import components._comp_joinTable;
	
	import flash.events.Event;
	
	import model.M_Game;
	import model.M_JoinTable;
	
	import mx.managers.PopUpManager;
	
	import params.RequestParams;
	import params.RoomVarParams;
	
	import zUtilities.GameVariable;
	import zUtilities.Logger;
	import zUtilities.MainController;
	import zUtilities.ServerController;

	public class C_JoinTable
	{
		private var m_mJoinTable:M_JoinTable = M_JoinTable.getInstance();
		private var m_mGame:M_Game = M_Game.getInstance();
		private var m_cMain:MainController = MainController.getInstance();
		private var m_server:ServerController = ServerController.getInstance();
		
		private var m_logger: Logger = new Logger();
		
		public function C_JoinTable(){
		}
		
		/*public function leaveCurrentGame():void{
			if(m_cMain.getCurrentState() == MainController.STATE_TABLE){
				try{
					m_server.sendRequest(new LeaveRoomRequest());
					m_mGame.removeAll();
					//m_cMain.gotoState_Cashier();
					m_cMain.gotoState_Lobby_Cash();
					//m_globalVar.myPos = -1;
				}catch(err:Error){
					trace(err.message);
				}
			}
		}*/
		public function leaveCurrentGame():void{
			if(m_cMain.getCurrentState() == MainController.STATE_TABLE){
				try{
					var exitRoom: Room = GameVariable.GetInstance().CurrentRoom;
					m_server.sendRequest(new LeaveRoomRequest(exitRoom));
					m_mGame.removeAll();
					//m_cMain.gotoState_Cashier();
					GameVariable.GetInstance().myPos = -1;
				}catch(err:Error){
					m_logger.Log(err.message);
				}
			}
		}
		
		public function showJoinTableBox():void{
			m_mJoinTable.vJoinTable = new _comp_joinTable();
			PopUpManager.addPopUp(m_mJoinTable.vJoinTable, m_cMain.vMain, true);
			PopUpManager.centerPopUp(m_mJoinTable.vJoinTable);
		}
		
		private function hideJoinTableBox():void{
			PopUpManager.removePopUp(m_mJoinTable.vJoinTable);
		}
		
		/********* HANDLE GUI EVENT ***********/
		public function handleBtnOK_click(event:Event):void{
			var chipAmount:Number = m_mJoinTable.getBuyIn();
			if(chipAmount < 0){
				return;
			}
			//sendBuyChip(chipAmount);
			sendSitdown(chipAmount);
			hideJoinTableBox();
		}
		
		private function sendBuyChip(chipAmount:Number):void{
			
			/*var param:ISFSObject = new SFSObject();
			param.putUtfString(RoomVarParams.NAME, m_mJoinTable.strTableName);
			param.putDouble(RequestParams.CHIP_AMOUNT, chipAmount);
			m_server.sendRequest(new ExtensionRequest(CustomRequest.USER_BUY_CHIP, param));*/
		}
		
		//khoatd edited
		/*private function sendSitdown():void{
			var param:ISFSObject = new SFSObject();
			param.putInt(RequestParams.SIT_POS, m_mJoinTable.sitPos);
			param.putUtfString(RoomVarParams.NAME, m_globalVar.curTable.name);
			m_server.sendRequest(new ExtensionRequest(CustomRequest.USER_SIT_DOWN, param));
		}*/
		private function sendSitdown(chipAmount: Number):void{
			try{
				var request: SitOnRequest = new SitOnRequest();
				var userName: String = GameVariable.GetInstance().UserInfo.UserName;
				
				request.AddParam(SitOnRequest.DESKID, m_mJoinTable.sitPos);
				request.AddParam(SitOnRequest.BUY_IN, chipAmount);
				m_server.SendCustomRequest(request);
			}catch(err: Error){
				m_logger.Log(err.message);
			}
		}
		
		public function handleBtnCancel_click(event:Event):void{
//			hideJoinTableBox();
//			leaveCurrentGame();
			hideJoinTableBox();
			standUp();			
		}
		/********* END HANDLE GUI EVENT ***********/
		public function standUp():void{
			/*try{
				var param:ISFSObject = new SFSObject();
				param.putUtfString(RoomVarParams.NAME, m_globalVar.curTable.name);
				m_server.sendRequest(new ExtensionRequest(CustomRequest.USER_STAND_UP, param));
			}catch(err:Error){
				trace(err.message);
			}*/
		}
	}
}