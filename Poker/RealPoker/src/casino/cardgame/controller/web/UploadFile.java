/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.controller.web;

import casino.cardgame.entity.UserInfo;
import casino.cardgame.utils.GlobalValue;
import casino.cardgame.utils.Logger;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author Kenjuzi
 */
public class UploadFile extends CoreAction {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            boolean result = false;
            List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(req);
            for (FileItem item : items) {
                if (item.isFormField()) {
                    // Process regular form field (input type="text|radio|checkbox|etc", select, etc).
                    String fieldname = item.getFieldName();
                    String fieldvalue = item.getString();
                    // ... (do your job here)
                } else {
                    // Process form file field (input type="file").
                    String fieldname = item.getFieldName();
                    String filename = item.getName();
                    InputStream filecontent = item.getInputStream();
                    
                    result = true;
                }
            }

            //response for client
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("result", result);
            printJSON(jsonObject, resp);
        } catch (Exception exc) {
            Logger.error(this.getClass(), exc);
        }
    }
}
