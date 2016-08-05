/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.message.event;

import com.smartfoxserver.v2.core.ISFSEvent;
import com.smartfoxserver.v2.core.SFSEventParam;
import com.smartfoxserver.v2.core.SFSEventType;
import com.smartfoxserver.v2.entities.User;



/**
 *
 * @author KIDKID
 */
public class UserJoinZone extends SFSGameEvent {
    private User m_user;
    @Override
    public String GetEventName() {
        return SFSEventType.USER_JOIN_ZONE.toString();
    }
    
    @Override
    public SFSGameEvent FromSFSEvent(ISFSEvent isfse) {
        
        m_user = (User) isfse.getParameter(SFSEventParam.USER);        
        return this;
    }

    /**
     * @return the m_user
     */
    public User getM_user() {
        return m_user;
    }
    
}
