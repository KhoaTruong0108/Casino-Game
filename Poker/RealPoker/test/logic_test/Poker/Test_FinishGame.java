/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package logic_test.Poker;

import casino.cardgame.entity.game_entity.poker.*;
import logic_test.LogicTest;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author KIDKID
 */
public class Test_FinishGame extends LogicTest {

    @Override
    public Boolean RunTest() {
        TestCase7();
        return true;

    }
    
    protected void printData1(ArrayList<Double> listObj){
        System.out.println();
        for (int i = 0; i < listObj.size(); i++) {
            System.out.print(listObj.get(i).toString());
            System.out.print(" ; ");
        }
    }
    protected void printData2(ArrayList<String> listObj){
        System.out.println();
        for (int i = 0; i < listObj.size(); i++) {
            System.out.print(listObj.get(i));
            System.out.print(" ; ");
        }
    }

    //u4: 9400, u2: 17400, u1: -9200, u3: 3200 pot: 26800
    public Boolean TestCase1() {
        PokerTableInfo info = new PokerTableInfo(100);

        String u1 = "user1";
        String u2 = "user2";
        String u3 = "user3";
        String u4 = "user4";
        
        info.GetListActiveUserName().add(u1);
        info.GetListActiveUserName().add(u2);
        info.GetListActiveUserName().add(u3);
        info.GetListActiveUserName().add(u4);
        
        info.getMapUserBet().put(u1, new UserBetHistory());
        info.getMapUserBet().put(u2, new UserBetHistory());
        info.getMapUserBet().put(u3, new UserBetHistory());
        info.getMapUserBet().put(u4, new UserBetHistory());

        info.processUserAction(PokerGameTurn.BETTING, u1, UserActionType.CALL, 200);
        info.processUserAction(PokerGameTurn.FLOP, u1, UserActionType.CALL, 1000);
        info.processUserAction(PokerGameTurn.TURN, u1, UserActionType.RAISE, 5000);
        info.processUserAction(PokerGameTurn.RIVER, u1, UserActionType.CALL, 3000);

        info.processUserAction(PokerGameTurn.BETTING, u2, UserActionType.CALL, 200);
        info.processUserAction(PokerGameTurn.FLOP, u2, UserActionType.CALL, 1000);
        info.processUserAction(PokerGameTurn.TURN, u2, UserActionType.CALL, 5000);
        info.processUserAction(PokerGameTurn.RIVER, u2, UserActionType.RAISE, 3000);

        info.processUserAction(PokerGameTurn.BETTING, u3, UserActionType.CALL, 200);
        info.processUserAction(PokerGameTurn.FLOP, u3, UserActionType.BET, 1000);
        info.processUserAction(PokerGameTurn.TURN, u3, UserActionType.FOLD, 2000);

        info.processUserAction(PokerGameTurn.BETTING, u4, UserActionType.CALL, 200);
        info.processUserAction(PokerGameTurn.FLOP, u4, UserActionType.CALL, 1000);
        info.processUserAction(PokerGameTurn.TURN, u4, UserActionType.GOING_ALL_IN, 4000);

        ArrayList<String> listWinners = new ArrayList<String>();
        listWinners.add(u2);
        listWinners.add(u4);
        ArrayList<String> listLoser = new ArrayList<String>();
        listLoser.add(u1);
        listLoser.add(u3);

        ArrayList<Double> listChip = info.processCaculateChip(listWinners, listLoser);

        int i = 0;
        ArrayList<String> listUser = new ArrayList<String>();
        for (i = 0; i < listWinners.size(); i++) {
            listUser.add(listWinners.get(i));
        }
        for (i = 0; i < listLoser.size(); i++) {
            listUser.add(listLoser.get(i));
        }
        
        printData2(listUser);
        printData1(listChip);

        return true;
    }
    
