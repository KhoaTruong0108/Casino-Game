package Message.event.game.pokertexas {

	import Message.SFSGameEvent;
	import Message.event.game.pokertexas.POKER_RESPONSE_NAME;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import flash.events.Event;

	public class Notify_PreStart extends SFSGameEvent {

		protected var m_isPrestart: Boolean;
		protected var m_time:int;

		public function Notify_PreStart() {
			super(POKER_RESPONSE_NAME.PRE_START); 
		}

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_RESPONSE_NAME.PRE_START){
				throw new Error("Can't parse from " + sfse.type + " to Notify_PreStart");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(POKER_RESPONSE_NAME.PRE_START) as SFSObject;
			if(param == null){
				throw new Error("Notify_PreStart::FromSFSEvent Error");			
			}
			
			m_isPrestart = param.getBool("is_prestart");
			m_time = param.getInt("time");
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_RESPONSE_NAME.PRE_START;
		}

		public function get Time():int
		{
			return m_time;
		}

		public function set Time(value:int):void
		{
			m_time = value;
		}

		public function get IsPrestart():Boolean
		{
			return m_isPrestart;
		}

		public function set IsPrestart(value:Boolean):void
		{
			m_isPrestart = value;
		}
		
		
	} // end class
} // end package