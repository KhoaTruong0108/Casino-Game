/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.entity.game_entity.tala;

import casino.cardgame.entity.game_entity.card.A_Co;
import casino.cardgame.entity.game_entity.card.Tam_Bich;
import casino.cardgame.entity.game_entity.card.Bon_Ro;
import casino.cardgame.entity.game_entity.card.Q_Chuon;
import casino.cardgame.entity.game_entity.card.Chin_Chuon;
import casino.cardgame.entity.game_entity.card.Nam_Chuon;
import casino.cardgame.entity.game_entity.card.A_Ro;
import casino.cardgame.entity.game_entity.card.Muoi_Bich;
import casino.cardgame.entity.game_entity.card.Hai_Ro;
import casino.cardgame.entity.game_entity.card.K_Bich;
import casino.cardgame.entity.game_entity.card.Sau_Co;
import casino.cardgame.entity.game_entity.card.Ba_Chuon;
import casino.cardgame.entity.game_entity.card.Ba_Bich;
import casino.cardgame.entity.game_entity.card.Ba_Co;
import casino.cardgame.entity.game_entity.card.Hai_Bich;
import casino.cardgame.entity.game_entity.card.J_Ro;
import casino.cardgame.entity.game_entity.card.Bay_Co;
import casino.cardgame.entity.game_entity.card.A_Bich;
import casino.cardgame.entity.game_entity.card.K_Chuon;
import casino.cardgame.entity.game_entity.card.Chin_Bich;
import casino.cardgame.entity.game_entity.card.Q_Co;
import casino.cardgame.entity.game_entity.card.Bon_Chuon;
import casino.cardgame.entity.game_entity.card.Ba_Ro;
import casino.cardgame.entity.game_entity.card.Muoi_Chuon;
import casino.cardgame.entity.game_entity.card.Muoi_Co;
import casino.cardgame.entity.game_entity.card.Bon_Co;
import casino.cardgame.entity.game_entity.card.Hai_Chuon;
import casino.cardgame.entity.game_entity.card.J_Co;
import casino.cardgame.entity.game_entity.card.A_Chuon;
import casino.cardgame.entity.game_entity.card.K_Co;
import casino.cardgame.entity.game_entity.card.Sau_Ro;
import casino.cardgame.entity.game_entity.card.Bay_Bich;
import casino.cardgame.entity.game_entity.card.Bay_Ro;
import casino.cardgame.entity.game_entity.card.Muoi_Ro;
import casino.cardgame.entity.game_entity.card.Sau_Bich;
import casino.cardgame.entity.game_entity.card.Tam_Chuon;
import casino.cardgame.entity.game_entity.card.J_Chuon;
import casino.cardgame.entity.game_entity.card.K_Ro;
import casino.cardgame.entity.game_entity.card.Tam_Co;
import casino.cardgame.entity.game_entity.card.Bay_Chuon;
import casino.cardgame.entity.game_entity.card.Nam_Ro;
import casino.cardgame.entity.game_entity.card.Q_Ro;
import casino.cardgame.entity.game_entity.card.Nam_Bich;
import casino.cardgame.entity.game_entity.card.Chin_Ro;
import casino.cardgame.entity.game_entity.card.Bon_Bich;
import casino.cardgame.entity.game_entity.card.Nam_Co;
import casino.cardgame.entity.game_entity.card.Tam_Ro;
import casino.cardgame.entity.game_entity.card.Hai_Co;
import casino.cardgame.entity.game_entity.card.J_Bich;
import casino.cardgame.entity.game_entity.card.Q_Bich;
import casino.cardgame.entity.game_entity.card.Chin_Co;
import casino.cardgame.entity.game_entity.card.Sau_Chuon;
import casino.cardgame.entity.game_entity.ICard;
import casino.cardgame.entity.game_entity.IListCards;
import casino.cardgame.utils.Logger;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

/**
 *
 * @author KIDKID Desc: Quản lý các lá bài trong bàn (52 lá bài)
 */
public class TaLaCardCollection implements IListCards {

