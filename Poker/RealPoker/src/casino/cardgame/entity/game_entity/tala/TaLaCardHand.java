/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.entity.game_entity.tala;

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
public class TaLaCardHand implements ICardHand {

    protected List<ICard> m_currentHand;

    /**
     * ***************************************************************************
     * SangDN: Lấy danh sách bài hiện có trên tay người dùng
     * ***************************************************************************
     */
    public TaLaCardHand() {
        m_currentHand = new ArrayList<ICard>();
    }

    @Override
    public synchronized List<ICard> getCurrentHand() {
        return m_currentHand;
    }

    /**
     * ***************************************************************************
     * SangDN: Set danh sách bài trên tay người dùng
     * ***************************************************************************
     */
    @Override
    public synchronized void setCurrentHand(List<ICard> hand) {
        m_currentHand = hand;
    }

    /**
     * ***************************************************************************
     * SangDN: So Sánh Bài trên tay người dùng với nhau >0: Hiện tại lớn hơn bộ
     * được so RESULT = WIN =0: 2 bộ hòa RESULT = DRAW <0: Hiện tại nhỏ hơn bộ
     * được so RESULT = LOOSE
     * ***************************************************************************
     */
    @Override
    public synchronized COMPARE compare(ICardHand hand) {
        //Tính tổng card, ai nhỏ hơn là thắng
        int currentHandTotal = 0;
        int compareHandTotal = 0;
        for (int i = 0; i < m_currentHand.size(); ++i) {
            currentHandTotal += m_currentHand.get(i).getCardValue();
        }
        List<ICard> compareHand = hand.getCurrentHand();
        for (int i = 0; i < compareHand.size(); ++i) {
            compareHandTotal += compareHand.get(i).getCardValue();
        }

        if (currentHandTotal < compareHandTotal) {
            return COMPARE.WIN;
        } else if (currentHandTotal > compareHandTotal) {
            return COMPARE.LOOSE;
        } else {
            return COMPARE.DRAW;
        }
    }

    /**
     * ***************************************************************************
     * SangDN: Lấy kiểu (tên gọi) của bài trên tay người dùng (tạm chưa dùng)
     * ***************************************************************************
     */
    @Override
    public synchronized String getHandType() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    /**
     * ***************************************************************************
     * SangDN: Add lá bài ICard vào danh sách bài đang có trên tay nguwofi dùng
     * (HandCard)
     * ***************************************************************************
     */
    @Override
    public synchronized boolean AddToCurrentHand(ICard card) {
        if (m_currentHand.contains(card) == true) {
            return false;
        }
        m_currentHand.add(card);
        return true;

    }

    /**
     * ***************************************************************************
     * SangDN: Lấy ra 1 lá bài trên hand theo cardId Trả về card đó nếu có trên
     * hand, ngược lại trả về null
     * ***************************************************************************
     */
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

    /**
     * ***************************************************************************
     * SangDN: Lấy ra 1 lá bài trên hand ở ví trí cuối cùng Dùng trong trường
     * hợp move card
     * ***************************************************************************
     */
    @Override
    public synchronized ICard RemoveLastCard() {
        int size = m_currentHand.size();
        if (size > 0) {
            return m_currentHand.remove(size - 1);
        }
        return null;

    }

    /**
     * ***************************************************************************
     * SangDN: Kiểm tra xem người dùng có thể lấy 1 lá bài từ người khác là hợp
     * lệ ko ? Nếu ko là hack do dưới client cũng đã kiểm tra ( trong luật game
     * hiện tai) Lá bài lấy là hợp lệ khi tồn tại 1 trong 2 yếu tố: *** Dãy Đồng
     * chất > 2 : 3 bích, 4 bích, 5 bích *** Dãy Đồng lượng > 2: 3 bích, 3
     * chuồn, 3 rô
     * ***************************************************************************
     */
    public synchronized boolean IsGetACardValid(int playerCardId) {
        //lá bài lấy ko thể có trong ds của người dùng
        if (this.IsContain(playerCardId)) {
            return false;
        }
        ICard card = TaLaCardCollection.getCardById(playerCardId);
        if (card != null) {
            //Tìm danh sách đồng lượng
            List<Integer> listDongLuong = GetListDongLuongDaiNhat(playerCardId);
//            listDongLuong.add(playerCardId);
            //khoatd edited: listDongLuong.size() > 2 (old version)
            //  cause: playerCardId is not exist in currentHand.
            if (listDongLuong != null && listDongLuong.size() > 1) {
                return true;
            }
            //Kiểm tra đồng chất
            //DS card dong chat lien ke
            int p1 = playerCardId - 20;
            int p2 = playerCardId - 10;
            int p3 = playerCardId;
            int p4 = playerCardId + 10;
            int p5 = playerCardId + 20;

            boolean case1 = TaLaCardCollection.isCardIdValid(p1) && this.IsContain(p1);
            boolean case2 = TaLaCardCollection.isCardIdValid(p2) && this.IsContain(p2);
            boolean case4 = TaLaCardCollection.isCardIdValid(p4) && this.IsContain(p4);
            boolean case5 = TaLaCardCollection.isCardIdValid(p5) && this.IsContain(p5);

            if (case1 && case2) {
                return true;
            }
            if (case2 && case4) {
                return true;
            }
            if (case4 && case5) {
                return true;
            }
        }
        return false;
    }

