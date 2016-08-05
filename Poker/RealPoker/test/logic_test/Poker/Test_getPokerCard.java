/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package logic_test.Poker;

import casino.cardgame.entity.game_entity.poker.PokerHandComparer;
import casino.cardgame.entity.game_entity.poker.PokerHandType;
import casino.cardgame.entity.game_entity.poker.PokerHandTypeEntity;
import logic_test.LogicTest;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author KIDKID
 */
public class Test_getPokerCard extends LogicTest {

    @Override
    public Boolean RunTest() {
        AssertTrue(TestCase1(), "TestCase1");
        AssertTrue(TestCase2(), "TestCase2");
        AssertTrue(TestCase3(), "TestCase3");
        AssertTrue(TestCase4(), "TestCase4");
        AssertTrue(TestCase5(), "TestCase5");
        return true;
    }
    
    protected void printCard(int[] cards){
        for (int i = 0; i < cards.length; i++) {
            System.out.print(cards[i]);
            System.out.print(" , ");
        }
    }

    //four of kind
    public Boolean TestCase1() {
        int[] listCardId = new int[7];
        listCardId[0] = 142;
        listCardId[1] = 22;
        listCardId[2] = 21;
        listCardId[3] = 23;
        listCardId[4] = 24;
        listCardId[5] = 71;
        listCardId[6] = 61;
        PokerHandComparer comparer = new PokerHandComparer();
        comparer.setPokerData(listCardId);
        comparer.findThePokerHand();

        String pokerHand = comparer.getThePokerHand().getPokerHandType().getName();
        int[] listCard = comparer.getListPokerCard();
        printCard(listCard);
        
        if (pokerHand.equals(PokerHandType.FOUR_OF_KIND)) {
            return true;
        }
        return false;
    }

    //three of kind
    public Boolean TestCase2() {
        int[] listCardId = new int[7];
        listCardId[0] = 102;
        listCardId[1] = 52;
        listCardId[2] = 53;
        listCardId[3] = 54;
        listCardId[4] = 24;
        listCardId[5] = 71;
        listCardId[6] = 33;
        PokerHandComparer comparer = new PokerHandComparer();
        comparer.setPokerData(listCardId);
        comparer.findThePokerHand();

        String pokerHand = comparer.getThePokerHand().getPokerHandType().getName();
        int[] listCard = comparer.getListPokerCard();
        printCard(listCard);
        
        if (pokerHand.equals(PokerHandType.THREE_OF_KIND)) {
            return true;
        }
        return false;
    }

    //two of kind
    public Boolean TestCase3() {
        int[] listCardId = new int[7];
        listCardId[0] = 102;
        listCardId[1] = 142;
        listCardId[2] = 143;
        listCardId[3] = 54;
        listCardId[4] = 84;
        listCardId[5] = 91;
        listCardId[6] = 33;
        PokerHandComparer comparer = new PokerHandComparer();
        comparer.setPokerData(listCardId);
        comparer.findThePokerHand();

        String pokerHand = comparer.getThePokerHand().getPokerHandType().getName();
        int[] listCard = comparer.getListPokerCard();
        printCard(listCard);
        
        if (pokerHand.equals(PokerHandType.PAIR)) {
            return true;
        }
        return false;
    }

    //two of pairs
    public Boolean TestCase4() {
        int[] listCardId = new int[7];
        listCardId[0] = 102;
        listCardId[1] = 112;
        listCardId[2] = 111;
        listCardId[3] = 54;
        listCardId[4] = 32;
        listCardId[5] = 91;
        listCardId[6] = 33;
        PokerHandComparer comparer = new PokerHandComparer();
        comparer.setPokerData(listCardId);
        comparer.findThePokerHand();

        String pokerHand = comparer.getThePokerHand().getPokerHandType().getName();
        int[] listCard = comparer.getListPokerCard();
        printCard(listCard);
        
        if (pokerHand.equals(PokerHandType.TWO_PAIRS)) {
            return true;
        }
        return false;
    }
    
    //two of pairs
    public Boolean TestCase5() {
        int[] listCardId = new int[7];
        listCardId[0] = 102;
        listCardId[1] = 112;
        listCardId[2] = 131;
        listCardId[3] = 54;
        listCardId[4] = 22;
        listCardId[5] = 91;
        listCardId[6] = 33;
        PokerHandComparer comparer = new PokerHandComparer();
        comparer.setPokerData(listCardId);
        comparer.findThePokerHand();

        String pokerHand = comparer.getThePokerHand().getPokerHandType().getName();
        int[] listCard = comparer.getListPokerCard();
        printCard(listCard);
        
        if (pokerHand.equals(PokerHandType.TWO_PAIRS)) {
            return true;
        }
        return false;
    }
    
}
