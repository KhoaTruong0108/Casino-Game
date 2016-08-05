/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.message.reponse.game.poker;

import casino.cardgame.entity.game_entity.Desk;
import casino.cardgame.entity.game_entity.DeskState;
import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.entities.data.SFSObject;
import java.util.List;

/**
 *
 * @author Kenjuzi
 */
public class Notify_UserSitOn extends casino.cardgame.message.reponse.SFSGameReponse {
    //khoatd: NOtify_userSitOn
    //  NOtify_userSitOn được response về khi có một player join vào game
    //      
    
    private String UserName;
    private double chip;
    private double buyIn;
    private String currentUser;
    private DeskState deskState;
    private int deskId;

    public Notify_UserSitOn() {
        super(POKER_REPONSE_NAME.USER_SIT_ON_RES);
    }

    public SFSObject ToSFSObject() {
        SFSObject obj = new SFSObject();
        obj.putUtfString("username", getUserName());
        obj.putDouble("chip", chip);
        obj.putDouble("buy_in", buyIn);
        obj.putUtfString("currenUser", currentUser);
        obj.putInt("deskID", deskId);
        String state = "";
        if (deskState != DeskState.EMPTY) {
            state = "EMPTY";
        } else if (deskState != DeskState.PLAYING) {
            state = "PLAYING";
        } else if (deskState != DeskState.STOP_PLAYING) {
            state = "STOP_PLAYING";
        } else if (deskState != DeskState.WAITING) {
            state = "WAITING";
        }
        obj.putUtfString("deskState", state);
        return obj;
    }
   
    public int getDeskId() {
        return deskId;
    }
    public Notify_UserSitOn setDeskId(int m_iDeskId) {
        this.deskId = m_iDeskId;
        return this;
        
    }

    public String getUserName() {
        return UserName;
    }

    public Notify_UserSitOn setUserName(String m_UserName) {
        this.UserName = m_UserName;
        return this;
    }

    public String getCurrentUser() {
        return currentUser;
    }

    public Notify_UserSitOn setCurrentUser(String m_currentUser) {
        this.currentUser = m_currentUser;
        return this;
    }

    public DeskState getDeskState() {
        return deskState;
    }

    public Notify_UserSitOn setDeskState(DeskState m_deskState) {
        this.deskState = m_deskState;
        return this;
    }

    public double getChip() {
        return chip;
    }

    public Notify_UserSitOn setChip(double m_chip) {
        this.chip = m_chip;
        return this;
    }

    public Notify_UserSitOn setBuyIn(double buyIn) {
        this.buyIn = buyIn;
        return this;
    }
}
