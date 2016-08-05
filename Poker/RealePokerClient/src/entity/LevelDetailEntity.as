package entity
{
	public class LevelDetailEntity
	{
		private var _level: int;
		private var _smallBlind: Number;
		private var _bigBlind: Number;
		private var _ante: Number;
		private var _time: int;
		
		public function LevelDetailEntity()
		{
		}


		public function get level():int
		{
			return _level;
		}

		public function set level(value:int):void
		{
			_level = value;
		}

		public function get smallBlind():Number
		{
			return _smallBlind;
		}

		public function set smallBlind(value:Number):void
		{
			_smallBlind = value;
		}

		public function get bigBlind():Number
		{
			return _bigBlind;
		}

		public function set bigBlind(value:Number):void
		{
			_bigBlind = value;
		}

		public function get ante():Number
		{
			return _ante;
		}

		public function set ante(value:Number):void
		{
			_ante = value;
		}

		public function get time():int
		{
			return _time;
		}

		public function set time(value:int):void
		{
			_time = value;
		}


	}
}