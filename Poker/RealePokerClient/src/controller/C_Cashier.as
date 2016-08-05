package controller
{
	import Message.event.UserVariableUpdateEvent;
	import Message.event.general.GENERAL_EVENT_NAME;
	import Message.event.general.GetTransByUserEvent;
	import Message.request.general.GetTransactionByUserRequest;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.ISFSArray;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	
	import entity.UserEntity;
	
	import flash.events.Event;
	
	import model.M_Cashier;
	
	import params.CashierParams;
	import params.ResponseParams;
	
	import zUtilities.GameVariable;
	import zUtilities.NumberFormat;
	import zUtilities.ServerController;

	public class C_Cashier
	{
		private var m_mCashier:M_Cashier = M_Cashier.getInstance();
		
		private var m_server:ServerController = ServerController.getInstance();
		
		public function C_Cashier()
		{
			m_server.addEventListener(GENERAL_EVENT_NAME.GET_TRANS_BY_USER_RES, onGetTransByUser);
			m_server.addEventListener(SFSEvent.USER_VARIABLES_UPDATE, onUserVariableUpdate);
		}
		
		private function onGetTransByUser(event: Event):void
		{
			// TODO Auto Generated method stub
			var response: GetTransByUserEvent = event as GetTransByUserEvent;
			m_mCashier.arrCashier = response.listTrans;
		}
		
		public function handleCashier_enterState(event:Event):void{
			handleGetTransactionByUser();
			
			m_mCashier.updateUseInfo();
		}
		
		private function handleGetTransactionByUser():void
		{
			var request: GetTransactionByUserRequest = new GetTransactionByUserRequest();
			request.AddParam("user_name",GameVariable.GetInstance().UserInfo.UserName);
			request.AddParam("index", 0);
			request.AddParam("num_row",99999);
			m_server.SendCustomRequest(request);
		}
		
		private function onUserVariableUpdate(evt: Event):void{
			try{
				var updateEvt: UserVariableUpdateEvent = evt as UserVariableUpdateEvent;
				
				GameVariable.GetInstance().UserInfo = UserEntity.FromUser(updateEvt.userInfo);
				m_mCashier.updateUseInfo();
			}catch(err:Error){
				trace(err.message);
			}
		}
	}
}