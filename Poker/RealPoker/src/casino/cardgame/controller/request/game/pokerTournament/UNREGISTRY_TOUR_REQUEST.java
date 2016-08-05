/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.controller.request.game.pokerTournament;

import casino.cardgame.controller.request.game.poker.*;
import casino.cardgame.message.request.game.poker.BetRequest;
import casino.cardgame.message.request.game.poker.CallRequest;
import casino.cardgame.message.request.game.pokerTournament.CreateTourRequest;
import casino.cardgame.message.request.game.pokerTournament.UnregistryRequest;
import casino.cardgame.utils.GlobalValue;
import casino.cardgame.utils.Logger;
import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;

/**
 *
 * @author KIDKID
 * Desc: User request get next card from table card collection to user card collection
 */
public class UNREGISTRY_TOUR_REQUEST extends BaseClientRequestHandler{

    @Override
    public void handleClientRequest(User user, ISFSObject isfso) {
        try{
            //khoatd
            UnregistryRequest request = new UnregistryRequest();
            request.setM_user(user);
            request.FromSFSObject(isfso);
            GlobalValue.serverHandler.HandleGameMessage(request);
        }catch(Exception ex){
            Logger.error(this.getClass(), ex);
        }
    }
    
}
