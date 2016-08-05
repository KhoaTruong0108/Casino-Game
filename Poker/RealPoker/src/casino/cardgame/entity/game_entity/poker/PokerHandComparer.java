/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.entity.game_entity.poker;

import com.smartfoxserver.v2.entities.data.ISFSObject;
import java.util.ArrayList;

/**
 *
 * @author LTP
 */
public class PokerHandComparer {

    private int[] _pokerData;
    private PokerHand _pokerController;
    int[][] arr = new int[21][5];
    private PokerHandTypeEntity m_handType;
    
    public PokerHandComparer() {
        _pokerData = new int[7];
        _pokerController = new PokerHand();

        //<editor-fold desc="to hop">    
        arr[0] = new int[]{0, 1, 2, 3, 4};
        arr[1] = new int[]{0, 1, 2, 3, 5};
        arr[2] = new int[]{0, 1, 2, 3, 6};
        arr[3] = new int[]{0, 1, 2, 4, 5};
        arr[4] = new int[]{0, 1, 2, 4, 6};
        arr[5] = new int[]{0, 1, 2, 5, 6};
        arr[6] = new int[]{0, 1, 3, 4, 5};
        arr[7] = new int[]{0, 1, 3, 4, 6};
        arr[8] = new int[]{0, 1, 3, 5, 6};
        arr[9] = new int[]{0, 1, 4, 5, 6};
        arr[10] = new int[]{0, 2, 3, 4, 5};
        arr[11] = new int[]{0, 2, 3, 4, 6};
        arr[12] = new int[]{0, 2, 3, 5, 6};
        arr[13] = new int[]{0, 2, 4, 5, 6};
        arr[14] = new int[]{0, 3, 4, 5, 6};
        arr[15] = new int[]{1, 2, 3, 4, 5};
        arr[16] = new int[]{1, 2, 3, 4, 6};
        arr[17] = new int[]{1, 2, 3, 5, 6};
        arr[18] = new int[]{1, 2, 4, 5, 6};
        arr[19] = new int[]{1, 3, 4, 5, 6};
        arr[20] = new int[]{2, 3, 4, 5, 6};
        //</editor-fold>

    }

    public PokerHand getThePokerHand() {
        return _pokerController;
    }

    public void setPokerData(int[] card) {
        if (card.length < 7) {
            return;
        }
        System.arraycopy(card, 0, _pokerData, 0, 7);
    }

//    public void setPokerData(ISFSObject userData, int[] arrComCard){
//        if(userData == null || arrComCard == null || arrComCard.length < 5){
//            return;
//        }
//        _pokerData[0] = userData.getInt(ResponseParams.CARD_1);
//        _pokerData[1] = userData.getInt(ResponseParams.CARD_2);
//        System.arraycopy(arrComCard, 0, _pokerData, 2, 5);
//        findThePokerHand();
//        //print();
//    }
    public void findThePokerHand() {
        _pokerController.setPokerHand(_pokerData[arr[0][0]],
                _pokerData[arr[0][1]],
                _pokerData[arr[0][2]],
                _pokerData[arr[0][3]],
                _pokerData[arr[0][4]]);
        for (int i = 1; i < 21; i++) {
            PokerHand tempPokerHand = new PokerHand();
            tempPokerHand.setPokerHand(_pokerData[arr[i][0]],
                    _pokerData[arr[i][1]],
                    _pokerData[arr[i][2]],
                    _pokerData[arr[i][3]],
                    _pokerData[arr[i][4]]);

            tempPokerHand = _pokerController.compare(tempPokerHand);
            if (tempPokerHand != null) {
                _pokerController = tempPokerHand;
            }
        }
        m_handType = _pokerController.getPokerHandType();
    }

    public PokerHandTypeEntity getPokerHandType() {
        return m_handType;
    }

