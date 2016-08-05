package logic_test.Tala;

import logic_test.LogicTest;
import casino.cardgame.controller.game.table.TaLaController;
import casino.cardgame.entity.game_entity.Desk;
import casino.cardgame.entity.game_entity.ICard;
import casino.cardgame.entity.game_entity.tala.TaLaCardCollection;
import casino.cardgame.entity.game_entity.tala.TaLaCardHand;
import casino.cardgame.entity.game_entity.tala.TaLaTableInfo;
import com.smartfoxserver.v2.entities.User;
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
public class Test_finishUGame extends LogicTest {

    @Override
    public Boolean RunTest() {
        TestCase1();
        return true;
    }

    protected TaLaCardHand createTalaCardHand(TaLaCardCollection talaCollection, int numbCard) {
        TaLaCardHand cardHand = new TaLaCardHand();
        ArrayList<ICard> listCard = new ArrayList<ICard>();
        listCard.addAll(talaCollection.getNextCard(numbCard));
        cardHand.setCurrentHand(listCard);
        return cardHand;
    }

    protected TaLaCardHand createUCardHand(TaLaCardCollection talaCollection) {
        TaLaCardHand cardHand = new TaLaCardHand();
        ArrayList<ICard> listCard = new ArrayList<ICard>();

        ICard card1 = TaLaCardCollection.getCardById(23);
        listCard.add(card1);
        ICard card2 = TaLaCardCollection.getCardById(33);
        listCard.add(card2);
        ICard card3 = TaLaCardCollection.getCardById(43);
        listCard.add(card3);
        ICard card4 = TaLaCardCollection.getCardById(22);
        listCard.add(card4);
        ICard card5 = TaLaCardCollection.getCardById(21);
        listCard.add(card5);
        ICard card6 = TaLaCardCollection.getCardById(24);
        listCard.add(card6);
        ICard card7 = TaLaCardCollection.getCardById(51);
        listCard.add(card7);
        ICard card8 = TaLaCardCollection.getCardById(61);
        listCard.add(card8);
        ICard card9 = TaLaCardCollection.getCardById(71);
        listCard.add(card9);
//        ICard card10 = TaLaCardCollection.getCardById(84);
//        listCard.add(card10);

        cardHand.setCurrentHand(listCard);
        return cardHand;
    }

    protected void printListDouble(ArrayList<Double> list) {
        for (int i = 0; i < list.size(); i++) {
            System.out.print(list.get(i));
            System.out.print(";");
        }
        System.out.println("");
    }

    protected void printListInteger(ArrayList<Integer> list) {
        for (int i = 0; i < list.size(); i++) {
            System.out.print(list.get(i));
            System.out.print(";");
        }
        System.out.println("");
    }

    protected void printListString(ArrayList<String> list) {
        for (int i = 0; i < list.size(); i++) {
            System.out.print(list.get(i));
            System.out.print(";");
        }
        System.out.println("");
    }

    public void TestCase1() {
        TaLaTableInfo info = new TaLaTableInfo();

        info.setBetChip(100);
        String user1 = "user1";
        String user2 = "user2";
        String user3 = "user3";
        String user4 = "user4";
        info.GetListActiveUserName().add(user1);
        info.GetListActiveUserName().add(user2);
        info.GetListActiveUserName().add(user3);
        info.GetListActiveUserName().add(user4);

        info.getMapUserCard().put(user3, createUCardHand(info.getTaLaCardCollection()));
        info.getMapUserCard().put(user1, createTalaCardHand(info.getTaLaCardCollection(), 9));
        info.getMapUserCard().put(user2, createTalaCardHand(info.getTaLaCardCollection(), 9));
        info.getMapUserCard().put(user4, createTalaCardHand(info.getTaLaCardCollection(), 9));

        List<Integer> listPhom = new ArrayList<Integer>();
        int numPhom = info.GetNumPhom(user3, listPhom);
        System.out.println(numPhom);
        if(numPhom == 3){
            ArrayList<Double> listChip = info.processFinishUGame(user3);
            ArrayList<Integer> listResult = (ArrayList) info.getListResult();
            ArrayList<String> listPlayingUser = (ArrayList) info.getListUserNameResult();

            printListString((ArrayList<String>)info.getListUserNameResult());
            printListInteger((ArrayList<Integer>)info.getListResult());
            printListDouble(listChip);
        }else{
            System.out.println("FALSE");
        }
    }
}
