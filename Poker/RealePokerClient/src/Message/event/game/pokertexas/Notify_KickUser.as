package Message.event.game.pokertexas {

	import Message.SFSGameEvent;
	import Message.event.game.pokertexas.POKER_RESPONSE_NAME;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import mx.collections.ArrayList;

	public class Notify_KickUser extends SFSGameEvent {
		//Notify_KickUser is used in 2 cases:
		//	1: user not ready in prestart game.
		//	2: user don't have enought money to play game.(after finish game).
		
		protected var m_resType: int; //1, 2
		
		public function Notify_KickUser() {
			super(POKER_RESPONSE_NAME.KICK_USER_RES);
		}

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_RESPONSE_NAME.KICK_USER_RES){
				throw new Error("Can't parse from " + sfse.type + " to Notify_KickUser");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject)
				.getSFSObject(POKER_RESPONSE_NAME.KICK_USER_RES) as SFSObject;
			if(param == null){
				throw new Error("Notify_KickUser::FromSFSEvent Error");			
			}
			m_resType = param.getInt("response_type");
			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_RESPONSE_NAME.KICK_USER_RES;
		}

		public function get ResponseType():int
		{
			return m_resType;
		}

		public function set ResponseType(value:int):void
		{
			m_resType = value;
		}


	} // end class
} // end package