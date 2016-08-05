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
public class Notify_UserSitOut extends casino.cardgame.message.reponse.SFSGameReponse {
    //khoatd: NOtify_userSitOn
    //  NOtify_userSitOn được response về khi có một player join vào game
    //      
    
    private String _userName;
    private boolean _isSitOut;

    public Notify_UserSitOut() {
        super(POKER_REPONSE_NAME.USER_SIT_OUT_RES);
    }

    public SFSObject ToSFSObject() {
        SFSObject obj = new SFSObject();
        obj.putUtfString("user_name", _userName);
        obj.putBool("is_sit_out", _isSitOut);
        return obj;
    }

    public void setUserName(String userName) {
        this._userName = userName;
    }

    public void setIsSitOut(boolean isSitOut) {
        this._isSitOut = isSitOut;
    }
}
