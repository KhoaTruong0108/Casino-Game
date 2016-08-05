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
	
	public class CreateRes extends SFSGameEvent {
		protected var _message: String; 
		private var _objCreated: String;
		
		public function CreateRes() {
			super(ADMIN_RESPONSE_NAME.CREATE_RES);
		}
		
		override public function FromSFSEvent(sfse:SFSEvent):SFSGameEvent
		{
			if(sfse.type != SFSEvent.EXTENSION_RESPONSE &&
				sfse.params.cmd != ADMIN_RESPONSE_NAME.CREATE_RES){
				throw new Error("Can't parse from " + sfse.type + " to CreateRes");			
			}
			var param : SFSObject = (sfse.params.params as SFSObject)
				.getSFSObject(ADMIN_RESPONSE_NAME.CREATE_RES) as SFSObject;
			if(param == null){
				throw new Error("CreateRes::FromSFSEvent Error");			
			}
			
			_message = param.getUtfString("message");
			_objCreated = param.getUtfString("object_created");
			
			return this;
		}
		
		override public function GetEventName():String
		{
			return ADMIN_RESPONSE_NAME.CREATE_RES;
		}

		public function get Message():String
		{
			return _message;
		}

		public function get ObjCreated():String
		{
			return _objCreated;
		}
	} 
}