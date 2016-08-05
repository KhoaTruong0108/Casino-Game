/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package logic_test.Poker;

import casino.cardgame.entity.game_entity.ICard;
import casino.cardgame.entity.game_entity.poker.*;
import casino.cardgame.entity.game_entity.tala.TaLaCardCollection;
import logic_test.LogicTest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 *
 * @author KIDKID
 */
public class Test_GetWinner extends LogicTest {

    @Override
    public Boolean RunTest() {
        //TestCase1();
//        AssertTrue(TestCase1(), "TestCase1");
//        AssertTrue(TestCase2(), "TestCase2");
//        AssertTrue(TestCase3(), "TestCase3");
//        AssertTrue(TestCase4(), "TestCase4");
//        AssertTrue(TestCase5(), "TestCase5");
//        AssertTrue(TestCase6(), "TestCase6");
//        AssertTrue(TestCase7(), "TestCase7");
//        AssertTrue(TestCase8(), "TestCase8");
//        AssertTrue(TestCase9(), "TestCase9");
//        AssertTrue(TestCase10(), "TestCase10");
//        AssertTrue(TestCase11(), "TestCase11");
//        AssertTrue(TestCase12(), "TestCase12");
//        AssertTrue(TestCase13(), "TestCase13");
//        AssertTrue(TestCase14(), "TestCase14");
        AssertTrue(TestCase15(), "TestCase15");
        return true;

    }

    public boolean executeTest(ArrayList<String> listUserName, ArrayList<ArrayList<Integer>> listUserCard, ArrayList<Integer> listComCard,
            ArrayList<String> expectWinners, String expectPokerHand) {
        PokerTableInfo info = new PokerTableInfo(100);

        int i;
        ArrayList<ICard> listCard = new ArrayList<ICard>();
        for (i = 0; i < listComCard.size(); i++) {
            listCard.add(PokerCardCollection.getCardById(listComCard.get(i)));
        }
        info.setListCommunityCard(listCard);

        for (i = 0; i < listUserName.size(); i++) {
            String userName = listUserName.get(i);
            info.GetListActiveUserName().add(userName);
            info.getMapUserCard().put(userName, new PokerCardHand());
            info.getMapPokerComparer().put(userName, new PokerHandComparer());
            UserBetHistory betHis = new UserBetHistory();
            betHis.setUserAction(PokerGameTurn.BETTING, UserActionType.BET, 100);
            info.getMapUserBet().put(userName, betHis);


            ArrayList<Integer> userCards = listUserCard.get(i);
            PokerCardHand cardHand = info.getMapUserCard(userName);
            for (int j = 0; j < userCards.size(); j++) {
                cardHand.AddToCurrentHand(userCards.get(j));
            }
        }


        ArrayList<String> listWinners = info.findListWinner();
        
        
        boolean result = true;
        
        if(listWinners.size() > 0){
            String winner = listWinners.get(0);
            String pokerHand = info.getMapPokerComparer(winner).getThePokerHand().getPokerHandType().getName();
            if(pokerHand.equals(expectPokerHand) == false){
                result = false;
            }
        }
        if(listWinners.size() != expectWinners.size())
            result = false;
        for (i = 0; i < expectWinners.size(); i++) {
            String winner = expectWinners.get(i);
            if(listWinners.contains(winner) == false){
                result = false;
            }
        }
        
        if (result == false) {
            for (i = 0; i < listWinners.size(); i++) {
                System.out.print(listWinners.get(i));
                System.out.println(" ; " + info.getMapPokerComparer(listWinners.get(i)).getThePokerHand().getPokerHandType().getName());
            }
        }
        
        return result;
    }

