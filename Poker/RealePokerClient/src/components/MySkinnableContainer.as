package components
{
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.elements.TextFlow;
	
	import spark.components.SkinnableContainer;
	import spark.utils.TextFlowUtil;

	public class MySkinnableContainer extends SkinnableContainer
	{
		
		[Bindable]
		public var htmlTextFlow: TextFlow;
		private var iLineCount :int = 0;
		private var text:String;
		
		public function MySkinnableContainer(){
			htmlTextFlow = new TextFlow();
			text = "";
			super();
		}
		
		public function appendText(txt:String):void{
			text += txt;
			var tempFlow : TextFlow;
			tempFlow = TextConverter.importToFlow(text,TextConverter.TEXT_FIELD_HTML_FORMAT);			
			htmlTextFlow = tempFlow;
		}
		
		public function sysMessage(txt:String):void{
			appendText('<p><font color="#FF0000">' + txt + '</font></p>');
		}
		
		public function userMessage(userName:String, txt:String):void{
			txt = txt.split("<").join("&lt");
			var text:String;
			text = '<p><font color="#f68282"><b>' + userName + '</b></font>: ';
			text += '<font color="#f7b5b5">' + txt + '</font></p>';
			appendText(text);
		}

		public function myMessage(userName:String, txt:String):void{
			txt = txt.split("<").join("&lt;");
			var text:String;
			text = '<p><font color="#497af5"><b>' + userName + '</b></font>: ';
			text += '<font color="#98b1f0">' + txt + '</font></p>';
			appendText(text);			
		}
		
		public function clearAll():void{
			text = "";
			appendText("");
		}
		
		//public var fnChangeValueByPage:Function;
	}
}