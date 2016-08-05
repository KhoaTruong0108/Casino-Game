package Message.event.game.pokertexas
{
	import Message.SFSGameEvent;
	import Message.event.game.pokertexas.POKER_RESPONSE_NAME;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import entity.game_Entity.Desk;
	
	import flash.events.Event;
	
	import mx.collections.ArrayList;

	public class Notify_UserSitOut extends SFSGameEvent
	{
		private var m_userName: String;
		private var m_isSitOut: Boolean;
		
		public function Notify_UserSitOut()
		{
			super(POKER_RESPONSE_NAME.USER_SIT_OUT_RES);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_RESPONSE_NAME.USER_SIT_OUT_RES){
				throw new Error("Can't parse from " + sfse.type + " to Notify_UserSitOut");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(POKER_RESPONSE_NAME.USER_SIT_OUT_RES) as SFSObject;
			if(param == null){
				throw new Error("Notify_UserSitOut::FromSFSEvent Error");			
			}
			
			m_userName = param.getUtfString("user_name");
			m_isSitOut = param.getBool("is_sit_out");
			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_RESPONSE_NAME.USER_SIT_OUT_RES;
		}
		
		override public function ToEvent():Event
		{
			return new Event(GetEventName());
		}

		public function get UserName():String
		{
			return m_userName;
		}

		public function get isSitOut():Boolean
		{
			return m_isSitOut;
		}


	}
}