    protected boolean TestCase1() {
        ArrayList<String> listUserName = new ArrayList<String>();
        listUserName.add("user1");
        listUserName.add("user2");
        listUserName.add("user3");
        listUserName.add("user4");
        listUserName.add("user5");

        ArrayList<Integer> listComCard = new ArrayList<Integer>();
        listComCard.add(44);
        listComCard.add(22);
        listComCard.add(33);
        listComCard.add(13);
        listComCard.add(121);

        ArrayList<ArrayList<Integer>> listUserCard = new ArrayList<ArrayList<Integer>>();
        ArrayList<Integer> userCard1 = new ArrayList<Integer>();
        userCard1.add(52);
        userCard1.add(124);
        listUserCard.add(userCard1);

        ArrayList<Integer> userCard2 = new ArrayList<Integer>();
        userCard2.add(92);
        userCard2.add(31);
        listUserCard.add(userCard2);

        ArrayList<Integer> userCard3 = new ArrayList<Integer>();
        userCard3.add(123);
        userCard3.add(84);
        listUserCard.add(userCard3);

        ArrayList<Integer> userCard4 = new ArrayList<Integer>();
        userCard4.add(122);
        userCard4.add(54);
        listUserCard.add(userCard4);

        ArrayList<Integer> userCard5 = new ArrayList<Integer>();
        userCard5.add(91);
        userCard5.add(74);
        listUserCard.add(userCard5);

        ArrayList<String> expectWinner = new ArrayList<String>();
        expectWinner.add("user1");
        expectWinner.add("user4");
        String expectPokerHand = PokerHandType.STRAIGHT;
                
        return executeTest(listUserName, listUserCard, listComCard, expectWinner, expectPokerHand);
    }

    protected boolean TestCase2() {
        ArrayList<String> listUserName = new ArrayList<String>();
        listUserName.add("user1");
        listUserName.add("user2");
        listUserName.add("user3");
        listUserName.add("user4");
        listUserName.add("user5");

        ArrayList<Integer> listComCard = new ArrayList<Integer>();
        listComCard.add(13);
        listComCard.add(123);
        listComCard.add(103);
        listComCard.add(33);
        listComCard.add(121);

        ArrayList<ArrayList<Integer>> listUserCard = new ArrayList<ArrayList<Integer>>();
        ArrayList<Integer> userCard1 = new ArrayList<Integer>();
        userCard1.add(52);
        userCard1.add(124);
        listUserCard.add(userCard1);

        ArrayList<Integer> userCard2 = new ArrayList<Integer>();
        userCard2.add(92);
        userCard2.add(31);
        listUserCard.add(userCard2);

        ArrayList<Integer> userCard3 = new ArrayList<Integer>();
        userCard3.add(113);
        userCard3.add(133);
        listUserCard.add(userCard3);

        ArrayList<Integer> userCard4 = new ArrayList<Integer>();
        userCard4.add(122);
        userCard4.add(54);
        listUserCard.add(userCard4);

        ArrayList<Integer> userCard5 = new ArrayList<Integer>();
        userCard5.add(32);
        userCard5.add(81);
        listUserCard.add(userCard5);

        ArrayList<String> expectWinner = new ArrayList<String>();
        expectWinner.add("user3");
        String expectPokerHand = PokerHandType.ROYAL_FLUSH;
                
        return executeTest(listUserName, listUserCard, listComCard, expectWinner, expectPokerHand);
    }

    protected boolean TestCase3() {
        ArrayList<String> listUserName = new ArrayList<String>();
        listUserName.add("user1");
        listUserName.add("user2");
        listUserName.add("user3");
        listUserName.add("user4");
        listUserName.add("user5");

        ArrayList<Integer> listComCard = new ArrayList<Integer>();
        listComCard.add(71);
        listComCard.add(31);
        listComCard.add(103);
        listComCard.add(112);
        listComCard.add(121);

        ArrayList<ArrayList<Integer>> listUserCard = new ArrayList<ArrayList<Integer>>();
        ArrayList<Integer> userCard1 = new ArrayList<Integer>();
        userCard1.add(91);
        userCard1.add(82);
        listUserCard.add(userCard1);

        ArrayList<Integer> userCard2 = new ArrayList<Integer>();
        userCard2.add(92);
        userCard2.add(83);
        listUserCard.add(userCard2);

        ArrayList<Integer> userCard3 = new ArrayList<Integer>();
        userCard3.add(113);
        userCard3.add(133);
        listUserCard.add(userCard3);

        ArrayList<Integer> userCard4 = new ArrayList<Integer>();
        userCard4.add(122);
        userCard4.add(54);
        listUserCard.add(userCard4);

        ArrayList<Integer> userCard5 = new ArrayList<Integer>();
        userCard5.add(32);
        userCard5.add(81);
        listUserCard.add(userCard5);

        ArrayList<String> expectWinner = new ArrayList<String>();
        expectWinner.add("user1");
        expectWinner.add("user2");
        String expectPokerHand = PokerHandType.STRAIGHT;
                
        return executeTest(listUserName, listUserCard, listComCard, expectWinner, expectPokerHand);
    }
    
