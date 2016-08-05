package controller
{
	import Message.request.game.pokertexas.CallRequest;
	import Message.request.game.pokertexas.FoldRequest;
	import Message.request.game.pokertexas.GoingAllInRequest;
	import Message.request.game.pokertexas.RaiseRequest;
	
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.requests.ExtensionRequest;
	import com.smartfoxserver.v2.requests.buddylist.SetBuddyVariablesRequest;
	
	import flash.events.Event;
	
	import model.M_BetBoard;
	import model.M_Game;
	
	import params.RequestParams;
	import params.RoomVarParams;
	
	import zUtilities.NumberFormat;
	import zUtilities.ServerController;

	public class C_BetBoard
	{
		private var m_mBetBoard:M_BetBoard = M_BetBoard.getInstance();
		private var m_server:ServerController = ServerController.getInstance();
		
		public function C_BetBoard()
		{
		}
		
		public function showBetBoard():void{
			m_mBetBoard.setVisibled(true);
		}
		
		public function hideBetBoard():void{
			m_mBetBoard.isVisibled = false;			
		}
		
		
		/***************** HANDLE GUI EVENT *******************/
		public function handleBtnCheck_click(event:Event):void{
			// send message CHECK to server
			/*sendBetMessage(RequestParams.USER_BET_CHECK);*/
			handleCallRequest();
			hideBetBoard();
		}
		
		public function handleBtnFold_click(event:Event):void{
			// send message FOLD to server
			/*sendBetMessage(RequestParams.USER_BET_FOLD);*/
			handleFoldRequest();
			hideBetBoard();
		}
		
		public function handleBtnRaise_click(event:Event):void{
			// send message RAISE,amount to server
			/*sendBetMessage(RequestParams.USER_BET_RAISE, m_mBetBoard.getRaise());*/
			handleRaiseRequest(m_mBetBoard.getRaise());
			hideBetBoard();
		}
		
		public function handleBtnShowHand_click(event:Event):void{
			// send message SHOW_HAND to server
			/*sendBetMessage(RequestParams.USER_BET_SHOW_HAND);*/
			handleGoingAllInRequest();
			hideBetBoard();
		}
		public function HandleRaise2_3_Pot(event: Event):void{
			var mGame : M_Game = M_Game.getInstance();
			var strPotValue: String = mGame.strPot.substring(1);			
			strPotValue = strPotValue.replace(",", "");
			var pot : Number = parseFloat(strPotValue);
			if( isNaN( pot) )
				return;
			// 12.567 = 12.6
			var raise : Number =  (2*pot)/3;
			//raise = NumberFormat.RoundNumber(raise);	
			raise = Math.round(raise);
			handleRaiseRequest(raise);
			hideBetBoard();
		}
		public function HandleRaise1_2_Pot(event: Event):void{
			var mGame : M_Game = M_Game.getInstance();
			var strPotValue: String = mGame.strPot.substring(1);	
			strPotValue = strPotValue.replace(",", "");
			var pot : Number = parseFloat(strPotValue);
			if( isNaN( pot) )
				return;
			// 12.567 = 12.6
			var raise : Number =  pot/2;
			//raise = NumberFormat.RoundNumber(raise);
			raise = Math.round(raise);
			handleRaiseRequest(raise);
			hideBetBoard();
		}
		public function HandleRaise1_Pot(evt: Event):void{
			var mGame : M_Game = M_Game.getInstance();
			
			var strPotValue: String = mGame.strPot.substring(1);			
			strPotValue = strPotValue.replace(",", "");
			var pot : Number = parseFloat(strPotValue);
			if( isNaN( pot) )
				return;
			// 12.567 = 12.6
			var raise : Number =  pot;
			raise = NumberFormat.RoundNumber(raise);			
			/*sendBetMessage(RequestParams.USER_BET_RAISE, raise );*/
			handleRaiseRequest(raise);
			hideBetBoard();
		}
		/***************** END HANDLE GUI EVENT *******************/
		
		public function handleRaiseRequest(chip: Number):void{
			try{
				//if(chip > 0){
					var request: RaiseRequest = new RaiseRequest();
					request.AddParam(RaiseRequest.BET_CHIP, chip);
					m_server.SendCustomRequest(request);
				/*}else{
					handleCallRequest();
				}*/
			}catch(error: Error){
			}
		}
		public function handleCallRequest():void{
			try{
				var request: CallRequest = new CallRequest();
				m_server.SendCustomRequest(request);
			}catch(error: Error){
			}
		}
		public function handleGoingAllInRequest():void{
			try{
				var request: GoingAllInRequest = new GoingAllInRequest();
				m_server.SendCustomRequest(request);
			}catch(error: Error){
			}
		}
		public function handleFoldRequest():void{
			try{
				var request: FoldRequest = new FoldRequest();
				m_server.SendCustomRequest(request);
			}catch(error: Error){
			}
		}
		
		private function sendBetMessage(type:String, amount:Number = 0):void{
			/*var param:ISFSObject = new SFSObject();
			param.putUtfString(RequestParams.BET_TYPE, type);
			param.putDouble(RequestParams.RAISE_AMOUNT, amount);
			param.putUtfString(RoomVarParams.NAME, m_globalVar.curTable.name);
			m_server.sendRequest(new ExtensionRequest(CustomRequest.USER_BET, param));
			m_mBetBoard.strRaiseValue = "";*/
		}
	}
}