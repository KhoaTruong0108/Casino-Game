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
public class ChargeCardRequest extends SFSGameRequest {

    public static String SERIAL_NUMBER = "serial_number";
    public static String CARD_PASS = "card_pass";
    
    private String serialNumber;
    private String cardPass;
    
    @Override
    public SFSGameRequest FromSFSObject(ISFSObject isfso) {
        cardPass = isfso.getUtfString(CARD_PASS);
        serialNumber = isfso.getUtfString(SERIAL_NUMBER);
        return this;
    }

    @Override
    public String GetRequestName() {
        return GAME_REQUEST_NAME.CHARGE_CARD_REQ;
    }

    /**
     * @return the serialNumber
     */
    public String getSerialNumber() {
        return serialNumber;
    }

    /**
     * @return the cardPass
     */
    public String getCardPass() {
        return cardPass;
    }

}