    protected boolean TestCase4() {
        ArrayList<String> listUserName = new ArrayList<String>();
        listUserName.add("user1");
        listUserName.add("user2");
        listUserName.add("user3");
        listUserName.add("user4");
        listUserName.add("user5");

        ArrayList<Integer> listComCard = new ArrayList<Integer>();
        listComCard.add(91);
        listComCard.add(92);
        listComCard.add(93);
        listComCard.add(112);
        listComCard.add(52);

        ArrayList<ArrayList<Integer>> listUserCard = new ArrayList<ArrayList<Integer>>();
        ArrayList<Integer> userCard1 = new ArrayList<Integer>();
        userCard1.add(31);
        userCard1.add(32);
        listUserCard.add(userCard1);

        ArrayList<Integer> userCard2 = new ArrayList<Integer>();
        userCard2.add(81);
        userCard2.add(83);
        listUserCard.add(userCard2);

        ArrayList<Integer> userCard3 = new ArrayList<Integer>();
        userCard3.add(103);
        userCard3.add(133);
        listUserCard.add(userCard3);

        ArrayList<Integer> userCard4 = new ArrayList<Integer>();
        userCard4.add(122);
        userCard4.add(54);
        listUserCard.add(userCard4);

        ArrayList<Integer> userCard5 = new ArrayList<Integer>();
        userCard5.add(34);
        userCard5.add(84);
        listUserCard.add(userCard5);

        ArrayList<String> expectWinner = new ArrayList<String>();
        expectWinner.add("user2");
        String expectPokerHand = PokerHandType.FULL_HOUSE;
                
        return executeTest(listUserName, listUserCard, listComCard, expectWinner, expectPokerHand);
    }
    
    //two pairs
    protected boolean TestCase5() {
        ArrayList<String> listUserName = new ArrayList<String>();
        listUserName.add("user1");
        listUserName.add("user2");
        listUserName.add("user3");
        listUserName.add("user4");
        listUserName.add("user5");

        ArrayList<Integer> listComCard = new ArrayList<Integer>();
        listComCard.add(12);
        listComCard.add(11);
        listComCard.add(132);
        listComCard.add(133);
        listComCard.add(52);

        ArrayList<ArrayList<Integer>> listUserCard = new ArrayList<ArrayList<Integer>>();
        ArrayList<Integer> userCard1 = new ArrayList<Integer>();
        userCard1.add(71);
        userCard1.add(32);
        listUserCard.add(userCard1);

        ArrayList<Integer> userCard2 = new ArrayList<Integer>();
        userCard2.add(112);
        userCard2.add(83);
        listUserCard.add(userCard2);

        ArrayList<Integer> userCard3 = new ArrayList<Integer>();
        userCard3.add(72);
        userCard3.add(21);
        listUserCard.add(userCard3);

        ArrayList<Integer> userCard4 = new ArrayList<Integer>();
        userCard4.add(64);
        userCard4.add(54);
        listUserCard.add(userCard4);

        ArrayList<Integer> userCard5 = new ArrayList<Integer>();
        userCard5.add(34);
        userCard5.add(84);
        listUserCard.add(userCard5);

        ArrayList<String> expectWinner = new ArrayList<String>();
        expectWinner.add("user2");
        String expectPokerHand = PokerHandType.TWO_PAIRS;
                
        return executeTest(listUserName, listUserCard, listComCard, expectWinner, expectPokerHand);
    }
    
