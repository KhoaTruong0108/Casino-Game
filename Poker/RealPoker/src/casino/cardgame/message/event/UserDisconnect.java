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
public class UserDisconnect extends SFSGameEvent {
    private User m_user;
    private List<Room> m_listJoinedRoom;
    @Override
    public SFSGameEvent FromSFSEvent(ISFSEvent isfse) {
        m_user =  (User)isfse.getParameter(SFSEventParam.USER);
        m_listJoinedRoom = (List<Room>)isfse.getParameter(SFSEventParam.JOINED_ROOMS);
        return this;
    }

    @Override
    public String GetEventName() {
        return SFSEventType.USER_DISCONNECT.toString();
    }

    /**
     * @return the m_user
     */
    public User getM_user() {
        return m_user;
    }

    /**
     * @return the m_listJoinedRoom
     */
    public List<Room> getM_listJoinedRoom() {
        return m_listJoinedRoom;
    }
    
}
