/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.controller.request;

import casino.cardgame.entity.LeaderBoardInfo;
import casino.cardgame.entity.TopWinnerInfo;
import casino.cardgame.message.reponse.GetLeaderBoardResponse;
import casino.cardgame.message.reponse.GetTopWinnerResponse;
import casino.cardgame.message.request.GetLeaderBoardRequest;
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
public class GetLeaderBoardController extends BaseClientRequestHandler{

    @Override
    public void handleClientRequest(User user, ISFSObject isfso) {
        GetLeaderBoardRequest request = (GetLeaderBoardRequest) new GetLeaderBoardRequest().FromSFSObject(isfso);

        List<LeaderBoardInfo> leaderBoards = NormalDataProxy.getInstance().GetLeaderBoard();
        SFSArray listSFSLeaderBoards = new SFSArray();
        for(int i = 0; i < leaderBoards.size(); ++i){
            listSFSLeaderBoards.addSFSObject(leaderBoards.get(i).ToSFSObject());
        }
        GetLeaderBoardResponse response = new GetLeaderBoardResponse();
        response.AddReceiver(user).AddParam(GetTopWinnerResponse.TOP_WINNER_LIST,listSFSLeaderBoards);
       
        this.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());
        
    }
    
}
