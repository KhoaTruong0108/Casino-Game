package controller
{
	import Message.event.ConnectionEvent;
	import Message.event.ConnectionLostEvent;
	import Message.event.LoginErrorEvent;
	import Message.event.LoginEvent;
	import Message.event.admin.*;
	import Message.event.admin.ADMIN_RESPONSE_NAME;
	import Message.request.LoginRequest;
	import Message.request.admin.*;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.User;
	
	import components._comp_addChip;
	import components._comp_detailUser;
	
	import entity.AdminEntity;
	
	import enum.ManagedObject;
	import enum.TransactionType;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import model.M_AddChip;
	import model.M_Admin;
	import model.M_DetailUser;
	import model.M_Login;
	
	import mx.collections.ArrayCollection;
	import mx.managers.PopUpManager;
	
	import spark.components.Application;
	
	import zUtilities.GameVariable;
	import zUtilities.ServerController;
	
	
	public class C_AddChip
	{
		private var m_mAddChip : M_AddChip = M_AddChip.getInstance();
		private var m_serverController : ServerController = ServerController.getInstance();
		private var m_cMain:MainController = MainController.getInstance();
		
		public function C_AddChip()
		{	
			m_serverController.addEventListener(ADMIN_RESPONSE_NAME.ADD_CHIP_FOR_USER_RES, onAddChipRes);
		}
		
		private function onAddChipRes(event: Event):void
		{
			var response: AddChipRes = event as AddChipRes;
			var result : Boolean = response.result;
			var msg: String = response.Message;
			m_mAddChip.status = msg;
			
			if(result){
				m_mAddChip.chip = "0";
			}
		}		
		
		public function handleAddChip():void{
			var request: AddChipRequest = new AddChipRequest();
			
			var chip: Number = 0;
			if(m_mAddChip.chip != "")
				chip = parseFloat(m_mAddChip.chip);
			if(m_mAddChip.type.toString() == TransactionType.WITHDRAW){
				chip = -chip;
			}
			
			request.AddParam("user_name", m_mAddChip.name);
			request.AddParam("amount", chip);
			request.AddParam("type", m_mAddChip.type.toString());
			
			m_serverController.SendCustomRequest(request);
			
			m_mAddChip.status = "";
		}
		
		public function showUserDetailBox(user: Object):void{
			if(user != null){
				m_mAddChip.vAddChip = new _comp_addChip();
				m_mAddChip.clearAll();
			
				m_mAddChip.name = user.UserName;
			
				PopUpManager.addPopUp(m_mAddChip.vAddChip, m_cMain.vMain, true);
				PopUpManager.centerPopUp(m_mAddChip.vAddChip);
			}
			
		}
		
		public function hideUserDetailBox():void{
			PopUpManager.removePopUp(m_mAddChip.vAddChip);
		}
		
	}
}