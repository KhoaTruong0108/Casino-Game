package logic_test.Tala;

import logic_test.LogicTest;
import casino.cardgame.entity.game_entity.Desk;
import casino.cardgame.entity.game_entity.ICard;
import casino.cardgame.entity.game_entity.tala.TaLaCardCollection;
import casino.cardgame.entity.game_entity.tala.TaLaCardHand;
import casino.cardgame.entity.game_entity.tala.TaLaTableInfo;
import java.util.ArrayList;
import java.util.List;

/*
 * To change this template, choose Tools | Templates and open the template in
 * the editor.
 */
/**
 *
 * @author KIDKID
 */
public class Test_finishGame extends LogicTest {

    @Override
    public Boolean RunTest() {
//        TestCase1();
//        TestCase121();
//        TestCase122();
//        TestCase131();
//        TestCase141();
//        TestCase151();
//        TestCase152();
//        TestCase211();
        TestCase221();
//        TestCase231();
//        TestCase241();
//        TestCase251();
//        TestCase261();
//        TestCase271();
        return true;
    }

    protected TaLaCardHand createTalaCardHand(TaLaCardCollection talaCollection, int numbCard){
        TaLaCardHand cardHand = new TaLaCardHand();
        ArrayList<ICard> listCard = new ArrayList<ICard>();
        listCard.addAll(talaCollection.getNextCard(numbCard));
        cardHand.setCurrentHand(listCard);
        return cardHand;
    }
    protected void printListDouble(ArrayList<Double> list){
        for(int i = 0; i< list.size(); i++){
            System.out.print(list.get(i));
            System.out.print(";");
        }
        System.out.println("");
    }
    protected void printListInteger(ArrayList<Integer> list){
        for(int i = 0; i< list.size(); i++){
            System.out.print(list.get(i));
            System.out.print(";");
        }
        System.out.println("");
    }
    protected void printListString(ArrayList<String> list){
        for(int i = 0; i< list.size(); i++){
            System.out.print(list.get(i));
            System.out.print(";");
        }
        System.out.println("");
    }
    
