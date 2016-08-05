/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.message.request.game;

import casino.cardgame.message.request.GAME_REQUEST_NAME;
import casino.cardgame.message.request.SFSGameRequest;
import com.smartfoxserver.v2.entities.data.ISFSObject;

/**
 *
 * @author Kenjuzi
 */
public class GetListFreeUserRequest extends SFSGameRequest {

    @Override
    public SFSGameRequest FromSFSObject(ISFSObject isfso) {
        return this;
    }

    @Override
    public String GetRequestName() {
        return GAME_REQUEST_NAME.GET_LIST_FREE_USER_REQ;
    }

}
