package Message.event.game.pokertexas
{
	import Message.SFSGameEvent;
	import Message.event.game.pokertexas.POKER_RESPONSE_NAME;
	import entity.game_Entity.Desk;
	import entity.game_Entity.ICard;
	import entity.game_Entity.Poker.PokerCardHand;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import de.polygonal.ds.HashMap;
	
	import flash.events.Event;
	
	import mx.collections.ArrayList;

	public class Notify_StandUp extends SFSGameEvent
	{
		private var m_userName: String;

		public function Notify_StandUp()
		{
			super(POKER_RESPONSE_NAME.STAND_UP_RES);
		}
		

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_RESPONSE_NAME.STAND_UP_RES){
				throw new Error("Can't parse from " + sfse.type + " to Notify_StandUp");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(POKER_RESPONSE_NAME.STAND_UP_RES) as SFSObject;
			if(param == null){
				throw new Error("Notify_StandUp::FromSFSEvent Error");			
			}
			
			m_userName = param.getUtfString("user_name");
			return this;
			
		}
		
		
		override public function GetEventName():String
		{
			return POKER_RESPONSE_NAME.STAND_UP_RES;
		}
		
		override public function ToEvent():Event
		{
			return new Event(GetEventName());
		}

		public function get UserName():String
		{
			return m_userName;
		}

	}
}