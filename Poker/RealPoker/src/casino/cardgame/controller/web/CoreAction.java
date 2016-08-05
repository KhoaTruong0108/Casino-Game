/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.controller.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author KIDKID
 */
public abstract class CoreAction extends HttpServlet {

    private static Logger _logger = Logger.getLogger(CoreAction.class);
    
    public CoreAction() {
    }
    
    protected void print(Object obj, HttpServletResponse response) throws IOException {
        try {
            response.setContentType("text/html;charset=UTF-8");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().print(obj);
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception ex) {
            _logger.error(ex);
        }
    }
    
    protected void printJSON(Object json, HttpServletResponse response) throws IOException {
        try {
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().print(json);
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception ex) {
            _logger.error(ex);
        }
        
    }
    
    protected String getClientIP(HttpServletRequest request) {
        return request.getRemoteAddr();
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
