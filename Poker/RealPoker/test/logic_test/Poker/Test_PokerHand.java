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
public class Test_PokerHand extends LogicTest {

    @Override
    public Boolean RunTest() {
        AssertTrue(TestCase7(), "TestCase7");
        return true;

    }

    protected void printCard(int[] cards){
        for (int i = 0; i < cards.length; i++) {
            System.out.print(cards[i]);
            System.out.print(" , ");
        }
    }
    
    //straight flush
    public Boolean TestCase1() {
        int[] listCardId = new int[7];
        listCardId[0] = 142;
        listCardId[1] = 22;
        listCardId[2] = 32;
        listCardId[3] = 42;
        listCardId[4] = 132;
        listCardId[5] = 71;
        listCardId[6] = 61;
        PokerHandComparer comparer = new PokerHandComparer();
        comparer.setPokerData(listCardId);
        comparer.findThePokerHand();

        if (comparer.getThePokerHand().getPokerHandType().getName().equals(PokerHandType.STRAIGHT_FLUSH)) {
            return true;
        }
        return false;
    }

    //royal flush
    public Boolean TestCase2() {
        int[] listCardId = new int[7];
        listCardId[0] = 102;
        listCardId[1] = 112;
        listCardId[2] = 122;
        listCardId[3] = 132;
        listCardId[4] = 43;
        listCardId[5] = 142;
        listCardId[6] = 84;
        PokerHandComparer comparer = new PokerHandComparer();
        comparer.setPokerData(listCardId);
        comparer.findThePokerHand();
        comparer.getThePokerHand().getStraightFlush();

        if (comparer.getThePokerHand().getPokerHandType().getName().equals(PokerHandType.STRAIGHT_FLUSH)) {
            return true;
        }
        return false;
    }

    //flush
    public Boolean TestCase3() {
        int[] listCardId = new int[7];
        listCardId[0] = 82;
        listCardId[1] = 22;
        listCardId[2] = 72;
        listCardId[3] = 52;
        listCardId[4] = 122;
        listCardId[5] = 71;
        listCardId[6] = 42;
        PokerHandComparer comparer = new PokerHandComparer();
        comparer.setPokerData(listCardId);
        comparer.findThePokerHand();

        if (comparer.getThePokerHand().getPokerHandType().getName().equals(PokerHandType.FLUSH)) {
            return true;
        }
        return false;
    }

    //two pairs
    public Boolean TestCase4() {
        int[] listCardId = new int[7];
        listCardId[0] = 82;
        listCardId[1] = 83;
        listCardId[2] = 101;
        listCardId[3] = 103;
        listCardId[4] = 122;
        listCardId[5] = 71;
        listCardId[6] = 42;
        PokerHandComparer comparer = new PokerHandComparer();
        comparer.setPokerData(listCardId);
        comparer.findThePokerHand();
        PokerHandTypeEntity obj = comparer.getThePokerHand().getPokerHandType();

        if (comparer.getThePokerHand().getPokerHandType().getName().equals(PokerHandType.FLUSH)) {
            return true;
        }
        return false;
    }
    
     //three of kind
    public Boolean TestCase5() {
        int[] listCardId = new int[7];
        listCardId[0] = 24;
        listCardId[1] = 23;
        listCardId[2] = 101;
        listCardId[3] = 103;
        listCardId[4] = 102;
        listCardId[5] = 52;
        listCardId[6] = 22;
        PokerHandComparer comparer = new PokerHandComparer();
        comparer.setPokerData(listCardId);
        comparer.findThePokerHand();
        printCard(comparer.getListPokerCard());
        
        if (comparer.getThePokerHand().getPokerHandType().getName().equals(PokerHandType.THREE_OF_KIND)) {
            return true;
        }
        return false;
    }
    
     //pairs
    public Boolean TestCase6() {
        int[] listCardId = new int[7];
        listCardId[0] = 82;
        listCardId[1] = 83;
        listCardId[2] = 21;
        listCardId[3] = 62;
        listCardId[4] = 34;
        listCardId[5] = 71;
        listCardId[6] = 42;
        PokerHandComparer comparer = new PokerHandComparer();
        comparer.setPokerData(listCardId);
        comparer.findThePokerHand();

        if (comparer.getThePokerHand().getPokerHandType().getName().equals(PokerHandType.PAIR)) {
            return true;
        }
        return false;
    }
    
     //full house
    public Boolean TestCase7() {
        int[] listCardId = new int[7];
        listCardId[0] = 91;
        listCardId[1] = 94;
        listCardId[2] = 82;
        listCardId[3] = 83;
        listCardId[4] = 81;
        listCardId[5] = 71;
        listCardId[6] = 42;
        PokerHandComparer comparer = new PokerHandComparer();
        comparer.setPokerData(listCardId);
        comparer.findThePokerHand();

        if (comparer.getThePokerHand().getPokerHandType().getName().equals(PokerHandType.FULL_HOUSE)) {
            return true;
        }
        return false;
    }
}
