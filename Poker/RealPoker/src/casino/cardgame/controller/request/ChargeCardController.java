/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.controller.request;

import casino.cardgame.entity.TopWinnerInfo;
import casino.cardgame.message.reponse.ChargeCardResponse;
import casino.cardgame.message.reponse.GetTopWinnerResponse;
import casino.cardgame.message.request.ChargeCardRequest;
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
public class ChargeCardController extends BaseClientRequestHandler {

    @Override
    public void handleClientRequest(User user, ISFSObject isfso) {
        ChargeCardRequest request = (ChargeCardRequest) new ChargeCardRequest().FromSFSObject(isfso);

        String serial = request.getSerialNumber();
        String cardPass = request.getCardPass();

        double gameChips = validateCard(serial, cardPass);
        boolean result = false;
        String message = "";
        if (gameChips == -1) {
            result = false;
            message = "Serial number card is invalid! Please try again";
        } else {
            result = true;
            message = "charging success!";
        }

        ChargeCardResponse response = new ChargeCardResponse();
        response.AddReceiver(user);
        response.AddParam(ChargeCardResponse.GAME_CHIP, gameChips);
        response.AddParam(ChargeCardResponse.MESAGE, message);
        response.AddParam(ChargeCardResponse.RESULT, result);

        this.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());

    }

    protected double validateCard(String serial, String cardPass) {

        //NormalDataProxy.getInstance().checkCard(serial, cardPass);
        if (serial.equals("123456")) {
            return 100;
        } else {
            return -1;
        }
    }
}
