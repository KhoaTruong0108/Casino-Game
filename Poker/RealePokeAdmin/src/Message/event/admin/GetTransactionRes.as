package Message.event.admin
{
	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.ISFSArray;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import entity.AdminEntity;
	import entity.RoomEntity;
	import entity.TransactionEntity;
	import entity.UserEntity;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	
	public class GetTransactionRes extends SFSGameEvent {
		protected var m_listTransaction: ArrayCollection; 
		
		public function GetTransactionRes() {
			super(ADMIN_RESPONSE_NAME.GET_TRANSACTION_RES);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != ADMIN_RESPONSE_NAME.GET_TRANSACTION_RES){
				throw new Error("Can't parse from " + sfse.type + " to GetTransactionRes");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject)
				.getSFSObject(ADMIN_RESPONSE_NAME.GET_TRANSACTION_RES) as SFSObject;
			if(param == null){
				throw new Error("GetTransactionRes::FromSFSEvent Error");			
			}
			
			var sfsArrTrans: ISFSArray = param.getSFSArray("list_transaction");
			m_listTransaction = new ArrayCollection();
			for(var i: int = 0; i< sfsArrTrans.size(); i++){
				var item: ISFSObject = sfsArrTrans.getSFSObject(i);
				var trans: TransactionEntity = new TransactionEntity();
				trans.userName = item.getUtfString("username");
				trans.byAdmin = item.getUtfString("byAdmin");
				trans.amount = item.getDouble("amount");
				trans.type = item.getUtfString("type");
				trans.date = item.getUtfString("date");

				m_listTransaction.addItem(trans);
			}
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return ADMIN_RESPONSE_NAME.GET_TRANSACTION_RES;
		}

		public function get listTransaction():ArrayCollection
		{
			return m_listTransaction;
		}


	} 
}