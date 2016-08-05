/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.message.event;


import com.smartfoxserver.v2.core.ISFSEvent;
import com.smartfoxserver.v2.core.SFSEvent;
import com.smartfoxserver.v2.core.SFSEventParam;
import com.smartfoxserver.v2.core.SFSEventType;
import com.smartfoxserver.v2.entities.Room;
import com.smartfoxserver.v2.entities.User;
import java.util.List;

/**
 *
 * @author KIDKID
 */
public class UserVariableUpdate extends SFSGameEvent{
    private Room m_room;
    private User m_user;
    private List<UserVariableUpdate> m_variables;
    @Override
    public SFSGameEvent FromSFSEvent(ISFSEvent isfse) {
         setM_room((Room) isfse.getParameter(SFSEventParam.ROOM));
        setM_user((User) isfse.getParameter(SFSEventParam.USER));
        setM_variables((List<UserVariableUpdate>) isfse.getParameter(SFSEventParam.VARIABLES));
        return this;
    }

    @Override
    public String GetEventName() {
        return SFSEventType.USER_VARIABLES_UPDATE.toString();
    }

    /**
     * @return the m_room
     */
    public Room getM_room() {
        return m_room;
    }

    /**
     * @param m_room the m_room to set
     */
    public void setM_room(Room m_room) {
        this.m_room = m_room;
    }

    /**
     * @return the m_user
     */
    public User getM_user() {
        return m_user;
    }

    /**
     * @param m_user the m_user to set
     */
    public void setM_user(User m_user) {
        this.m_user = m_user;
    }

    /**
     * @return the m_variables
     */
    public List<UserVariableUpdate> getM_variables() {
        return m_variables;
    }

    /**
     * @param m_variables the m_variables to set
     */
    public void setM_variables(List<UserVariableUpdate> m_variables) {
        this.m_variables = m_variables;
    }
    
}
