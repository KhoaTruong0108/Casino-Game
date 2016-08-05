package entity.game_Entity
{
	import mx.collections.ArrayList;

	public interface ICardHand
	{
		function  getCurrentHand(): ArrayList;			
		function  AddToCurrentHand(cardId: int):Boolean ;		
		function  RemoveACardInHand(cardId: int): void;		
		function  setCurrentHand(hand: ArrayList): void;	
		function  getHandType(): String;
	}
}