    protected boolean TestCase6() {
        ArrayList<String> listUserName = new ArrayList<String>();
        listUserName.add("user1");
        listUserName.add("user2");

        ArrayList<Integer> listComCard = new ArrayList<Integer>();
        listComCard.add(101);
        listComCard.add(54);
        listComCard.add(73);
        listComCard.add(13);
        listComCard.add(43);

        ArrayList<ArrayList<Integer>> listUserCard = new ArrayList<ArrayList<Integer>>();
        ArrayList<Integer> userCard1 = new ArrayList<Integer>();
        userCard1.add(21);
        userCard1.add(91);
        listUserCard.add(userCard1);

        ArrayList<Integer> userCard2 = new ArrayList<Integer>();
        userCard2.add(22);
        userCard2.add(62);
        listUserCard.add(userCard2);

        ArrayList<String> expectWinner = new ArrayList<String>();
        expectWinner.add("user1");
        String expectPokerHand = PokerHandType.HIGH_CARD;
                
        return executeTest(listUserName, listUserCard, listComCard, expectWinner, expectPokerHand);
    }
    
    protected boolean TestCase7() {
        ArrayList<String> listUserName = new ArrayList<String>();
        listUserName.add("user1");
        listUserName.add("user2");
        listUserName.add("user3");

        ArrayList<Integer> listComCard = new ArrayList<Integer>();
        listComCard.add(32);
        listComCard.add(21);
        listComCard.add(54);
        listComCard.add(44);
        listComCard.add(62);

        ArrayList<ArrayList<Integer>> listUserCard = new ArrayList<ArrayList<Integer>>();
        ArrayList<Integer> userCard1 = new ArrayList<Integer>();
        userCard1.add(22);
        userCard1.add(91);
        listUserCard.add(userCard1);

        ArrayList<Integer> userCard2 = new ArrayList<Integer>();
        userCard2.add(92);
        userCard2.add(81);
        listUserCard.add(userCard2);
        
        ArrayList<Integer> userCard3 = new ArrayList<Integer>();
        userCard3.add(41);
        userCard3.add(51);
        listUserCard.add(userCard3);

        ArrayList<String> expectWinner = new ArrayList<String>();
        expectWinner.add("user1");
        expectWinner.add("user2");
        expectWinner.add("user3");
        String expectPokerHand = PokerHandType.STRAIGHT;
                
        return executeTest(listUserName, listUserCard, listComCard, expectWinner, expectPokerHand);
    }
    
    protected boolean TestCase8() {
        ArrayList<String> listUserName = new ArrayList<String>();
        listUserName.add("user1");
        listUserName.add("user2");

        ArrayList<Integer> listComCard = new ArrayList<Integer>();
        listComCard.add(62);
        listComCard.add(123);
        listComCard.add(104);
        listComCard.add(23);
        listComCard.add(132);

        ArrayList<ArrayList<Integer>> listUserCard = new ArrayList<ArrayList<Integer>>();
        ArrayList<Integer> userCard1 = new ArrayList<Integer>();
        userCard1.add(64);
        userCard1.add(84);
        listUserCard.add(userCard1);

        ArrayList<Integer> userCard2 = new ArrayList<Integer>();
        userCard2.add(93);
        userCard2.add(11);
        listUserCard.add(userCard2);
        
        ArrayList<String> expectWinner = new ArrayList<String>();
        expectWinner.add("user1");
        String expectPokerHand = PokerHandType.PAIR;
                
        return executeTest(listUserName, listUserCard, listComCard, expectWinner, expectPokerHand);
    }
    
    protected boolean TestCase9() {
        ArrayList<String> listUserName = new ArrayList<String>();
        listUserName.add("user1");
        listUserName.add("user2");
        listUserName.add("user3");
        listUserName.add("user4");
        listUserName.add("user5");

        ArrayList<Integer> listComCard = new ArrayList<Integer>();
        listComCard.add(72);
        listComCard.add(84);
        listComCard.add(63);
        listComCard.add(92);
        listComCard.add(102);

        ArrayList<ArrayList<Integer>> listUserCard = new ArrayList<ArrayList<Integer>>();
        ArrayList<Integer> userCard1 = new ArrayList<Integer>();
        userCard1.add(64);
        userCard1.add(84);
        listUserCard.add(userCard1);

        ArrayList<Integer> userCard2 = new ArrayList<Integer>();
        userCard2.add(93);
        userCard2.add(11);
        listUserCard.add(userCard2);
        
        ArrayList<Integer> userCard3 = new ArrayList<Integer>();
        userCard3.add(21);
        userCard3.add(133);
        listUserCard.add(userCard3);

        ArrayList<Integer> userCard4 = new ArrayList<Integer>();
        userCard4.add(122);
        userCard4.add(54);
        listUserCard.add(userCard4);

        ArrayList<Integer> userCard5 = new ArrayList<Integer>();
        userCard5.add(112);
        userCard5.add(81);
        listUserCard.add(userCard5);
        
        ArrayList<String> expectWinner = new ArrayList<String>();
        expectWinner.add("user5");
        String expectPokerHand = PokerHandType.STRAIGHT;
                
        return executeTest(listUserName, listUserCard, listComCard, expectWinner, expectPokerHand);
    }
    
