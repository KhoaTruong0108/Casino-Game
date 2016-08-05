/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.utils;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
/**
 *
 * @author KIDKID
 */
public class ZLogger {
    
     
    public static void error(String className,Exception ex){
         Logger _logger = Logger.getLogger(className);
         _logger.error(ex.getMessage());
         System.out.println(ex.getMessage());
    }
    public static void error(Exception ex){
        Logger _logger = Logger.getLogger(ZLogger.class);
         _logger.error(ex.getMessage());
    }
    public static void error(Class org, Exception ex){
        Logger _logger = Logger.getLogger(org);
         _logger.error(ex.getMessage());
         System.out.println(ex.getMessage());
    }
    public static void trace(String msg){
         Logger _logger = Logger.getLogger(ZLogger.class);
         _logger.setLevel(Level.ALL);
         _logger.debug(msg);
         System.out.println(msg);
         
    }
    public static void trace(Class org,String msg){
        Logger _logger = Logger.getLogger(org);
         _logger.setLevel(Level.ALL);
         _logger.debug(msg);
    }
    
    public static void error(Class org,String msg){
        Logger _logger = Logger.getLogger(org);
         _logger.error(msg);
    }
    
}
