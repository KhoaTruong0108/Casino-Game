package Message.event {

	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.entities.User;
	
	import flash.events.Event;

	public class SpectatorToPlayerEvent extends SFSGameEvent {

		protected var m_room:Room;

		protected var m_user:User;

		protected var m_playerID:int;


		public function SpectatorToPlayerEvent() {
			super(SFSEvent.SPECTATOR_TO_PLAYER);
		}

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent {
			m_room = sfse.params.room;
			m_user = sfse.params.user;
			m_playerID = sfse.params.playerID;
			return this;
		}
		
		override public function ToEvent():Event {
			return new Event(GetEventName());
		}
		
		override public function GetEventName(): String{
			return SFSEvent.SPECTATOR_TO_PLAYER;
		}

		public function get Room():Room
		{
			return m_room;
		}

		public function set Room(value:Room):void
		{
			m_room = value;
		}

		public function get User():User
		{
			return m_user;
		}

		public function set User(value:User):void
		{
			m_user = value;
		}

		public function get PlayerID():int
		{
			return m_playerID;
		}

		public function set PlayerID(value:int):void
		{
			m_playerID = value;
		}


	} // end class
} // end package