    //3 player have phom, 
    public void TestCase111() {
        System.out.println();
        System.out.println("TestCase1.1.1");
        
        TaLaTableInfo talaInfo = new TaLaTableInfo();
        talaInfo.setBetChip(100);
        
        String user1 = "user1";
        String user2 = "user2";
        String user3 = "user3";
        talaInfo.GetListActiveUserName().add(user1);
        talaInfo.GetListActiveUserName().add(user2);
        talaInfo.GetListActiveUserName().add(user3);
        
        
        talaInfo.getMapUserCard().put(user1, createTalaCardHand(talaInfo.getTaLaCardCollection(),5));
        talaInfo.getMapUserCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        talaInfo.getMapUserCard().put(user3, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        

        talaInfo.getMapUserPhomCard().put(user1, createTalaCardHand(talaInfo.getTaLaCardCollection(),4));
        talaInfo.getMapUserPhomCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),3));
        talaInfo.getMapUserPhomCard().put(user3, createTalaCardHand(talaInfo.getTaLaCardCollection(),3));
        
        
        ArrayList<Integer> listScore = talaInfo.processCaculateScore();
        printListInteger(listScore);
        
        talaInfo.processSetResultForUser(listScore);
        printListString((ArrayList<String>)talaInfo.getListUserNameResult());
        printListInteger((ArrayList<Integer>)talaInfo.getListResult());

        ArrayList<Double> listChip = talaInfo.processCaculateChip();
        printListDouble(listChip);
    }
    
    //3 players and user1 is loose
    public void TestCase121() {
        System.out.println();
        System.out.println("TestCase1.2.1");
        TaLaTableInfo talaInfo = new TaLaTableInfo();
        talaInfo.setBetChip(100);
        
        String user1 = "user1";
        String user2 = "user2";
        String user3 = "user3";
        talaInfo.GetListActiveUserName().add(user1);
        talaInfo.GetListActiveUserName().add(user2);
        talaInfo.GetListActiveUserName().add(user3);
        
        talaInfo.setUserResult(user2, 4);
        talaInfo.setUserResult(user3, -1);
        talaInfo.setUserResult(user1, -1);
        
        talaInfo.getMapUserCard().put(user1, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        talaInfo.getMapUserCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),10));
        talaInfo.getMapUserCard().put(user3, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        
        
        talaInfo.getMapUserPhomCard().put(user1, createTalaCardHand(talaInfo.getTaLaCardCollection(),3));
        talaInfo.getMapUserPhomCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),0));
        talaInfo.getMapUserPhomCard().put(user3, createTalaCardHand(talaInfo.getTaLaCardCollection(),3));
        
        
        ArrayList<Integer> listScore = talaInfo.processCaculateScore();
        printListInteger(listScore);
        
        talaInfo.processSetResultForUser(listScore);
        printListString((ArrayList<String>)talaInfo.getListUserNameResult());
        printListInteger((ArrayList<Integer>)talaInfo.getListResult());

        ArrayList<Double> listChip = talaInfo.processCaculateChip();
        printListDouble(listChip);
    }
    
    //3 players and user2 is loose
    public void TestCase122() {
        System.out.println();
        System.out.println("TestCase1.2.2");
        TaLaTableInfo talaInfo = new TaLaTableInfo();
        talaInfo.setBetChip(100);
        
        String user1 = "user1";
        String user2 = "user2";
        String user3 = "user3";
        talaInfo.GetListActiveUserName().add(user1);
        talaInfo.GetListActiveUserName().add(user2);
        talaInfo.GetListActiveUserName().add(user3);
        
        //loose
        talaInfo.getListUserNameResult().add(user2);
        talaInfo.getListResult().add(4);
        talaInfo.getMapUserCard().put(user1, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        talaInfo.getMapUserCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),10));
        talaInfo.getMapUserCard().put(user3, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        
        
        talaInfo.getMapUserPhomCard().put(user1, createTalaCardHand(talaInfo.getTaLaCardCollection(),3));
        talaInfo.getMapUserPhomCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),0));
        talaInfo.getMapUserPhomCard().put(user3, createTalaCardHand(talaInfo.getTaLaCardCollection(),3));
        
        
        ArrayList<Integer> listScore = talaInfo.processCaculateScore();
        printListInteger(listScore);
        
        talaInfo.processSetResultForUser(listScore);
        printListString((ArrayList<String>)talaInfo.getListUserNameResult());
        printListInteger((ArrayList<Integer>)talaInfo.getListResult());

        ArrayList<Double> listChip = talaInfo.processCaculateChip();
        printListDouble(listChip);
    }
    
    //3 players and user2 and user3 are loose
    public void TestCase131() {
        System.out.println();
        System.out.println("TestCase1.3.1");
        TaLaTableInfo talaInfo = new TaLaTableInfo();
        
        talaInfo.setPotChip(400);
        talaInfo.setBetChip(100);
        
        String user1 = "user1";
        String user2 = "user2";
        String user3 = "user3";
        talaInfo.GetListActiveUserName().add(user1);
        talaInfo.GetListActiveUserName().add(user2);
        talaInfo.GetListActiveUserName().add(user3);
        
        //loose
        talaInfo.getListUserNameResult().add(user2);
        talaInfo.getListResult().add(4);
        talaInfo.getListUserNameResult().add(user3);
        talaInfo.getListResult().add(4);
        
        talaInfo.getMapUserCard().put(user1, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        talaInfo.getMapUserCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),10));
        talaInfo.getMapUserCard().put(user3, createTalaCardHand(talaInfo.getTaLaCardCollection(),10));
        
        
        talaInfo.getMapUserPhomCard().put(user1, createTalaCardHand(talaInfo.getTaLaCardCollection(),3));
        talaInfo.getMapUserPhomCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),0));
        talaInfo.getMapUserPhomCard().put(user3, createTalaCardHand(talaInfo.getTaLaCardCollection(),0));
        
        
        ArrayList<Integer> listScore = talaInfo.processCaculateScore();
        printListInteger(listScore);
        
        talaInfo.processSetResultForUser(listScore);
        printListString((ArrayList<String>)talaInfo.getListUserNameResult());
        printListInteger((ArrayList<Integer>)talaInfo.getListResult());

        ArrayList<Double> listChip = talaInfo.processCaculateChip();
        printListDouble(listChip);
    }
    
    //3 players and all are loose
    public void TestCase141() {
        System.out.println();
        System.out.println("TestCase1.4.1");
        TaLaTableInfo talaInfo = new TaLaTableInfo();
        talaInfo.setBetChip(100);
        
        String user1 = "user1";
        String user2 = "user2";
        String user3 = "user3";
        talaInfo.GetListActiveUserName().add(user1);
        talaInfo.GetListActiveUserName().add(user2);
        talaInfo.GetListActiveUserName().add(user3);
        
        //loose
        talaInfo.getListUserNameResult().add(user3);
        talaInfo.getListResult().add(4);
        talaInfo.getListUserNameResult().add(user2);
        talaInfo.getListResult().add(4);
        talaInfo.getListUserNameResult().add(user1);
        talaInfo.getListResult().add(4);
        
        talaInfo.getMapUserCard().put(user1, createTalaCardHand(talaInfo.getTaLaCardCollection(),10));
        talaInfo.getMapUserCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),10));
        talaInfo.getMapUserCard().put(user3, createTalaCardHand(talaInfo.getTaLaCardCollection(),10));
        
        
        talaInfo.getMapUserPhomCard().put(user1, createTalaCardHand(talaInfo.getTaLaCardCollection(),0));
        talaInfo.getMapUserPhomCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),0));
        talaInfo.getMapUserPhomCard().put(user3, createTalaCardHand(talaInfo.getTaLaCardCollection(),0));
        
        
        ArrayList<Integer> listScore = talaInfo.processCaculateScore();
        printListInteger(listScore);
        
        talaInfo.processSetResultForUser(listScore);
        printListString((ArrayList<String>)talaInfo.getListUserNameResult());
        printListInteger((ArrayList<Integer>)talaInfo.getListResult());

        ArrayList<Double> listChip = talaInfo.processCaculateChip();
        printListDouble(listChip);
    }
    
    //3 players and user1 and user2 are win
    public void TestCase151() {
        System.out.println();
        System.out.println("TestCase1.5.1");
        TaLaTableInfo talaInfo = new TaLaTableInfo();
        talaInfo.setBetChip(100);
        
        String user1 = "user1";
        String user2 = "user2";
        String user3 = "user3";
        talaInfo.GetListActiveUserName().add(user1);
        talaInfo.GetListActiveUserName().add(user2);
        talaInfo.GetListActiveUserName().add(user3);
        
        
        TaLaCardHand handCard = createTalaCardHand(talaInfo.getTaLaCardCollection(),3);
        talaInfo.getMapUserCard().put(user1, handCard);
        talaInfo.getMapUserCard().put(user3, handCard);
        talaInfo.getMapUserCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        
        
        talaInfo.getMapUserPhomCard().put(user1, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        talaInfo.getMapUserPhomCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),3));
        talaInfo.getMapUserPhomCard().put(user3, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        
        
        ArrayList<Integer> listScore = talaInfo.processCaculateScore();
        printListInteger(listScore);
        
        talaInfo.processSetResultForUser(listScore);
        printListString((ArrayList<String>)talaInfo.getListUserNameResult());
        printListInteger((ArrayList<Integer>)talaInfo.getListResult());

        ArrayList<Double> listChip = talaInfo.processCaculateChip();
        printListDouble(listChip);
    }
    
    //3 players and user1, user2, user3 are same score
    public void TestCase152() {
        System.out.println();
        System.out.println("TestCase1.5.2");
        TaLaTableInfo talaInfo = new TaLaTableInfo();
        talaInfo.setBetChip(100);
        
        String user1 = "user1";
        String user2 = "user2";
        String user3 = "user3";
        talaInfo.GetListActiveUserName().add(user1);
        talaInfo.GetListActiveUserName().add(user2);
        talaInfo.GetListActiveUserName().add(user3);
        
        
        TaLaCardHand handCard = createTalaCardHand(talaInfo.getTaLaCardCollection(),3);
        talaInfo.getMapUserCard().put(user1, handCard);
        talaInfo.getMapUserCard().put(user3, handCard);
        talaInfo.getMapUserCard().put(user2, handCard);
        
        
        talaInfo.getMapUserPhomCard().put(user1, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        talaInfo.getMapUserPhomCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        talaInfo.getMapUserPhomCard().put(user3, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        
        
        ArrayList<Integer> listScore = talaInfo.processCaculateScore();
        printListInteger(listScore);
        
        talaInfo.processSetResultForUser(listScore);
        printListString((ArrayList<String>)talaInfo.getListUserNameResult());
        printListInteger((ArrayList<Integer>)talaInfo.getListResult());

        ArrayList<Double> listChip = talaInfo.processCaculateChip();
        printListDouble(listChip);
    }
    
    //4 players 
    public void TestCase211() {
        System.out.println();
        System.out.println("TestCase2.1.1");
        TaLaTableInfo talaInfo = new TaLaTableInfo();
        talaInfo.setBetChip(100);
        
        String user1 = "user1";
        String user2 = "user2";
        String user3 = "user3";
        String user4 = "user4";
        talaInfo.GetListActiveUserName().add(user1);
        talaInfo.GetListActiveUserName().add(user2);
        talaInfo.GetListActiveUserName().add(user3);
        talaInfo.GetListActiveUserName().add(user4);
        
        
        talaInfo.getMapUserCard().put(user1, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        talaInfo.getMapUserCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        talaInfo.getMapUserCard().put(user3, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        talaInfo.getMapUserCard().put(user4, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        
        
        talaInfo.getMapUserPhomCard().put(user1, createTalaCardHand(talaInfo.getTaLaCardCollection(),3));
        talaInfo.getMapUserPhomCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),3));
        talaInfo.getMapUserPhomCard().put(user3, createTalaCardHand(talaInfo.getTaLaCardCollection(),3));
        talaInfo.getMapUserPhomCard().put(user4, createTalaCardHand(talaInfo.getTaLaCardCollection(),3));
        
        
        ArrayList<Integer> listScore = talaInfo.processCaculateScore();
        printListInteger(listScore);
        
        talaInfo.processSetResultForUser(listScore);
        printListString((ArrayList<String>)talaInfo.getListUserNameResult());
        printListInteger((ArrayList<Integer>)talaInfo.getListResult());

        ArrayList<Double> listChip = talaInfo.processCaculateChip();
        printListDouble(listChip);
    }
    
    //4 players and user3 loose
    public void TestCase221() {
        System.out.println();
        System.out.println("TestCase2.1.1");
        TaLaTableInfo talaInfo = new TaLaTableInfo();
        talaInfo.setBetChip(100);
        
        String user1 = "user1";
        String user2 = "user2";
        String user3 = "user3";
        String user4 = "user4";
        talaInfo.GetListActiveUserName().add(user1);
        talaInfo.GetListActiveUserName().add(user2);
        talaInfo.GetListActiveUserName().add(user3);
        talaInfo.GetListActiveUserName().add(user4);
        
        talaInfo.setUserResult(user3, 4);
        talaInfo.setUserResult(user4, -1);
        talaInfo.setUserResult(user1, -1);
        talaInfo.setUserResult(user2, -1);
        
        talaInfo.getMapUserCard().put(user1, createTalaCardHand(talaInfo.getTaLaCardCollection(),3));
        talaInfo.getMapUserCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        talaInfo.getMapUserCard().put(user3, createTalaCardHand(talaInfo.getTaLaCardCollection(),10));
        talaInfo.getMapUserCard().put(user4, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        
        
        talaInfo.getMapUserPhomCard().put(user1, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        talaInfo.getMapUserPhomCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),3));
        talaInfo.getMapUserPhomCard().put(user3, createTalaCardHand(talaInfo.getTaLaCardCollection(),0));
        talaInfo.getMapUserPhomCard().put(user4, createTalaCardHand(talaInfo.getTaLaCardCollection(),3));
        
        
        ArrayList<Integer> listScore = talaInfo.processCaculateScore();
        printListInteger(listScore);
        
        talaInfo.processSetResultForUser(listScore);
        printListString((ArrayList<String>)talaInfo.getListUserNameResult());
        printListInteger((ArrayList<Integer>)talaInfo.getListResult());

        ArrayList<Double> listChip = talaInfo.processCaculateChip();
        printListDouble(listChip);
    }
    
    //4 players and user3, user4 loose
    public void TestCase231() {
        System.out.println();
        System.out.println("TestCase2.3.1");
        TaLaTableInfo talaInfo = new TaLaTableInfo();
        talaInfo.setBetChip(100);
        
        String user1 = "user1";
        String user2 = "user2";
        String user3 = "user3";
        String user4 = "user4";
        talaInfo.GetListActiveUserName().add(user1);
        talaInfo.GetListActiveUserName().add(user2);
        talaInfo.GetListActiveUserName().add(user3);
        talaInfo.GetListActiveUserName().add(user4);
        
        //loose
        talaInfo.getListUserNameResult().add(user4);
        talaInfo.getListResult().add(4);
        talaInfo.getListUserNameResult().add(user3);
        talaInfo.getListResult().add(4);
        
        talaInfo.getMapUserCard().put(user1, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        talaInfo.getMapUserCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        talaInfo.getMapUserCard().put(user3, createTalaCardHand(talaInfo.getTaLaCardCollection(),10));
        talaInfo.getMapUserCard().put(user4, createTalaCardHand(talaInfo.getTaLaCardCollection(),10));
        
        
        talaInfo.getMapUserPhomCard().put(user1, createTalaCardHand(talaInfo.getTaLaCardCollection(),3));
        talaInfo.getMapUserPhomCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),3));
        talaInfo.getMapUserPhomCard().put(user3, createTalaCardHand(talaInfo.getTaLaCardCollection(),0));
        talaInfo.getMapUserPhomCard().put(user4, createTalaCardHand(talaInfo.getTaLaCardCollection(),0));
        
        
        ArrayList<Integer> listScore = talaInfo.processCaculateScore();
        printListInteger(listScore);
        
        talaInfo.processSetResultForUser(listScore);
        printListString((ArrayList<String>)talaInfo.getListUserNameResult());
        printListInteger((ArrayList<Integer>)talaInfo.getListResult());

        ArrayList<Double> listChip = talaInfo.processCaculateChip();
        printListDouble(listChip);
    }
    
    //4 players and user4, user1, user3 loose
    public void TestCase241() {
        System.out.println();
        System.out.println("TestCase2.4.1");
        TaLaTableInfo talaInfo = new TaLaTableInfo();
        talaInfo.setBetChip(100);
        
        String user1 = "user1";
        String user2 = "user2";
        String user3 = "user3";
        String user4 = "user4";
        talaInfo.GetListActiveUserName().add(user1);
        talaInfo.GetListActiveUserName().add(user2);
        talaInfo.GetListActiveUserName().add(user3);
        talaInfo.GetListActiveUserName().add(user4);
        
        //loose
        talaInfo.getListUserNameResult().add(user4);
        talaInfo.getListResult().add(4);
        talaInfo.getListUserNameResult().add(user1);
        talaInfo.getListResult().add(4);
        talaInfo.getListUserNameResult().add(user3);
        talaInfo.getListResult().add(4);
        
        talaInfo.getMapUserCard().put(user1, createTalaCardHand(talaInfo.getTaLaCardCollection(),10));
        talaInfo.getMapUserCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        talaInfo.getMapUserCard().put(user3, createTalaCardHand(talaInfo.getTaLaCardCollection(),10));
        talaInfo.getMapUserCard().put(user4, createTalaCardHand(talaInfo.getTaLaCardCollection(),10));
        
        
        talaInfo.getMapUserPhomCard().put(user1, createTalaCardHand(talaInfo.getTaLaCardCollection(),0));
        talaInfo.getMapUserPhomCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),3));
        talaInfo.getMapUserPhomCard().put(user3, createTalaCardHand(talaInfo.getTaLaCardCollection(),0));
        talaInfo.getMapUserPhomCard().put(user4, createTalaCardHand(talaInfo.getTaLaCardCollection(),0));
        
        
        ArrayList<Integer> listScore = talaInfo.processCaculateScore();
        printListInteger(listScore);
        
        talaInfo.processSetResultForUser(listScore);
        printListString((ArrayList<String>)talaInfo.getListUserNameResult());
        printListInteger((ArrayList<Integer>)talaInfo.getListResult());

        ArrayList<Double> listChip = talaInfo.processCaculateChip();
        printListDouble(listChip);
    }
    
    //4 players and all are loose
    public void TestCase251() {
        System.out.println();
        System.out.println("TestCase2.5.1");
        TaLaTableInfo talaInfo = new TaLaTableInfo();
        talaInfo.setBetChip(100);
        
        String user1 = "user1";
        String user2 = "user2";
        String user3 = "user3";
        String user4 = "user4";
        talaInfo.GetListActiveUserName().add(user1);
        talaInfo.GetListActiveUserName().add(user2);
        talaInfo.GetListActiveUserName().add(user3);
        talaInfo.GetListActiveUserName().add(user4);
        
        //loose
        talaInfo.getListUserNameResult().add(user4);
        talaInfo.getListResult().add(4);
        talaInfo.getListUserNameResult().add(user1);
        talaInfo.getListResult().add(4);
        talaInfo.getListUserNameResult().add(user2);
        talaInfo.getListResult().add(4);
        talaInfo.getListUserNameResult().add(user3);
        talaInfo.getListResult().add(4);
        
        talaInfo.getMapUserCard().put(user1, createTalaCardHand(talaInfo.getTaLaCardCollection(),10));
        talaInfo.getMapUserCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),10));
        talaInfo.getMapUserCard().put(user3, createTalaCardHand(talaInfo.getTaLaCardCollection(),10));
        talaInfo.getMapUserCard().put(user4, createTalaCardHand(talaInfo.getTaLaCardCollection(),10));
        
        
        talaInfo.getMapUserPhomCard().put(user1, createTalaCardHand(talaInfo.getTaLaCardCollection(),0));
        talaInfo.getMapUserPhomCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),0));
        talaInfo.getMapUserPhomCard().put(user3, createTalaCardHand(talaInfo.getTaLaCardCollection(),0));
        talaInfo.getMapUserPhomCard().put(user4, createTalaCardHand(talaInfo.getTaLaCardCollection(),0));
        
        
        ArrayList<Integer> listScore = talaInfo.processCaculateScore();
        printListInteger(listScore);
        
        talaInfo.processSetResultForUser(listScore);
        printListString((ArrayList<String>)talaInfo.getListUserNameResult());
        printListInteger((ArrayList<Integer>)talaInfo.getListResult());

        ArrayList<Double> listChip = talaInfo.processCaculateChip();
        printListDouble(listChip);
    }
    
    //4 players and 2 player have same best score and 1 loose
    public void TestCase261() {
        System.out.println();
        System.out.println("TestCase2.6.1");
        TaLaTableInfo talaInfo = new TaLaTableInfo();
        talaInfo.setBetChip(100);
        
        String user1 = "user1";
        String user2 = "user2";
        String user3 = "user3";
        String user4 = "user4";
        talaInfo.GetListActiveUserName().add(user1);
        talaInfo.GetListActiveUserName().add(user2);
        talaInfo.GetListActiveUserName().add(user3);
        talaInfo.GetListActiveUserName().add(user4);
        
        //loose
        talaInfo.getListUserNameResult().add(user2);
        talaInfo.getListResult().add(4);

        
        TaLaCardHand handCard = createTalaCardHand(talaInfo.getTaLaCardCollection(),3);
        talaInfo.getMapUserCard().put(user1, handCard);
        talaInfo.getMapUserCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),10));
        talaInfo.getMapUserCard().put(user3, handCard);
        talaInfo.getMapUserCard().put(user4, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        
        
        talaInfo.getMapUserPhomCard().put(user1, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        talaInfo.getMapUserPhomCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),0));
        talaInfo.getMapUserPhomCard().put(user3, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        talaInfo.getMapUserPhomCard().put(user4, createTalaCardHand(talaInfo.getTaLaCardCollection(),3));
        
        
        ArrayList<Integer> listScore = talaInfo.processCaculateScore();
        printListInteger(listScore);
        
        talaInfo.processSetResultForUser(listScore);
        printListString((ArrayList<String>)talaInfo.getListUserNameResult());
        printListInteger((ArrayList<Integer>)talaInfo.getListResult());

        ArrayList<Double> listChip = talaInfo.processCaculateChip();
        printListDouble(listChip);
    }
    
    //4 players and 3 player have same best score and 1 loose 
    public void TestCase271() {
        System.out.println();
        System.out.println("TestCase2.7.1");
        TaLaTableInfo talaInfo = new TaLaTableInfo();
        talaInfo.setBetChip(100);
        
        String user1 = "user1";
        String user2 = "user2";
        String user3 = "user3";
        String user4 = "user4";
        talaInfo.GetListActiveUserName().add(user1);
        talaInfo.GetListActiveUserName().add(user2);
        talaInfo.GetListActiveUserName().add(user3);
        talaInfo.GetListActiveUserName().add(user4);
        
        //loose
        talaInfo.getListUserNameResult().add(user2);
        talaInfo.getListResult().add(4);

        
        TaLaCardHand handCard = createTalaCardHand(talaInfo.getTaLaCardCollection(),3);
        talaInfo.getMapUserCard().put(user1, handCard);
        talaInfo.getMapUserCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),10));
        talaInfo.getMapUserCard().put(user3, handCard);
        talaInfo.getMapUserCard().put(user4, handCard);
        
        
        talaInfo.getMapUserPhomCard().put(user1, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        talaInfo.getMapUserPhomCard().put(user2, createTalaCardHand(talaInfo.getTaLaCardCollection(),0));
        talaInfo.getMapUserPhomCard().put(user3, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        talaInfo.getMapUserPhomCard().put(user4, createTalaCardHand(talaInfo.getTaLaCardCollection(),6));
        
        
        ArrayList<Integer> listScore = talaInfo.processCaculateScore();
        printListInteger(listScore);
        
        talaInfo.processSetResultForUser(listScore);
        printListString((ArrayList<String>)talaInfo.getListUserNameResult());
        printListInteger((ArrayList<Integer>)talaInfo.getListResult());

        ArrayList<Double> listChip = talaInfo.processCaculateChip();
        printListDouble(listChip);
    }
    
}
