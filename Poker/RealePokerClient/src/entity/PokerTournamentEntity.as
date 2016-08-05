package entity
{
	public class PokerTournamentEntity
	{
		private var _name: String;
		private var _displayName: String;
		private var _fee: Number;
		private var _capacity: int;
		private var _playerCount: int;
		private var _status: String;
		private var _startingChip: Number;
		//private var _betChip: Number;
		private var _levelType: int;
		private var _beginLevel: int;
		private var _endLevel: int;
		private var _stakes: String;
		private var _firstPrize: Number;
		private var _secondPrize: Number;
		private var _thirdPrize: Number;
		private var _smallBlind: Number;
		private var _bigBlind: Number;
		
		public function PokerTournamentEntity()
		{
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get fee():Number
		{
			return _fee;
		}

		public function set fee(value:Number):void
		{
			_fee = value;
		}

		public function get capacity():int
		{
			return _capacity;
		}

		public function set capacity(value:int):void
		{
			_capacity = value;
		}

		public function get status():String
		{
			return _status;
		}

		public function set status(value:String):void
		{
			_status = value;
		}

		public function get startingChip():Number
		{
			return _startingChip;
		}

		public function set startingChip(value:Number):void
		{
			_startingChip = value;
		}

		public function get levelType():Number
		{
			return _levelType;
		}
		
		public function set levelType(value:Number):void
		{
			_levelType = value;
		}
		
		public function get firstPrize():Number
		{
			return _firstPrize;
		}

		public function set firstPrize(value:Number):void
		{
			_firstPrize = value;
		}

		public function get secondPrize():Number
		{
			return _secondPrize;
		}

		public function set secondPrize(value:Number):void
		{
			_secondPrize = value;
		}

		public function get thirdPrize():Number
		{
			return _thirdPrize;
		}

		public function set thirdPrize(value:Number):void
		{
			_thirdPrize = value;
		}

		public function get playerCount():int
		{
			return _playerCount;
		}

		public function set playerCount(value:int):void
		{
			_playerCount = value;
		}

		public function get displayName():String
		{
			return _displayName;
		}

		public function set displayName(value:String):void
		{
			_displayName = value;
		}

		public function get beginLevel():int
		{
			return _beginLevel;
		}
		
		public function set beginLevel(value:int):void
		{
			_beginLevel = value;
		}
		
		public function get endLevel():int
		{
			return _endLevel;
		}
		
		public function set endLevel(value:int):void
		{
			_endLevel = value;
		}

		public function get stakes():String
		{
			return _stakes;
		}

		public function set stakes(value:String):void
		{
			_stakes = value;
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


	}
}