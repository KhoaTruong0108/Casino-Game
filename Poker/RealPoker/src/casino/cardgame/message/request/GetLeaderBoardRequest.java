/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.message.request;

import com.smartfoxserver.v2.entities.data.ISFSObject;

/**
 *
 * @author Kenjuzi
 */
public class GetLeaderBoardRequest extends SFSGameRequest{

    //properties

    @Override
    public SFSGameRequest FromSFSObject(ISFSObject isfso) {
        return this;
    }

    @Override
    public String GetRequestName() {
        return GAME_REQUEST_NAME.GET_LEADER_BOARD_REQ;
    }
    
}
