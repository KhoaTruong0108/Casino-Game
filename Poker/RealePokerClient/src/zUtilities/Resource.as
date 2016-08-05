package zUtilities
{
	import Enum.PokerActionType;
	
	import entity.game_Entity.Poker.PokerHandType;
	
	import flash.utils.Dictionary;
	
	import mx.core.SoundAsset;
	
	import params.ResponseParams;

	public class Resource
	{
		private static var m_instance:Resource = null;
		private static var m_isAllowed:Boolean = false;
		
		
		[Embed(source="/assets/sound/bet.mp3")]
		private var sound_bet:Class;
		[Embed(source="/assets/sound/fold.mp3")]
		private var sound_Fold:Class;
		[Embed(source="/assets/sound/loose.mp3")]
		private var sound_loose:Class;
		[Embed(source="/assets/sound/throw-chip.mp3")]
		private var sound_throwChip:Class;
		[Embed(source="/assets/sound/time-over.mp3")]
		private var sound_timeOver:Class;
		[Embed(source="/assets/sound/get-chip.mp3")]
		private var sound_getChip:Class;
		[Embed(source="/assets/sound/Bai_thuvo.mp3")]
		private var sound_dealCard:Class;
		
		private function initAssetsSound():void{
			m_sound = new Dictionary();
			
			m_sound["user_bet"] = sound_bet;
			m_sound["user_fold"] = sound_Fold;
			m_sound["user_loose"] = sound_loose;
			m_sound["throw_chip"] = sound_throwChip;
			m_sound["time_over"] = sound_timeOver;
			m_sound["get_chip"] = sound_getChip;
			m_sound["deal_card"] = sound_dealCard;
		}
		
		public function getSound(sound:String):SoundAsset{
			var snd:SoundAsset = new m_sound[sound]() as SoundAsset;
			return snd;
		}
		
		[Embed(source="/assets/images/labai/999.png")]
		private var labai999:Class;
		
		[Embed(source="assets/images/labai/20.png")]
		private var labai20:Class;
		[Embed(source="/assets/images/labai/21.png")]
		private var labai21:Class;
		[Embed(source="/assets/images/labai/22.png")]
		private var labai22:Class;
		[Embed(source="/assets/images/labai/23.png")]
		private var labai23:Class;
		
		[Embed(source="/assets/images/labai/30.png")]
		private var labai30:Class;
		[Embed(source="/assets/images/labai/31.png")]
		private var labai31:Class;
		[Embed(source="/assets/images/labai/32.png")]
		private var labai32:Class;
		[Embed(source="/assets/images/labai/33.png")]
		private var labai33:Class;
		
		[Embed(source="/assets/images/labai/40.png")]
		private var labai40:Class;
		[Embed(source="/assets/images/labai/41.png")]
		private var labai41:Class;
		[Embed(source="/assets/images/labai/42.png")]
		private var labai42:Class;
		[Embed(source="/assets/images/labai/43.png")]
		private var labai43:Class;
		
		[Embed(source="/assets/images/labai/50.png")]
		private var labai50:Class;
		[Embed(source="/assets/images/labai/51.png")]
		private var labai51:Class;
		[Embed(source="/assets/images/labai/52.png")]
		private var labai52:Class;
		[Embed(source="/assets/images/labai/53.png")]
		private var labai53:Class;
		
		[Embed(source="/assets/images/labai/60.png")]
		private var labai60:Class;
		[Embed(source="/assets/images/labai/61.png")]
		private var labai61:Class;
		[Embed(source="/assets/images/labai/62.png")]
		private var labai62:Class;
		[Embed(source="/assets/images/labai/63.png")]
		private var labai63:Class;
		
		[Embed(source="/assets/images/labai/70.png")]
		private var labai70:Class;
		[Embed(source="/assets/images/labai/71.png")]
		private var labai71:Class;
		[Embed(source="/assets/images/labai/72.png")]
		private var labai72:Class;
		[Embed(source="/assets/images/labai/73.png")]
		private var labai73:Class;
		
		[Embed(source="/assets/images/labai/80.png")]
		private var labai80:Class;
		[Embed(source="/assets/images/labai/81.png")]
		private var labai81:Class;
		[Embed(source="/assets/images/labai/82.png")]
		private var labai82:Class;
		[Embed(source="/assets/images/labai/83.png")]
		private var labai83:Class;
		
		[Embed(source="/assets/images/labai/90.png")]
		private var labai90:Class;
		[Embed(source="/assets/images/labai/91.png")]
		private var labai91:Class;
		[Embed(source="/assets/images/labai/92.png")]
		private var labai92:Class;
		[Embed(source="/assets/images/labai/93.png")]
		private var labai93:Class;
		
		[Embed(source="/assets/images/labai/100.png")]
		private var labai100:Class;
		[Embed(source="/assets/images/labai/101.png")]
		private var labai101:Class;
		[Embed(source="/assets/images/labai/102.png")]
		private var labai102:Class;
		[Embed(source="/assets/images/labai/103.png")]
		private var labai103:Class;
		
		[Embed(source="/assets/images/labai/110.png")]
		private var labai110:Class;
		[Embed(source="/assets/images/labai/111.png")]
		private var labai111:Class;
		[Embed(source="/assets/images/labai/112.png")]
		private var labai112:Class;
		[Embed(source="/assets/images/labai/113.png")]
		private var labai113:Class;
		
		[Embed(source="/assets/images/labai/120.png")]
		private var labai120:Class;
		[Embed(source="/assets/images/labai/121.png")]
		private var labai121:Class;
		[Embed(source="/assets/images/labai/122.png")]
		private var labai122:Class;
		[Embed(source="/assets/images/labai/123.png")]
		private var labai123:Class;
		
		[Embed(source="/assets/images/labai/130.png")]
		private var labai130:Class;
		[Embed(source="/assets/images/labai/131.png")]
		private var labai131:Class;
		[Embed(source="/assets/images/labai/132.png")]
		private var labai132:Class;
		[Embed(source="/assets/images/labai/133.png")]
		private var labai133:Class;
		
		[Embed(source="/assets/images/labai/140.png")]
		private var labai140:Class;
		[Embed(source="/assets/images/labai/141.png")]
		private var labai141:Class;
		[Embed(source="/assets/images/labai/142.png")]
		private var labai142:Class;
		[Embed(source="/assets/images/labai/143.png")]
		private var labai143:Class;
		
		[Embed(source="/assets/images/result/win.swf")]
		private var swfWin:Class;
		[Embed(source="/assets/images/result/lose.swf")]
		private var swfLose:Class;
		[Embed(source="/assets/images/result/fold.swf")]
		private var swfFold:Class;
		[Embed(source="/assets/images/result/show_hand.swf")]
		private var swfShowHand:Class;

		[Embed(source="/assets/images/result/high_card.png")]
		private var imgHighCard:Class;
		[Embed(source="/assets/images/result/pair.png")]
		private var imgPair:Class;
		[Embed(source="/assets/images/result/two_pair.png")]
		private var imgTwoPair:Class;
		[Embed(source="/assets/images/result/three_of_a_kind.png")]
		private var imgThreeOfAKind:Class;
		[Embed(source="/assets/images/result/straight.png")]
		private var imgStraight:Class;
		[Embed(source="/assets/images/result/flush.png")]
		private var imgFlush:Class;
		[Embed(source="/assets/images/result/full_house.png")]
		private var imgFullHouse:Class;
		[Embed(source="/assets/images/result/four_of_a_kind.png")]
		private var imgFourOfAKind:Class;
		[Embed(source="/assets/images/result/straight_flush.png")]
		private var imgStraightFlush:Class;
		[Embed(source="/assets/images/result/royal_flush.png")]
		private var imgRoyalFlush:Class;

		[Embed(source="/assets/images/table/tick_ready.png")]
		private var tickReady:Class;
		
		[Embed(source="/assets/images/chip/chip_001.png")]
		private var chip_001:Class;
		[Embed(source="/assets/images/chip/chip_005.png")]
		private var chip_005:Class;
		[Embed(source="/assets/images/chip/chip_1.png")]
		private var chip_1:Class;
		[Embed(source="/assets/images/chip/chip_1m.png")]
		private var chip_1m:Class;
		[Embed(source="/assets/images/chip/chip_05.png")]
		private var chip_05:Class;
		[Embed(source="/assets/images/chip/chip_5.png")]
		private var chip_5:Class;
		[Embed(source="/assets/images/chip/chip_010.png")]
		private var chip_01:Class;
		[Embed(source="/assets/images/chip/chip_025.png")]
		private var chip_025:Class;
		[Embed(source="/assets/images/chip/chip_25.png")]
		private var chip_25:Class;
		[Embed(source="/assets/images/chip/chip_25k.png")]
		private var chip_25k:Class;
		[Embed(source="/assets/images/chip/chip_50k.png")]
		private var chip_50k:Class;
		[Embed(source="/assets/images/chip/chip_100.png")]
		private var chip_100:Class;
		[Embed(source="/assets/images/chip/chip_100k.png")]
		private var chip_100k:Class;
		[Embed(source="/assets/images/chip/chip_250.png")]
		private var chip_250:Class;
		[Embed(source="/assets/images/chip/chip_500.png")]
		private var chip_500:Class;
		[Embed(source="/assets/images/chip/chip_500k.png")]
		private var chip_500k:Class;
		[Embed(source="/assets/images/chip/chip_1k.png")]
		private var chip_1k:Class;
		[Embed(source="/assets/images/chip/chip_5k.png")]
		private var chip_5k:Class;
		
		
		private var m_cardImg:Dictionary;
		private var m_sound:Dictionary;
		
		public function Resource(){
			if(m_isAllowed == false){
				throw new Error("Cannot create an instance of a singleton class!");
			}
			initAssetsImg();
			initAssetsSound();
		}
		
		public static function getInstance():Resource{
			if(m_instance == null){
				m_isAllowed = true;
				m_instance = new Resource();
				m_isAllowed = false;
			}
			return m_instance;
		}
		
		public function getImg(card:String):Class{
			return m_cardImg[card];
		}
		
		/*private function initAssetsImg():void{
			m_cardImg = new Dictionary();
			
			m_cardImg["999"] = labai999;
			
			m_cardImg["20"] = labai20;
			m_cardImg["21"] = labai21;
			m_cardImg["22"] = labai22;
			m_cardImg["23"] = labai23;
			
			m_cardImg["30"] = labai30;
			m_cardImg["31"] = labai31;
			m_cardImg["32"] = labai32;
			m_cardImg["33"] = labai33;
			
			m_cardImg["40"] = labai40;
			m_cardImg["41"] = labai41;
			m_cardImg["42"] = labai42;
			m_cardImg["43"] = labai43;
			
			m_cardImg["50"] = labai50;
			m_cardImg["51"] = labai51;
			m_cardImg["52"] = labai52;
			m_cardImg["53"] = labai53;
			
			m_cardImg["60"] = labai60;
			m_cardImg["61"] = labai61;
			m_cardImg["62"] = labai62;
			m_cardImg["63"] = labai63;
			
			m_cardImg["70"] = labai70;
			m_cardImg["71"] = labai71;
			m_cardImg["72"] = labai72;
			m_cardImg["73"] = labai73;
			
			m_cardImg["80"] = labai80;
			m_cardImg["81"] = labai81;
			m_cardImg["82"] = labai82;
			m_cardImg["83"] = labai83;
			
			m_cardImg["90"] = labai90;
			m_cardImg["91"] = labai91;
			m_cardImg["92"] = labai92;
			m_cardImg["93"] = labai93;
			
			m_cardImg["100"] = labai100;
			m_cardImg["101"] = labai101;
			m_cardImg["102"] = labai102;
			m_cardImg["103"] = labai103;
			
			m_cardImg["110"] = labai110;
			m_cardImg["111"] = labai111;
			m_cardImg["112"] = labai112;
			m_cardImg["113"] = labai113;
			
			m_cardImg["120"] = labai120;
			m_cardImg["121"] = labai121;
			m_cardImg["122"] = labai122;
			m_cardImg["123"] = labai123;
			
			m_cardImg["130"] = labai130;
			m_cardImg["131"] = labai131;
			m_cardImg["132"] = labai132;
			m_cardImg["133"] = labai133;
			
			m_cardImg["140"] = labai140;
			m_cardImg["141"] = labai141;
			m_cardImg["142"] = labai142;
			m_cardImg["143"] = labai143;
			
			m_cardImg["win"] = swfWin;
			m_cardImg["lose"] = swfLose;
			m_cardImg["tickReady"] = tickReady;
			
			m_cardImg[ResponseParams.USER_BET_FOLD] = swfFold;
			m_cardImg[ResponseParams.USER_BET_SHOW_HAND] = swfShowHand;
			
			m_cardImg[PokerHandType.PH_HIGH_CARD] = imgHighCard;
			m_cardImg[PokerHandType.PH_ONE_PAIR] = imgPair;
			m_cardImg[PokerHandType.PH_TWO_PAIR] = imgTwoPair;
			m_cardImg[PokerHandType.PH_THREE_OF_A_KIND] = imgThreeOfAKind;
			m_cardImg[PokerHandType.PH_STRAIGHT] = imgStraight;
			m_cardImg[PokerHandType.PH_FLUSH] = imgFlush;
			m_cardImg[PokerHandType.PH_FULL_HOUSE] = imgFullHouse;
			m_cardImg[PokerHandType.PH_FOUR_OF_A_KIND] = imgFourOfAKind;
			m_cardImg[PokerHandType.PH_STRAIGHT_FLUSH] = imgStraightFlush;
			m_cardImg[PokerHandType.PH_ROYAL_FLUSH] = imgRoyalFlush;
			
			m_cardImg["chip_1000000"] = chip_1m;
			m_cardImg["chip_500000"] = chip_500k;
			m_cardImg["chip_100000"] = chip_100k;
			m_cardImg["chip_50000"] = chip_50k;
			m_cardImg["chip_25000"] = chip_25k;
			m_cardImg["chip_5000"] = chip_5k;
			m_cardImg["chip_1000"] = chip_1k;
			m_cardImg["chip_500"] = chip_500;
			m_cardImg["chip_250"] = chip_250;
			m_cardImg["chip_100"] = chip_100;
			m_cardImg["chip_25"] = chip_25;
			m_cardImg["chip_5"] = chip_5;
			m_cardImg["chip_1"] = chip_1;
			m_cardImg["chip_0.1"] = chip_01;
			m_cardImg["chip_0.5"] = chip_05;
			m_cardImg["chip_0.25"] = chip_025;
			m_cardImg["chip_0.05"] = chip_005;
			m_cardImg["chip_0.01"] = chip_001;			
		}
	}*/
		private function initAssetsImg():void{
			m_cardImg = new Dictionary();
			
			m_cardImg["999"] = labai999;
			
			m_cardImg["21"] = labai20;
			m_cardImg["22"] = labai21;
			m_cardImg["23"] = labai22;
			m_cardImg["24"] = labai23;
			
			m_cardImg["31"] = labai30;
			m_cardImg["32"] = labai31;
			m_cardImg["33"] = labai32;
			m_cardImg["34"] = labai33;
			
			m_cardImg["41"] = labai40;
			m_cardImg["42"] = labai41;
			m_cardImg["43"] = labai42;
			m_cardImg["44"] = labai43;
			
			m_cardImg["51"] = labai50;
			m_cardImg["52"] = labai51;
			m_cardImg["53"] = labai52;
			m_cardImg["54"] = labai53;
			
			m_cardImg["61"] = labai60;
			m_cardImg["62"] = labai61;
			m_cardImg["63"] = labai62;
			m_cardImg["64"] = labai63;
			
			m_cardImg["71"] = labai70;
			m_cardImg["72"] = labai71;
			m_cardImg["73"] = labai72;
			m_cardImg["74"] = labai73;
			
			m_cardImg["81"] = labai80;
			m_cardImg["82"] = labai81;
			m_cardImg["83"] = labai82;
			m_cardImg["84"] = labai83;
			
			m_cardImg["91"] = labai90;
			m_cardImg["92"] = labai91;
			m_cardImg["93"] = labai92;
			m_cardImg["94"] = labai93;
			
			m_cardImg["101"] = labai100;
			m_cardImg["102"] = labai101;
			m_cardImg["103"] = labai102;
			m_cardImg["104"] = labai103;
			
			m_cardImg["111"] = labai110;
			m_cardImg["112"] = labai111;
			m_cardImg["113"] = labai112;
			m_cardImg["114"] = labai113;
			
			m_cardImg["121"] = labai120;
			m_cardImg["122"] = labai121;
			m_cardImg["123"] = labai122;
			m_cardImg["124"] = labai123;
			
			m_cardImg["131"] = labai130;
			m_cardImg["132"] = labai131;
			m_cardImg["133"] = labai132;
			m_cardImg["134"] = labai133;
			/*
			m_cardImg["141"] = labai140;
			m_cardImg["142"] = labai141;
			m_cardImg["143"] = labai142;
			m_cardImg["144"] = labai143;*/
			
			m_cardImg["11"] = labai140;
			m_cardImg["12"] = labai141;
			m_cardImg["13"] = labai142;
			m_cardImg["14"] = labai143;
			
			m_cardImg["win"] = swfWin;
			m_cardImg["lose"] = swfLose;
			m_cardImg["tickReady"] = tickReady;
			
			m_cardImg[ResponseParams.USER_FOLD] = swfFold;
			m_cardImg[ResponseParams.USER_ALL_IN] = swfShowHand;
			
			m_cardImg[PokerHandType.HIGH_CARD] = imgHighCard;
			m_cardImg[PokerHandType.PAIR] = imgPair;
			m_cardImg[PokerHandType.TWO_PAIRS] = imgTwoPair;
			m_cardImg[PokerHandType.THREE_OF_KIND] = imgThreeOfAKind;
			m_cardImg[PokerHandType.STRAIGHT] = imgStraight;
			m_cardImg[PokerHandType.FLUSH] = imgFlush;
			m_cardImg[PokerHandType.FULL_HOUSE] = imgFullHouse;
			m_cardImg[PokerHandType.FOUR_OF_KIND] = imgFourOfAKind;
			m_cardImg[PokerHandType.STRAIGHT_FLUSH] = imgStraightFlush;
			m_cardImg[PokerHandType.ROYAL_FLUSH] = imgRoyalFlush;
			
			m_cardImg["chip_1000000"] = chip_1m;
			m_cardImg["chip_500000"] = chip_500k;
			m_cardImg["chip_100000"] = chip_100k;
			m_cardImg["chip_50000"] = chip_50k;
			m_cardImg["chip_25000"] = chip_25k;
			m_cardImg["chip_5000"] = chip_5k;
			m_cardImg["chip_1000"] = chip_1k;
			m_cardImg["chip_500"] = chip_500;
			m_cardImg["chip_250"] = chip_250;
			m_cardImg["chip_100"] = chip_100;
			m_cardImg["chip_25"] = chip_25;
			m_cardImg["chip_5"] = chip_5;
			m_cardImg["chip_1"] = chip_1;
			m_cardImg["chip_0.1"] = chip_01;
			m_cardImg["chip_0.5"] = chip_05;
			m_cardImg["chip_0.25"] = chip_025;
			m_cardImg["chip_0.05"] = chip_005;
			m_cardImg["chip_0.01"] = chip_001;			
		}
	}
}