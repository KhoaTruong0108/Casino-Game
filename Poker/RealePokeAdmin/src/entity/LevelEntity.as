package entity
{
	public class LevelEntity
	{
		private var _id: int;
		private var _level: int;
		private var _levelType: int;
		private var _smallBlind: Number;
		private var _bigBlind: Number;
		private var _ante: Number;
		private var _timeLife: int;
		
		public function LevelEntity()
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

		public function get timeLife():int
		{
			return _timeLife;
		}

		public function set timeLife(value:int):void
		{
			_timeLife = value;
		}

		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}

		public function get levelType():int
		{
			return _levelType;
		}

		public function set levelType(value:int):void
		{
			_levelType = value;
		}


	}
}