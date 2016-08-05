/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.message.request.game;

import casino.cardgame.message.request.GAME_REQUEST_NAME;
import casino.cardgame.message.request.SFSGameRequest;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.entities.data.SFSObject;
import java.util.ArrayList;

public class InvitationRequest extends SFSGameRequest {
    
    private ArrayList<String> m_listInviteUser;
    private int m_roomId;
    private String m_message;
    @Override
    public SFSGameRequest FromSFSObject(ISFSObject isfso) {
        SFSObject sfsObj = (SFSObject)isfso.getSFSObject(GAME_REQUEST_NAME.INVITATION_REQ);
        
        m_listInviteUser = new ArrayList<String>();
        SFSArray sfsArray = (SFSArray)sfsObj.getSFSArray("list_invite_user");
        for(int i = 0 ; i< sfsArray.size(); i++){
            getM_listInviteUser().add(sfsArray.getUtfString(i));
        }
        m_roomId = sfsObj.getInt("room_id");
        m_message = sfsObj.getUtfString("message");
        return this;
    }

    @Override
    public String GetRequestName() {
        return GAME_REQUEST_NAME.INVITATION_REQ;
    }

    public int getM_roomId() {
        return m_roomId;
    }

    public String getM_message() {
        return m_message;
    }

    public ArrayList<String> getM_listInviteUser() {
        return m_listInviteUser;
    }

}
