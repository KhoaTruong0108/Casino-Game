package Message.event {

	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	
	import flash.events.Event;

	public class SpectatorToPlayerErrorEvent extends SFSGameEvent {

		protected var m_errorMessage:String;

		protected var m_errorCode:int;


		public function SpectatorToPlayerErrorEvent() {
			super(SFSEvent.SPECTATOR_TO_PLAYER_ERROR);
		}
	
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent {
			m_errorMessage = sfse.params.errorMessage;
			m_errorCode = sfse.params.errorCode;
			return this;
		}
		
		override public function ToEvent():Event {
			return new Event(GetEventName());
		}
		
		override public function GetEventName(): String{
			return SFSEvent.SPECTATOR_TO_PLAYER_ERROR;
		}

	} // end class
} // end package