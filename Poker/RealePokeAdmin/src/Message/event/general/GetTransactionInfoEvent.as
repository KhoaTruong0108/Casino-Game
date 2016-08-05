package Message.event.general {

	import Message.SFSGameEvent;

	public class GetTransactionInfoEvent extends SFSGameEvent {

		public function GetTransactionInfoEvent(type: String, params: Object) {
			super(type, params);
		}

	} // end class
} // end package