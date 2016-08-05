/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.utils;

import java.util.logging.Level;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;

/**
 *
 * @author KIDKID
 */
public class Config {

    private static Configuration config;
    public static String UPLOAD_IMG_PATH = "";
    public static String UPLOAD_IMG_TEMP_PATH = "";

    public static void Init(String config_path) {
        try {            
            Logger.trace("Enter RealPoker Config ");
            config = new PropertiesConfiguration(config_path);
            UPLOAD_IMG_PATH = config.getString("upload.path");
            UPLOAD_IMG_TEMP_PATH = config.getString("upload.temp_path");
            Logger.trace("Upload Img Path: " + UPLOAD_IMG_PATH);
            Logger.trace("Upload Temp Img Path: " + UPLOAD_IMG_TEMP_PATH);
        } catch (Exception ex) {
            Logger.error(ex);
        }finally{
            Logger.trace("Exit RealPoker Config ");
        }

    }
}