    protected boolean TestCase10() {
        ArrayList<String> listUserName = new ArrayList<String>();
        listUserName.add("user1");
        listUserName.add("user2");
        listUserName.add("user3");
        listUserName.add("user4");
        listUserName.add("user5");

        ArrayList<Integer> listComCard = new ArrayList<Integer>();
        listComCard.add(11);
        listComCard.add(21);
        listComCard.add(81);
        listComCard.add(52);
        listComCard.add(102);

        ArrayList<ArrayList<Integer>> listUserCard = new ArrayList<ArrayList<Integer>>();
        ArrayList<Integer> userCard1 = new ArrayList<Integer>();
        userCard1.add(61);
        userCard1.add(84);
        listUserCard.add(userCard1);

        ArrayList<Integer> userCard2 = new ArrayList<Integer>();
        userCard2.add(91);
        userCard2.add(31);
        listUserCard.add(userCard2);
        
        ArrayList<Integer> userCard3 = new ArrayList<Integer>();
        userCard3.add(71);
        userCard3.add(101);
        listUserCard.add(userCard3);

        ArrayList<Integer> userCard4 = new ArrayList<Integer>();
        userCard4.add(122);
        userCard4.add(54);
        listUserCard.add(userCard4);

        ArrayList<Integer> userCard5 = new ArrayList<Integer>();
        userCard5.add(112);
        userCard5.add(83);
        listUserCard.add(userCard5);
        
        ArrayList<String> expectWinner = new ArrayList<String>();
        expectWinner.add("user3");
        String expectPokerHand = PokerHandType.FLUSH;
                
        return executeTest(listUserName, listUserCard, listComCard, expectWinner, expectPokerHand);
    }
    
    protected boolean TestCase11() {
        ArrayList<String> listUserName = new ArrayList<String>();
        listUserName.add("user1");
        listUserName.add("user2");
        listUserName.add("user3");
        listUserName.add("user4");
        listUserName.add("user5");

        ArrayList<Integer> listComCard = new ArrayList<Integer>();
        listComCard.add(51);
        listComCard.add(52);
        listComCard.add(53);
        listComCard.add(54);
        listComCard.add(102);

        ArrayList<ArrayList<Integer>> listUserCard = new ArrayList<ArrayList<Integer>>();
        ArrayList<Integer> userCard1 = new ArrayList<Integer>();
        userCard1.add(61);
        userCard1.add(84);
        listUserCard.add(userCard1);

        ArrayList<Integer> userCard2 = new ArrayList<Integer>();
        userCard2.add(91);
        userCard2.add(31);
        listUserCard.add(userCard2);
        
        ArrayList<Integer> userCard3 = new ArrayList<Integer>();
        userCard3.add(71);
        userCard3.add(101);
        listUserCard.add(userCard3);

        ArrayList<Integer> userCard4 = new ArrayList<Integer>();
        userCard4.add(122);
        userCard4.add(94);
        listUserCard.add(userCard4);

        ArrayList<Integer> userCard5 = new ArrayList<Integer>();
        userCard5.add(112);
        userCard5.add(83);
        listUserCard.add(userCard5);
        
        ArrayList<String> expectWinner = new ArrayList<String>();
        expectWinner.add("user4");
        String expectPokerHand = PokerHandType.FOUR_OF_KIND;
                
        return executeTest(listUserName, listUserCard, listComCard, expectWinner, expectPokerHand);
    }
    
