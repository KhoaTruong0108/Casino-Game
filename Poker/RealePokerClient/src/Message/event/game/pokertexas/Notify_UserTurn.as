package Message.event.game.pokertexas {

	import Message.SFSGameEvent;
	import Message.event.game.pokertexas.POKER_RESPONSE_NAME;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import mx.collections.ArrayList;

	public class Notify_UserTurn extends SFSGameEvent {

		protected var m_username:String;
		protected var m_bettingChip:Number;
		protected var m_time:int;


		public function Notify_UserTurn() {
			super(POKER_RESPONSE_NAME.USER_TURN_RES);
		}

		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_RESPONSE_NAME.USER_TURN_RES){
				throw new Error("Can't parse from " + sfse.type + " to TURN");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(POKER_RESPONSE_NAME.USER_TURN_RES) as SFSObject;
			if(param == null){
				throw new Error("TURN::FromSFSEvent Error");			
			}
			
			m_username = param.getUtfString("user_name");
			m_bettingChip = param.getDouble("betting_chip");
			m_time = param.getInt("time");
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_RESPONSE_NAME.USER_TURN_RES;
		}

		public function get UserName():String
		{
			return m_username;
		}

		public function set UserName(value:String):void
		{
			m_username = value;
		}

		public function get Time():int
		{
			return m_time;
		}

		public function set Time(value:int):void
		{
			m_time = value;
		}

		public function get BettingChip():Number
		{
			return m_bettingChip;
		}

		
	} // end class
} // end package