    public synchronized boolean IsGetACardValid(ICard playerCard) {
        if (playerCard != null) {
            return false;
        }
        return IsGetACardValid(playerCard.getCardId());
    }
    //Kiem tra 2 la bai la dong chat
    // ex: 3 bich - 4 bich || 3 bich - 2 bich

    protected boolean IsDongChat(int id1, int id2) {
        //sx id1 > id2        
        int temp = id1;
        if (id1 < id2) {
            id1 = id2;
            id2 = temp;
        }
        int distance = id1 - id2;
        if (distance == 0xA || distance == 120) {
            return true;
        }
        return false;

    }

    // Lay card dong chat lien tiep no trong day, tra ve null neu ko ton tai
    // ví dụ liền tiếp 3 rô là 4 rô, K rô là A rô
    protected Integer GetCardDongChatLienTiep(int cardId) {
        for (int i = 0; i < m_currentHand.size(); ++i) {
            int id = m_currentHand.get(i).getCardId();
            int distance = id - cardId;
            if (distance == 0xA || distance == -120) {
                return id;
            }
        }
        return null;
    }
    // Lay card dong chat lien sau no trong day, tra ve null neu ko ton tai
    //  

    protected Integer GetCardDongChatLienSau(int cardId) {
        for (int i = 0; i < m_currentHand.size(); ++i) {
            int id = m_currentHand.get(i).getCardId();
            int distance = cardId - id;
            if (distance == 0xA || distance == -120) {
                return id;
            }
        }
        return null;
    }
    // Lay ds card đồng lượng dài nhất trong hand.
    // 2 bich -> 2bich, 2 chuon, 2 ro

    protected List<Integer> GetListDongLuongDaiNhat(int cardId) {
        List<Integer> result = new ArrayList<Integer>();
        for (int i = 0; i < m_currentHand.size(); ++i) {
            int id = m_currentHand.get(i).getCardId();
            if (IsDongLuong(id, cardId)) {
                result.add(id);
            }
        }
        if (result.size() > 0) {
            //result.add(cardId);
            return result;
        }
        return null;
    }

    protected boolean IsDongLuong(int card1, int card2) {
        if (Math.abs(card1 - card2) < 4) {
            return true;
        }
        return false;
    }

    /**
     * ***************************************************************************
     * SangDN: Kiểm tra DS Card dùng để hạ xuống (lúc kết thúc) có hợp lệ ko ?
     * Nếu Không : + Xử lí hack
     * ***************************************************************************
     */
    public boolean IsListCardValid(List<ICard> listCard) {
        return false;
    }

    /**
     * ***************************************************************************
     * SangDN: Kiểm tra DS Card dùng để hạ xuống (lúc kết thúc) có hợp lệ ko ?
     * subHand is winHand, card must contain in currentHand or in subHand Nếu
     * Không : + Xử lí hack
     * ***************************************************************************
     */
    public boolean IsListCardIdValid(List<Integer> listCardId, TaLaCardHand subHand) {
        try {
            //listCardId would from 3 up to 5 cards
            if (listCardId.size() < 3 || listCardId.size() > 5) {
                return false;
            }
            //Check cardId in listHand is exclusive
            for (int i = 0; i < listCardId.size() - 1; ++i) {
                int id = listCardId.get(i);
                for (int j = i + 1; j < listCardId.size(); ++j) {
                    if (id == listCardId.get(j)) {
                        return false;
                    }
                }
            }
            //check if contain in current hand or in subHand  
            for (int i = 0; i < listCardId.size(); ++i) {
                boolean b1 = this.IsContain(listCardId.get(i));
                if (b1 == false) {
                    if (subHand == null) {
                        return false;
                    }
                    boolean b2 = subHand.IsContain(listCardId.get(i));
                    if (b2 == false) {
                        return false;
                    }
                }
            }
            //check dong luong
            int id = listCardId.get(0);
            boolean dong_luong = true;
            for (int i = 1; i < listCardId.size(); ++i) {
                if (IsDongLuong(id, listCardId.get(i)) == false) {
                    dong_luong = false;
                    break;
                }
            }
            if (dong_luong == true) {
                return true;
            }
            //check dong chat
            //sort listCard            
            SortIncrease(listCardId);
            //Incase Q K A or J Q K A or 10 J Q K A
            int firstId = listCardId.get(0);
            if (firstId > 10 && firstId < 15) {
                boolean isValid = true;
                for (int i = 0; i < listCardId.size() - 1; ++i) {
                    if (IsDongChat(listCardId.get(i), listCardId.get(i + 1)) == false) {
                        isValid = false;
                        break;
                    }
                }
                if (isValid == true) {
                    return true;
                }
                listCardId.remove(0);
                listCardId.add(firstId);
                for (int i = 0; i < listCardId.size() - 1; ++i) {
                    if (IsDongChat(listCardId.get(i), listCardId.get(i + 1)) == false) {
                        return false;
                    }
                }

            } else {
                for (int i = 0; i < listCardId.size() - 1; ++i) {
                    if (IsDongChat(listCardId.get(i), listCardId.get(i + 1)) == false) {
                        return false;
                    }
                }
            }
            return true;
        } catch (Exception ex) {
            Logger.error(TaLaCardHand.class, ex);
            return false;
        }
    }

