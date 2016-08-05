/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.controller.request;

import casino.cardgame.message.request.GetUserInfoRequest;
import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;

/**
 *
 * @author Kenjuzi
 */
public class GetUserInfoController extends BaseClientRequestHandler {

    
    @Override
    public void handleClientRequest(User user, ISFSObject isfso) {
        GetUserInfoRequest request = (GetUserInfoRequest) new GetUserInfoRequest().FromSFSObject(isfso);
        //request.
    }
    
}
