package entity.game_Entity
{
	import mx.core.IVisualElement;

	public interface ICard extends IVisualElement
	{
		function getCardId():int;
		
		function getCardName():String;
		
		function getCardValue():int;
		
		function ActiveEffect(isActive: Boolean):void;
	}
}