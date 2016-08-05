package controller
{
	import com.greensock.TweenMax;
	
	import spark.components.BorderContainer;
	import spark.components.Image;
	
	import zUtilities.MainController;
	import zUtilities.Resource;

	public class C_Chip
	{
		
		private var m_Chip:BorderContainer = null;
		private var m_cMain:MainController;		
		private var m_chipPrices:Array = null;
		private var m_mResource:Resource;
		
		public function C_Chip()
		{		
			m_cMain = MainController.getInstance();
			m_Chip = new BorderContainer();
			m_mResource = Resource.getInstance();			
			initChipPrices();
		}
		
		public function setChip(amount:Number):void{
			m_cMain.vMain.m_mChipContainer.removeAllElements();
			var arrChip:Array = getChippArray(amount);
			var chipContainer:BorderContainer = _addChip(arrChip);
			m_cMain.vMain.m_mChipContainer.addElement(chipContainer);
		}
		
		public function userBet(x:Number, y:Number, amount:Number):void{
			amount = Math.abs(amount);
			var arrChip:Array = getChippArray(amount);
			for(var i:int = 0; i < arrChip.length; i++){				
				var img:Image = new Image();
				var chip:int = arrChip[i];
				img.source =  m_mResource.getImg("chip_" + chip.toString());
				img.x = x;
				img.y = y;
				img.alpha = 1;
//				img.scaleX = 1;
//				img.scaleY = 1;
				var xN:Number = randomNumber(50,150);
				var yN:Number = randomNumber(10, 50);
				m_cMain.vMain.m_mChipContainer1.addElement(img);
				TweenMax.to(img, 0.6, {x:xN, y:yN});
				TweenMax.delayedCall( 1, function():void{
					img.visible = false;
					m_cMain.vMain.m_mChipContainer1.removeAllElements();
				});
			}			
		}
		
		public function userWin(x:Number, y:Number, amount:Number):void{
			amount = Math.abs(amount);
			var arrChip:Array = getChippArray(amount);
			var chipContainer:BorderContainer = _addChip(arrChip);
			m_cMain.vMain.m_mWinnerContainer.addElement(chipContainer);
			TweenMax.to(chipContainer, 0.8, {x:x, y:y});
			
			TweenMax.delayedCall(1.6, function():void{
				m_cMain.vMain.m_mWinnerContainer.removeAllElements();
			});
		}
		
		private function randomNumber(low:Number=NaN, high:Number=NaN):Number
		{
			var low:Number = low;
			var high:Number = high;
			
			if(isNaN(low))
			{
				throw new Error("low must be defined");
			}
			if(isNaN(high))
			{
				throw new Error("high must be defined");
			}
			
			return Math.round(Math.random() * (high - low)) + low;
		}
		
		private function _addChip(arrChip:Array):BorderContainer{
			var max:int = -1;
			var countChip:int = 0;
			var countChipPT:int = 0;			
			var chipContainer:BorderContainer = new BorderContainer();
			for(var i:int = 0; i < arrChip.length; i++){				
				var img:Image = new Image();
				var chip:int = arrChip[i];
				img.source =  m_mResource.getImg("chip_" + chip.toString());
				if(arrChip[i] != max){
					max = arrChip[i];
					countChipPT = 0;
					countChip++;
				}
				img.x = countChip * 38;
				img.y = countChipPT * 4 * (-1);
				countChipPT++;				
				chipContainer.addElement(img);
			}
			chipContainer.x = 0;
			chipContainer.width = 0;
			chipContainer.height = 0;	
			return chipContainer;
		}
		
		private function getChippArray(amount:Number):Array{
			var arrChip:Array = new Array();
			for(var i:int = 0; i < 18; i++){
				while(amount >= m_chipPrices[i]){
					amount -= m_chipPrices[i];
					arrChip.push(m_chipPrices[i]);
				}
			}
			return arrChip;
		}
		
		private function initChipPrices():void{
			m_chipPrices = new Array();
			m_chipPrices[0] = 1000000;
			m_chipPrices[1] = 500000;
			m_chipPrices[2] = 100000;
			m_chipPrices[3] = 50000;
			m_chipPrices[4] = 25000;
			m_chipPrices[5] = 5000;
			m_chipPrices[6] = 1000;
			m_chipPrices[7] = 500;
			m_chipPrices[8] = 250;
			m_chipPrices[9] = 100;
			m_chipPrices[10] = 25;
			m_chipPrices[11] = 5;
			m_chipPrices[12] = 1;
			m_chipPrices[13] = 0.1;
			m_chipPrices[14] = 0.5;
			m_chipPrices[15] = 0.25;
			m_chipPrices[16] = 0.05;
			m_chipPrices[17] = 0.02;
		}
	}
}