    public int comparePokerHand(PokerHandComparer comparer) {
        PokerHandTypeEntity handType2 = comparer.getPokerHandType();
        if (m_handType.getOrder() == handType2.getOrder()) {
            if (m_handType.getValue() == handType2.getValue()) {
                return 0;
            } else if (m_handType.getValue() < handType2.getValue()) {
                return -1;
            } else {
                return 1;
            }
        } else if (m_handType.getOrder() < handType2.getOrder()) {
            return -1;
        } else {
            return 1;
        }
    }

    public boolean isExistCard(int cardId) {
        int[] listPokerCard = getListPokerCard();
        for (int i = 0; i < listPokerCard.length; i++) {
            if (cardId == listPokerCard[i]) {
                return true;
            }
        }
        return false;
    }

    public int[] getListPokerCard() {
        String pokerType = m_handType.getName();

        int[] pokerHand = _pokerController.getPokerHand();

        if (pokerType.equals(PokerHandType.FOUR_OF_KIND)) {
            return getFourOfKindCard(pokerHand);
        } else if (pokerType.equals(PokerHandType.THREE_OF_KIND)) {
            return getThreeOfKindCard(pokerHand);
        } else if (pokerType.equals(PokerHandType.TWO_PAIRS)) {
            return getTwoPairCard(pokerHand);
        } else if (pokerType.equals(PokerHandType.PAIR)) {
            return getPairCard(pokerHand);
        } else if (pokerType.equals(PokerHandType.HIGH_CARD)) {
            return getHighCard(pokerHand);
        } else {
            return _pokerController.getPokerHand();
        }

    }

    protected int[] getFourOfKindCard(int[] pokerHand) {
        int[] listCard = new int[4];

        int valueCard = (m_handType.getValue()) * 10;
        int iCount = 0;
        for (int i = 0; i < pokerHand.length; i++) {
            int temp = pokerHand[i] - valueCard;
            if (temp >= 0 && temp <= 4) {
                listCard[iCount] = pokerHand[i];
                iCount++;
            }
        }

        return listCard;
    }

    protected int[] getThreeOfKindCard(int[] pokerHand) {
        int[] listCard = new int[3];

        int valueCard = (m_handType.getValue()) * 10;
        int iCount = 0;
        for (int i = 0; i < pokerHand.length; i++) {
            int temp = pokerHand[i] - valueCard;
            if (temp >= 0 && temp <= 4) {
                listCard[iCount] = pokerHand[i];
                iCount++;
            }
        }

        return listCard;
    }

    protected int[] getPairCard(int[] pokerHand) {
        int[] listCard = new int[2];

        int valueCard = (m_handType.getValue()) * 10;
        int iCount = 0;
        for (int i = 0; i < pokerHand.length; i++) {
            int temp = pokerHand[i] - valueCard;
            if (temp >= 0 && temp <= 4) {
                listCard[iCount] = pokerHand[i];
                iCount++;
            }
        }

        return listCard;
    }

    protected int[] getTwoPairCard(int[] pokerHand) {
        int[] listCard = new int[4];

        int valueCard1 = _pokerController.getTwoPairs()[0] * 10;
        int valueCard2 = _pokerController.getTwoPairs()[1] * 10;

        int iCount = 0;
        for (int i = 0; i < pokerHand.length; i++) {
            int temp1 = pokerHand[i] - valueCard1;
            int temp2 = pokerHand[i] - valueCard2;
            if ((temp1 >= 0 && temp1 <= 4) || (temp2 >= 0 && temp2 <= 4)) {
                listCard[iCount] = pokerHand[i];
                iCount++;
            }
        }

        return listCard;
    }

    protected int[] getHighCard(int[] pokerHand) {
        int[] listCard = new int[1];

        int maxCard = pokerHand[0];
        for (int i = 0; i < pokerHand.length; i++) {
            if (maxCard < pokerHand[i]) {
                maxCard = pokerHand[i];
            }
        }
        listCard[0] = maxCard;

        return listCard;
    }
}
