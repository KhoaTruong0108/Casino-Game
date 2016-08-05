/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.message.reponse;

import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;

/**
 *
 * @author Kenjuzi
 */
public class ChargeCardResponse extends SFSGameReponse {

    public static String RESULT = "result";
    public static String GAME_CHIP = "game_chip";
    public static String MESAGE = "mesage";

    public ChargeCardResponse() {
        super(GAME_RESPONSE_NAME.CHARGE_CARD_RES);
    }
}
