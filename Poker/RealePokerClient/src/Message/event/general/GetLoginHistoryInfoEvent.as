package Message.event.general {

	import Message.SFSGameEvent;

	public class GetLoginHistoryInfoEvent extends SFSGameEvent {

		public function GetLoginHistoryInfoEvent(type: String, params: Object) {
			super(type, params);
		}

	} // end class
} // end package