/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.controller.web;

import casino.cardgame.entity.UserInfo;
import casino.cardgame.message.reponse.web.RegisterResponse;
import casino.cardgame.utils.GlobalValue;
import casino.cardgame.utils.Logger;
//import casino.cardgame.utils.data.DbController;
import com.smartfoxserver.v2.db.IDBManager;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;

/**
 *
 * @author KIDKID
 */
public class Register extends CoreAction {
//    protected static int requestCount = 0;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
//            requestCount++;
//            Logger.trace("request count: " + requestCount);
            String userName = req.getParameterValues("userName")[0];
            String password = req.getParameterValues("password")[0];
            String email = req.getParameterValues("email")[0];
            String displayName = req.getParameterValues("displayName")[0];

            UserInfo user = new UserInfo(userName, password, email, displayName, 0.0, 0.0, 0.0, 0.0, null, null, 0.0, "", "", 0, 0, 0, "", "", null, null);

//            DbController m_dbCtrl = DbController.getInstance();
//            boolean result = m_dbCtrl.createNewUser(user);

            user.setChip(1500.0);
            boolean result = GlobalValue.dataProxy.addUserInfo(user);

            //response for client
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("result", result);
            printJSON(jsonObject, resp);
        } catch (Exception exc) {
            Logger.error(this.getClass(), exc);
        }
    }
}
