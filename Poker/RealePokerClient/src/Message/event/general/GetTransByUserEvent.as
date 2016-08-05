package Message.event.general {

	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.ISFSArray;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import entity.TransactionEntity;
	
	import mx.collections.ArrayCollection;

	public class GetTransByUserEvent extends SFSGameEvent {

		protected var m_listTrans: ArrayCollection;
		
		public function GetTransByUserEvent() {
			super(GENERAL_EVENT_NAME.GET_TRANS_BY_USER_RES);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != GENERAL_EVENT_NAME.GET_TRANS_BY_USER_RES){
				throw new Error("Can't parse from " + sfse.type + " to GetTransByUserEvent");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject)
				.getSFSObject(GENERAL_EVENT_NAME.GET_TRANS_BY_USER_RES) as SFSObject;
			if(param == null){
				throw new Error("GetTransByUserEvent::FromSFSEvent Error");			
			}
			m_listTrans = new ArrayCollection();
			
			var sfsArr: ISFSArray = param.getSFSArray("list_transaction");
			for (var i:int = 0; i < sfsArr.size(); i++) 
			{
				var item: ISFSObject = sfsArr.getSFSObject(i);
				var trans: TransactionEntity = new TransactionEntity();
				trans.userName = item.getUtfString("user_name");
				trans.byAdmin = item.getUtfString("byAdmin");
				trans.date = item.getUtfString("date");
				trans.amount = item.getDouble("amount");
				trans.type = item.getUtfString("type");
				
				m_listTrans.addItem(trans);
			}
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return GENERAL_EVENT_NAME.GET_TRANS_BY_USER_RES;
		}
		

		public function get listTrans():ArrayCollection
		{
			return m_listTrans;
		}

	} // end class
} // end package