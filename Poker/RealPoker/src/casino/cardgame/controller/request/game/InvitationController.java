/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.controller.request.game;

import casino.cardgame.entity.TopWinnerInfo;
import casino.cardgame.message.reponse.ChargeCardResponse;
import casino.cardgame.message.reponse.GetTopWinnerResponse;
import casino.cardgame.message.request.ChargeCardRequest;
import casino.cardgame.message.request.game.GetListFreeUserRequest;
import casino.cardgame.message.request.GetTopWinnerRequest;
import casino.cardgame.message.request.game.InvitationRequest;
import casino.cardgame.message.request.game.ConfirmReadyGameRequest;
import casino.cardgame.utils.GlobalValue;
import casino.cardgame.utils.Logger;
import casino.cardgame.utils.data.NormalDataProxy;
import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;
import java.util.List;

/**
 *
 * @author Kenjuzi
 */
public class InvitationController extends BaseClientRequestHandler {

    @Override
    public void handleClientRequest(User user, ISFSObject isfso) {
       try{
            //khoatd
            InvitationRequest request = new InvitationRequest();
            request.setM_user(user);
            request.FromSFSObject(isfso);
            GlobalValue.serverHandler.HandleGameMessage(request);
        }catch(Exception ex){
            Logger.error(this.getClass(), ex);
        }
    }

}
