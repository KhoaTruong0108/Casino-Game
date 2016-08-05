/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package RandomTest;

import casino.cardgame.entity.game_entity.tala.TaLaTableInfo;
import java.util.ArrayList;



/**
 *
 * @author KIDKID
 */
public class RTest_GetNumPhom extends RandTest {
    @Override
    public void RunTest(){
        int numRandom = 100;
        TaLaTableInfo info = new TaLaTableInfo();
        for(int i = 0; i < 100;++i){
            RandomList rand = new RandomList();
            ArrayList<Integer> list = rand.GetRandCard(10);
            System.out.print("\n List: ");
            PrintList(list);
            int num = info.GetNumPhom(list);
            System.out.print("\n List: ");
            PrintList(list);
            System.out.print(" Num: " + num);
        }
    }
    public void PrintList(ArrayList<Integer> list){
        for(int i = 0; i < list.size(); ++i){
            System.out.print(list.get(i) + ",");
        }
    }
    
}
