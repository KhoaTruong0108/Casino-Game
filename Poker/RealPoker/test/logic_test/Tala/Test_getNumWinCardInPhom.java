/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package logic_test.Tala;

import logic_test.LogicTest;
import casino.cardgame.entity.game_entity.tala.TaLaCardHand;
import casino.cardgame.entity.game_entity.tala.TaLaTableInfo;
import java.util.ArrayList;

/**
 *
 * @author KIDKID
 */
public class Test_getNumWinCardInPhom extends LogicTest {

    @Override
    public Boolean RunTest() {
        AssertTrue(TestCase1(), "TestCase1");
        AssertTrue(TestCase2(), "TestCase2");
           
        return true;

    }
    
    public Boolean TestCase1() {
        TaLaTableInfo talaInfo = new TaLaTableInfo();
        talaInfo.setBetChip(100);
        
        String user1 = "user1";
        String user2 = "user2";
        String user3 = "user3";
        talaInfo.getMapUserWinCard().put(user1, new ArrayList<Integer>());
        talaInfo.getMapUserWinCard().put(user2, new ArrayList<Integer>());
        talaInfo.getMapUserWinCard().put(user3, new ArrayList<Integer>());
        talaInfo.getMapUserWinFromPlayer().put(user1, new ArrayList<String>());
        talaInfo.getMapUserWinFromPlayer().put(user2, new ArrayList<String>());
        talaInfo.getMapUserWinFromPlayer().put(user3, new ArrayList<String>());
        talaInfo.getMapUserWinChip().put(user1, new ArrayList<Double>());
        talaInfo.getMapUserWinChip().put(user2, new ArrayList<Double>());
        talaInfo.getMapUserWinChip().put(user3, new ArrayList<Double>());
        
        int wincard1 = 51;
        int wincard2 = 52;
        
        talaInfo.getMapUserWinCard(user1).add(wincard1);
        talaInfo.getMapUserWinCard(user1).add(wincard2);
        talaInfo.getMapUserWinFromPlayer(user1).add(user3);
        talaInfo.getMapUserWinFromPlayer(user1).add(user3);
        talaInfo.getMapUserWinChip(user1).add(200.0);
        talaInfo.getMapUserWinChip(user1).add(300.0);
        
        ArrayList<Integer> phom = new ArrayList<Integer>();
        phom.add(51);
        phom.add(52);
        phom.add(53);
        phom.add(54);
        
        if(talaInfo.getNumWinCardInPhom(user1, phom) == 2) return true;
        return false;
    }
    
    public Boolean TestCase2() {
        TaLaTableInfo talaInfo = new TaLaTableInfo();
        talaInfo.setBetChip(100);
        
        String user1 = "user1";
        String user2 = "user2";
        String user3 = "user3";
        talaInfo.getMapUserWinCard().put(user1, new ArrayList<Integer>());
        talaInfo.getMapUserWinCard().put(user2, new ArrayList<Integer>());
        talaInfo.getMapUserWinCard().put(user3, new ArrayList<Integer>());
        talaInfo.getMapUserWinFromPlayer().put(user1, new ArrayList<String>());
        talaInfo.getMapUserWinFromPlayer().put(user2, new ArrayList<String>());
        talaInfo.getMapUserWinFromPlayer().put(user3, new ArrayList<String>());
        talaInfo.getMapUserWinChip().put(user1, new ArrayList<Double>());
        talaInfo.getMapUserWinChip().put(user2, new ArrayList<Double>());
        talaInfo.getMapUserWinChip().put(user3, new ArrayList<Double>());
        
        int wincard1 = 51;
        int wincard2 = 52;
        
        talaInfo.getMapUserWinCard(user1).add(wincard1);
        talaInfo.getMapUserWinCard(user1).add(wincard2);
        talaInfo.getMapUserWinFromPlayer(user1).add(user3);
        talaInfo.getMapUserWinFromPlayer(user1).add(user3);
        talaInfo.getMapUserWinChip(user1).add(200.0);
        talaInfo.getMapUserWinChip(user1).add(300.0);
        
        ArrayList<Integer> phom = new ArrayList<Integer>();
        phom.add(32);
        phom.add(42);
        phom.add(52);
        phom.add(62);
        
        if(talaInfo.getNumWinCardInPhom(user1, phom) == 1) return true;
        return false;
    }
}
