package zUtilities
{
	import mx.core.SoundAsset;

	public class SoundController
	{
		public function SoundController()
		{
		}
		
		public static function playSound(soundId: String):void{
			var snd:SoundAsset = Resource.getInstance().getSound(soundId); 
			if(snd != null){
				snd.play();
			}
		}
	}
}