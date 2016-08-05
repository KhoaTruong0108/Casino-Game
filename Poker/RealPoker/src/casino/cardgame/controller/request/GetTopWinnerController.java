/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.controller.request;

import casino.cardgame.entity.TopWinnerInfo;
import casino.cardgame.message.reponse.GetTopWinnerResponse;
import casino.cardgame.message.request.GetTopWinnerRequest;
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
public class GetTopWinnerController extends BaseClientRequestHandler{

    @Override
    public void handleClientRequest(User user, ISFSObject isfso) {
        GetTopWinnerRequest request = (GetTopWinnerRequest) new GetTopWinnerRequest().FromSFSObject(isfso);
        
        List<TopWinnerInfo> listWiner = NormalDataProxy.getInstance().GetTopWiner();
        SFSArray listSFSWinner = new SFSArray();
        for(int i = 0; i < listWiner.size(); ++i){
            listSFSWinner.addSFSObject(listWiner.get(i).ToSFSObject());
        }
        GetTopWinnerResponse response = new GetTopWinnerResponse();
        response.AddReceiver(user).AddParam(GetTopWinnerResponse.TOP_WINNER_LIST,listSFSWinner );
       
        this.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());
        
    }
    
}
