/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.message.reponse.game.poker;

import casino.cardgame.entity.game_entity.Desk;
import casino.cardgame.entity.game_entity.DeskState;
import casino.cardgame.entity.game_entity.ICard;
import casino.cardgame.entity.game_entity.tala.TaLaCardHand;
import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.entities.data.SFSObject;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 *
 * @author Kenjuzi
 */
public class Notify_StandUp extends casino.cardgame.message.reponse.SFSGameReponse {
    private String _userName;
    
    public Notify_StandUp() {
        super(POKER_REPONSE_NAME.STAND_UP_RES);
    }

    public SFSObject ToSFSObject() {
        SFSObject obj = new SFSObject();
        obj.putUtfString("user_name", _userName);
        
        return obj;
    }

    public void setUserName(String userName) {
        this._userName = userName;
    }

}
