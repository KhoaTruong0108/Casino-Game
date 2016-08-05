/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sfs2x.extension.realpokerserver.src;

import casino.cardgame.controller.CasinoWebServer;
import com.smartfoxserver.v2.extensions.SFSExtension;
import casino.cardgame.controller.ServerHandler;
import casino.cardgame.controller.request.ChargeCardController;
import casino.cardgame.controller.request.GetTopWinnerController;
import casino.cardgame.controller.request.admin.*;
import casino.cardgame.controller.request.game.*;
import casino.cardgame.controller.request.game.poker.SIT_ON_REQUEST;
import casino.cardgame.controller.request.game.poker.*;
import casino.cardgame.controller.request.game.pokerTournament.*;
import casino.cardgame.controller.request.game.tala.*;
import casino.cardgame.message.request.GAME_REQUEST_NAME;
import casino.cardgame.message.request.admin.ADMIN_REQUEST_NAME;
import casino.cardgame.message.request.game.poker.POKER_REQUEST_NAME;
import casino.cardgame.message.request.game.pokerTournament.POKER_TOUR_REQUEST_NAME;
import casino.cardgame.message.request.game.tala.TALA_REQUEST_NAME;
import casino.cardgame.utils.Config;
import casino.cardgame.utils.GlobalValue;
import casino.cardgame.utils.data.NormalDataProxy;
import com.smartfoxserver.v2.SmartFoxServer;
import com.smartfoxserver.v2.api.ISFSBuddyApi;
import com.smartfoxserver.v2.api.ISFSGameApi;
import com.smartfoxserver.v2.core.SFSEventType;
import java.util.logging.Logger;
import sfs2x.extension.realpokerserver.src.sfsHandler.*;
import org.apache.log4j.PropertyConfigurator;

/** 
 *
 * @author Root
 */
public class SFSServer extends SFSExtension {

    protected SmartFoxServer sfs;
    protected ISFSGameApi gameApi;
    protected ISFSBuddyApi buddyApi;
    protected Thread tWebServer;

