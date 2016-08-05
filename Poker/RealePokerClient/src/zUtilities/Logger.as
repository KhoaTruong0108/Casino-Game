

package zUtilities
{
	import Message.SFSGameEvent;
	import Message.event.general.SFSExceptionEvent;
	
	import com.smartfoxserver.v2.core.SFSEvent;
	
	import controller.C_DebugLog;
	
	import model.M_DebugLog;
	
	import mx.managers.PopUpManager;

	public class Logger
	{
		private var m_cdebugLog: C_DebugLog = new C_DebugLog();
		public function Logger()
		{
			/*PopUpManager.addPopUp(dlgDebug,ViewHolder.vCasinoWeb,false);
			dlgDebug.x = 0;
			dlgDebug.y = 800;
			PopUpManager.bringToFront(dlgDebug);*/
		}
		
		public function Log(message : String):void{
			m_cdebugLog.addText(message);
			trace(message);
		}
		
		public function LogError(err:Error):void{
			m_cdebugLog.addText(err.message);
			m_cdebugLog.addText(err.getStackTrace());
			trace(err);
		}
		
		public function Dump(evt: SFSEvent):void
		{
			m_cdebugLog.addText("Event: " + evt.type);
			m_cdebugLog.addText("---- Param: " +evt.params.toString());
			trace("Event Name: " + evt.type);
			trace(evt.params);
		}
		public function Dump2(evt: SFSGameEvent):void{
			/*dlgDebug.addText("Event: " + evt.GetEventName());*/
		}
	}
}