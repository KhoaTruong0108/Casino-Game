
import logic_test.Tala.Test_GetNumPhom;
import RandomTest.RTest_GetNumPhom;
import RandomTest.RandTest;
import RandomTest.RTest_GetNumPhom;
import logic_test.LogicTest;
import logic_test.Poker.Test_FinishGame;
import logic_test.Poker.Test_GetWinner;
import logic_test.Poker.Test_PokerHand;
import logic_test.Poker.Test_getPokerCard;

/*
 * To change this template, choose Tools | Templates and open the template in
 * the editor.
 */
/**
 *
 * @author KIDKID
 */
public class Test {

    public static void main(String[] args) {
        LogicTest test = new Test_GetWinner();
//        LogicTest test = new Test_PokerHand();
//        LogicTest test = new Test_getPokerCard();
        test.RunTest();
    }
}
