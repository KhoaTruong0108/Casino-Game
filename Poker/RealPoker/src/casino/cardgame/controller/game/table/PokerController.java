/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.controller.game.table;

import casino.cardgame.message.request.game.poker.SitOnRequest;
import casino.cardgame.entity.UserInfo;
import casino.cardgame.entity.game_entity.Desk;
import casino.cardgame.entity.game_entity.DeskState;
import casino.cardgame.entity.game_entity.ICard;
import casino.cardgame.entity.game_entity.poker.*;
import casino.cardgame.game_enum.RoomStatus;
import casino.cardgame.message.IGameRequest;
import casino.cardgame.message.event.SFSGameEvent;
import casino.cardgame.message.event.UserDisconnect;
import casino.cardgame.message.event.UserExitRoom;
import casino.cardgame.message.event.UserJoinRoom;
import casino.cardgame.message.reponse.SFSGameReponse;
import casino.cardgame.message.reponse.game.poker.*;
import casino.cardgame.message.reponse.game.tala.Notify_Turn;
import casino.cardgame.message.reponse.game.tala.TALA_REPONSE_NAME;
import casino.cardgame.message.request.game.poker.*;
import casino.cardgame.message.request.game.tala.TALA_REQUEST_NAME;
import casino.cardgame.utils.GlobalValue;
import casino.cardgame.utils.Logger;
import com.smartfoxserver.v2.entities.User;
import java.util.*;

/**
 *
 * @author Kenjuzi
 */
public class PokerController extends TableController {

    protected PokerTableInfo m_tableInfo;
    protected Timer m_timer;
    protected PreStartTask prestartTask;

    public PokerController(String roomName, double betChip) {
        m_tableInfo = new PokerTableInfo(roomName, betChip);
        m_timer = new Timer();
    }

    @Override
    public void HandleGameMessage(User sender, IGameRequest request) {
        if (request.GetRequestName().equals(POKER_REQUEST_NAME.SIT_ON_REQ)) {
            handleSitOn(sender, request);
        } else if (request.GetRequestName().equals(POKER_REQUEST_NAME.SIT_OUT_REQ)) {
            handleSitOut(sender, request);
        } else if (request.GetRequestName().equals(POKER_REQUEST_NAME.STAND_UP_REQ)) {
            handleUserStandUp(sender, request);
        } else if (request.GetRequestName().equals(POKER_REQUEST_NAME.BET_REQ)) {
            handleUserBet(sender, request);
        } else if (request.GetRequestName().equals(POKER_REQUEST_NAME.CALL_REQ)) {
            handleUserCall(sender, request);
        } else if (request.GetRequestName().equals(POKER_REQUEST_NAME.CHECK_REQ)) {
            handleUserCheck(sender, request);
        } else if (request.GetRequestName().equals(POKER_REQUEST_NAME.FOLD_REQ)) {
            handleUserFold(sender, request);
        } else if (request.GetRequestName().equals(POKER_REQUEST_NAME.RAISE_REQ)) {
            handleUserRaise(sender, request);
        } else if (request.GetRequestName().equals(POKER_REQUEST_NAME.GOING_ALL_REQ)) {
            handleUserGoingAll(sender, request);
        } else if (request.GetRequestName().equals(POKER_REQUEST_NAME.CONFIRM_READY_GAME)) {
            HandleConfirmReadyGame(sender, request);
        }
    }

