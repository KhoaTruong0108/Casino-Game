/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.utils;

import casino.cardgame.controller.ServerHandler;
import casino.cardgame.controller.game.GameController;
import casino.cardgame.controller.game.table.TaLaController;
import casino.cardgame.controller.server.ServerController;
import casino.cardgame.entity.game_entity.tala.TaLaCardCollection;
import casino.cardgame.utils.data.IDataProxy;
import casino.cardgame.utils.data.IMemoryCached;
import com.smartfoxserver.v2.SmartFoxServer;
import com.smartfoxserver.v2.api.ISFSBuddyApi;
import com.smartfoxserver.v2.api.ISFSGameApi;
import com.smartfoxserver.v2.extensions.BaseSFSExtension;
import sfs2x.extension.realpokerserver.src.SFSServer;

/**
 *
 * @author KIDKID
 */
public class GlobalValue {
    public static SFSServer sfsServer;
    public static ServerHandler serverHandler;
    public static GameController gameController;
    public static ServerController serverController;
    public static ISFSGameApi gameAPI;
    public static ISFSBuddyApi buddyAPI;
    public static SmartFoxServer smartfoxServer;
    public static IDataProxy dataProxy;
}