    //user4: 18800, user2: 4000, use1: 4000, user3: -3200 pot: 26800
    public Boolean TestCase2() {
        PokerTableInfo info = new PokerTableInfo(100);

        String u1 = "user1";
        String u2 = "user2";
        String u3 = "user3";
        String u4 = "user4";
        
        info.GetListActiveUserName().add(u1);
        info.GetListActiveUserName().add(u2);
        info.GetListActiveUserName().add(u3);
        info.GetListActiveUserName().add(u4);
        
        info.getMapUserBet().put(u1, new UserBetHistory());
        info.getMapUserBet().put(u2, new UserBetHistory());
        info.getMapUserBet().put(u3, new UserBetHistory());
        info.getMapUserBet().put(u4, new UserBetHistory());

        info.processUserAction(PokerGameTurn.BETTING, u1, UserActionType.CALL, 200);
        info.processUserAction(PokerGameTurn.FLOP, u1, UserActionType.CALL, 1000);
        info.processUserAction(PokerGameTurn.TURN, u1, UserActionType.RAISE, 5000);
        info.processUserAction(PokerGameTurn.RIVER, u1, UserActionType.CALL, 3000);

        info.processUserAction(PokerGameTurn.BETTING, u2, UserActionType.CALL, 200);
        info.processUserAction(PokerGameTurn.FLOP, u2, UserActionType.CALL, 1000);
        info.processUserAction(PokerGameTurn.TURN, u2, UserActionType.CALL, 5000);
        info.processUserAction(PokerGameTurn.RIVER, u2, UserActionType.RAISE, 3000);

        info.processUserAction(PokerGameTurn.BETTING, u3, UserActionType.CALL, 200);
        info.processUserAction(PokerGameTurn.FLOP, u3, UserActionType.BET, 1000);
        info.processUserAction(PokerGameTurn.TURN, u3, UserActionType.FOLD, 2000);

        info.processUserAction(PokerGameTurn.BETTING, u4, UserActionType.CALL, 200);
        info.processUserAction(PokerGameTurn.FLOP, u4, UserActionType.CALL, 1000);
        info.processUserAction(PokerGameTurn.TURN, u4, UserActionType.GOING_ALL_IN, 4000);

        ArrayList<String> listWinners = new ArrayList<String>();
        listWinners.add(u4);
        ArrayList<String> listLoser = new ArrayList<String>();
        listLoser.add(u2);
        listLoser.add(u1);
        listLoser.add(u3);

        ArrayList<Double> listChip = info.processCaculateChip(listWinners, listLoser);

        int i = 0;
        ArrayList<String> listUser = new ArrayList<String>();
        for (i = 0; i < listWinners.size(); i++) {
            listUser.add(listWinners.get(i));
        }
        for (i = 0; i < listLoser.size(); i++) {
            listUser.add(listLoser.get(i));
        }
        
        printData2(listUser);
        printData1(listChip);

        return true;
    }
    
    //user3 = 12800.0; user2 = 6000.0; user1 = 6000.0; user4 = 2000.0; pot: 26800
    public Boolean TestCase3() {
        PokerTableInfo info = new PokerTableInfo(100);

        String u1 = "user1";
        String u2 = "user2";
        String u3 = "user3";
        String u4 = "user4";
        
        info.GetListActiveUserName().add(u1);
        info.GetListActiveUserName().add(u2);
        info.GetListActiveUserName().add(u3);
        info.GetListActiveUserName().add(u4);
        
        info.getMapUserBet().put(u1, new UserBetHistory());
        info.getMapUserBet().put(u2, new UserBetHistory());
        info.getMapUserBet().put(u3, new UserBetHistory());
        info.getMapUserBet().put(u4, new UserBetHistory());

        info.processUserAction(PokerGameTurn.BETTING, u1, UserActionType.CALL, 200);
        info.processUserAction(PokerGameTurn.FLOP, u1, UserActionType.CALL, 1000);
        info.processUserAction(PokerGameTurn.TURN, u1, UserActionType.RAISE, 5000);
        info.processUserAction(PokerGameTurn.RIVER, u1, UserActionType.CALL, 3000);

        info.processUserAction(PokerGameTurn.BETTING, u2, UserActionType.CALL, 200);
        info.processUserAction(PokerGameTurn.FLOP, u2, UserActionType.CALL, 1000);
        info.processUserAction(PokerGameTurn.TURN, u2, UserActionType.CALL, 5000);
        info.processUserAction(PokerGameTurn.RIVER, u2, UserActionType.RAISE, 3000);

        info.processUserAction(PokerGameTurn.BETTING, u3, UserActionType.CALL, 200);
        info.processUserAction(PokerGameTurn.FLOP, u3, UserActionType.BET, 1000);
        info.processUserAction(PokerGameTurn.TURN, u3, UserActionType.GOING_ALL_IN, 2000);

        info.processUserAction(PokerGameTurn.BETTING, u4, UserActionType.CALL, 200);
        info.processUserAction(PokerGameTurn.FLOP, u4, UserActionType.CALL, 1000);
        info.processUserAction(PokerGameTurn.TURN, u4, UserActionType.GOING_ALL_IN, 4000);

        ArrayList<String> listWinners = new ArrayList<String>();
        listWinners.add(u3);
        ArrayList<String> listLoser = new ArrayList<String>();
        listLoser.add(u2);
        listLoser.add(u1);
        listLoser.add(u4);

        ArrayList<Double> listChip = info.processCaculateChip(listWinners, listLoser);

        int i = 0;
        ArrayList<String> listUser = new ArrayList<String>();
        for (i = 0; i < listWinners.size(); i++) {
            listUser.add(listWinners.get(i));
        }
        for (i = 0; i < listLoser.size(); i++) {
            listUser.add(listLoser.get(i));
        }
        
        printData2(listUser);
        printData1(listChip);

        return true;
    }
    