    protected void RegisterSysEvent() {
        /********************************************************************************/
        /******************************* EVENT HANDLER **********************************/
        /********************************************************************************/
        //CHAT event
        addEventHandler(SFSEventType.PRIVATE_MESSAGE, PRIVATE_MESSAGE.class);
        addEventHandler(SFSEventType.PUBLIC_MESSAGE, PUBLIC_MESSAGE.class);
        //Room Event
        addEventHandler(SFSEventType.ROOM_ADDED, ROOM_ADDED.class);
        addEventHandler(SFSEventType.ROOM_REMOVED, ROOM_REMOVED.class);
        addEventHandler(SFSEventType.ROOM_VARIABLES_UPDATE, ROOM_VARIABLES_UPDATE.class);
        //User Event
        addEventHandler(SFSEventType.SERVER_READY, SERVER_READY.class);
        addEventHandler(SFSEventType.USER_DISCONNECT, USER_DISCONNECT.class);
        addEventHandler(SFSEventType.USER_JOIN_ROOM, USER_JOIN_ROOM.class);
        addEventHandler(SFSEventType.USER_JOIN_ZONE, USER_JOIN_ZONE.class);
        addEventHandler(SFSEventType.USER_LEAVE_ROOM, USER_LEAVE_ROOM.class);
        addEventHandler(SFSEventType.USER_VARIABLES_UPDATE, USER_VARIABLES_UPDATE.class);
        addEventHandler(SFSEventType.SPECTATOR_TO_PLAYER, SPECTATOR_TO_PLAYER.class);
        addEventHandler(SFSEventType.USER_LOGIN, USER_LOGIN.class);
        addEventHandler(SFSEventType.USER_LOGOUT, USER_LOGOUT.class);
        addEventHandler(SFSEventType.PLAYER_TO_SPECTATOR, PLAYER_TO_SPECTATOR.class);

        addRequestHandler(TALA_REQUEST_NAME.CONFIRM_READY_GAME, CONFIRM_READY_GAME_REQUEST.class);
        addRequestHandler(TALA_REQUEST_NAME.GET_NEXT_CARD, GET_NEXT_CARD_REQUEST.class);
        addRequestHandler(TALA_REQUEST_NAME.GET_PLAYER_CARD, GET_PLAYER_CARD_REQUEST.class);
        addRequestHandler(TALA_REQUEST_NAME.REMOVE_CARD, REMOVE_CARD_REQUEST.class);
        addRequestHandler(TALA_REQUEST_NAME.SHOW_CARD, SHOW_CARD_REQUEST.class);
        addRequestHandler(GAME_REQUEST_NAME.CHARGE_CARD_REQ, ChargeCardController.class);

        addRequestHandler(POKER_REQUEST_NAME.STAND_UP_REQ, STAND_UP_REQUEST.class);
        addRequestHandler(POKER_REQUEST_NAME.SIT_ON_REQ, SIT_ON_REQUEST.class);
        addRequestHandler(POKER_REQUEST_NAME.SIT_OUT_REQ, SIT_OUT_REQUEST.class);
        addRequestHandler(POKER_REQUEST_NAME.BET_REQ, BET_REQUEST.class);
        addRequestHandler(POKER_REQUEST_NAME.CALL_REQ, CALL_REQUEST.class);
        addRequestHandler(POKER_REQUEST_NAME.CHECK_REQ, CHECK_REQUEST.class);
        addRequestHandler(POKER_REQUEST_NAME.FOLD_REQ, FOLD_REQUEST.class);
        addRequestHandler(POKER_REQUEST_NAME.GOING_ALL_REQ, GOING_ALL_IN_REQUEST.class);
        addRequestHandler(POKER_REQUEST_NAME.RAISE_REQ, RAISE_REQUEST.class);

        addRequestHandler(POKER_TOUR_REQUEST_NAME.CREATE_TOUR, CREATE_TOUR_REQUEST.class);
        addRequestHandler(POKER_TOUR_REQUEST_NAME.GET_DETAIL_TOUR, GET_DETAIL_TOUR_REQUEST.class);
        addRequestHandler(POKER_TOUR_REQUEST_NAME.GET_LIST_TOUR, GET_LIST_TOUR_REQUEST.class);
        addRequestHandler(POKER_TOUR_REQUEST_NAME.REGISTRY_TOUR, REGISTRY_TOUR_REQUEST.class);
        addRequestHandler(POKER_TOUR_REQUEST_NAME.UNREGISTRY_TOUR, UNREGISTRY_TOUR_REQUEST.class);
        addRequestHandler(POKER_TOUR_REQUEST_NAME.REPLY_INVITE_TOUR, REPLY_INVITE_TOUR_REQUEST.class);

        addRequestHandler(GAME_REQUEST_NAME.GET_LIST_FREE_USER_REQ, GetListFreeUserController.class);
        addRequestHandler(GAME_REQUEST_NAME.INVITATION_REQ, InvitationController.class);
        addRequestHandler(GAME_REQUEST_NAME.INVITATION_REPLY_REQ, InvitationReplyController.class);
        addRequestHandler(GAME_REQUEST_NAME.GET_TRANS_BY_USER_REQ, GetTransactionByUserController.class);
        
        addRequestHandler(ADMIN_REQUEST_NAME.GET_LIST_ROOM_REQ, GET_LIST_ROOM_REQUEST.class);
        addRequestHandler(ADMIN_REQUEST_NAME.GET_LIST_TOURNAMENT_REQ, GET_LIST_TOURNAMENT_REQUEST.class);
        addRequestHandler(ADMIN_REQUEST_NAME.GET_LIST_LEVEL_REQ, GET_LIST_LEVEL_REQUEST.class);
        addRequestHandler(ADMIN_REQUEST_NAME.GET_LEVEL_COLLECTION_REQ, GET_LEVEL_COLLECTION_REQUEST.class);
        addRequestHandler(ADMIN_REQUEST_NAME.GET_LIST_USER_REQ, GET_LIST_USER_REQUEST.class);
        addRequestHandler(ADMIN_REQUEST_NAME.CREATE_USER_REQ, CREATE_USER_REQUEST.class);
        addRequestHandler(ADMIN_REQUEST_NAME.UPDATE_USER_REQ, UPDATE_USER_REQUEST.class);
        addRequestHandler(ADMIN_REQUEST_NAME.DELETE_USER_REQ, DELETE_USER_REQUEST.class);
        addRequestHandler(ADMIN_REQUEST_NAME.CREATE_ROOM_REQ, CREATE_ROOM_REQUEST.class);
        addRequestHandler(ADMIN_REQUEST_NAME.UPDATE_ROOM_REQ, UPDATE_ROOM_REQUEST.class);
        addRequestHandler(ADMIN_REQUEST_NAME.DELETE_ROOM_REQ, DELETE_ROOM_REQUEST.class);
        addRequestHandler(ADMIN_REQUEST_NAME.CREATE_TOUR_REQ, CREATE_TOURNAMENT_REQUEST.class);
        addRequestHandler(ADMIN_REQUEST_NAME.UPDATE_TOUR_REQ, UPDATE_TOURNAMENT_REQUEST.class);
        addRequestHandler(ADMIN_REQUEST_NAME.DELETE_TOUR_REQ, DELETE_TOURNAMENT_REQUEST.class);
        addRequestHandler(ADMIN_REQUEST_NAME.CREATE_LEVEL_REQ, CREATE_LEVEL_REQUEST.class);
        addRequestHandler(ADMIN_REQUEST_NAME.UPDATE_LEVEL_REQ, UPDATE_LEVEL_REQUEST.class);
        addRequestHandler(ADMIN_REQUEST_NAME.DELETE_LEVEL_REQ, DELETE_LEVEL_REQUEST.class);
        addRequestHandler(ADMIN_REQUEST_NAME.UPDATE_TOUR_STATUS_REQ, UPDATE_TOUR_STATUS_REQUEST.class);
        addRequestHandler(ADMIN_REQUEST_NAME.ADD_CHIP_FOR_USER_REQ, ADD_CHIP_REQUEST.class);
        addRequestHandler(ADMIN_REQUEST_NAME.GET_TRANSACTION_REQ, GET_TRANSACTION_REQUEST.class);
    }

