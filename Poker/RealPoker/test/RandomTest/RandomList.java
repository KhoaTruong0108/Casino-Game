/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package RandomTest;

import java.util.ArrayList;
import java.util.Random;

/**
 *
 * @author KIDKID
 */
public class RandomList {
    int[] card = {10,11,12,13,
    20,21,22,23,
    30,31,32,33,
    40,41,42,43,
    50,51,52,53,
    60,61,62,63,
    70,71,72,73,
    80,81,82,83,
    90,91,92,93,
    100,101,102,103,
    110,111,112,113,
    120,121,122,123,
    130,131,132,133,
    };
    ArrayList<Integer> CardCollection = new ArrayList<Integer>();
    public ArrayList<Integer> GetRandCard(int num){
        Random random = new Random();
        InitCardCollection();
        ArrayList<Integer> list = new ArrayList<Integer>();
        
        for(int i = 0; i < 10; ++i){
            int index = Math.abs(random.nextInt()%(52 - i));    
            Integer x = CardCollection.remove(index);
            list.add(x);
        }
        return list;
    }
    public void InitCardCollection(){
        CardCollection.clear();
        for(int i = 0; i < 52; i++){
            CardCollection.add(card[i]);
        }
            
    }
}