    protected boolean TestCase12() {
        ArrayList<String> listUserName = new ArrayList<String>();
        listUserName.add("user1");
        listUserName.add("user2");
        listUserName.add("user3");
        listUserName.add("user4");
        listUserName.add("user5");

        ArrayList<Integer> listComCard = new ArrayList<Integer>();
        listComCard.add(61);
        listComCard.add(71);
        listComCard.add(81);
        listComCard.add(91);
        listComCard.add(101);

        ArrayList<ArrayList<Integer>> listUserCard = new ArrayList<ArrayList<Integer>>();
        ArrayList<Integer> userCard1 = new ArrayList<Integer>();
        userCard1.add(111);
        userCard1.add(84);
        listUserCard.add(userCard1);

        ArrayList<Integer> userCard2 = new ArrayList<Integer>();
        userCard2.add(52);
        userCard2.add(31);
        listUserCard.add(userCard2);
        
        ArrayList<Integer> userCard3 = new ArrayList<Integer>();
        userCard3.add(93);
        userCard3.add(101);
        listUserCard.add(userCard3);

        ArrayList<Integer> userCard4 = new ArrayList<Integer>();
        userCard4.add(122);
        userCard4.add(94);
        listUserCard.add(userCard4);

        ArrayList<Integer> userCard5 = new ArrayList<Integer>();
        userCard5.add(112);
        userCard5.add(83);
        listUserCard.add(userCard5);
        
        ArrayList<String> expectWinner = new ArrayList<String>();
        expectWinner.add("user1");
        String expectPokerHand = PokerHandType.STRAIGHT_FLUSH;
                
        return executeTest(listUserName, listUserCard, listComCard, expectWinner, expectPokerHand);
    }
    
    protected boolean TestCase13() {
        ArrayList<String> listUserName = new ArrayList<String>();
        listUserName.add("user1");
        listUserName.add("user2");
        listUserName.add("user3");
        listUserName.add("user4");
        listUserName.add("user5");

        ArrayList<Integer> listComCard = new ArrayList<Integer>();
        listComCard.add(82);
        listComCard.add(71);
        listComCard.add(81);
        listComCard.add(42);
        listComCard.add(73);

        ArrayList<ArrayList<Integer>> listUserCard = new ArrayList<ArrayList<Integer>>();
        ArrayList<Integer> userCard1 = new ArrayList<Integer>();
        userCard1.add(83);
        userCard1.add(84);
        listUserCard.add(userCard1);

        ArrayList<Integer> userCard2 = new ArrayList<Integer>();
        userCard2.add(52);
        userCard2.add(31);
        listUserCard.add(userCard2);
        
        ArrayList<Integer> userCard3 = new ArrayList<Integer>();
        userCard3.add(93);
        userCard3.add(101);
        listUserCard.add(userCard3);

        ArrayList<Integer> userCard4 = new ArrayList<Integer>();
        userCard4.add(74);
        userCard4.add(72);
        listUserCard.add(userCard4);

        ArrayList<Integer> userCard5 = new ArrayList<Integer>();
        userCard5.add(112);
        userCard5.add(53);
        listUserCard.add(userCard5);
        
        ArrayList<String> expectWinner = new ArrayList<String>();
        expectWinner.add("user1");
        String expectPokerHand = PokerHandType.FOUR_OF_KIND;
                
        return executeTest(listUserName, listUserCard, listComCard, expectWinner, expectPokerHand);
    }
    
    protected boolean TestCase14() {
        ArrayList<String> listUserName = new ArrayList<String>();
        listUserName.add("user1");
        listUserName.add("user2");
//        listUserName.add("user3");
//        listUserName.add("user4");
//        listUserName.add("user5");

        ArrayList<Integer> listComCard = new ArrayList<Integer>();
        listComCard.add(132);
        listComCard.add(63);
        listComCard.add(74);
        listComCard.add(92);
        listComCard.add(122);

        ArrayList<ArrayList<Integer>> listUserCard = new ArrayList<ArrayList<Integer>>();
        ArrayList<Integer> userCard1 = new ArrayList<Integer>();
        userCard1.add(93);
        userCard1.add(21);
        listUserCard.add(userCard1);

        ArrayList<Integer> userCard2 = new ArrayList<Integer>();
        userCard2.add(91);
        userCard2.add(42);
        listUserCard.add(userCard2);
        
//        ArrayList<Integer> userCard3 = new ArrayList<Integer>();
//        userCard3.add(93);
//        userCard3.add(101);
//        listUserCard.add(userCard3);
//
//        ArrayList<Integer> userCard4 = new ArrayList<Integer>();
//        userCard4.add(74);
//        userCard4.add(72);
//        listUserCard.add(userCard4);
//
//        ArrayList<Integer> userCard5 = new ArrayList<Integer>();
//        userCard5.add(112);
//        userCard5.add(53);
//        listUserCard.add(userCard5);
        
        ArrayList<String> expectWinner = new ArrayList<String>();
        expectWinner.add("user1");
        expectWinner.add("user2");
        String expectPokerHand = PokerHandType.PAIR;
                
        return executeTest(listUserName, listUserCard, listComCard, expectWinner, expectPokerHand);
    }
    
