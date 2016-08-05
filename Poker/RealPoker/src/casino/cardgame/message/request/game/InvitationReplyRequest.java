/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.message.request.game;

import casino.cardgame.message.request.GAME_REQUEST_NAME;
import casino.cardgame.message.request.SFSGameRequest;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSObject;

/**
 *
 * @author Kenjuzi
 */
public class InvitationReplyRequest extends SFSGameRequest {
    
    private int m_invitationReply;//0: ACCEPT; 1: REFUSE
    private String m_receiverName;
    @Override
    public SFSGameRequest FromSFSObject(ISFSObject isfso) {
        SFSObject sfsObj = (SFSObject)isfso.getSFSObject(GAME_REQUEST_NAME.INVITATION_REQ);
        m_invitationReply = sfsObj.getInt("invitation_reply");
        m_receiverName = sfsObj.getUtfString("receiver_name");
        return this;
    }

    @Override
    public String GetRequestName() {
        return GAME_REQUEST_NAME.INVITATION_REPLY_REQ;
    }

    public int getM_invitationReply() {
        return m_invitationReply;
    }

    public String getM_receiverName() {
        return m_receiverName;
    }
    public void setM_receiverName(String m_receiverName) {
        this.m_receiverName = m_receiverName;
    }

}
