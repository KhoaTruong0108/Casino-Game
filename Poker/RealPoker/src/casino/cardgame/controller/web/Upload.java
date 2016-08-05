/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.controller.web;

import casino.cardgame.entity.UserInfo;
import casino.cardgame.utils.Config;
import casino.cardgame.utils.GlobalValue;
import casino.cardgame.utils.Logger;
import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author KIDKID
 */
public class Upload extends CoreAction {

    
    protected boolean m_isMultiPart = true;
    protected int m_maxFileSize = 5 * 1024 * 1024; //5Mb
    protected int m_maxMemSize = 10 * 1024; //4Kb
    protected File file;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String img = "";
            m_isMultiPart = ServletFileUpload.isMultipartContent(req);
            if (m_isMultiPart) {
                DiskFileItemFactory fileFactory = new DiskFileItemFactory();
                fileFactory.setSizeThreshold(m_maxMemSize);
                fileFactory.setRepository(new File(Config.UPLOAD_IMG_TEMP_PATH));
                ServletFileUpload upload = new ServletFileUpload(fileFactory);
                upload.setSizeMax(m_maxFileSize);

                try {
                    // Parse the request to get file items.
                    List fileItems = upload.parseRequest(req);

                    // Process the uploaded file items
                    Iterator i = fileItems.iterator();

                  
                    while (i.hasNext()) {
                        FileItem fi = (FileItem) i.next();
                        if (!fi.isFormField()) {
                            
                            String username = fi.getFieldName();
                            String fileName = fi.getName();
                            
//                            if (fileName.lastIndexOf("\\") >= 0) {
//                                file = new File(Config.UPLOAD_IMG_PATH + username + "_" 
//                                        + fileName.substring(fileName.lastIndexOf("\\")));
//                            } else {
//                                file = new File(Config.UPLOAD_IMG_PATH + username + "_"
//                                        + fileName.substring(fileName.lastIndexOf("\\") + 1));
//                            }
                            
                            String imgPath = Config.UPLOAD_IMG_PATH + username + "_";
                            DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
                            Calendar cal = Calendar.getInstance();
                            
                            if (fileName.lastIndexOf("\\") >= 0) {
                                imgPath +=  dateFormat.format(cal.getTime()) + "_" + fileName.substring(fileName.lastIndexOf("\\"));
                            } else {
                                imgPath +=  dateFormat.format(cal.getTime()) + "_" +   fileName.substring(fileName.lastIndexOf("\\") + 1);
                            }
                            
                            file = new File(imgPath);
                            
                            UserInfo user = GlobalValue.dataProxy.GetUserInfo(username);
                            user.setAvartar(imgPath);
                            GlobalValue.dataProxy.updateUser(user);
                            
                            fi.write(file);
                            printJSON("true", resp);
                        }
                    }
                } catch (Exception ioEx) {
                    printJSON("false", resp);
                }
            } else {
                printJSON("false", resp);
            }

        } catch (Exception ex) {
            printJSON("false", resp);
            Logger.error(ex);
        }

    }
}
