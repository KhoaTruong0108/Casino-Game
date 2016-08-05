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
public class GetLeaderBoardResponse extends SFSGameReponse{

   public static String LEADER_BOARD_LIST = "leader_board_list";
   public GetLeaderBoardResponse(){
       super(GAME_RESPONSE_NAME.GET_LEADER_BOARD_RES);
   }
}