    @Override
    public void HandleUserDisconnect(SFSGameEvent evt) {
        try {
            Logger.trace("Enter PokerController:: HandleUserDisconnect");
            UserDisconnect disconnect = (UserDisconnect) evt;
            processUserLeaveRoom(disconnect.getM_user());
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    @Override
    public void HandleUserLogout(SFSGameEvent evt) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    //WARNING: không quan trọng thuộc tính isSpectator của user.
    @Override
    public void HandleUserJoinRoom(SFSGameEvent evt) {
        try {
            Logger.trace("Enter PokerController:: HandleUserJoinRoom");
            UserJoinRoom joinEvt = (UserJoinRoom) evt;
            User user = joinEvt.getM_user();

            if (joinEvt.getM_room().getOwner() != null && user.getName().equals(joinEvt.getM_room().getOwner().getName())) {
                //user join game is a room owner(user create it)

                m_tableInfo.SitUserOn(user);
                //update chip for user.


                //response to user
                processLoadTableInfoResponse(user);

                //response to player in room
                processUserSitOnResponse(user.getName());

                if (!m_tableInfo.isPrestart() && !m_tableInfo.IsGameStart() && m_tableInfo.getNumberUserSitting() > 1) {
                    HandlePreStartGame();
                }

//                //udpate status of room -> PLAYING
//                if (joinEvt.getM_room().getUserList().size() == 1) {
//                    GlobalValue.dataProxy.changeRoomStatus(joinEvt.getM_room().getName(), RoomStatus.PLAYING);
//                }
            } else {
                m_tableInfo.processSpectatorJoinRoom(user);
                //response to user join room table information.
                processLoadTableInfoResponse(user);
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    protected void processLoadTableInfoResponse(User user) {
        //get a listDesk and listUser to add to notify_sitOn response
        List<Desk> desks = m_tableInfo.getListDesk();
        ArrayList<Desk> listDesk = new ArrayList<Desk>();
        ArrayList<String> listUser = new ArrayList<String>();
        ArrayList<Double> listBetChip = new ArrayList<Double>();

        for (int i = 0; i < desks.size(); i++) {
            Desk desk = desks.get(i);
            if (desk.getUser() != null) {
                listDesk.add(desk);
                listUser.add(desk.getUser().getName());

                UserBetHistory betHis = m_tableInfo.getMapUserBet(desk.getUser().getName());
                if (betHis != null) {
                    listBetChip.add(betHis.getTotalBetChip());
                } else {
                    listBetChip.add(0.0);
                }
            }
        }

        int prestartTime = 0;
        if (m_tableInfo.isPrestart()) {
            prestartTime = prestartTask.getMilisecondsLeft();
            prestartTime += 1000;
        }

        ArrayList<ArrayList<Integer>> listHandCard = new ArrayList<ArrayList<Integer>>();
        for (int i = 0; i < listUser.size(); i++) {
            String userName = listUser.get(i);
            List<ICard> cards1 = m_tableInfo.getMapUserCard(userName).getCurrentHand();
            ArrayList<Integer> handCards = new ArrayList<Integer>();
            for (int j = 0; j < cards1.size(); j++) {
                handCards.add(-1);
            }
            listHandCard.add(handCards);
        }

        ArrayList<Integer> listComCard = new ArrayList<Integer>();
        for (int i = 0; i < m_tableInfo.getListCommunicateCard().size(); i++) {
            listComCard.add(m_tableInfo.getListCommunicateCard().get(i).getCardId());
        }
        LoadTableInfoRes tableInfoRes = new LoadTableInfoRes();
        tableInfoRes.setListDesk(listDesk)
                .setListUserSitOut((ArrayList<String>) m_tableInfo.getListUserSitOut())
                .setListUser(listUser)
                .setListUserPlaying((ArrayList<String>) m_tableInfo.GetListActiveUserName())
                .setListHandCard(listHandCard).setGameStart(m_tableInfo.IsGameStart())
                .setPrestart(m_tableInfo.isPrestart())
                .setPrestartTime(prestartTime).setPotChip(m_tableInfo.getPotChip()).setListBetChip(listBetChip).setListCommunityCard(listComCard).setDealer(m_tableInfo.getDealer()).setSmallBlind(m_tableInfo.getSmallBlind()).setBigBlind(m_tableInfo.getBigBlind());
        tableInfoRes.AddParam(POKER_REPONSE_NAME.LOAD_TABLE_INFO_RES, tableInfoRes.ToSFSObject());
        tableInfoRes.AddReceiver(user);

        GlobalValue.sfsServer.send(tableInfoRes.GetReponseName(), tableInfoRes.GetParam(), tableInfoRes.GetListReceiver());

    }

    protected void processUserSitOnResponse(String userName) {
        List<Desk> listDesk = m_tableInfo.getListDesk();

        //khoatd
//        double userChip = 0.0;
//        UserInfo info = GlobalValue.dataProxy.GetUserInfo(userName);
//        if (info != null) {
//            userChip = info.getChip();
//        }
        double userBuyIn = 0.0;
        UserInfo info = GlobalValue.dataProxy.GetUserInfo(userName);
        if (info != null) {
            userBuyIn = info.getBuyIn();
        }

        double buyIn = 0.0;
        int deskId = -1;
        DeskState deskState = DeskState.EMPTY;
        Desk desk = m_tableInfo.getMapUserDesk(userName);
        if (desk != null) {
            deskId = desk.getDeskId();
            buyIn = desk.getChip();
            deskState = desk.getDeskState();
        }

        Notify_UserSitOn userSitOnRes = new Notify_UserSitOn();
        userSitOnRes.setDeskId(deskId).setUserName(userName).setChip(userBuyIn).setBuyIn(buyIn).setDeskState(deskState).setCurrentUser(userName).
                AddParam(POKER_REPONSE_NAME.USER_SIT_ON_RES, userSitOnRes.ToSFSObject());
        //send for others player except the sender
        for (int i = 0; i < listDesk.size(); i++) {
            User receiver = listDesk.get(i).getUser();
            if (receiver != null) {
                if (!receiver.getName().equals(userName)) {
                    userSitOnRes.AddReceiver(receiver);
                }
            }
        }
        //send for spectator
        responseToSpectator(userSitOnRes);
        GlobalValue.sfsServer.send(userSitOnRes.GetReponseName(), userSitOnRes.GetParam(), userSitOnRes.GetListReceiver());
    }

    private void handleSitOn(User sender, IGameRequest request) {
        try {
            Logger.trace("Enter PokerController:: handleSitOn");
            SitOnRequest req = (SitOnRequest) request;

            String userName = sender.getName();
            Desk desk = m_tableInfo.getMapUserDesk(userName);
            if (desk == null) {
                int deskId = req.getDeskId();
                double buyIn = req.getBuyIn();

                m_tableInfo.SitUserOn(sender, deskId, buyIn);

                //update chip for user.
                double userChip = GlobalValue.dataProxy.GetUserInfo(userName).getChip();
                GlobalValue.dataProxy.updateUserChip(userName, userChip - buyIn);
                GlobalValue.dataProxy.GetUserInfo(userName).setBuyIn(buyIn);

                //response to user
                processLoadTableInfoResponse(sender);

                //response to player in room
                processUserSitOnResponse(userName);

                if (!m_tableInfo.isPrestart() && !m_tableInfo.IsGameStart() && m_tableInfo.getNumberUserSitting() > 1) {
                    HandlePreStartGame();
                }
                
                if(m_tableInfo.IsGameStart()){
                    processSitOut(userName, true);
                }
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    private void handleSitOut(User sender, IGameRequest request) {
        try {
            Logger.trace("Enter PokerController:: handleSitOut");
            SitOutRequest req = (SitOutRequest) request;

            processSitOut(sender.getName(), req.isSitOut());
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }
    
    private void processSitOut(String userName, boolean isSitOut) throws Exception {
        Logger.trace("Enter PokerController:: processSitOut");

        Desk desk = m_tableInfo.getMapUserDesk(userName);

        if (desk != null) {
            m_tableInfo.sitUserOut(userName, isSitOut);

            if (isSitOut == false) {
                if (m_tableInfo.countUserNotSitOut() == 2
                        && !m_tableInfo.IsGameStart() && !m_tableInfo.isPrestart()) {
                    HandlePreStartGame();
                }
            }

            Notify_UserSitOut response = new Notify_UserSitOut();
            response.setUserName(userName);
            response.setIsSitOut(isSitOut);
            response.AddParam(POKER_REPONSE_NAME.USER_SIT_OUT_RES, response.ToSFSObject());
            responseToAllUser(response);
            GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());
        }
    }

    //khoatd: add all user to response
    protected void responseToAllUser(SFSGameReponse response) {
        for (int i = 0; i < m_tableInfo.getListUser().size(); i++) {
            User receiver = m_tableInfo.getListUser().get(i);
            if (receiver != null) {
                response.AddReceiver(receiver);
            }
        }
    }

    protected void responseToSpectator(SFSGameReponse response) {
        for (int i = 0; i < m_tableInfo.getListUser().size(); i++) {
            User receiver = m_tableInfo.getListUser().get(i);
            if (receiver != null && m_tableInfo.isSpectator(receiver)) {
                response.AddReceiver(receiver);
            }
        }
    }

    protected void responseToUserSittingOut(SFSGameReponse response) {
        for (int i = 0; i < m_tableInfo.getListUserSitOut().size(); i++) {
            String name = m_tableInfo.getListUserSitOut().get(i);
            User receiver = m_tableInfo.getMapUser(name);
            response.AddReceiver(receiver);
        }
    }

    protected void handleUserStandUp(User sender, IGameRequest request) {
        processUserStandUp(sender);
    }

    protected void processUserStandUp(User user) {
        try {
            String username = user.getName();
            Logger.trace("Enter PokerController::processUserStandUp user: " + username);

            Desk desk = m_tableInfo.getMapUserDesk(username);
            if (desk != null) {
                double buyIn = m_tableInfo.getMapUserDesk(username).getChip();
                m_tableInfo.StandUserUp(user);

                //update chip for user
                double userChip = GlobalValue.dataProxy.GetUserInfo(username).getChip();
                GlobalValue.dataProxy.updateUserChip(username, userChip + buyIn);
                GlobalValue.dataProxy.GetUserInfo(username).setBuyIn(0.0);

                processAfterLeaveGame(user);

                Notify_StandUp response = new Notify_StandUp();
                response.setUserName(user.getName());
                response.AddParam(POKER_REPONSE_NAME.STAND_UP_RES, response.ToSFSObject());
                responseToAllUser(response);
                GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());
            } else {
                Logger.trace("this user: " + username + " is not sitting ");
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    @Override
    public void HandleUserLeaveRoom(SFSGameEvent evt) {
        UserExitRoom exitEvt = (UserExitRoom) evt;
        processUserLeaveRoom(exitEvt.getM_user());
    }

    @Override
    public void HandleRoomRemove(SFSGameEvent evt) {
        try {
            Logger.trace("Enter PokerController:: HandleRoomRemove");
            StopTimer();
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    @Override
    public void Start() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    //PRESTART
    private void HandlePreStartGame() {
        try {
            Logger.trace("Enter PokerController:: HandlePreStartGame");


            processLeaveUserLessMinChip();//kick user does not enough chip to continous

            //prestart game.
            m_tableInfo.prepareNewGame();

            m_tableInfo.processGamePrestart();


            boolean isPrestart = false;
            if (m_tableInfo.getNumberUserSitting() > 1) {
                isPrestart = true;
            }
            Notify_PreStart response = new Notify_PreStart();
            response.setM_isPrestart(isPrestart).setM_time(m_tableInfo.PRE_START_TIME).AddParam(POKER_REPONSE_NAME.PRE_START, response.ToSFSObject());
            responseToAllUser(response);
            GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());


            StopTimer();
            m_timer = new Timer();
            prestartTask = new PreStartTask();
            m_timer.schedule(prestartTask, m_tableInfo.PRE_START_TIME);
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    //START GAME
    private void HandleStartGame() {
        try {
            Logger.trace("Enter PokerController:: HandleStartGame");
            StopTimer();
            
            m_tableInfo.processSittingOutUser();

            // user stand up if not ready
            // listActiveUserName is empty in a first time run this table
            for (Desk desk : m_tableInfo.getListDesk()) {
                User user = desk.getUser();
                if (user != null && desk.getDeskState() != DeskState.READY
                        && m_tableInfo.getListUserSitOut().contains(user.getName()) == false) {
////                        processKickUsers(receiver, 1);
////                        m_tableInfo.ProcessUserLeaveGame(receiver);
//                        processUserStandUp(receiver);
                    m_tableInfo.processUserReady(user.getName());

                }
            }

            if (m_tableInfo.GetListActiveUserName().size() > 1) {
                m_tableInfo.setupSmallBlindUser();
                ////////////////////////////////////////////////////////////////////////////////////
                String smallBlindDefault = m_tableInfo.getSmallBlind();
                Desk desk = null;
                if (smallBlindDefault != null) {
                    desk = m_tableInfo.getMapUserDesk(smallBlindDefault);
                }
                if (desk != null && m_tableInfo.GetListActiveUserName().contains(smallBlindDefault)) {
                    m_tableInfo.processSetSmallBlind(smallBlindDefault);
                } else {
                    //nếu smallblind mặc định  đã rời bàn thì tìm 1 smallblind khác
                    int sBlindPos = m_tableInfo.getNextSmallBlindPosition(-1);
                    if (sBlindPos == -1) {
                        return;
                    }
                    smallBlindDefault = m_tableInfo.getListDesk().get(sBlindPos).getUser().getName();
                    m_tableInfo.processSetSmallBlind(smallBlindDefault);
                }
                //////////////////////////////////////////////////////////////////////////////////

                m_tableInfo.processGameStart();

                //start game for user
                for (int i = 0; i < m_tableInfo.GetListActiveUserName().size(); i++) {
                    String reciverName = m_tableInfo.GetListActiveUserName().get(i);
                    User reciver = m_tableInfo.getMapUser(reciverName);
                    startGameForUser(reciver);
                }

                m_tableInfo.setCurrentGameTurn(PokerGameTurn.BETTING);

                startGameForEveryoneElse();

                //update room status in database
                updateRoomStaus(m_tableInfo.getRoomName(), RoomStatus.PLAYING);

                m_timer = new Timer();
                m_timer.schedule(new EndUserTurnTask(), m_tableInfo.USER_ACTION_TIME);
            } else {
                if (m_tableInfo.GetListActiveUserName().size() == 1) {
                    String userName = m_tableInfo.GetListActiveUserName().get(0);
                    if (userName != null) {
                        m_tableInfo.ProcessUserWaiting(userName);
                    }
                }

                m_tableInfo.processGameWaiting();
            } 
//            else {
//                m_tableInfo.processGameEmpty();
//            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
            StopTimer();
        }
    }

    private void processKickUsers(User receiver, int resType) {
        Logger.trace("process kick user: " + receiver.getName());
        Notify_KickUser kickRes = new Notify_KickUser();
        kickRes.setM_resType(resType);
        kickRes.AddParam(POKER_REPONSE_NAME.KICK_USER_RES, kickRes.ToSFSObject());

        kickRes.AddReceiver(receiver);
        GlobalValue.sfsServer.send(kickRes.GetReponseName(), kickRes.GetParam(), kickRes.GetListReceiver());
    }

    private void startGameForUser(User receiver) {
        try {
            Logger.trace("Enter PokerController:: startGameForUser");
            m_tableInfo.ProcessUserPlay(receiver.getName());

            List<ICard> listCard = m_tableInfo.getCardCollection().getNextCard(2);
            PokerCardHand cardHand = new PokerCardHand();
            cardHand.setCurrentHand(listCard);
            m_tableInfo.getMapUserCard().put(receiver.getName(), cardHand);

            ArrayList<Integer> listCardID = new ArrayList<Integer>();
            for (int i = 0; i < listCard.size(); i++) {
                int cardId = listCard.get(i).getCardId();
                listCardID.add(cardId);
            }
            Notify_Start startRes = new Notify_Start();
            startRes.setCurrentUser(m_tableInfo.getCurrentUser()).setBetChipGame(m_tableInfo.getBetChipGame()).setDealer(m_tableInfo.getDealer()).setSmallBlind(m_tableInfo.getSmallBlind()).setBigBlind(m_tableInfo.getBigBlind()).setUserTime(m_tableInfo.USER_ACTION_TIME).setListCard(listCardID).setListActiveUserName((ArrayList) m_tableInfo.GetListActiveUserName());

            startRes.AddParam(POKER_REPONSE_NAME.START, startRes.ToSFSObject());
            startRes.AddReceiver(receiver);
            GlobalValue.sfsServer.send(startRes.GetReponseName(), startRes.GetParam(), startRes.GetListReceiver());
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    private void startGameForEveryoneElse() {
        Logger.trace("Enter PokerController:: startGameForEveryoneElse");
        ArrayList<Integer> listHiddenCard = new ArrayList<Integer>();
        for (int i = 0; i < 2; i++) {
            int cardId = -1;
            listHiddenCard.add(cardId);
        }
        Notify_Start startRes = new Notify_Start();
        startRes.setCurrentUser(m_tableInfo.getCurrentUser())
                .setBetChipGame(m_tableInfo.getBetChipGame())
                .setDealer(m_tableInfo.getDealer())
                .setSmallBlind(m_tableInfo.getSmallBlind())
                .setBigBlind(m_tableInfo.getBigBlind())
                .setUserTime(m_tableInfo.USER_ACTION_TIME)
                .setListCard(listHiddenCard)
                .setListActiveUserName((ArrayList) m_tableInfo.GetListActiveUserName());
        startRes.AddParam(POKER_REPONSE_NAME.START, startRes.ToSFSObject());
        //response to sepectator
        responseToSpectator(startRes);
        //response to user sitting out
        responseToUserSittingOut(startRes);
        GlobalValue.sfsServer.send(startRes.GetReponseName(), startRes.GetParam(), startRes.GetListReceiver());
    }

    public void processUserLeaveRoom(User user) {
        try {
            Logger.trace("Enter PokerController:: processUserLeaveRoom");

            String username = user.getName();
            Desk desk = m_tableInfo.getMapUserDesk(username);
            if (desk != null) {
                double buyIn = m_tableInfo.getMapUserDesk(username).getChip();
                //update chip for user
                double userChip = GlobalValue.dataProxy.GetUserInfo(username).getChip();
                GlobalValue.dataProxy.updateUserChip(username, userChip + buyIn);
                GlobalValue.dataProxy.GetUserInfo(username).setBuyIn(0.0);
            }
            //remove leaving user from m_tableInfo
            m_tableInfo.LeaveUserOut(user);

            processAfterLeaveGame(user);

//            //udpate status of room -> PLAYING
//            if (m_tableInfo.getListUser().size() < 1) {
//                GlobalValue.dataProxy.changeRoomStatus(m_tableInfo.getr, RoomStatus.PLAYING);
//            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    private void processAfterLeaveGame(User user) {
        try {
            Logger.trace("Enter PokerController:: processAfterLeaveGame");
            String userName = user.getName();

            if (m_tableInfo.IsGameStart()) {

                //handle finish or turn game
                if (m_tableInfo.GetListActiveUserName().size() == 1) {
                    handleEarlyFinish();
                } else if (m_tableInfo.countUserNotFold() == 1) {
                    handleEarlyFinish();
                } else if (m_tableInfo.GetListActiveUserName().size() > 1) {

                    if (m_tableInfo.getCurrentUser().equals(userName)) {
                        //if user who leave room is a current user (holder) -> turn to other user
                        HandleTurn();
                    }

                } else {
                    StopTimer();
                    m_tableInfo.processGameEmpty();
                }
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    public void HandleConfirmReadyGame(User sender, IGameRequest request) {
        try {
            if (!m_tableInfo.IsGameStart()) {
                Logger.trace("Enter PokerController:: HandleConfirmReadyGame");
                if (m_tableInfo.isSpectator(sender) == false) {
                    m_tableInfo.processUserReady(sender.getName());

                    Notify_UserReady response = new Notify_UserReady();
                    response.setUserName(sender.getName()).AddParam(POKER_REPONSE_NAME.USER_READY_RES, response.ToSFSObject());
                    responseToAllUser(response);
                    GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());

                    //if enough player in room then start game without waiting count down
//                    int userReady = m_tableInfo.countUserReady();
//                    int userSitting = m_tableInfo.countUserSitting();
//                    if (userReady == userSitting && userSitting > 1) {
//                        StopTimer();
//                        HandleStartGame();
//                    }
                }
            }

        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    //action của user đầu tiên luôn là bet (dù chip >=0), hoặc fold
    private void handleUserBet(User sender, IGameRequest request) {
//        try {
//            if (sender.getName().equals(m_tableInfo.getCurrentUser()) && m_tableInfo.IsGameStart()) {
//                Logger.trace("Enter PokerController:: handleUserBet");
////                if (m_tableInfo.getBettingUser().equals(m_tableInfo.getCurrentUser())) {
//                    StopTimer();
//                    String userName = sender.getName();
//                    BetRequest req = (BetRequest) request;
//                    double betChip = req.getBetChip();
//                    double currentChip = m_tableInfo.getMapUserDesk(userName).getChip();
//
//                    if (currentChip > betChip) {
//                        //udpate user chip in database
//
//                        //update user chip in tableinfo
//                        m_tableInfo.processUserAction(m_tableInfo.getCurrentGameTurn(), userName, UserActionType.BET, betChip);
//
//                        Notify_UserBet response = new Notify_UserBet();
//                        response.setChip(betChip);
//                        response.setUserName(userName);
//                        response.AddParam(POKER_REPONSE_NAME.USER_BET_RES, response.ToSFSObject());
//                        responseToAllUser(response);
//                        GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());
//
//                        HandleTurn();
//                    } else {
//                        processUserGoingAll(userName, currentChip);
//                    }
//                } else {
//                    //Action bet is occured just only one time in the begin of game turn or start game.
//                    // and before game turn, and start game, betting user is assigned user bet fist time.
//                    Logger.trace("Error logic in handleUserBet");
//                }
//            }
//        } catch (Exception ex) {
//            Logger.error(this.getClass(), ex);
//        }
    }

    private void handleUserGoingAll(User sender, IGameRequest request) {
        try {
            if (sender.getName().equals(m_tableInfo.getCurrentUser()) && m_tableInfo.IsGameStart()) {
                Logger.trace("Enter PokerController:: handleUserGoingAll");

                StopTimer();
                String userName = sender.getName();
                double currentChip = m_tableInfo.getMapUserDesk(userName).getChip();
                processUserGoingAll(userName, currentChip);
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    private void processUserGoingAll(String userName, double currentChip) {
        //udpate user chip in database

        //update user chip in tableinfo
//        m_tableInfo.processUserBet(userName, currentChip);
        m_tableInfo.processUserAction(m_tableInfo.getCurrentGameTurn(), userName, UserActionType.ALL_IN, currentChip);

        Notify_UserGoingAllIn response = new Notify_UserGoingAllIn();
        response.setChip(currentChip);
        response.setUserName(userName);
        response.AddParam(POKER_REPONSE_NAME.USER_GOING_ALL_RES, response.ToSFSObject());

        responseToAllUser(response);
        GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());

        HandleTurn();
    }

    private void handleUserRaise(User sender, IGameRequest request) {
        try {
            if (sender.getName().equals(m_tableInfo.getCurrentUser()) && m_tableInfo.IsGameStart()) {
                Logger.trace("Enter PokerController:: handleUserRaise");


//                if (m_tableInfo.getBettingUser() != null) {
                StopTimer();
                String userName = sender.getName();
                RaiseRequest req = (RaiseRequest) request;
                double betChip = req.getBetChip();
                double currentChip = m_tableInfo.getMapUserDesk(userName).getChip();
                double totalBetChip = m_tableInfo.getMapUserBet(userName).getTotalBetChip() + betChip;

                if (currentChip > betChip) {
                    if (totalBetChip > m_tableInfo.getBettingChip()) {
                        //udpate user chip in database

                        //update user chip in tableinfo
                        //                    m_tableInfo.processUserBet(userName, betChip);
                        m_tableInfo.processUserAction(m_tableInfo.getCurrentGameTurn(), userName, UserActionType.RAISE, betChip);

                        Notify_UserRaise response = new Notify_UserRaise();
                        response.setChip(betChip);
                        response.setUserName(userName);
                        response.AddParam(POKER_REPONSE_NAME.USER_RAISE_RES, response.ToSFSObject());
                        responseToAllUser(response);
                        GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());

                        HandleTurn();
                    } else {
                        handleUserCall(sender, request);
                    }
                } else {
                    processUserGoingAll(userName, currentChip);
                }
//                } else {
//                    Logger.trace("Error logic in handleUserRaise");
//                }
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    private void handleUserCheck(User sender, IGameRequest request) {
        try {
            Logger.trace("Enter PokerController:: handleUserCheck");

//            StopTimer();
//            String userName = sender.getName();
//            m_tableInfo.processUserAction(userName, UserActionType.CHECK, 0.0);
//
//            Notify_UserCheck response = new Notify_UserCheck();
//            response.setUserName(userName);
//            response.AddParam(POKER_REPONSE_NAME.USER_CHECK_RES, response.ToSFSObject());
//            responseToAllUser(response);
//            GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());
//
//            HandleTurn();
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    private void handleUserCall(User sender, IGameRequest request) {
        try {
            if (sender.getName().equals(m_tableInfo.getCurrentUser()) && m_tableInfo.IsGameStart()) {
                Logger.trace("Enter PokerController:: handleUseCall");

                StopTimer();
                String userName = sender.getName();

                double currentChip = m_tableInfo.getMapUserDesk(userName).getChip();
                double callChip = m_tableInfo.getBettingChip() - m_tableInfo.getMapUserBet(userName).getTotalBetChip();//số chip mà user bet/call

                if (currentChip > callChip) {
                    //get chip which user bet
                    m_tableInfo.processUserAction(m_tableInfo.getCurrentGameTurn(), userName, UserActionType.CALL, callChip);

                    Notify_UserCall response = new Notify_UserCall();
                    response.setUserName(userName);
                    response.setChip(callChip);
                    response.AddParam(POKER_REPONSE_NAME.USER_CALL_RES, response.ToSFSObject());
                    responseToAllUser(response);
                    GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());
                    HandleTurn();
                } else {
                    processUserGoingAll(userName, currentChip);
                }
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    private void handleUserFold(User sender, IGameRequest request) {
        try {
            if (sender.getName().equals(m_tableInfo.getCurrentUser()) && m_tableInfo.IsGameStart()) {
                Logger.trace("Enter PokerController:: handleUserFold");

                StopTimer();
                processUserFold(sender.getName());
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    protected void processUserFold(String userName) {
        m_tableInfo.processUserAction(m_tableInfo.getCurrentGameTurn(), userName, UserActionType.FOLD, 0.0);

        Notify_UserFold response = new Notify_UserFold();
        response.setUserName(userName);
        response.AddParam(POKER_REPONSE_NAME.USER_FOLD_RES, response.ToSFSObject());
        responseToAllUser(response);
        GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());

        HandleTurn();
    }

    //NEXT TURN 
    private void HandleTurn() {
        try {
            Logger.trace("Enter PokerController:: HandleTurn");

            String nextUser = getNextUser(m_tableInfo.getCurrentUser());
            StopTimer();

            if (nextUser == null) {
                if (m_tableInfo.GetListActiveUserName().size() <= 0) {
                    //room is empty.
                    HandlePreStartGame();
                    return;
                }
            }

            int numPlaying = m_tableInfo.getNumPlaying();
            int bettedCount = m_tableInfo.getBettedCount();

            if (numPlaying < 1) {
                // tất cả user All in hoặc fold
                if (m_tableInfo.countUserNotFold() == 1) {
                    //duy nhất 1 user all in -> tất cả user còn lại đều fold
                    handleEarlyFinish();
                } else {
                    //tất cả user 
                    handleShowDown();
                }
            } else if (numPlaying == 1) {
                // chỉ duy nhất user có quyền cược.
                if (m_tableInfo.countUserNotFold() == 1) {
                    //tất cả user còn lại đều fold
                    handleEarlyFinish();
                } else {
                    //tất cả user còn lại có thể là fold hoặc All in
                    if (bettedCount < numPlaying) {
                        turnToNextUser(nextUser);
                    } else {
                        handleShowDown();
                    }
                }
            } else {
                if (bettedCount == numPlaying) {
                    if (m_tableInfo.getCurrentGameTurn().equals(PokerGameTurn.RIVER)) {
                        // qua game turn cuối cùng, finish game.
                        handleShowDown();
                    } else {
                        //tất cả user đều đã cược -> go to next game turn.
                        processNextGameTurn();
                    }
                } else if (bettedCount < numPlaying) {
                    // đến lượt user tiếp theo
                    turnToNextUser(nextUser);
                }
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
            StopTimer();
        }
    }

    private void processNextGameTurn() {
        //go to next game turn

        String firstBetting = getFirstBettingUser(m_tableInfo.getSBlindPos());
        if (firstBetting == null) {
            Logger.trace("processNextGameTurn:: cannot find first betting: " + firstBetting);
            HandlePreStartGame();
            return;
        }
        Logger.trace("processNextGameTurn:: Turn to next game with first betting: " + firstBetting);

        m_tableInfo.setCurrentUser(firstBetting);

        ArrayList<Integer> listCardId = m_tableInfo.processGoingNextGameTurn(firstBetting);

        Notify_GameTurn gTurnRes = new Notify_GameTurn();
        gTurnRes.setCurrentUser(m_tableInfo.getCurrentUser()).setListCommunityCard(listCardId).setCurrentGameTurn(m_tableInfo.getCurrentGameTurn()).setTime(m_tableInfo.USER_ACTION_TIME);
        gTurnRes.AddParam(POKER_REPONSE_NAME.GAME_TURN_RES, gTurnRes.ToSFSObject());

        responseToAllUser(gTurnRes);
        GlobalValue.sfsServer.send(gTurnRes.GetReponseName(), gTurnRes.GetParam(), gTurnRes.GetListReceiver());

        m_timer = new Timer();
        m_timer.schedule(new EndUserTurnTask(), m_tableInfo.USER_ACTION_TIME);
    }

    //return null if nobody in room.
//    private String getFirstBettingUser() {
//        int SBPosition = m_tableInfo.getSBlindPos();
//        if (SBPosition != -1) {
//            Desk desk = m_tableInfo.getListDesk().get(SBPosition);
//
////            if (checkSmallBlindValid(SBPosition) == false) {
////                //smallblinder left room => find a next user of smallblinder 
////                //=> set smallblinder position is this user position.
////                SBPosition = m_tableInfo.getNextSmallBlindPosition(SBPosition);
////                if (SBPosition == -1) {
////                    return null;
////                }
////                desk = m_tableInfo.getListDesk().get(SBPosition);
////            }
//            if (checkSmallBlindValid(SBPosition)) {
//                return desk.getUser().getName();
//            }else{
//                if(desk.getUser() == null){
//                    SBPosition = m_tableInfo.getNextSmallBlindPosition(SBPosition);
//                }
//                String userName = desk.getUser().getName();
//                String nextFistBetting = getNextUser(userName);
//                return nextFistBetting;
//            }
//            
//        } else {
//            return null;
//        }
//    }
    
    private String getFirstBettingUser(int SBPosition) {
        if(SBPosition == -1){
            SBPosition = m_tableInfo.getNextSmallBlindPosition(SBPosition);
        }
        
        if(SBPosition == -1){
            return null;
        }

        String userName = m_tableInfo.getListDesk().get(SBPosition).getUser().getName();
        for (int i = 0; i < m_tableInfo.GetListActiveUserName().size(); i++) {
            if (checkSmallBlindValid(SBPosition)) {
                return userName;
            }else{
                userName = getNextUser(userName);
                SBPosition = m_tableInfo.getMapUserDesk(userName).getDeskId();
            }
        }
        return null;
    }
   
    private boolean checkSmallBlindValid(int SBPosition) {
        Desk desk = m_tableInfo.getListDesk().get(SBPosition);
        if(desk == null){
            return false;
        }
        if(desk.getUser() == null){
            return false;
        }
        if (desk.getDeskState() != DeskState.PLAYING){
            return false;
        }
        UserBetObject betObj = m_tableInfo.getMapUserBet(desk.getUser().getName()).getLastAction();
        if(betObj != null && (betObj.getActionType().equals(UserActionType.ALL_IN) 
                || betObj.getActionType().equals(UserActionType.FOLD))){
            return false;
        }
        
        return true;
    }

    private void turnToNextUser(String nextUser) {
        Logger.trace("next user is " + nextUser);
        if (nextUser != null) {
            //go to next user turn 
            m_tableInfo.setCurrentUser(nextUser);

            Notify_userTurn uTurnRes = new Notify_userTurn();
            uTurnRes.setUserName(m_tableInfo.getCurrentUser());
            //edite for realPoker
            //uTurnRes.setBettingChip(m_tableInfo.getBettingChip());
            double userTotalBet = m_tableInfo.getMapUserBet(nextUser).getTotalBetChip();
            double betChip = m_tableInfo.getBettingChip() - userTotalBet;
            uTurnRes.setBettingChip(betChip);

            uTurnRes.setTime(m_tableInfo.USER_ACTION_TIME);
            uTurnRes.AddParam(POKER_REPONSE_NAME.USER_TURN_RES, uTurnRes.ToSFSObject());

            responseToAllUser(uTurnRes);
            GlobalValue.sfsServer.send(uTurnRes.GetReponseName(), uTurnRes.GetParam(), uTurnRes.GetListReceiver());

            m_timer = new Timer();
            m_timer.schedule(new EndUserTurnTask(), m_tableInfo.USER_ACTION_TIME);
        } else {
            Logger.trace("ERROR     PokerController:: turnToNextUser  nextUser = null");
            m_tableInfo.printImportantData();

            HandlePreStartGame();
        }
    }

    private String getNextUser(String currentUser) {
        String nextUser = null;

        String userName = currentUser;
        for (int i = 0; i < m_tableInfo.GetListActiveUserName().size(); i++) {
            userName = m_tableInfo.getNextPlayerName(userName);
            if (userName != null) {
                UserBetObject betObj = m_tableInfo.getMapUserBet(userName).getLastAction();
                //đang ở vong BETTING, tất cả user đều chưa cược.
                if (betObj == null) {
                    nextUser = userName;
                    break;
                } else if (betObj.getActionType().equals(UserActionType.FOLD) == false
                        && betObj.getActionType().equals(UserActionType.ALL_IN) == false) {
                    nextUser = userName;
                    break;
                }
            } else {
                //room is empty or nobody sitting on.
                return null;
            }
        }
        return nextUser;
    }

    //SHOW DOWN
    private void handleShowDown() {
        try {
            StopTimer();
            Logger.trace("Enter PokerController:: handleShowDown");

            m_tableInfo.getAllRemainCommunityCard();

            ArrayList<String> listUser = new ArrayList<String>();
            ArrayList<ArrayList<Integer>> listCard = new ArrayList<ArrayList<Integer>>();

            for (int i = 0; i < m_tableInfo.GetListActiveUserName().size(); i++) {
                String userName = m_tableInfo.GetListActiveUserName().get(i);
                UserBetObject lastAction = m_tableInfo.getMapUserBet(userName).getLastAction();
                if (lastAction.getActionType().equals(UserActionType.FOLD) == false) {
                    listUser.add(userName);

                    ArrayList<Integer> listCardId = new ArrayList<Integer>();
                    List<ICard> cards = m_tableInfo.getMapUserCard(userName).getCurrentHand();
                    for (int j = 0; j < cards.size(); j++) {
                        listCardId.add(cards.get(j).getCardId());
                    }
                    listCard.add(listCardId);
                }
            }

            ArrayList<Integer> listComCard = new ArrayList<Integer>();
            for (int i = 0; i < m_tableInfo.getListCommunicateCard().size(); i++) {
                listComCard.add(m_tableInfo.getListCommunicateCard().get(i).getCardId());
            }
            Notify_ShowDown response = new Notify_ShowDown();
            response.setListCard(listCard).setListUser(listUser).setListComCard(listComCard).setCurrentGameTurn(m_tableInfo.getCurrentGameTurn());
            response.AddParam(POKER_REPONSE_NAME.SHOW_DOWN_RES, response.ToSFSObject());

            responseToAllUser(response);
            GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());

            m_timer = new Timer();
            m_timer.schedule(new EndShowDownTask(), m_tableInfo.SHOW_DOWN_TIME);
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
            StopTimer();
        }
    }

    //FINISH
    private void handleFinishGame() {
        try {
            StopTimer();
            Logger.trace("Enter PokerController:: handleFinishGame");

            m_tableInfo.setCurrentGameTurn(PokerGameTurn.END);

            //find winner
            ArrayList<String> listWinners = m_tableInfo.findListWinner();
            if (listWinners == null) {
                //room is empty
                HandlePreStartGame();
            }

            int i;
            //get list win card
            ArrayList<Integer> listWinCard = new ArrayList<Integer>();
            for (i = 0; i < listWinners.size(); i++) {
                PokerHandComparer comparer = m_tableInfo.getMapPokerComparer(listWinners.get(i));
                int[] cardIds = comparer.getListPokerCard();
                for (int j = 0; j < cardIds.length; j++) {
                    //in PokerHandComparer, id of A card is 141,142,143,144 => transfer to current code is 11,12,13,14
                    int id = cardIds[j];
                    if (id > 140 && id < 145) {
                        id -= 130;
                    }
                    listWinCard.add(cardIds[j]);
                }
            }

            //get list loser
            ArrayList<String> listLoser = new ArrayList<String>();
            for (i = 0; i < m_tableInfo.GetListActiveUserName().size(); i++) {
                String userName = m_tableInfo.GetListActiveUserName().get(i);
                if (m_tableInfo.isExist(listWinners, userName) == false) {
                    listLoser.add(userName);
                }
            }

            ArrayList<Double> listChip = m_tableInfo.processCaculateChip(listWinners, listLoser);

            //combine list winners and losers
            ArrayList<String> listUser = new ArrayList<String>();
            for (i = 0; i < listWinners.size(); i++) {
                listUser.add(listWinners.get(i));
            }
            for (i = 0; i < listLoser.size(); i++) {
                listUser.add(listLoser.get(i));
            }

            //get list poker hand of user
            ArrayList<String> listPokerHand = new ArrayList<String>();
            for (i = 0; i < listUser.size(); i++) {
                String userName = listUser.get(i);
                if (m_tableInfo.isUserFold(userName) == false) {
                    PokerHandComparer pokerHandComparer = m_tableInfo.getMapPokerComparer(listUser.get(i));
                    if (pokerHandComparer != null) {
                        listPokerHand.add(pokerHandComparer.getPokerHandType().getName());
                    } else {
                        //user up bo.
                        listPokerHand.add("");
                    }
                } else {
                    listPokerHand.add("");
                }
            }
            //update chip for talbleinfo
            for (i = 0; i < listUser.size(); i++) {
                Desk desk = m_tableInfo.getMapUserDesk(listUser.get(i));
                if (desk != null && listChip.get(i) > 0) {
                    desk.setChip(desk.getChip() + listChip.get(i));
                }
            }

            Notify_FinishGame response = new Notify_FinishGame();
            response.setListWinner(listWinners).setListUser(listUser).setListWinCard(listWinCard).setListChip(listChip).setListPokerHand(listPokerHand);
            response.AddParam(POKER_REPONSE_NAME.FINISH_GAME, response.ToSFSObject());
            responseToAllUser(response);
            GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());

            m_tableInfo.processGameWaiting();

            //update room status in database
            updateRoomStaus(m_tableInfo.getRoomName(), RoomStatus.EMPTY);

            m_timer = new Timer();
            m_timer.schedule(new ReplayGameTask(), m_tableInfo.REPLAY);
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
            StopTimer();
        }
    }

    private void processLeaveUserLessMinChip() {
        double minChip = m_tableInfo.getBetChipGame() * 2;

//        for (int i = 0; i < m_tableInfo.getListDesk().size(); i++) {
//            Desk desk = m_tableInfo.getListDesk().get(i);
//            if (desk.getDeskState() == DeskState.PLAYING) {
//                if (desk.getChip() < minChip) {
//                    processKickUsers(desk.getUser(), 2);
//                    m_tableInfo.LeaveUserOut(desk.getUser());
//                }
//            }
//        }
        for (int i = 0; i < m_tableInfo.GetListActiveUserName().size(); i++) {
            String userName = m_tableInfo.GetListActiveUserName().get(i);
            Desk desk = m_tableInfo.getMapUserDesk(userName);
            if (desk.getChip() < minChip) {
                processKickUsers(desk.getUser(), 2);
                m_tableInfo.LeaveUserOut(desk.getUser());
            }
        }
    }

    //khi chỉ còn 1 người theo bài, tat ca deu fold
    private void handleEarlyFinish() {
        try {
            StopTimer();
            Logger.trace("Enter PokerController:: handleEarlyFinish");

            m_tableInfo.setCurrentGameTurn(PokerGameTurn.END);
            ArrayList<String> listWinners = new ArrayList<String>();
            String uniqueBettinUser = findUniqueBettingUser();

            if (uniqueBettinUser != null) {
                listWinners.add(uniqueBettinUser);

                ArrayList<String> listPokerHandType = new ArrayList<String>();

                ArrayList<String> listUser = new ArrayList<String>();
                listUser.add(uniqueBettinUser);
                ArrayList<Integer> listWinCard = new ArrayList<Integer>();
                ArrayList<Double> listChip = new ArrayList<Double>();
                listChip.add(m_tableInfo.getPotChip());

                //update chip for tableinfo
                Desk desk = m_tableInfo.getMapUserDesk(uniqueBettinUser);
                if (desk != null) {
                    desk.setChip(desk.getChip() + m_tableInfo.getPotChip());
                }

                Notify_FinishGame response = new Notify_FinishGame();
                response.setListWinner(listWinners).setListUser(listUser).setListWinCard(listWinCard).setListChip(listChip).setListPokerHand(listPokerHandType);
                response.AddParam(POKER_REPONSE_NAME.FINISH_GAME, response.ToSFSObject());
                responseToAllUser(response);
                GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());

                //printImportantData();

                m_tableInfo.processGameWaiting();
//                processLeaveUserLessMinChip();
//
//                //prestart game.
//                m_tableInfo.prepareNewGame();

                //update room status in database
                updateRoomStaus(m_tableInfo.getRoomName(), RoomStatus.EMPTY);

                m_timer = new Timer();
                m_timer.schedule(new ReplayGameTask(), m_tableInfo.REPLAY);
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    private String findUniqueBettingUser() {
        String winner = null;
        for (int i = 0; i < m_tableInfo.GetListActiveUserName().size(); i++) {
            String userName = m_tableInfo.GetListActiveUserName().get(i);
            UserBetObject betObj = m_tableInfo.getMapUserBet(userName).getLastAction();
            if (betObj != null) {
                if (betObj.getActionType().equals(UserActionType.FOLD) == false) {
                    if (winner == null) {
                        winner = userName;
                    } else {
                        //there is more than 1 user betting
                        winner = null;
                        break;
                    }
                }
            } else {
                winner = userName;
            }
        }
        return winner;
    }

    private void HandleEndUserTurn() {
        try {
            Logger.trace("Enter PokerController:: HandleEndUserTurn");
            processUserFold(m_tableInfo.getCurrentUser());
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    private void HandleShowDownTurn() {
        try {
            Logger.trace("Enter PokerController:: HandleShowDownTurn");

            handleFinishGame();
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }
    //khoatd

    private void StopTimer() {
        m_timer.cancel();
        m_timer.purge();
    }

    private void updateRoomStaus(String roomName, String status) {
        try {
            Logger.trace("updateRoomStaus");
            GlobalValue.dataProxy.UpdateRoomStatus(roomName, status);
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    class PreStartTask extends TimerTask {

        @Override
        public void run() {
            RemoveTimer();
            HandleStartGame();
        }

        public int getMilisecondsLeft() {
            long time = System.currentTimeMillis() - prestartTask.scheduledExecutionTime();
            int miliSecondesLeft = (int) (-time);
            return miliSecondesLeft;
        }

        private void RemoveTimer() {
            m_timer.cancel();
            m_timer.purge();
        }
    }

    class EndShowDownTask extends TimerTask {

        @Override
        public void run() {
            RemoveTimer();
            HandleShowDownTurn();
        }

        private void RemoveTimer() {
            m_timer.cancel();
            m_timer.purge();
        }
    }

    class EndUserTurnTask extends TimerTask {

        @Override
        public void run() {
            RemoveTimer();
            HandleEndUserTurn();
        }

        private void RemoveTimer() {
            m_timer.cancel();
            m_timer.purge();
        }
    }

    //khoatd
    class ReplayGameTask extends TimerTask {

        @Override
        public void run() {
            RemoveTimer();
            HandlePreStartGame();
        }

        private void RemoveTimer() {
            m_timer.cancel();
            m_timer.purge();
        }
    }
}
