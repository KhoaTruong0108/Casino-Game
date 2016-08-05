package Message.event.game.pokertexas {

	import Message.SFSGameEvent;
	import Message.event.game.pokertexas.POKER_RESPONSE_NAME;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import mx.collections.ArrayList;

	public class Notify_LevelTurn extends SFSGameEvent {

		protected var m_level:int;
		protected var m_smallBlind:Number;
		protected var m_bigBlind: Number;
		protected var m_ante: Number;
		protected var m_time:int;


		public function Notify_LevelTurn() {
			super(POKER_RESPONSE_NAME.LEVEL_TURN_RES);
		}

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_RESPONSE_NAME.LEVEL_TURN_RES){
				throw new Error("Can't parse from " + sfse.type + " to PAY_ANTE_RES");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(POKER_RESPONSE_NAME.LEVEL_TURN_RES) as SFSObject;
			if(param == null){
				throw new Error("PAY_ANTE_RES::FromSFSEvent Error");			
			}
			
			m_level = param.getInt("level");
			m_smallBlind = param.getDouble("small_blind");
			m_bigBlind = param.getDouble("big_blind");
			m_ante = param.getDouble("ante");
			m_time = param.getInt("time");
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_RESPONSE_NAME.LEVEL_TURN_RES;
		}

		public function get Time():int
		{
			return m_time;
		}

		public function get level():int
		{
			return m_level;
		}

		public function get smallBlind():Number
		{
			return m_smallBlind;
		}

		public function get bigBlind():Number
		{
			return m_bigBlind;
		}

		public function get ante():Number
		{
			return m_ante;
		}

	} // end class
} // end package