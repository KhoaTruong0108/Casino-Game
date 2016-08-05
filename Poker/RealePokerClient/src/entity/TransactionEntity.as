package entity {
	
	public class TransactionEntity {

		protected var m_userName: String;
		protected var m_amount: Number;
		protected var m_byAdmin: String;
		protected var m_type: String;
		protected var m_date: String;
		
		public function TransactionEntity() {
		}


		public function get userName():String
		{
			return m_userName;
		}

		public function set userName(value:String):void
		{
			m_userName = value;
		}

		public function get byAdmin():String
		{
			return m_byAdmin;
		}

		public function set byAdmin(value:String):void
		{
			m_byAdmin = value;
		}

		public function get type():String
		{
			return m_type;
		}

		public function set type(value:String):void
		{
			m_type = value;
		}

		public function get date():String
		{
			return m_date;
		}

		public function set date(value:String):void
		{
			m_date = value;
		}

		public function get amount():Number
		{
			return m_amount;
		}

		public function set amount(value:Number):void
		{
			m_amount = value;
		}

		
	} // end class
} // end package