    //user5 31000.0; user2 2000.0; user1 2000.0; user4 -5200.0 ; user3 -3200.0 ; user6 -1000.0; pot: 35000
    public Boolean TestCase6() {
        PokerTableInfo info = new PokerTableInfo(100);

        String u1 = "user1";
        String u2 = "user2";
        String u3 = "user3";
        String u4 = "user4";
        String u5 = "user5";
        String u6 = "user6";
        
        info.GetListActiveUserName().add(u1);
        info.GetListActiveUserName().add(u2);
        info.GetListActiveUserName().add(u3);
        info.GetListActiveUserName().add(u4);
        info.GetListActiveUserName().add(u5);
        info.GetListActiveUserName().add(u6);
        
        info.getMapUserBet().put(u1, new UserBetHistory());
        info.getMapUserBet().put(u2, new UserBetHistory());
        info.getMapUserBet().put(u3, new UserBetHistory());
        info.getMapUserBet().put(u4, new UserBetHistory());
        info.getMapUserBet().put(u5, new UserBetHistory());
        info.getMapUserBet().put(u6, new UserBetHistory());

        info.processUserAction(PokerGameTurn.BETTING, u1, UserActionType.CALL, 200);
        info.processUserAction(PokerGameTurn.FLOP, u1, UserActionType.CALL, 1000);
        info.processUserAction(PokerGameTurn.TURN, u1, UserActionType.RAISE, 5000);
        info.processUserAction(PokerGameTurn.RIVER, u1, UserActionType.CALL, 3000);

        info.processUserAction(PokerGameTurn.BETTING, u2, UserActionType.CALL, 200);
        info.processUserAction(PokerGameTurn.FLOP, u2, UserActionType.CALL, 1000);
        info.processUserAction(PokerGameTurn.TURN, u2, UserActionType.CALL, 5000);
        info.processUserAction(PokerGameTurn.RIVER, u2, UserActionType.RAISE, 3000);

        info.processUserAction(PokerGameTurn.BETTING, u3, UserActionType.CALL, 200);
        info.processUserAction(PokerGameTurn.FLOP, u3, UserActionType.BET, 1000);
        info.processUserAction(PokerGameTurn.TURN, u3, UserActionType.FOLD, 2000);

        info.processUserAction(PokerGameTurn.BETTING, u4, UserActionType.CALL, 200);
        info.processUserAction(PokerGameTurn.FLOP, u4, UserActionType.CALL, 1000);
        info.processUserAction(PokerGameTurn.TURN, u4, UserActionType.GOING_ALL_IN, 4000);

        info.processUserAction(PokerGameTurn.BETTING, u5, UserActionType.CALL, 200);
        info.processUserAction(PokerGameTurn.FLOP, u5, UserActionType.CALL, 1000);
        info.processUserAction(PokerGameTurn.TURN, u5, UserActionType.CALL, 5000);
        info.processUserAction(PokerGameTurn.RIVER, u5, UserActionType.GOING_ALL_IN, 1000);

        info.processUserAction(PokerGameTurn.BETTING, u6, UserActionType.CALL, 200);
        info.processUserAction(PokerGameTurn.FLOP, u6, UserActionType.GOING_ALL_IN, 800);

        ArrayList<String> listWinners = new ArrayList<String>();
        listWinners.add(u5);
        ArrayList<String> listLoser = new ArrayList<String>();
        listLoser.add(u2);
        listLoser.add(u1);
        listLoser.add(u4);
        listLoser.add(u3);
        listLoser.add(u6);

        ArrayList<Double> listChip = info.processCaculateChip(listWinners, listLoser);

        int i = 0;
        ArrayList<String> listUser = new ArrayList<String>();
        for (i = 0; i < listWinners.size(); i++) {
            listUser.add(listWinners.get(i));
        }
        for (i = 0; i < listLoser.size(); i++) {
            listUser.add(listLoser.get(i));
        }
        
        printData2(listUser);
        printData1(listChip);

        return true;
    }
    