    List<ICard> m_listCard;

    public TaLaCardCollection() {
        //renew a list
        renew();
    }

    @Override
    public List<ICard> getCurrentList() {
        return m_listCard;
    }

    /**
     * ***************************************************************************
     * SangDN: Làm mới lại danh sách bài trên bàn.Thường Dùng để bắt đầu 1 bàn
     * mới.
     */
    @Override
    public final void renew() {
        if (m_listCard == null) {
            m_listCard = new ArrayList<ICard>();
        }
        m_listCard.add(new A_Bich());
        m_listCard.add(new A_Chuon());
        m_listCard.add(new A_Ro());
        m_listCard.add(new A_Co());

        m_listCard.add(new Hai_Bich());
        m_listCard.add(new Hai_Chuon());
        m_listCard.add(new Hai_Ro());
        m_listCard.add(new Hai_Co());

        m_listCard.add(new Ba_Bich());
        m_listCard.add(new Ba_Chuon());
        m_listCard.add(new Ba_Ro());
        m_listCard.add(new Ba_Co());

        m_listCard.add(new Bon_Bich());
        m_listCard.add(new Bon_Chuon());
        m_listCard.add(new Bon_Ro());
        m_listCard.add(new Bon_Co());

        m_listCard.add(new Nam_Bich());
        m_listCard.add(new Nam_Chuon());
        m_listCard.add(new Nam_Ro());
        m_listCard.add(new Nam_Co());

        m_listCard.add(new Sau_Bich());
        m_listCard.add(new Sau_Chuon());
        m_listCard.add(new Sau_Ro());
        m_listCard.add(new Sau_Co());

        m_listCard.add(new Bay_Bich());
        m_listCard.add(new Bay_Chuon());
        m_listCard.add(new Bay_Ro());
        m_listCard.add(new Bay_Co());

        m_listCard.add(new Tam_Bich());
        m_listCard.add(new Tam_Chuon());
        m_listCard.add(new Tam_Ro());
        m_listCard.add(new Tam_Co());

        m_listCard.add(new Chin_Bich());
        m_listCard.add(new Chin_Chuon());
        m_listCard.add(new Chin_Ro());
        m_listCard.add(new Chin_Co());

        m_listCard.add(new Muoi_Bich());
        m_listCard.add(new Muoi_Chuon());
        m_listCard.add(new Muoi_Ro());
        m_listCard.add(new Muoi_Co());

        m_listCard.add(new J_Bich());
        m_listCard.add(new J_Chuon());
        m_listCard.add(new J_Ro());
        m_listCard.add(new J_Co());

        m_listCard.add(new Q_Bich());
        m_listCard.add(new Q_Chuon());
        m_listCard.add(new Q_Ro());
        m_listCard.add(new Q_Co());

        m_listCard.add(new K_Bich());
        m_listCard.add(new K_Chuon());
        m_listCard.add(new K_Ro());
        m_listCard.add(new K_Co());

        if (m_listCard.size() != 52) {
            Logger.error(TaLaCardCollection.class, "Init TalaCard Wrong");
        }
        //Shuffle Card
        int n = 5;
        for (int i = 0; i < n; ++i) {
            shuffleListCard();
        }

    }

    /**
     * ***************************************************************************
     * SangDN: Lấy 1 lá bài từ danh sách bài trên bàn. Thường dùng để phát bài
     * cho user
     ****************************************************************************
     */
    @Override
    public ICard getNextCard() {
        int size = m_listCard.size();
        Random rand = new Random();
        int index = Math.abs(rand.nextInt()) % size;
       
        return m_listCard.remove(index);
    }

