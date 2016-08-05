/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package logic_test.Tala;

import logic_test.LogicTest;
import casino.cardgame.entity.game_entity.tala.TaLaCardHand;
import casino.cardgame.entity.game_entity.tala.TaLaTableInfo;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author KIDKID
 */
public class Test_GetNumPhom extends LogicTest {

    @Override
    public Boolean RunTest() {
        AssertTrue(TestCase1(), "TestCase1");
        AssertTrue(TestCase2(), "TestCase2");
        AssertTrue(TestCase3(), "TestCase3");
        AssertTrue(TestCase4(), "TestCase4");
        AssertTrue(TestCase5(), "TestCase5");
        return true;

    }
    
    public Boolean TestCase1() {
        List<Integer> listCardId = new ArrayList<Integer>();
        listCardId.add(32);
        listCardId.add(34);
        listCardId.add(33);
        listCardId.add(52);
        listCardId.add(62);
        listCardId.add(72);
        listCardId.add(11);
        listCardId.add(121);
        listCardId.add(131);
        List<Integer> listPhom = null;
        TaLaTableInfo info = new TaLaTableInfo();
//        int totalPhom = info.GetNumPhom(listCardId);
        int totalPhom = info.GetNumPhom2(listCardId, listPhom);
        
        System.out.println(totalPhom);
        if(totalPhom == 3) return true;
        return false;
    }
    
    public Boolean TestCase2() {
        List<Integer> listCardId = new ArrayList<Integer>();
        listCardId.add(32);
        listCardId.add(34);
        listCardId.add(33);
        listCardId.add(52);
        listCardId.add(51);
        listCardId.add(53);
        listCardId.add(81);
        listCardId.add(82);
        listCardId.add(84);
        List<Integer> listPhom = null;
        TaLaTableInfo info = new TaLaTableInfo();
//        int totalPhom = info.GetNumPhom(listCardId);
        int totalPhom = info.GetNumPhom2(listCardId, listPhom);
        
        System.out.println(totalPhom);
        if(totalPhom == 3) return true;
        return false;
    }
    
    public Boolean TestCase3() {
        List<Integer> listCardId = new ArrayList<Integer>();
        listCardId.add(22);
        listCardId.add(32);
        listCardId.add(42);
        listCardId.add(52);
        listCardId.add(62);
        listCardId.add(72);
        listCardId.add(11);
        listCardId.add(121);
        listCardId.add(131);
        List<Integer> listPhom = null;
        TaLaTableInfo info = new TaLaTableInfo();
//        int totalPhom = info.GetNumPhom(listCardId);
        int totalPhom = info.GetNumPhom2(listCardId, listPhom);
        
        System.out.println(totalPhom);
        if(totalPhom == 3) return true;
        return false;
    }
    
    public Boolean TestCase4() {
        List<Integer> listCardId = new ArrayList<Integer>();
        listCardId.add(11);
        listCardId.add(12);
        listCardId.add(14);
        listCardId.add(44);
        listCardId.add(42);
        listCardId.add(43);
        listCardId.add(84);
        listCardId.add(94);
        listCardId.add(104);
        List<Integer> listPhom = null;
        TaLaTableInfo info = new TaLaTableInfo();
//        int totalPhom = info.GetNumPhom(listCardId);
        int totalPhom = info.GetNumPhom2(listCardId, listPhom);
        
        System.out.println(totalPhom);
        if(totalPhom == 3) return true;
        return false;
    }
    
    public Boolean TestCase5() {
        List<Integer> listCardId = new ArrayList<Integer>();
        listCardId.add(51);
        listCardId.add(52);
        listCardId.add(53);
        listCardId.add(84);
        listCardId.add(83);
        listCardId.add(82);
        listCardId.add(11);
        listCardId.add(14);
        listCardId.add(13);
        List<Integer> listPhom = null;
        TaLaTableInfo info = new TaLaTableInfo();
//        int totalPhom = info.GetNumPhom(listCardId);
        int totalPhom = info.GetNumPhom2(listCardId, listPhom);
        
        System.out.println(totalPhom);
        if(totalPhom == 3) return true;
        return false;
    }
}
