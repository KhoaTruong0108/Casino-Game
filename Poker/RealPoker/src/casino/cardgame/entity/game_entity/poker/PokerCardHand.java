/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.entity.game_entity.poker;

import casino.cardgame.entity.game_entity.tala.*;
import casino.cardgame.entity.game_entity.ICard;
import casino.cardgame.entity.game_entity.ICardHand;
import casino.cardgame.entity.game_entity.card.GameCard;
import casino.cardgame.utils.Logger;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import javax.smartcardio.Card;

/**
 *
 * @author KIDKID
 */
public class PokerCardHand implements ICardHand {

    protected List<ICard> m_currentHand;

    /**
     * ***************************************************************************
     * SangDN: Lấy danh sách bài hiện có trên tay người dùng
     * ***************************************************************************
     */
    public PokerCardHand() {
        m_currentHand = new ArrayList<ICard>();
    }

    @Override
    public List<ICard> getCurrentHand() {
        return m_currentHand;
    }

    @Override
    public synchronized boolean IsContain(ICard card) {
        return this.IsContain(card.getCardId());
    }

    @Override
    public synchronized boolean IsContain(int cardId) {
        for (int i = 0; i < m_currentHand.size(); ++i) {
            if (m_currentHand.get(i).getCardId() == cardId) {
                return true;
            }
        }
        return false;
    }

    @Override
    public boolean AddToCurrentHand(int cardId) {
        ICard card = TaLaCardCollection.getCardById(cardId);
        if (card == null) {
            return false;
        }
        if (m_currentHand.contains(card) == true) {
            return false;
        }
        m_currentHand.add(card);
        return true;
    }

    @Override
    public boolean AddToCurrentHand(ICard card) {
        if (card == null) {
            return false;
        }
        if (m_currentHand.contains(card) == true) {
            return false;
        }
        m_currentHand.add(card);
        return true;
    }

    @Override
    public boolean AddToCurrentHand(List<ICard> listCard) {
        for (int i = 0; i < listCard.size(); i++) {
            AddToCurrentHand(listCard.get(i));
        }
        return true;
    }

    @Override
    public boolean AddToCurrentHand2(List<Integer> listCard) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public synchronized ICard RemoveACardInHand(int cardId) {
        for (int i = 0; i < m_currentHand.size(); ++i) {
            if (m_currentHand.get(i).getCardId() == cardId) {
                ICard rmCard = m_currentHand.remove(i);
                return rmCard;
            }
        }
        return null;
    }

    @Override
    public synchronized ICard RemoveACardInHand(ICard card) {
        return this.RemoveACardInHand(card.getCardId());
    }

    @Override
    public ICard RemoveLastCard() {
        int size = m_currentHand.size();
        if (size > 0) {
            return m_currentHand.remove(size - 1);
        }
        return null;
    }

    @Override
    public void setCurrentHand(List<ICard> hand) {
        m_currentHand = hand;
    }

    @Override
    public COMPARE compare(ICardHand hand) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public String getHandType() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public String getHandType(List<ICard> hand) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public String getHandType2(List<Integer> handId) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}