    /**
     * ***************************************************************************
     * SangDN: Lấy number lá bài từ danh sách bài trên bàn.Dùng phát những lá
     * bài đầu tiên cho user
     ****************************************************************************
     */
    @Override
    public List<ICard> getNextCard(int number) {
        List<ICard> list = new ArrayList<ICard>();
        for (int i = 0; i < number; ++i) {
            list.add(getNextCard());
        }
        return list;
    }
    public List<ICard> getNextCard2(int number) {
        List<ICard> listUCard = new ArrayList<ICard>();
        listUCard.add(new Ba_Bich());
        listUCard.add(new Ba_Chuon());
        listUCard.add(new Ba_Ro());
        listUCard.add(new Sau_Bich());
        listUCard.add(new Bay_Bich());
        listUCard.add(new Tam_Bich());
        listUCard.add(new J_Bich());
        listUCard.add(new Q_Bich());
        listUCard.add(new K_Bich());
        if(number == 10)
            listUCard.add(new Tam_Bich());
        
        return listUCard;
    }

    /**
     * ***************************************************************************
     * SangDN: Trộn bài.
     ****************************************************************************
     */
    @Override
    public void shuffleListCard() {
        //Shuffle By Java Lib
        Collections.shuffle(m_listCard);
        //Human shuffle for confirm
        Random rand = new Random();
        int size = m_listCard.size();
        for (int i = 0; i < 26; ++i) {
            int exchangePos = Math.abs(rand.nextInt()) % size;
            ICard temp = m_listCard.get(i);
            m_listCard.set(i, m_listCard.get(exchangePos));
            m_listCard.set(exchangePos, temp);
        }
    }

    @Override
    public int getCurrentLengh() {
        return m_listCard.size();
    }

    public static ICard getCardById(int cardId) {
        switch (cardId) {
            //case Bich
            case 11:
                return new A_Bich();
            case 21:
                return new Hai_Bich();
            case 31:
                return new Ba_Bich();
            case 41:
                return new Bon_Bich();
            case 51:
                return new Nam_Bich();
            case 61:
                return new Sau_Bich();
            case 71:
                return new Bay_Bich();
            case 81:
                return new Tam_Bich();
            case 91:
                return new Chin_Bich();
            case 101:
                return new Muoi_Bich();
            case 111:
                return new J_Bich();
            case 121:
                return new Q_Bich();
            case 131:
                return new K_Bich();
            //Card _Chuon
            case 12:
                return new A_Chuon();
            case 22:
                return new Hai_Chuon();
            case 32:
                return new Ba_Chuon();
            case 42:
                return new Bon_Chuon();
            case 52:
                return new Nam_Chuon();
            case 62:
                return new Sau_Chuon();
            case 72:
                return new Bay_Chuon();
            case 82:
                return new Tam_Chuon();
            case 92:
                return new Chin_Chuon();
            case 102:
                return new Muoi_Chuon();
            case 112:
                return new J_Chuon();
            case 122:
                return new Q_Chuon();
            case 132:
                return new K_Chuon();
            //Case _Ro
            case 13:
                return new A_Ro();
            case 23:
                return new Hai_Ro();
            case 33:
                return new Ba_Ro();
            case 43:
                return new Bon_Ro();
            case 53:
                return new Nam_Ro();
            case 63:
                return new Sau_Ro();
            case 73:
                return new Bay_Ro();
            case 83:
                return new Tam_Ro();
            case 93:
                return new Chin_Ro();
            case 103:
                return new Muoi_Ro();
            case 113:
                return new J_Ro();
            case 123:
                return new Q_Ro();
            case 133:
                return new K_Ro();
            //Case _Co
            case 14:
                return new A_Co();
            case 24:
                return new Hai_Co();
            case 34:
                return new Ba_Co();
            case 44:
                return new Bon_Co();
            case 54:
                return new Nam_Co();
            case 64:
                return new Sau_Co();
            case 74:
                return new Bay_Co();
            case 84:
                return new Tam_Co();
            case 94:
                return new Chin_Co();
            case 104:
                return new Muoi_Co();
            case 114:
                return new J_Co();
            case 124:
                return new Q_Co();
            case 134:
                return new K_Co();
            default:
                return null;
        }
    }

    public static boolean isCardIdValid(int cardId) {
        if (cardId < 11 || cardId > 134) {
            return false;
        }
        if ((cardId % 10) > 4) {
            return false;
        }
        return true;
    }
}
