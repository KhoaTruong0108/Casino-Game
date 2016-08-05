/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.message.reponse.game.tala;

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
    
    private String m_UserName;
    private double m_chip;
    private String m_currentUser;
    private DeskState m_deskState;
    private int m_iDeskId;

    public Notify_UserSitOn() {
        super(TALA_REPONSE_NAME.USER_SIT_ON_RES);
    }

    public SFSObject ToSFSObject() {
        SFSObject obj = new SFSObject();
        obj.putUtfString("username", getUserName());
        obj.putDouble("chip", getChip());
        obj.putUtfString("currenUser", m_currentUser);
        obj.putInt("deskID", m_iDeskId);
        String state = "";
        if (m_deskState != DeskState.EMPTY) {
            state = "EMPTY";
        } else if (m_deskState != DeskState.PLAYING) {
            state = "PLAYING";
        } else if (m_deskState != DeskState.STOP_PLAYING) {
            state = "STOP_PLAYING";
        } else if (m_deskState != DeskState.WAITING) {
            state = "WAITING";
        }
        obj.putUtfString("deskState", state);
        return obj;
    }
   

    /**
     * @return the m_iDeskId
     */
    public int getM_iDeskId() {
        return m_iDeskId;
    }

    /**
     * @param m_iDeskId the m_iDeskId to set
     */
    public Notify_UserSitOn setDeskId(int m_iDeskId) {
        this.m_iDeskId = m_iDeskId;
        return this;
        
    }

    /**
     * @return the m_UserName
     */
    public String getUserName() {
        return m_UserName;
    }

    /**
     * @param m_UserName the m_UserName to set
     */
    public Notify_UserSitOn setUserName(String m_UserName) {
        this.m_UserName = m_UserName;
        return this;
    }

    /**
     * @return the m_currentUser
     */
    public String getM_currentUser() {
        return m_currentUser;
    }

    /**
     * @param m_currentUser the m_currentUser to set
     */
    public Notify_UserSitOn setCurrentUser(String m_currentUser) {
        this.m_currentUser = m_currentUser;
        return this;
    }

    /**
     * @return the m_deskState
     */
    public DeskState getM_deskState() {
        return m_deskState;
    }

    /**
     * @param m_deskState the m_deskState to set
     */
    public Notify_UserSitOn setDeskState(DeskState m_deskState) {
        this.m_deskState = m_deskState;
        return this;
    }

    /**
     * @return the m_chip
     */
    public double getChip() {
        return m_chip;
    }

    /**
     * @param m_chip the m_chip to set
     */
    public Notify_UserSitOn setChip(double m_chip) {
        this.m_chip = m_chip;
        return this;
    }
}
