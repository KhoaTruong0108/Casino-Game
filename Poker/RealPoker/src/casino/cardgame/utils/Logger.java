/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.utils;

import java.util.logging.Level;

/**
 *
 * @author KIDKID
 */
public class Logger {
    
    public static void error(String className,Exception ex){
        ZLogger.error(className, ex);
    }
    public static void error(Exception ex){
        ZLogger.error(ex);
    }
    public static void error(Class org, Exception ex){
        ZLogger.error(org, ex);
    }
    public static void trace(String msg){
        ZLogger.trace(msg);
    }
    public static void trace(Class org,String msg){
        ZLogger.trace(org, msg);
    }
    
    public static void error(Class org,String msg){
        ZLogger.error(org,msg);
    }
    
}
