package Message.event.game.pokertexas {

	import Message.SFSGameEvent;
	import Message.event.game.pokertexas.POKER_RESPONSE_NAME;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import mx.collections.ArrayList;

	public class Notify_PayAnte extends SFSGameEvent {

		protected var m_ante: Number;
		protected var m_listUser:ArrayList;


		public function Notify_PayAnte() {
			super(POKER_RESPONSE_NAME.PAY_ANTE_RES);
		}

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_RESPONSE_NAME.PAY_ANTE_RES){
				throw new Error("Can't parse from " + sfse.type + " to PAY_ANTE_RES");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(POKER_RESPONSE_NAME.PAY_ANTE_RES) as SFSObject;
			if(param == null){
				throw new Error("PAY_ANTE_RES::FromSFSEvent Error");			
			}
			
			m_ante = param.getDouble("ante");
			
			m_listUser = new ArrayList();
			var sfsUsers: SFSArray = param.getSFSArray("list_user") as SFSArray;
			for(var j: int = 0; j < sfsUsers.size(); j++){
				m_listUser.addItem(sfsUsers.getUtfString(j));
			}
			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_RESPONSE_NAME.PAY_ANTE_RES;
		}

		public function get ante():Number
		{
			return m_ante;
		}

		public function get listUser():ArrayList
		{
			return m_listUser;
		}

		
	} // end class
} // end package