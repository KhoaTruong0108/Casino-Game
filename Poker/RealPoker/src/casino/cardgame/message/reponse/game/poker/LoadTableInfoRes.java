/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.message.reponse.game.poker;

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
public class LoadTableInfoRes extends casino.cardgame.message.reponse.SFSGameReponse {
    //khoatd: Notify_SitOn
    //  Notify_sitOn được response về khi user vào game (vì chỉ duy nhất LoginEvt có out data)
    //      1: Game chưa start (chỉ chứa tên các player)
    //      2: Game đang chơi (gồm tên các player, các lá bài hiện tại(handCard, leaveCard, winCard).

    private boolean isGameStart;
    private boolean isPrestart;
    private int prestartTime;
    private ArrayList<Desk> listDesk;
    private ArrayList<String> listUser;
    private ArrayList<String> listUserPlaying;
    private ArrayList<ArrayList<Integer>> listHandCard;
    private ArrayList<Double> listBetChip;
    private ArrayList<Integer> listCommunityCard;
    private ArrayList<String> listUserSitOut;
    private double potChip; //user was ready or not.
    private String dealer;
    private String smallBlind;
    private String bigBlind;
    
    public LoadTableInfoRes() {
        super(POKER_REPONSE_NAME.LOAD_TABLE_INFO_RES);
    }

    public SFSObject ToSFSObject() {
        SFSObject obj = new SFSObject();
        obj.putBool("is_game_start", isGameStart);
        obj.putBool("is_prestart", isPrestart);
        obj.putInt("prestart_time", prestartTime);
        
        obj.putUtfString("dealer", dealer);
        obj.putUtfString("small_blind", smallBlind);
        obj.putUtfString("big_blind", bigBlind);
        
        SFSArray sfsArrDesk = new SFSArray();
        for (int i = 0; i < getListDesk().size(); i++) {
            sfsArrDesk.addSFSObject(DeskToSFSObject(getListDesk().get(i)));
        }
        obj.putSFSArray("list_desk", sfsArrDesk);
        
        SFSArray sfsArrUserSitOut = new SFSArray();
        for (int i = 0; i < listUserSitOut.size(); i++) {
            sfsArrUserSitOut.addUtfString(listUserSitOut.get(i));
        }
        obj.putSFSArray("list_user_sit_out", sfsArrUserSitOut);

        SFSArray sfsArrUser = new SFSArray();
        for (int i = 0; i < listUser.size(); i++) {
            sfsArrUser.addUtfString(listUser.get(i));
        }
        obj.putSFSArray("list_player", sfsArrUser);
        
        SFSArray sfsArrUserPlaying = new SFSArray();
        for (int i = 0; i < listUserPlaying.size(); i++) {
            sfsArrUserPlaying.addUtfString(listUserPlaying.get(i));
        }
        obj.putSFSArray("list_user_playing", sfsArrUserPlaying);

        //push list card hand in hashMap to sfsArray
        SFSArray sfsListCardHand = new SFSArray();
        for (int i = 0; i < listHandCard.size(); i++) {
            ArrayList<Integer> cards = listHandCard.get(i);
            SFSArray sfsCards = new SFSArray();
            for (int j = 0; j < cards.size(); j++) {
                sfsCards.addInt(cards.get(j));
            }
            sfsListCardHand.addSFSArray(sfsCards);
        }
        obj.putSFSArray("list_Hand_Card", sfsListCardHand);
        
        SFSArray sfsArrBetChip = new SFSArray();
        for (int i = 0; i < listBetChip.size(); i++) {
            sfsArrBetChip.addDouble(listBetChip.get(i));
        }
        obj.putSFSArray("list_bet_chip", sfsArrBetChip);

        SFSArray sfsArrCard = new SFSArray();
        for (int i = 0; i < listCommunityCard.size(); i++) {
            sfsArrCard.addInt(listCommunityCard.get(i));
        }
        obj.putSFSArray("list_comminity_card", sfsArrCard);

        obj.putDouble("pot_chip", potChip);
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

    public ArrayList<String> getListUser() {
        return listUser;
    }

    public LoadTableInfoRes setListUser(ArrayList<String> listUser) {
        this.listUser = listUser;
        return this;
    }

    public ArrayList<Desk> getListDesk() {
        return listDesk;
    }

    public LoadTableInfoRes setListDesk(ArrayList<Desk> listDesk) {
        this.listDesk = listDesk;
        return this;
    }

    public ArrayList<Double> getListBetChip() {
        return listBetChip;
    }

    public LoadTableInfoRes setListBetChip(ArrayList<Double> listBetChip) {
        this.listBetChip = listBetChip;
        return this;
    }

    public ArrayList<Integer> getListCommunityCard() {
        return listCommunityCard;
    }

    public LoadTableInfoRes setListCommunityCard(ArrayList<Integer> listCommunityCard) {
        this.listCommunityCard = listCommunityCard;
        return this;
    }

    public double getPotChip() {
        return potChip;
    }

    public LoadTableInfoRes setPotChip(double potChip) {
        this.potChip = potChip;
        return this;
    }

    public LoadTableInfoRes setGameStart(boolean isGameStart) {
        this.isGameStart = isGameStart;
        return this;
    }

    public LoadTableInfoRes setPrestart(boolean isPrestart) {
        this.isPrestart = isPrestart;
        return this;
    }

    public LoadTableInfoRes setPrestartTime(int prestartTime) {
        this.prestartTime = prestartTime;
        return this;
    }
    public LoadTableInfoRes setListHandCard(ArrayList<ArrayList<Integer>> listCard) {
        this.listHandCard = listCard;
        return this;
    }

    public LoadTableInfoRes setDealer(String dealer) {
        this.dealer = dealer;
        return this;
    }

    public LoadTableInfoRes setSmallBlind(String smallBlind) {
        this.smallBlind = smallBlind;
        return this;
    }

    public LoadTableInfoRes setBigBlind(String bigBlind) {
        this.bigBlind = bigBlind;
        return this;
    }

    public LoadTableInfoRes setListUserPlaying(ArrayList<String> listUserPlaying) {
        this.listUserPlaying = listUserPlaying;
        return this;
    }

    public LoadTableInfoRes setListUserSitOut(ArrayList<String> listUserSitOut) {
        this.listUserSitOut = listUserSitOut;
        return this;
    }
}
