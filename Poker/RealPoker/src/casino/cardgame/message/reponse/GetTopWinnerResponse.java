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
public class GetTopWinnerResponse extends SFSGameReponse{
   public static String TOP_WINNER_LIST = "top_winner_list";
   public GetTopWinnerResponse(){
       super(GAME_RESPONSE_NAME.GET_TOP_WINNER_RES);
   }
    
}
