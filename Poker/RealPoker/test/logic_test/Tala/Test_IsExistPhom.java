/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package logic_test.Tala;

import logic_test.LogicTest;
import casino.cardgame.entity.game_entity.tala.TaLaCardHand;

/**
 *
 * @author KIDKID
 */
public class Test_IsExistPhom extends LogicTest {

    @Override
    public Boolean RunTest() {
        AssertTrue(TestCase1(), "TestCase1");
        AssertTrue(TestCase2(), "TestCase2");
        AssertTrue(TestCase3(), "TestCase3");
        AssertTrue(TestCase4(), "TestCase4");
        AssertTrue(TestCase5(), "TestCase5");
        AssertTrue(TestCase6(), "TestCase6");
        AssertTrue(TestCase7(), "TestCase7");
        AssertTrue(TestCase8(), "TestCase8");
           
        return true;

    }
    
    public Boolean TestCase1() {
        TaLaCardHand hand = new TaLaCardHand();
        hand.AddToCurrentHand(31);
        hand.AddToCurrentHand(32);
        hand.AddToCurrentHand(33);
        if(hand.IsExistPhom() == false) return false;
        return true;
    }
    
    public Boolean TestCase2() {
        TaLaCardHand hand = new TaLaCardHand();
        hand.AddToCurrentHand(63);
        hand.AddToCurrentHand(32);
        hand.AddToCurrentHand(43);
        hand.AddToCurrentHand(71);
        hand.AddToCurrentHand(53);
        hand.AddToCurrentHand(33);
         if(hand.IsExistPhom() == false) return false;
        return true;
    }
    public Boolean TestCase5() {
        TaLaCardHand hand = new TaLaCardHand();
        hand.AddToCurrentHand(63);
        hand.AddToCurrentHand(121);
        hand.AddToCurrentHand(43);
        hand.AddToCurrentHand(131);
        hand.AddToCurrentHand(53);
        hand.AddToCurrentHand(11);
         if(hand.IsExistPhom() == false) return false;
        return true;
    }
    public Boolean TestCase6() {
        TaLaCardHand hand = new TaLaCardHand();
        hand.AddToCurrentHand(63);
        hand.AddToCurrentHand(121);
        hand.AddToCurrentHand(31);
        hand.AddToCurrentHand(21);
        hand.AddToCurrentHand(53);
        hand.AddToCurrentHand(11);
         if(hand.IsExistPhom() == false) return false;
        return true;
    }
        //TESTCASE WRONG
    public Boolean TestCase3() {
        TaLaCardHand hand = new TaLaCardHand();
        hand.AddToCurrentHand(31);
        hand.AddToCurrentHand(42);
        hand.AddToCurrentHand(52);
         if(hand.IsExistPhom() == true) return false;
        return true;
    }
    
    public Boolean TestCase4() {
        TaLaCardHand hand = new TaLaCardHand();
        hand.AddToCurrentHand(31);
        hand.AddToCurrentHand(42);
        hand.AddToCurrentHand(52);
         if(hand.IsExistPhom() == true) return false;
        return true;
    }
    //K A 2
    public Boolean TestCase7() {
        TaLaCardHand hand = new TaLaCardHand();
        hand.AddToCurrentHand(63);
        hand.AddToCurrentHand(131);
        hand.AddToCurrentHand(81);
        hand.AddToCurrentHand(21);
        hand.AddToCurrentHand(53);
        hand.AddToCurrentHand(11);
         if(hand.IsExistPhom() == true) return false;
        return true;
    }
    public Boolean TestCase8() {
        TaLaCardHand hand = new TaLaCardHand();
        hand.AddToCurrentHand(14);
        hand.AddToCurrentHand(12);
        hand.AddToCurrentHand(44);
        hand.AddToCurrentHand(52);
        hand.AddToCurrentHand(53);
        hand.AddToCurrentHand(64);
        hand.AddToCurrentHand(71);
        hand.AddToCurrentHand(122);
        hand.AddToCurrentHand(134);
        hand.AddToCurrentHand(132);
        hand.AddToCurrentHand(112);
         if(hand.IsExistPhom() == false) return false;
        return true;
    }
}
