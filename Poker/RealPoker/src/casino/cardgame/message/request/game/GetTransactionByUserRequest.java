/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.message.request.game;

import casino.cardgame.message.request.GAME_REQUEST_NAME;
import casino.cardgame.message.request.SFSGameRequest;
import casino.cardgame.message.request.admin.ADMIN_REQUEST_NAME;
import com.smartfoxserver.v2.entities.data.ISFSObject;

/**
 *
 * @author Kenjuzi
 */
public class GetTransactionByUserRequest extends SFSGameRequest {

    private String _userName;
    private int _index;
    private int _numRow;
    
    @Override
    public SFSGameRequest FromSFSObject(ISFSObject isfso) {
        _userName = isfso.getUtfString("user_name");
        _index = isfso.getDouble("index").intValue();
        _numRow = isfso.getDouble("num_row").intValue();
        return this;
    }

    @Override
    public String GetRequestName() {
        return GAME_REQUEST_NAME.GET_TRANS_BY_USER_REQ;
    }

    public int getIndex() {
        return _index;
    }

    public int getNumRow() {
        return _numRow;
    }

    public String getUserName() {
        return _userName;
    }

}
