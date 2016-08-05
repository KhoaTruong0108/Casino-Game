package entity.game_Entity.Poker
{
	import entity.game_Entity.ICard;
	import entity.game_Entity.ICardHand;
	
	import mx.collections.ArrayList;
	//*******************************************************************************
	//	SangDN: 
	//		+ Chứa danh sách id các lá bài của người dùng trên tay && dưới bàn		
	//					
	//*******************************************************************************
	public class PokerCardHand implements ICardHand
	{
		protected var m_listCard: ArrayList;
		
		public function PokerCardHand()
		{
			m_listCard = new ArrayList();		
		}
		//*******************************************************************************
		//			SangDN: Kiểm tra xem với tay bài hiện tại có thể ăn lá bài cardId ko?
		//			Case: Hiển thị gợi ý( nếu cần), && kiểm tra có ăn đc ko trc khi gởi lên server
		//*******************************************************************************
		public function CouldGetPlayerCard(cardId:int):Boolean{
			return false;
		}
		//*******************************************************************************
		//			SangDN: Add id vào tay bài hiện tại 
		//			Case: Ăn bài, hoặc lấy bài, id do server gởi về
		//*******************************************************************************
		public function AddToCurrentHand(cardId: int):Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}
		
		//*******************************************************************************
		//			SangDN: Bỏ id từ tay bài hiện tại 
		//			Case: Đánh bài rác
		//*******************************************************************************
		public function RemoveACardInHand(cardId:int):void
		{
		}
		
		//*******************************************************************************
		//			SangDN: Lấy ds lá bài hiện tại trên tay hoặc dưới bàn
		//			Case: ---
		//*******************************************************************************
		public function getCurrentHand():ArrayList
		{
			return m_listCard;
		}
		//*******************************************************************************
		//			SangDN: Set ds lá bài hiện tại trên tay hoặc dưới bàn
		//			Case: ---
		//*******************************************************************************
		public function setCurrentHand(listCard:ArrayList):void
		{
			m_listCard = listCard;
			
		}
		public function getHandType():String
		{
			
			return "Not Used";
		}
		
		
	}
}