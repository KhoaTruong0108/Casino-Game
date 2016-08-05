package casino.cardgame.entity.game_entity.poker;

/**
 *
 * @author LTP
 */
public class PokerHand {

    private int[] _pokerHand;

    public PokerHand() {
        _pokerHand = new int[5];
    }

    public int getPoker(int i) {
        return _pokerHand[i];
    }

    public void setPokerHand(int card1, int card2, int card3, int card4, int card5) {
        _pokerHand[0] = card1;
        _pokerHand[1] = card2;
        _pokerHand[2] = card3;
        _pokerHand[3] = card4;
        _pokerHand[4] = card5;
        sort();
    }

    private void print() {
        System.out.print("\n");
        for (int i = 0; i < 5; i++) {
            System.out.print(getPokerHand()[i] + " ");
        }
        System.out.print(" == " + this._twoPairs()[0] + " " + this._twoPairs()[1]);
    }

    public PokerHandTypeEntity getPokerHandType() {
        int straightFlush = this._straightFlush();
        if (straightFlush > 0) {
            if (straightFlush == 14) {
                return new PokerHandTypeEntity(PokerHandType.ROYAL_FLUSH, 10, 14);
            } else {
                return new PokerHandTypeEntity(PokerHandType.STRAIGHT_FLUSH, 9, getStraightFlush());//return PokerHandType.STRAIGHT_FLUSH;//khoatd edited
            }
        }
        if (this._fourOfAKind() > 0) {
            return new PokerHandTypeEntity(PokerHandType.FOUR_OF_KIND, 8, getFourOfAKind());//return PokerHandType.FOUR_OF_KIND;
        }
        if (this._fullHouse() > 0) {
            return new PokerHandTypeEntity(PokerHandType.FULL_HOUSE, 7, getFullHouse());//return PokerHandType.FULL_HOUSE;
        }
        if (this._flush() > 0) {
            return new PokerHandTypeEntity(PokerHandType.FLUSH, 6, getFlush());//return PokerHandType.FLUSH;
        }
        if (this._straight() > 0) {
            return new PokerHandTypeEntity(PokerHandType.STRAIGHT, 5, getStraight());//return PokerHandType.STRAIGHT;
        }
        if (this._threeOfAKind() > 0) {
            return new PokerHandTypeEntity(PokerHandType.THREE_OF_KIND, 4, getThreeOfAKind());//return PokerHandType.THREE_OF_KIND;
        }
        int[] twoPairs = this._twoPairs();
        if (twoPairs[0] > 0 && twoPairs[1] > 0) {
            return new PokerHandTypeEntity(PokerHandType.TWO_PAIRS, 3, twoPairs[0] + twoPairs[1]);//return PokerHandType.TWO_PAIRS;
        }
        if (twoPairs[0] > 0) {
            return new PokerHandTypeEntity(PokerHandType.PAIR, 2, twoPairs[0]);//return PokerHandType.PAIR;
        }
        return new PokerHandTypeEntity(PokerHandType.HIGH_CARD, 1, getStraightFlush());//return PokerHandType.HIGH_CARD;
    }

