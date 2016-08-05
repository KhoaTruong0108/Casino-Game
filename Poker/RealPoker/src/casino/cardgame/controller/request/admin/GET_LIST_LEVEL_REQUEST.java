/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.controller.request.admin;

import casino.cardgame.message.request.admin.GetListLevelRequest;
import casino.cardgame.message.request.admin.GetListTournamentRequest;
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
public class GET_LIST_LEVEL_REQUEST extends BaseClientRequestHandler{

    @Override
    public void handleClientRequest(User user, ISFSObject isfso) {
        try{
            //khoatd
            GetListLevelRequest request = new GetListLevelRequest();
            request.setM_user(user);
            request.FromSFSObject(isfso);
            GlobalValue.serverHandler.HandleAdminMessage(request);
        }catch(Exception ex){
            Logger.error(this.getClass(), ex);
        }
    }
    
}