    protected boolean TestCase15() {
        ArrayList<String> listUserName = new ArrayList<String>();
        listUserName.add("user1");
        listUserName.add("user2");
        listUserName.add("user3");
        listUserName.add("user4");
        listUserName.add("user5");

        ArrayList<Integer> listComCard = new ArrayList<Integer>();
        listComCard.add(74);
        listComCard.add(121);
        listComCard.add(61);
        listComCard.add(24);
        listComCard.add(114);

        ArrayList<ArrayList<Integer>> listUserCard = new ArrayList<ArrayList<Integer>>();
        ArrayList<Integer> userCard1 = new ArrayList<Integer>();
        userCard1.add(53);
        userCard1.add(23);
        listUserCard.add(userCard1);

        ArrayList<Integer> userCard2 = new ArrayList<Integer>();
        userCard2.add(63);
        userCard2.add(112);
        listUserCard.add(userCard2);
        
        ArrayList<Integer> userCard3 = new ArrayList<Integer>();
        userCard3.add(33);
        userCard3.add(43);
        listUserCard.add(userCard3);

        ArrayList<Integer> userCard4 = new ArrayList<Integer>();
        userCard4.add(64);
        userCard4.add(104);
        listUserCard.add(userCard4);

        ArrayList<Integer> userCard5 = new ArrayList<Integer>();
        userCard5.add(22);
        userCard5.add(32);
        listUserCard.add(userCard5);
        
        ArrayList<String> expectWinner = new ArrayList<String>();
        expectWinner.add("user4");
        String expectPokerHand = PokerHandType.FLUSH;
                
        return executeTest(listUserName, listUserCard, listComCard, expectWinner, expectPokerHand);
    }
    
    protected boolean TestCase16() {
        ArrayList<String> listUserName = new ArrayList<String>();
        listUserName.add("user1");
        listUserName.add("user2");
        listUserName.add("user3");
        listUserName.add("user4");
        listUserName.add("user5");

        ArrayList<Integer> listComCard = new ArrayList<Integer>();
        listComCard.add(74);
        listComCard.add(121);
        listComCard.add(61);
        listComCard.add(24);
        listComCard.add(114);

        ArrayList<ArrayList<Integer>> listUserCard = new ArrayList<ArrayList<Integer>>();
        ArrayList<Integer> userCard1 = new ArrayList<Integer>();
        userCard1.add(53);
        userCard1.add(23);
        listUserCard.add(userCard1);

        ArrayList<Integer> userCard2 = new ArrayList<Integer>();
        userCard2.add(63);
        userCard2.add(112);
        listUserCard.add(userCard2);
        
        ArrayList<Integer> userCard3 = new ArrayList<Integer>();
        userCard3.add(33);
        userCard3.add(43);
        listUserCard.add(userCard3);

        ArrayList<Integer> userCard4 = new ArrayList<Integer>();
        userCard4.add(64);
        userCard4.add(104);
        listUserCard.add(userCard4);

        ArrayList<Integer> userCard5 = new ArrayList<Integer>();
        userCard5.add(22);
        userCard5.add(32);
        listUserCard.add(userCard5);
        
        ArrayList<String> expectWinner = new ArrayList<String>();
        expectWinner.add("user4");
        String expectPokerHand = PokerHandType.FLUSH;
                
        return executeTest(listUserName, listUserCard, listComCard, expectWinner, expectPokerHand);
    }
}
