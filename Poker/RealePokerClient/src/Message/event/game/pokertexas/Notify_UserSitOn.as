package Message.event.game.pokertexas
{
	import Message.SFSGameEvent;
	import Message.event.game.pokertexas.POKER_RESPONSE_NAME;
	import entity.game_Entity.Desk;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import flash.events.Event;
	
	import mx.collections.ArrayList;

	public class Notify_UserSitOn extends SFSGameEvent
	{
		private var m_deskId: int;
		private var m_userName: String;
		private var m_userChip: Number;
		private var m_buyIn: Number;
		private var m_currentUser: String;
		private var m_deskState: String;
		public function Notify_UserSitOn()
		{
			super(POKER_RESPONSE_NAME.USER_SIT_ON_RES);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_RESPONSE_NAME.USER_SIT_ON_RES){
				throw new Error("Can't parse from " + sfse.type + " to Notify_UserSitOn");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(POKER_RESPONSE_NAME.USER_SIT_ON_RES) as SFSObject;
			if(param == null){
				throw new Error("Notify_UserSitOn::FromSFSEvent Error");			
			}
			
			m_deskId = param.getInt("deskID");
			m_userName = param.getUtfString("username");
			m_userChip = param.getDouble("chip");
			m_buyIn = param.getDouble("buy_in");
			m_deskState = param.getUtfString("deskState");
			m_currentUser = param.getUtfString("currentUser");
			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_RESPONSE_NAME.USER_SIT_ON_RES;
		}
		
		override public function ToEvent():Event
		{
			return new Event(GetEventName());
		}

		public function get DeskId():int
		{
			return m_deskId;
		}

		public function set DeskId(value:int):void
		{
			m_deskId = value;
		}

		public function get UserName():String
		{
			return m_userName;
		}

		public function set UserName(value:String):void
		{
			m_userName = value;
		}

		public function get CurrentUser():String
		{
			return m_currentUser;
		}

		public function set CurrentUser(value:String):void
		{
			m_currentUser = value;
		}

		public function get deskState():String
		{
			return m_deskState;
		}

		public function set deskState(value:String):void
		{
			m_deskState = value;
		}

		public function get UserChip():Number
		{
			return m_userChip;
		}

		public function set UserChip(value:Number):void
		{
			m_userChip = value;
		}

		public function get BuyIn():Number
		{
			return m_buyIn;
		}
	}
}