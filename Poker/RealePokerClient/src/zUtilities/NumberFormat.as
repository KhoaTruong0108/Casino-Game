package zUtilities
{
	import Configuration.config;
	
	import com.smartfoxserver.v2.requests.PublicMessageRequest;

	public class NumberFormat
	{
		private static function getDecimalFormat1(coin:Number):String{
			var retVal:String = "";
			var strCoin:String = coin.toString();
			if(coin < 100){
				retVal = config.CURRENCY + "0." + strCoin;
				return retVal;
			}
			retVal = "." + strCoin.charAt(strCoin.length - 2) + strCoin.charAt(strCoin.length - 1);
			var count:int = 0;
			for(var i:int = strCoin.length - 3; i >= 0; i--){
				if(count == 3){
					retVal = "," + retVal;
					count = 0;
				}
				retVal = strCoin.charAt(i) + retVal; 
				count++;
			}
			retVal = config.CURRENCY + retVal;
			return retVal;
		}
		
		public static function getNumber(coin:String):Number{
			if(Boolean(coin) == false){
				return 0;
			}
			return Number(coin.replace(config.CURRENCY,"").replace(",",""));
		}
		
		public static function getDecimalFormat(coin:Number):String{
			var retVal:String = "";
			
//			if(coin < 1000){
//				return "€" + coin.toString();
//			}
			var arrCoin:Array = coin.toString().split('.');
			var strCoin:String = arrCoin[0];			
			if(arrCoin.length == 2){
				var strNum:String = arrCoin[1];
				retVal = "." + strNum.substr(0, 2);
			}
			var count:int = 0;
			for(var i:int = strCoin.length - 1; i >= 0; i--){
				if(count == 3){
					retVal = "," + retVal;
					count = 0;
				}
				retVal = strCoin.charAt(i) + retVal; 
				count++;
			}
			return config.CURRENCY + retVal;
		}
		
		public static function getShortDecimal(coin:int):String{
			var retVal:String = "";
			if(coin >= 1000 && coin < 1000000){
				retVal = coin / 1000 + "K";
			}
			else if(coin >= 1000000){
				retVal = coin / 1000000 + "M" 
			}
			else{
				retVal = coin.toString();
			}
			return retVal;
		}
		
		public static function getFormatDate(lDate:Number):String{
			var date_create:Date = new Date();
			date_create.time = lDate;
			return date_create.getFullYear() + "/" + (date_create.getMonth() + 1) + "/" + date_create.getDate();
		}
		public static function RoundNumber(value: Number): Number{
			if(isNaN(value))
				return value;
			var temp : Number = int( value*10 ) / 10;
			return temp;
		}
	}
}