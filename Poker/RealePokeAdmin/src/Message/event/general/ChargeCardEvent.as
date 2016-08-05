package Message.event.general
{
	import Message.SFSGameEvent;
	import Message.request.general.ChargeCardRequest;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import flash.events.Event;

	public class ChargeCardEvent extends SFSGameEvent
	{
		public static var RESULT: String = "result";
		public static var GAME_CHIP: String = "game_chip";
		public static var MESAGE: String = "mesage";
		
		protected var m_result: Boolean;
		protected var m_gameChip: Number;
		protected var m_messageCharge: String;
		
		public function ChargeCardEvent()
		{
			super(GENERAL_EVENT_NAME.CHARGE_CARD_RES);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != GENERAL_EVENT_NAME.CHARGE_CARD_RES){
				throw new Error("Can't parse from " + sfse.type + " to GetTopWinnerEvent");			
			}
			var param : SFSObject = sfse.params.params as SFSObject;
			if(param == null){
				throw new Error("GetTopWinnerEvent::FromSFSEvent Error");			
			}
			m_result = param.getBool(RESULT);
			m_gameChip = param.getDouble(GAME_CHIP);
			m_messageCharge = param.getUtfString(MESAGE);
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return GENERAL_EVENT_NAME.CHARGE_CARD_RES;
		}
		
		override public function ToEvent():Event
		{
			return new Event(GetEventName());
		}

		public function get Result():Boolean
		{
			return m_result;
		}

		public function get GameChip():Number
		{
			return m_gameChip;
		}

		public function get MessageCharge():String
		{
			return m_messageCharge;
		}

	}
}