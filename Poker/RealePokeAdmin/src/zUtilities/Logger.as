

package zUtilities
{
	import Message.SFSGameEvent;
	import Message.event.general.SFSExceptionEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	
	import mx.managers.PopUpManager;

	public class Logger
	{
		//protected static var dlgDebug : DebugInfo = new DebugInfo;
		public function Logger()
		{
			/*PopUpManager.addPopUp(dlgDebug,ViewHolder.vCasinoWeb,false);
			dlgDebug.x = 0;
			dlgDebug.y = 800;
			PopUpManager.bringToFront(dlgDebug);*/
		}
		
		public static function Log( message : String):void{
			/*if(ViewHolder.vDebugInfo != null)
				ViewHolder.vDebugInfo.addText(message);
			trace(message);*/
		}
		
		public static function Dump(evt: SFSEvent):void
		{
			/*if(ViewHolder.vDebugInfo != null){
				ViewHolder.vDebugInfo.addText("Event: " + evt.type);
				ViewHolder.vDebugInfo.addText("---- Param: " +evt.params.toString());
			}
			trace("Event Name: " + evt.type);
			trace(evt.params);*/
		}
		public static function Dump2(evt: SFSGameEvent):void{
			/*dlgDebug.addText("Event: " + evt.GetEventName());*/
		}
	}
}