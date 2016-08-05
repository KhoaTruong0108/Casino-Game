package entity.game_Entity
{
	import entity.UserEntity;
	
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSObject;

	public class Desk
	{
		protected var m_iDeskId: int;
		protected var m_deskState: String;
		protected var m_userName: String;
		protected var m_userChip: Number;
		protected var m_userAvatar: String;
		
		protected var m_totalBetChip: Number;
		
		public function Desk()
		{
			
		}
		
		
		public function get UserAvatar():String
		{
			return m_userAvatar;
		}

		public function set UserAvatar(value:String):void
		{
			m_userAvatar = value;
		}

		public function get UserChip():Number
		{
			return m_userChip;
		}

		public function set UserChip(value:Number):void
		{
			m_userChip = value;
		}

		public function get UserName():String
		{
			return m_userName;
		}

		public function set UserName(value:String):void
		{
			m_userName = value;
		}

		public function get DeskId():int
		{
			return m_iDeskId;
		}

		public function set DeskId(value:int):void
		{
			m_iDeskId = value;
		}

		public function get DeskState():String
		{
			return m_deskState;
		}

		public function set DeskState(value:String):void
		{
			m_deskState = value;
		}

		public function get deskState():String
		{
			return m_deskState;
		}

		public function set deskState(value:String):void
		{
			m_deskState = value;
		}

		public function get TotalBetChip():Number
		{
			return m_totalBetChip;
		}

		public function set TotalBetChip(value:Number):void
		{
			m_totalBetChip = value;
		}


	}
}