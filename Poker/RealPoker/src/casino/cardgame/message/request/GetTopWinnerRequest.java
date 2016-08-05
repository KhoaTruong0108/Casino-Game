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
public class GetTopWinnerRequest extends SFSGameRequest {

    private int TopWinnerQuantity;
    public static String TOP_WINNER_QUANTITY = "top_winner_quantity";

    @Override
    public SFSGameRequest FromSFSObject(ISFSObject isfso) {
        TopWinnerQuantity = isfso.getInt(TOP_WINNER_QUANTITY);
        return this;
    }

    @Override
    public String GetRequestName() {
        return GAME_REQUEST_NAME.GET_TOP_WINNER_REQ;
    }

    /**
     * @return the TopWinnerQuantity
     */
    public int getTopWinnerQuantity() {
        return TopWinnerQuantity;
    }
}