    public PokerHand compare(PokerHand poker) {
        // Thung pha sanh
        if (poker == null) {
            return this;
        }
        //<editor-fold desc="Royal flush - Thung Pha Sanh">
        int thisRoyalFlush = this._straightFlush();
        int pokerRoyalFlush = poker._straightFlush();
        if (thisRoyalFlush > pokerRoyalFlush) {
            return this.clone();
        }
        if (thisRoyalFlush < pokerRoyalFlush) {
            return poker.clone();
        }
        if (thisRoyalFlush > 0 && thisRoyalFlush == pokerRoyalFlush) {
            return null;
        }
        //</editor-fold>

        //<editor-fold desc="Four of a kind - Tu Quy">
        int thisFourOfAKind = this._fourOfAKind();
        int pokerFourOfAKind = poker._fourOfAKind();
        if (thisFourOfAKind > pokerFourOfAKind) {
            return this.clone();
        }
        if (thisFourOfAKind < pokerFourOfAKind) {
            return poker.clone();
        }
        if (thisFourOfAKind > 0 && thisFourOfAKind == pokerFourOfAKind) {
            return this.compareHighCard(poker);
        }
        //</editor-fold>

        //<editor-fold desc="Full house - Cu Lu">
        int thisFullHouse = this._fullHouse();
        int pokerFullHouse = poker._fullHouse();
        if (thisFullHouse > pokerFullHouse) {
            return this.clone();
        }
        if (thisFullHouse < pokerFullHouse) {
            return poker.clone();
        }

        if (thisFullHouse > 0 && thisFullHouse == pokerFullHouse) {
            return this.compareHighCard(poker);
        }
        //</editor-fold>

        //<editor-fold desc="Flush - Thung">
        int thisFlush = this._flush();
        int pokerFlush = poker._flush();
        if (thisFlush > 0 && thisFlush == pokerFlush) {
            return this.compareHighCard(poker);
        } else if (thisFlush > pokerFlush) {
            return this.clone();
        } else if (thisFlush < pokerFlush) {
            return poker.clone();
        }
        //</editor-fold>

        //<editor-fold desc="Straight- Sanh">
        int thisStraight = this._straight();
        int pokerStraight = poker._straight();
        if (thisStraight > 0 && thisStraight == pokerStraight) {
            return null;
        }
        if (thisStraight > pokerStraight) {
            return this.clone();
        }
        if (thisStraight < pokerStraight) {
            return poker.clone();
        }

        //</editor-fold>

        //<editor-fold desc="Three of a kind - Xam co">
        int thisThreeOfAKind = this._threeOfAKind();
        int pokerThreeOfAKind = poker._threeOfAKind();
        if (thisThreeOfAKind > 0 && thisThreeOfAKind == pokerThreeOfAKind) {
            return this.compareHighCard(poker);
        }
        if (thisThreeOfAKind > pokerThreeOfAKind) {
            return this.clone();
        }
        if (thisThreeOfAKind < pokerThreeOfAKind) {
            return poker.clone();
        }
        //</editor-fold>

        //<editor-fold desc="Pair - doi">
        int[] thisTwoPairs = this._twoPairs();
        int[] pokerTwoPairs = poker._twoPairs();

        if (thisTwoPairs[1] > pokerTwoPairs[1]) {
            return this.clone();
        }
        if (thisTwoPairs[1] < pokerTwoPairs[1]) {
            return poker.clone();
        }

        if (thisTwoPairs[0] > pokerTwoPairs[0]) {
            return this.clone();
        }
        if (thisTwoPairs[0] < pokerTwoPairs[0]) {
            return poker.clone();
        }

        return this.compareHighCard(poker);
        //</editor-fold>
    }

    public int getStraightFlush() {
        return this._straightFlush();
    }

    public int getFourOfAKind() {
        return this._fourOfAKind();
    }

    public int getFullHouse() {
        return this._fullHouse();
    }

    public int getFlush() {
        return this._flush();
    }

    public int getStraight() {
        return this._straight();
    }

    public int getThreeOfAKind() {
        return this._threeOfAKind();
    }

    public int[] getTwoPairs() {
        return this._twoPairs();
    }

//<editor-fold desc="private function">
    private void sort() {
        for (int i = 0; i < 4; i++) {
            for (int j = i + 1; j < 5; j++) {
                if (getPokerHand()[i] > getPokerHand()[j]) {
                    int temp = getPokerHand()[i];
                    _pokerHand[i] = getPokerHand()[j];
                    _pokerHand[j] = temp;
                }
            }
        }
    }

    private PokerHand compareHighCard(PokerHand poker) {
        for (int i = 4; i >= 0; i--) {
            int thisValue = this.getPoker(i) / 10;
            int pokerValue = poker.getPoker(i) / 10;
            
            if (thisValue < pokerValue) {
                return poker.clone();
            }
            if (thisValue > pokerValue) {
                return this.clone();
            }
//            if (this.getPoker(i) < poker.getPoker(i)) {
//                return poker.clone();
//            }
//            if (this.getPoker(i) > poker.getPoker(i)) {
//                return this.clone();
//            }
        }
        return null;
    }

