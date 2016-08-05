package Message.event.game.PokerTournament
{
	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import mx.collections.ArrayList;

	public class GetDetailTourRes extends SFSGameEvent
	{
		private var _Name: String;
		private var _displayName: String;
		private var _Capacity: int;
		private var _numRegister: int;//number of user registed
		private var _betChip: Number;
		private var _fee: Number;
		private var _startingChip: Number;
		private var _Status: String;
		private var _firstPrize: Number;
		private var _secondPrize: Number;
		private var _thirdPrize: Number;
		private var _listRegister: ArrayList;		
		
		public function GetDetailTourRes() {
			super(POKER_TOUR_RESPONSE_NAME.GET_DETAIL_TOUR);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != POKER_TOUR_RESPONSE_NAME.GET_DETAIL_TOUR){
				throw new Error("Can't parse from " + sfse.type + " to GET_DETAIL_TOUR");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject).getSFSObject(POKER_TOUR_RESPONSE_NAME.GET_DETAIL_TOUR) as SFSObject;
			if(param == null){
				throw new Error("GET_DETAIL_TOUR::FromSFSEvent Error");			
			}
			
			_Name = param.getUtfString("name");
			_displayName = param.getUtfString("display_name");
			_Capacity = param.getInt("capacity");
			_numRegister = param.getInt("register");
			_betChip = param.getDouble("bet_chip");
			_fee = param.getDouble("fee");
			_startingChip = param.getDouble("starting_chip");
			_Status = param.getUtfString("status");
			_firstPrize = param.getDouble("first_prize");
			_secondPrize = param.getDouble("second_prize");
			_thirdPrize = param.getDouble("third_prize");
			
			_listRegister = new ArrayList();
			var sfsListRegister: SFSArray = param.getSFSArray("list_register") as SFSArray;
			for(var i: int = 0; i< sfsListRegister.size(); i++){
				_listRegister.addItem(sfsListRegister.getUtfString(i));
			}
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return POKER_TOUR_RESPONSE_NAME.GET_DETAIL_TOUR;
		}

		public function get Name():String
		{
			return _Name;
		}

		public function get Capacity():int
		{
			return _Capacity;
		}

		public function get NumRegister():int
		{
			return _numRegister;
		}

		public function get Status():String
		{
			return _Status;
		}

		public function get FirstPrize():Number
		{
			return _firstPrize;
		}

		public function get SecondPrize():Number
		{
			return _secondPrize;
		}

		public function get ThirdPrize():Number
		{
			return _thirdPrize;
		}

		public function get ListRegister():ArrayList
		{
			return _listRegister;
		}

		public function get BetChip():Number
		{
			return _betChip;
		}

		public function get Fee():Number
		{
			return _fee;
		}

		public function get StartingChip():Number
		{
			return _startingChip;
		}

		public function get displayName():String
		{
			return _displayName;
		}

		public function set displayName(value:String):void
		{
			_displayName = value;
		}


	}
}