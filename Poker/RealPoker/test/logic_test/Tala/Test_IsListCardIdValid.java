package logic_test.Tala;

import logic_test.LogicTest;
import casino.cardgame.entity.game_entity.tala.TaLaCardCollection;
import casino.cardgame.entity.game_entity.tala.TaLaCardHand;
import casino.cardgame.entity.game_entity.card.K_Bich;
import casino.cardgame.entity.game_entity.card.Q_Bich;
import java.util.ArrayList;
import java.util.List;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author KIDKID
 */
public class Test_IsListCardIdValid extends LogicTest {

    @Override
    public Boolean RunTest() {
        AssertTrue(TestCase1(), "TestCase1");
        AssertTrue(TestCase2(), "TestCase2");
        AssertTrue(TestCase3(), "TestCase4");
        AssertTrue(TestCase5(), "TestCase5");
        AssertTrue(TestCase6(), "TestCase6");
        AssertTrue(TestCase7(), "TestCase7");
        AssertTrue(TestCase8(), "TestCase8");
        AssertTrue(TestCase9(), "TestCase9");
        AssertTrue(TestCase10(), "TestCase10");
        AssertTrue(TestCase11(), "TestCase11");
        
        return true;

    }
    
    public Boolean TestCase1() {
        List<Integer> listCardId = new ArrayList<Integer>();
        //case Ab Ach Ar Ac
        listCardId.add(11);
        listCardId.add(12);
        listCardId.add(13);
        listCardId.add(14);
        TaLaCardHand hand = new TaLaCardHand();
        hand.AddToCurrentHand(11);
        hand.AddToCurrentHand(12);
        hand.AddToCurrentHand(13);
        hand.AddToCurrentHand(14);
        if (hand.IsListCardIdValid(listCardId, null) == true) {
            return true;
        }
        return false;
    }

    public Boolean TestCase2() {
        List<Integer> listCardId = new ArrayList<Integer>();
        //case Ab 2b 3b 4b 
        listCardId.add(11);
        listCardId.add(21);
        listCardId.add(31);
        listCardId.add(41);
        TaLaCardHand hand = new TaLaCardHand();
        hand.AddToCurrentHand(11);
        hand.AddToCurrentHand(21);
        hand.AddToCurrentHand(31);
        hand.AddToCurrentHand(41);
        if (hand.IsListCardIdValid(listCardId, null) == true) {
            return true;
        }
        return false;
    }

    public Boolean TestCase3() {
        List<Integer> listCardId = new ArrayList<Integer>();
        //case Ab 2b 3b 4b 5b
        listCardId.add(11);
        listCardId.add(21);
        listCardId.add(31);
        listCardId.add(41);
        listCardId.add(51);

        TaLaCardHand hand = new TaLaCardHand();
        hand.AddToCurrentHand(11);
        hand.AddToCurrentHand(21);
        hand.AddToCurrentHand(31);
        hand.AddToCurrentHand(41);
        hand.AddToCurrentHand(51);
        if (hand.IsListCardIdValid(listCardId, null) == true) {
            return true;
        }
        return false;
    }

    public Boolean TestCase5() {
        List<Integer> listCardId = new ArrayList<Integer>();
        //case Ab Qb Kb 
        listCardId.add(11);
        listCardId.add(121);
        listCardId.add(131);
        TaLaCardHand hand = new TaLaCardHand();
        hand.AddToCurrentHand(11);
        hand.AddToCurrentHand(121);
        hand.AddToCurrentHand(131);

        if (hand.IsListCardIdValid(listCardId, null) == true) {
            return true;
        }
        return false;
    }

    public Boolean TestCase6() {
        List<Integer> listCardId = new ArrayList<Integer>();
        //case Qb Kb Ab
        listCardId.add(121);
        listCardId.add(131);
        listCardId.add(11);
        TaLaCardHand hand = new TaLaCardHand();
        hand.AddToCurrentHand(121);
        hand.AddToCurrentHand(131);
        hand.AddToCurrentHand(11);
        if (hand.IsListCardIdValid(listCardId, null) == true) {
            return true;
        }
        return false;
    }

    public Boolean TestCase7() {
        List<Integer> listCardId = new ArrayList<Integer>();
        //case 3b 4b 5b 6b 7b

        listCardId.add(31);
        listCardId.add(41);
        listCardId.add(51);
        listCardId.add(61);
        listCardId.add(71);
        TaLaCardHand hand = new TaLaCardHand();
        hand.AddToCurrentHand(31);
        hand.AddToCurrentHand(41);
        hand.AddToCurrentHand(51);
        hand.AddToCurrentHand(61);
        hand.AddToCurrentHand(71);
        if (hand.IsListCardIdValid(listCardId, null) == true) {
            return true;
        }
        return false;
    }
    //*********************************************
    //          WRONG CASE
    //*********************************************

    public Boolean TestCase8() {
        List<Integer> listCardId = new ArrayList<Integer>();
        //case 3b 4b 5b 7b

        listCardId.add(31);
        listCardId.add(41);
        listCardId.add(51);
        listCardId.add(71);
        TaLaCardHand hand = new TaLaCardHand();
        hand.AddToCurrentHand(31);
        hand.AddToCurrentHand(41);
        hand.AddToCurrentHand(51);
        hand.AddToCurrentHand(71);
        if (hand.IsListCardIdValid(listCardId, null) == false) {
            return true;
        }
        return false;
    }

    public Boolean TestCase9() {
        List<Integer> listCardId = new ArrayList<Integer>();
        //case 3b 4b 5b 6b 7b 8b

        listCardId.add(31);
        listCardId.add(41);
        listCardId.add(51);
        listCardId.add(61);
        listCardId.add(71);
        listCardId.add(81);
        TaLaCardHand hand = new TaLaCardHand();
         hand.AddToCurrentHand(31);
        hand.AddToCurrentHand(41); 
        hand.AddToCurrentHand(51);
        hand.AddToCurrentHand(61);
        hand.AddToCurrentHand(71);
        hand.AddToCurrentHand(81);
        if (hand.IsListCardIdValid(listCardId, null) == false) {
            return true;
        }
        return false;
    }
    public Boolean TestCase10() {
        List<Integer> listCardId = new ArrayList<Integer>();
        //case 3b 3c 3r 4b
        listCardId.add(31);
        listCardId.add(32);
        listCardId.add(33);
        listCardId.add(41);
        TaLaCardHand hand = new TaLaCardHand();
        hand.AddToCurrentHand(31);
        hand.AddToCurrentHand(32);
        hand.AddToCurrentHand(33);
        hand.AddToCurrentHand(41);
        if (hand.IsListCardIdValid(listCardId, null) == false) {
            return true;
        }
        return false;
    }
    
    public Boolean TestCase11() {
        List<Integer> listCardId = new ArrayList<Integer>();
        listCardId.add(84);
        listCardId.add(94);
        listCardId.add(104);
        listCardId.add(114);
        listCardId.add(124);
        listCardId.add(134);
        TaLaCardHand hand = new TaLaCardHand();
        hand.AddToCurrentHand(14);
        hand.AddToCurrentHand(32);
        hand.AddToCurrentHand(43);
        hand.AddToCurrentHand(63);
        hand.AddToCurrentHand(84);
        hand.AddToCurrentHand(94);
        hand.AddToCurrentHand(104);
        hand.AddToCurrentHand(114);
        hand.AddToCurrentHand(124);
        hand.AddToCurrentHand(134);
        if (hand.IsListCardIdValid(listCardId, null) == true) {
            return true;
        }
        return false;
    }
}