    protected void SortIncrease(List<Integer> list) {
        for (int i = 0; i < list.size() - 1; ++i) {
            int minIndex = i;
            for (int j = i + 1; j < list.size(); ++j) {
                if (list.get(minIndex) > list.get(j)) {
                    minIndex = j;
                }
            }
            if (minIndex == i) {
                continue;
            }
            int value = list.get(i);
            list.set(i, list.get(minIndex));
            list.set(minIndex, value);
        }
    }

    protected void SortIncrease2(List<ICard> list) {
        for (int i = 0; i < list.size() - 1; ++i) {
            int minIndex = i;
            for (int j = i + 1; j < list.size(); ++j) {
                if (list.get(minIndex).getCardId() > list.get(j).getCardId()) {
                    minIndex = j;
                }
            }
            if (minIndex == i) {
                continue;
            }
            ICard value = list.get(i);
            list.set(i, list.get(minIndex));
            list.set(minIndex, value);
        }
    }
    
    //khoatd

    public boolean IsExistPhom() {
        List<ICard> listCard = m_currentHand;
        SortIncrease2(listCard);

        //check dong Luong
        for (int i = 0; i < listCard.size() - 2;) {
            int next = i + 1;
            int cardId1 = listCard.get(i).getCardId();
            int cardId2 = listCard.get(i + 1).getCardId();
            if (IsDongLuong(cardId1, cardId2)) {
                next = i + 2;
                int cardId3 = listCard.get(i + 2).getCardId();
                if (IsDongLuong(cardId2, cardId3)) {
                    return true;
                }
            }
            i = next;
        }

        //check dong chat
        boolean result = false;
        if (listCard.get(0).getCardId() < 15) {
            listCard.add(listCard.get(0));
        }
        if (listCard.get(1).getCardId() < 15) {
            listCard.add(listCard.get(1));
        }
        for (int i = 0; i < listCard.size() - 2; i++) {
            int index1 = checkDongChat(listCard, i);
            if(index1 != -1){
                int index2 = checkDongChat(listCard, index1 + i);
                if(index2 != -1){
                    result = true;
                    break;
                }
            }
        }
        if (listCard.get(1).getCardId() < 15) {
            listCard.remove(listCard.size() - 1);
        }
        if (listCard.get(0).getCardId() < 15) {
            listCard.remove(listCard.size() - 1);
        }

        return result;
    }
    // return a index of next Dong Chat Card, return -1 if not dong chat lien tiep.

    protected int checkDongChat(List<ICard> listCard, int index) {
        int cardId1 = listCard.get(index).getCardId();
        
        if (index + 1 < listCard.size()) {
            int cardId2 = listCard.get(index + 1).getCardId();
            if (IsDongChat(cardId1, cardId2)) {
                return 1;
            }
        }
        if (index + 2 < listCard.size()) {
            int cardId3 = listCard.get(index + 2).getCardId();
            if (IsDongChat(cardId1, cardId3)) {
                return 2;
            }
        }
        if (index + 3 < listCard.size()) {
            int cardId4 = listCard.get(index + 3).getCardId();
            if (IsDongChat(cardId1, cardId4)) {
                return 3;
            }
        }
        return -1;
    }

    /**
     * ***************************************************************************
     * SangDN: Kiểm tra xem người dùng có ù ko ?
     * ***************************************************************************
     */
    public boolean IsGoal() {
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
    public ICard RemoveACardInHand(ICard card) {
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

    @Override
    public synchronized boolean IsContain(ICard card) {
        return m_currentHand.contains(card);
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
}