    // Thú || Đôi int[2]
    //
    //
    private int[] _twoPairs() {
        int[] retArr = {-1, -1};
        for (int i = 0; i < 4; i++) {
            if ((int) (getPokerHand()[i] / 10) == (int) (getPokerHand()[i + 1] / 10)) {
                if (retArr[0] == -1) {
                    retArr[0] = (int) (getPokerHand()[i + 1] / 10);
                } else {
                    retArr[1] = (int) (getPokerHand()[i + 1] / 10);
                }
            }
        }
        return retArr;
    }

    // Xám cô
    private int _threeOfAKind() {
        int count = 1;
        for (int i = 0; i < 4; i++) {
            if ((int) (getPokerHand()[i] / 10) == (int) (getPokerHand()[i + 1] / 10)) {
                count++;
                if (count == 3) {
                    return (int) (getPokerHand()[i + 1] / 10);
                }
            } else {
                count = 1;
            }
        }
        return -1;
    }

    // Sảnh
    private int _straight() {
        if ((int) (getPokerHand()[4] / 10) == 14 && (int) (getPokerHand()[0] / 10) == 2) {
            for (int i = 0; i < 3; i++) {
                if (getPokerHand()[i] / 10 + 1 != getPokerHand()[i + 1] / 10) {
                    return -1;
                }
            }
            return (int) (getPokerHand()[3] / 10);
        }
        for (int i = 0; i < 4; i++) {
            if ((getPokerHand()[i] / 10 + 1) != getPokerHand()[i + 1] / 10) {
                return -1;
            }
        }
        return (int) (getPokerHand()[4] / 10);
    }

    // Thùng
    private int _flush() {
        for (int i = 0; i < 4; i++) {

            if ((getPokerHand()[i] % 10) != (getPokerHand()[i + 1] % 10)) {
                return -1;
            }
        }
        return (int) (getPokerHand()[4] / 10);
    }

    // Cù lủ  //khoatd edited
    private int _fullHouse() {
        int count = 1;
        int n = 0;
        int value1 = 0;
        int value2 = 0;
        for (int i = 0; i < 4; i++) {
            if ((int) (getPokerHand()[i] / 10) == (int) (getPokerHand()[i + 1] / 10)) {
                count++;
            } else {
                value1 = (int) (getPokerHand()[i] / 10);
                value2 = (int) (getPokerHand()[i + 1] / 10);
                if (count == 2) {
//                    if (n == 3) {
//                        return (int) (getPokerHand()[2] / 10);
//                    }
                    n = 2;
                    count = 1;
                } else if (count == 3) {
//                    if (n == 2) {
//                        return (int) (getPokerHand()[4] / 10);
//                    }
                    n = 3;
                    count = 1;
                }
            }
        }

        if (count == 2) {
            if (n == 3) {
//                return (int) (getPokerHand()[2] / 10);
                return value1 + value2;
            }
        } else if (count == 3) {
            if (n == 2) {
//                return (int) (getPokerHand()[4] / 10);
                return value1 + value2;
            }
        }

        return -1;
    }

    // Tứ quý
    private int _fourOfAKind() {
        int count = 1;
        for (int i = 0; i < 4; i++) {
            if ((int) (getPokerHand()[i] / 10) == (int) (getPokerHand()[i + 1] / 10)) {
                count++;
                if (count == 4) {
                    return (int) (getPokerHand()[i + 1] / 10);
                }
            } else {
                count = 1;
            }
        }
        return -1;
    }

    // Thùng phá sảnh
    private int _straightFlush() {
        int straight = _straight();
        if (straight > -1 && _flush() > -1) {
            return straight;
        }
        return -1;
    }
//</editor-fold>   

    @Override
    public PokerHand clone() {
        PokerHand instance = new PokerHand();
        instance.setPokerHand(getPokerHand()[0], getPokerHand()[1], getPokerHand()[2], getPokerHand()[3], getPokerHand()[4]);
        return instance;
    }

    /**
     * @return the _pokerHand
     */
    public int[] getPokerHand() {
        return _pokerHand;
    }
}

/*
 * Royal Flush         Thùng phá sảnh
 * Four of a kind      Tứ quý
 * Full House          Cù lủ
 * Flush               Thùng
 * Straight            Sảnh
 * Three of a kind     Xám cô
 * Two pairs           Thú
 * Pair                Đôi
 * High card           Mậu
 */