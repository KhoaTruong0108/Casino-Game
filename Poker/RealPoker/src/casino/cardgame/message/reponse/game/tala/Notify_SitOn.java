/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.message.reponse.game.tala;

import casino.cardgame.entity.game_entity.Desk;
import casino.cardgame.entity.game_entity.DeskState;
import casino.cardgame.entity.game_entity.ICard;
import casino.cardgame.entity.game_entity.tala.TaLaCardHand;
import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.entities.data.SFSObject;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 *
 * @author Kenjuzi
 */
public class Notify_SitOn extends casino.cardgame.message.reponse.SFSGameReponse {
    //khoatd: Notify_SitOn
    //  Notify_sitOn được response về khi user vào game (vì chỉ duy nhất LoginEvt có out data)
    //      1: Game chưa start (chỉ chứa tên các player)
    //      2: Game đang chơi (gồm tên các player, các lá bài hiện tại(handCard, leaveCard, winCard).

//    private String currentUser;
//    private List<Desk> listDesk;
//    private HashMap<String, TaLaCardHand> mapUserCard;
    private boolean isGameStart;
    private boolean isPrestart;
    private int prestartTime;
    private ArrayList<Desk> listDesk;
    private ArrayList<String> listUser;
    private ArrayList<ArrayList<Integer>> listHandCard;
    private ArrayList<ArrayList<Integer>> listLeaveCard;
    private ArrayList<ArrayList<Integer>> listWinCard;

    public Notify_SitOn() {
        super(TALA_REPONSE_NAME.SIT_ON_RES);
    }

    public SFSObject ToSFSObject() {
        SFSObject obj = new SFSObject();
        obj.putBool("is_game_start", isIsGameStart());
        obj.putBool("is_prestart", isPrestart());
        obj.putInt("prestart_time", prestartTime);

        SFSArray sfsDesk = new SFSArray();
        for (int i = 0; i < getListDesk().size(); i++) {
            sfsDesk.addSFSObject(DeskToSFSObject(getListDesk().get(i)));
        }
        obj.putSFSArray("list_desk", sfsDesk);

        SFSArray sfsUser = new SFSArray();
        for (int i = 0; i < listUser.size(); i++) {
            sfsUser.addUtfString(listUser.get(i));
        }
        obj.putSFSArray("list_player", sfsUser);

        //push list card hand in hashMap to sfsArray
        SFSArray sfsListCardHand = new SFSArray();
        for (int i = 0; i < getListHandCard().size(); i++) {
            ArrayList<Integer> cards = getListHandCard().get(i);
            SFSArray sfsCards = new SFSArray();
            for (int j = 0; j < cards.size(); j++) {
                sfsCards.addInt(cards.get(j));
            }
            sfsListCardHand.addSFSArray(sfsCards);
        }
        obj.putSFSArray("list_Hand_Card", sfsListCardHand);

        SFSArray sfsListLeaveCard = new SFSArray();
        for (int i = 0; i < getListLeaveCard().size(); i++) {
            ArrayList<Integer> cards = getListLeaveCard().get(i);
            SFSArray sfsCards = new SFSArray();
            for (int j = 0; j < cards.size(); j++) {
                sfsCards.addInt(cards.get(j));
            }
            sfsListLeaveCard.addSFSArray(sfsCards);
        }
        obj.putSFSArray("list_Leave_Card", sfsListLeaveCard);

        SFSArray sfsListWinHand = new SFSArray();
        for (int i = 0; i < getListWinCard().size(); i++) {
            ArrayList<Integer> cards = getListWinCard().get(i);
            SFSArray sfsCards = new SFSArray();
            for (int j = 0; j < cards.size(); j++) {
                sfsCards.addInt(cards.get(j));
            }
            sfsListWinHand.addSFSArray(sfsCards);
        }
        obj.putSFSArray("list_Win_Card", sfsListWinHand);
        return obj;
    }
    //khoatd

    protected static SFSObject DeskToSFSObject(Desk desk) {
        SFSObject sfsobj = new SFSObject();
        sfsobj.putInt("deskID", desk.getDeskId());
        String state = "";
        if (desk.getDeskState() != DeskState.EMPTY) {
            state = "EMPTY";
        } else if (desk.getDeskState() != DeskState.PLAYING) {
            state = "PLAYING";
        } else if (desk.getDeskState() != DeskState.STOP_PLAYING) {
            state = "STOP_PLAYING";
        } else if (desk.getDeskState() != DeskState.WAITING) {
            state = "WAITING";
        }
        sfsobj.putUtfString("deskState", state);
        User user = desk.getUser();
        if (user != null) {
            sfsobj.putUtfString("userName", desk.getUser().getName());
            //khoatd
            sfsobj.putDouble("chip", desk.getChip());
        }
        return sfsobj;
    }

    /**
     * @return the isGameStart
     */
    public boolean isIsGameStart() {
        return isGameStart;
    }

    /**
     * @param isGameStart the isGameStart to set
     */
    public Notify_SitOn setIsGameStart(boolean isGameStart) {
        this.isGameStart = isGameStart;
        return this;
    }

    /**
     * @return the listPlayer
     */
    public ArrayList<String> getListUser() {
        return listUser;
    }

    /**
     * @param listPlayer the listPlayer to set
     */
    public Notify_SitOn setListUser(ArrayList<String> listUser) {
        this.listUser = listUser;
        return this;
    }

    /**
     * @return the listCard
     */
    public ArrayList<ArrayList<Integer>> getListHandCard() {
        return listHandCard;
    }

    /**
     * @param listCard the listCard to set
     */
    public Notify_SitOn setListHandCard(ArrayList<ArrayList<Integer>> listCard) {
        this.listHandCard = listCard;
        return this;
    }

    /**
     * @return the listLeaveCard
     */
    public ArrayList<ArrayList<Integer>> getListLeaveCard() {
        return listLeaveCard;
    }

    /**
     * @param listLeaveCard the listLeaveCard to set
     */
    public Notify_SitOn setListLeaveCard(ArrayList<ArrayList<Integer>> listLeaveCard) {
        this.listLeaveCard = listLeaveCard;
        return this;
    }

    /**
     * @return the listWinCard
     */
    public ArrayList<ArrayList<Integer>> getListWinCard() {
        return listWinCard;
    }

    /**
     * @param listWinCard the listWinCard to set
     */
    public Notify_SitOn setListWinCard(ArrayList<ArrayList<Integer>> listWinCard) {
        this.listWinCard = listWinCard;
        return this;
    }

    /**
     * @return the listDesk
     */
    public ArrayList<Desk> getListDesk() {
        return listDesk;
    }

    /**
     * @param listDesk the listDesk to set
     */
    public Notify_SitOn setListDesk(ArrayList<Desk> listDesk) {
        this.listDesk = listDesk;
        return this;
    }

    /**
     * @return the isPrestart
     */
    public boolean isPrestart() {
        return isPrestart;
    }

    /**
     * @param isPrestart the isPrestart to set
     */
    public Notify_SitOn setIsPrestart(boolean isPrestart) {
        this.isPrestart = isPrestart;
        return this;
    }

    /**
     * @param prestartTime the prestartTime to set
     */
    public Notify_SitOn setPrestartTime(int prestartTime) {
        this.prestartTime = prestartTime;
        return this;
    }
}