    protected void RegisterGameEvent() {
        //SangDN
        addRequestHandler(GAME_REQUEST_NAME.GET_TOP_WINNER_REQ, GetTopWinnerController.class);

    }

    protected ISFSGameApi GetSFSGameAPI() {
        return gameApi;
    }

    protected ISFSBuddyApi GetSFSBuddyAPI() {
        return buddyApi;
    }

    protected SmartFoxServer GetSmartFoxServer() {
        return sfs;
    }

    @Override
    public void init() {
        trace("casino server extension handler");
        //Init Log
        PropertyConfigurator.configure("./conf/config.log4j.properties");
        //Init Config
        Config.Init("./conf/realpoker.conf.properties");
        sfs = SmartFoxServer.getInstance();
        gameApi = sfs.getAPIManager().getGameApi();
        buddyApi = sfs.getAPIManager().getBuddyApi();
        //SangDN: Init Static Variable        
        GlobalValue.sfsServer = this;
        GlobalValue.smartfoxServer = sfs;
        GlobalValue.gameAPI = gameApi;
        GlobalValue.buddyAPI = buddyApi;
        GlobalValue.dataProxy = NormalDataProxy.getInstance();
        GlobalValue.serverHandler = ServerHandler.getInstance();


        //Register SFS System Event
        RegisterSysEvent();
        //Register Game Event
        RegisterGameEvent();
        //Start Webserver
        StartWebServer();

    }

    @Override
    public void destroy() {
        try {
            trace("Shutdown Webserver");
            StopWebServer();
            tWebServer.join(2000);
            if (tWebServer.isAlive()) {
                tWebServer.stop();
            }
            trace("casinoserver destroy");
        } catch (InterruptedException ex) {
            org.apache.log4j.Logger.getLogger(SFSServer.class).error("SFSServer::Destroy "+ ex.getMessage());
        } finally {
            super.destroy();
        }
    }

    protected void StartWebServer() {
        tWebServer = new Thread(new Runnable() {

            @Override
            public void run() {
                try {
                    CasinoWebServer.getInstance().Start();
                } catch (Exception ex) {
                    org.apache.log4j.Logger.getLogger(SFSServer.class).error("SFSServer::StartWebServer " + ex.getMessage());
                }
            }
        }, "casino-webserver");

        tWebServer.start();

    }

    protected void StopWebServer() {
        CasinoWebServer.getInstance().Stop();;

    }
}
