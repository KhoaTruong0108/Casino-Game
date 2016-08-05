package Message.event.admin
{
	import Message.SFSGameEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.ISFSArray;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	
	import entity.AdminEntity;
	import entity.UserEntity;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	
	public class UpdateTourStatusRes extends SFSGameEvent {
		protected var _name: String; 
		private var _status: String;
		
		public function UpdateTourStatusRes() {
			super(ADMIN_RESPONSE_NAME.UPDATE_TOUR_STATUS_RES);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != ADMIN_RESPONSE_NAME.UPDATE_TOUR_STATUS_RES){
				throw new Error("Can't parse from " + sfse.type + " to ActiveTourRes");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject)
				.getSFSObject(ADMIN_RESPONSE_NAME.UPDATE_TOUR_STATUS_RES) as SFSObject;
			if(param == null){
				throw new Error("ActiveTourRes::FromSFSEvent Error");			
			}
			
			_name = param.getUtfString("name");
			_status = param.getUtfString("status");
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return ADMIN_RESPONSE_NAME.UPDATE_TOUR_STATUS_RES;
		}

		public function get name():String
		{
			return _name;
		}

		public function get status():String
		{
			return _status;
		}


	} 
}