    //
    public Boolean TestCase7() {
        PokerTableInfo info = new PokerTableInfo(100);

        String u1 = "user1";
        String u2 = "user2";
        String u3 = "user3";
        String u4 = "user4";
        String u5 = "user5";
        String u6 = "user6";
        
        info.GetListActiveUserName().add(u1);
        info.GetListActiveUserName().add(u2);
        info.GetListActiveUserName().add(u3);
        info.GetListActiveUserName().add(u4);
        info.GetListActiveUserName().add(u5);
        info.GetListActiveUserName().add(u6);
        
        info.getMapUserBet().put(u1, new UserBetHistory());
        info.getMapUserBet().put(u2, new UserBetHistory());
        info.getMapUserBet().put(u3, new UserBetHistory());
        info.getMapUserBet().put(u4, new UserBetHistory());
        info.getMapUserBet().put(u5, new UserBetHistory());
        info.getMapUserBet().put(u6, new UserBetHistory());

        info.processUserAction(PokerGameTurn.BETTING, u1, UserActionType.CALL, 200);
        info.processUserAction(PokerGameTurn.FLOP, u1, UserActionType.CALL, 1000);
        info.processUserAction(PokerGameTurn.TURN, u1, UserActionType.RAISE, 5000);
        info.processUserAction(PokerGameTurn.RIVER, u1, UserActionType.CALL, 3000);

        info.processUserAction(PokerGameTurn.BETTING, u2, UserActionType.CALL, 200);
        info.processUserAction(PokerGameTurn.FLOP, u2, UserActionType.CALL, 1000);
        info.processUserAction(PokerGameTurn.TURN, u2, UserActionType.CALL, 5000);
        info.processUserAction(PokerGameTurn.RIVER, u2, UserActionType.RAISE, 3000);

        info.processUserAction(PokerGameTurn.BETTING, u3, UserActionType.CALL, 200);
        info.processUserAction(PokerGameTurn.FLOP, u3, UserActionType.BET, 1000);
        info.processUserAction(PokerGameTurn.TURN, u3, UserActionType.FOLD, 2000);

        info.processUserAction(PokerGameTurn.BETTING, u4, UserActionType.CALL, 200);
        info.processUserAction(PokerGameTurn.FLOP, u4, UserActionType.CALL, 1000);
        info.processUserAction(PokerGameTurn.TURN, u4, UserActionType.GOING_ALL_IN, 4000);

        info.processUserAction(PokerGameTurn.BETTING, u5, UserActionType.CALL, 200);
        info.processUserAction(PokerGameTurn.FLOP, u5, UserActionType.CALL, 1000);
        info.processUserAction(PokerGameTurn.TURN, u5, UserActionType.CALL, 5000);
        info.processUserAction(PokerGameTurn.RIVER, u5, UserActionType.GOING_ALL_IN, 1000);

        info.processUserAction(PokerGameTurn.BETTING, u6, UserActionType.CALL, 200);
        info.processUserAction(PokerGameTurn.FLOP, u6, UserActionType.GOING_ALL_IN, 800);

        ArrayList<String> listWinners = new ArrayList<String>();
        listWinners.add(u6);
        listWinners.add(u1);
        listWinners.add(u5);
        ArrayList<String> listLoser = new ArrayList<String>();
        listLoser.add(u2);
        listLoser.add(u4);
        listLoser.add(u3);

        ArrayList<Double> listChip = info.processCaculateChip(listWinners, listLoser);

        int i = 0;
        ArrayList<String> listUser = new ArrayList<String>();
        for (i = 0; i < listWinners.size(); i++) {
            listUser.add(listWinners.get(i));
        }
        for (i = 0; i < listLoser.size(); i++) {
            listUser.add(listLoser.get(i));
        }
        
        printData2(listUser);
        printData1(listChip);

        return true;
    }
}
