/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.controller.game.table;

import casino.cardgame.entity.TransactionInfo;
import casino.cardgame.entity.UserInfo;
import casino.cardgame.entity.game_entity.Desk;
import casino.cardgame.entity.game_entity.DeskState;
import casino.cardgame.entity.game_entity.ICard;
import casino.cardgame.entity.game_entity.tala.TaLaCardCollection;
import casino.cardgame.entity.game_entity.tala.TaLaCardHand;
import casino.cardgame.entity.game_entity.tala.TaLaTableInfo;
import casino.cardgame.game_enum.TransactionStatus;
import casino.cardgame.game_enum.TransactionType;
import casino.cardgame.message.IGameRequest;
import casino.cardgame.message.event.*;
import casino.cardgame.message.reponse.SFSGameReponse;
import casino.cardgame.message.reponse.game.tala.*;
import casino.cardgame.message.request.GAME_REQUEST_NAME;
import casino.cardgame.message.request.SFSGameRequest;
import casino.cardgame.message.request.game.tala.GetPlayerCardRequest;
import casino.cardgame.message.request.game.tala.RemoveCardRequest;
import casino.cardgame.message.request.game.tala.ShowCardRequest;
import casino.cardgame.message.request.game.tala.TALA_REQUEST_NAME;
import casino.cardgame.utils.GlobalValue;
import casino.cardgame.utils.Logger;
import com.smartfoxserver.v2.entities.Room;
import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.entities.data.SFSObject;
import hirondelle.date4j.DateTime;
import java.util.*;
import org.omg.CORBA.UserException;

/**
 *
 * @author KIDKID
 */
public class TaLaController extends TableController {

    //SangDN: Chứa tất cả thông tin liên quan trong 1 bàn game TaLa
    protected TaLaTableInfo m_tableInfo;
    protected Timer m_timer;
    protected PreStartTask prestartTask;

    public TaLaController(double betChip) {
        m_tableInfo = new TaLaTableInfo();
        m_timer = new Timer();
        m_tableInfo.setBetChip(betChip);
    }
    //***********************************************************************************
    //          TABLE CONTROLLER API IMPLEMENT
    //***********************************************************************************

    @Override
    public void HandleGameMessage(User sender, IGameRequest request) {
        if (request.GetRequestName().equals(TALA_REQUEST_NAME.GET_NEXT_CARD)) {
            HandleGetNextCard(sender, request);
        } else if (request.GetRequestName().equals(TALA_REQUEST_NAME.GET_PLAYER_CARD)) {
            HandleGetPlayerCard(sender, request);
        } else if (request.GetRequestName().equals(TALA_REQUEST_NAME.REMOVE_CARD)) {
            HandleRemoveCard(sender, request);
        } else if (request.GetRequestName().equals(TALA_REQUEST_NAME.SHOW_CARD)) {
            HandleShowCard(sender, request);
        } else if (request.GetRequestName().equals(TALA_REQUEST_NAME.CONFIRM_READY_GAME)) {
            HandleConfirmReadyGame(sender, request);
        }
    }

    @Override
    public void Start() {
        //HandlePreStartGame();
    }

    @Override
    public void HandleUserDisconnect(SFSGameEvent evt) {
        try {
            Logger.trace("Enter HandleUserDisconnect");
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

    @Override
    public void HandleRoomRemove(SFSGameEvent evt) {
        try {
            Logger.trace("Enter HandleRoomRemove");
            StopTimer();
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }
    //khoatd

    @Override
    public void HandleUserJoinRoom(SFSGameEvent evt) {
        try {
            Logger.trace("Enter HandleUserJoinRoom");
            UserJoinRoom joinEvt = (UserJoinRoom) evt;
            m_tableInfo.SitUserOn(joinEvt.getM_user());


            //response to user
            processSitOnResponse(joinEvt.getM_user());

            //response to player in room
            processUserSitOnResponse(joinEvt.getM_user().getName());

            if (!m_tableInfo.isPrestart() && !m_tableInfo.IsGameStart() && m_tableInfo.getNumberUserSitting() > 1) {
                HandlePreStartGame();
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }
    //khoatd

    protected void processSitOnResponse(User user) {
        //get a listDesk and listUser to add to notify_sitOn response
        List<Desk> desks = m_tableInfo.getListDesk();
        ArrayList<Desk> listDesk = new ArrayList<Desk>();
        ArrayList<String> listUser = new ArrayList<String>();
        for (int i = 0; i < desks.size(); i++) {
            Desk desk = desks.get(i);
            if (desk.getUser() != null) {
                listDesk.add(desk);
                listUser.add(desk.getUser().getName());
            }
        }

        //cards info
        ArrayList<ArrayList<Integer>> listHandCard = new ArrayList<ArrayList<Integer>>();
        ArrayList<ArrayList<Integer>> listLeaveCard = new ArrayList<ArrayList<Integer>>();
        ArrayList<ArrayList<Integer>> listWinCard = new ArrayList<ArrayList<Integer>>();
        for (int i = 0; i < listUser.size(); i++) {
            String userName = listUser.get(i);
            List<ICard> cards1 = m_tableInfo.getMapUserCard(userName).getCurrentHand();
            ArrayList<Integer> handCards = new ArrayList<Integer>();
            for (int j = 0; j < cards1.size(); j++) {
                handCards.add(-1);
            }
            listHandCard.add(handCards);

            List<ICard> cards2 = m_tableInfo.getMapUserLeaveCard(userName).getCurrentHand();
            ArrayList<Integer> leaveCards = new ArrayList<Integer>();
            for (int j = 0; j < cards2.size(); j++) {
                leaveCards.add(cards2.get(j).getCardId());
            }
            listLeaveCard.add(leaveCards);

            List<ICard> cards3 = m_tableInfo.getMapUserPhomCard(userName).getCurrentHand();
            ArrayList<Integer> winCards = new ArrayList<Integer>();
            for (int j = 0; j < cards3.size(); j++) {
                winCards.add(cards3.get(j).getCardId());
            }
            listWinCard.add(winCards);
        }

        int prestartTime = 0;
        if (m_tableInfo.isPrestart()) {
            prestartTime = prestartTask.getMilisecondsLeft();
            prestartTime += 1000;
        }

        Notify_SitOn sitOnRes = new Notify_SitOn();
        sitOnRes.setListDesk(listDesk).setListUser(listUser).setIsGameStart(m_tableInfo.IsGameStart()).setIsPrestart(m_tableInfo.isPrestart()).setPrestartTime(prestartTime).setListHandCard(listHandCard).setListLeaveCard(listLeaveCard).setListWinCard(listWinCard);
        sitOnRes.AddParam(TALA_REPONSE_NAME.SIT_ON_RES, sitOnRes.ToSFSObject());
        sitOnRes.AddReceiver(user);

        GlobalValue.sfsServer.send(sitOnRes.GetReponseName(), sitOnRes.GetParam(), sitOnRes.GetListReceiver());

    }

    protected void processUserSitOnResponse(String userName) {
        List<Desk> listDesk = m_tableInfo.getListDesk();

        //khoatd
        double chip = 0.0;
        UserInfo info = GlobalValue.dataProxy.GetUserInfo(userName);
        if (info != null) {
            chip = info.getChip();
        }

        Desk desk = m_tableInfo.getMapUserDesk().get(userName);
        Notify_UserSitOn userSitOnRes = new Notify_UserSitOn();
        userSitOnRes.setDeskId(desk.getDeskId()).setUserName(userName).setChip(chip).setDeskState(desk.getDeskState()).setCurrentUser(userName).AddParam(TALA_REPONSE_NAME.USER_SIT_ON_RES, userSitOnRes.ToSFSObject());
        //set user who will receive this notify except the sender
        for (int i = 0; i < listDesk.size(); i++) {
            User receiver = listDesk.get(i).getUser();
            if (receiver != null) {
                if (!receiver.getName().equals(userName)) {
                    userSitOnRes.AddReceiver(receiver);
                }
            }
        }
        GlobalValue.sfsServer.send(userSitOnRes.GetReponseName(), userSitOnRes.GetParam(), userSitOnRes.GetListReceiver());
    }

    @Override
    public void HandleUserLeaveRoom(SFSGameEvent evt) {
        UserExitRoom exitEvt = (UserExitRoom) evt;

        processUserLeaveRoom(exitEvt.getM_user());
    }

    public void processUserLeaveRoom(User user) {
        try {
            Logger.trace("Enter processUserLeaveRoom");

            boolean isUserPlaying = false;
            String userName = user.getName();
            Desk desk = m_tableInfo.getMapUserDesk(userName);
            if (desk.getDeskState() == DeskState.PLAYING) {
                isUserPlaying = true;
            }
            //remove leaving user from m_tableInfo
            m_tableInfo.LeaveUserOut(user);


            if (m_tableInfo.IsGameStart()) {
                //update user chip in database if user leaves while game playing
                //NOT IMPLEMENT
                if (isUserPlaying) {
                    processUpdateChipForLeaver(userName);
                }

                //handle finish or turn game
                if (m_tableInfo.GetListActiveUserName().size() == 1) {
                    HandleFinishGame();
                } else {
                    //if user who leave room is a current user (holder) -> turn to other user
                    String leaveUser = userName;
                    if (m_tableInfo.getCurrentUser().equals(leaveUser)) {
                        HandleTurn();
                    }
                }
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    private void processUpdateChipForLeaver(String userName) {
    }

    //khoatd
    private void HandlePreStartGame() {
        try {
            Logger.trace("Enter HandlePreStartGame");
            m_tableInfo.prestartStatus();

            Notify_PreStart response = new Notify_PreStart();
            response.setM_isPrestart(true).setM_time(getTableInfo().PRE_START_TIME).AddParam(TALA_REPONSE_NAME.PRE_START, response.ToSFSObject());
            responseToAllUser(response);

            GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());

            StopTimer();
            m_timer = new Timer();
            prestartTask = new PreStartTask();
            m_timer.schedule(prestartTask, getTableInfo().PRE_START_TIME);

        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    public void HandleConfirmReadyGame(User sender, IGameRequest request) {
        try {
            if (!m_tableInfo.IsGameStart()) {
                Logger.trace("Enter HandleConfirmReadyGame");
                m_tableInfo.processUserReady(sender);

                Notify_UserReady response = new Notify_UserReady();
                response.setUserName(sender.getName()).AddParam(TALA_REPONSE_NAME.USER_READY_RES, response.ToSFSObject());
                responseToAllUser(response);
                GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());
            }

            //if enough player in room then start game without waiting count down
//            if (userReady == userInRoom) {
//                StopTimer();
//                HandleStartGame();
//            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }
    //khoatd

    private void HandleStartGame() {
        try {
            Logger.trace("Enter HandleStartGame");
            //kick user not ready
            for (Desk desk : getTableInfo().getListDesk()) {
                User receiver = desk.getUser();
                if (receiver != null) {
                    if (desk.getDeskState() != DeskState.READY) {
                        processKickUsers(receiver, 1);
                        m_tableInfo.ProcessUserLeaveGame(receiver);
                    }
                }
            }
            if (m_tableInfo.GetListActiveUserName().size() > 1) {
                m_tableInfo.startGameStatus();

                //- nếu currentUser == "" (khi mới tạo phòng) hoặc currentUser đã leave room 
                //      thì gán mặc định người tiếp theo là currentUser
                //- Kiểm tra xem holder có còn trong phòng hay ko trước khi bắt đầu game.
                if (m_tableInfo.getCurrentUser() == null || m_tableInfo.getCurrentUser().equals("")
                        || !m_tableInfo.GetListActiveUserName().contains(m_tableInfo.getCurrentUser())) {
                    for (int i = 0; i < m_tableInfo.getListDesk().size(); i++) {
                        Desk d = m_tableInfo.getListDesk().get(i);
                        if (d.getDeskState() == DeskState.READY) {
                            m_tableInfo.setCurrentUser(d.getUser().getName());
                            break;
                        }
                    }
                }
                for (int i = 0; i < m_tableInfo.GetListActiveUser().size(); i++) {
                    User reciver = m_tableInfo.GetListActiveUser().get(i);
                    processStartGameForUser(reciver);
                }

                if (checkUGameInStart()) {
                    return;
                }

                m_tableInfo.ChangeUserRemoveCard();
                m_timer = new Timer();
                m_timer.schedule(new EndRemoveCardTask(), getTableInfo().REMOVE_CARD_TIME);
            } else {
                User user = m_tableInfo.GetListActiveUser().get(0);
                if (user != null) {
                    m_tableInfo.ProcessUserWaiting(user);
                }

                m_tableInfo.waitingStatus();
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    private boolean checkUGameInStart() {
        for (int i = 0; i < m_tableInfo.GetListActiveUserName().size(); i++) {
            String userName = m_tableInfo.GetListActiveUserName().get(i);
            List<Integer> listPhom = new ArrayList<Integer>();
            if (CheckFinishUGame(userName, listPhom)) {
                HandleFinishUGame(userName, listPhom);
                return true;
            }
        }
        return false;
    }

    private void processStartGameForUser(User receiver) {
        m_tableInfo.ProcessUserPlay(receiver);

        Notify_Start startRes = new Notify_Start();
        startRes.setM_holderName(m_tableInfo.getCurrentUser());
        startRes.setM_time(m_tableInfo.REMOVE_CARD_TIME);

        int cardNumber;
        if (m_tableInfo.getCurrentUser().equals(receiver.getName())) {
            cardNumber = 10;
        } else {
            cardNumber = 9;
        }
        List<ICard> listCard = m_tableInfo.getTaLaCardCollection().getNextCard(cardNumber);
//        if (receiver.getName().equalsIgnoreCase("user1")) {
//            listCard = m_tableInfo.getTaLaCardCollection().getNextCard2(cardNumber);
//        }
        TaLaCardHand cardHand = new TaLaCardHand();
        cardHand.setCurrentHand(listCard);
        m_tableInfo.getMapUserCard().put(receiver.getName(), cardHand);

        ArrayList<Integer> listCardID = new ArrayList<Integer>();
        for (int i = 0; i < listCard.size(); i++) {
            int cardId = listCard.get(i).getCardId();
            listCardID.add(cardId);
        }
        startRes.setM_listCard(listCardID);

        startRes.AddParam(TALA_REPONSE_NAME.START, startRes.ToSFSObject());
        startRes.AddReceiver(receiver);
        GlobalValue.sfsServer.send(startRes.GetReponseName(), startRes.GetParam(), startRes.GetListReceiver());
    }

    private void processKickUsers(User receiver, int resType) {
        Notify_KickUser kickRes = new Notify_KickUser();
        kickRes.setM_resType(resType);
        kickRes.AddParam(TALA_REPONSE_NAME.KICK_USER_RES, kickRes.ToSFSObject());

        kickRes.AddReceiver(receiver);
        GlobalValue.sfsServer.send(kickRes.GetReponseName(), kickRes.GetParam(), kickRes.GetListReceiver());
    }

//    private void HandleEndTurnUser() {
//        try {             Logger.trace("Enter HandleRoomRemove");
//            StopTimer();
//            String currentUser = m_tableInfo.getCurrentUser();
//            TaLaCardHand handCard = m_tableInfo.getMapUserCard(currentUser);
//            if (m_tableInfo.isLastTurn(currentUser)) {
//                TaLaCardHand phomCard = m_tableInfo.getMapUserPhomCard(currentUser);
//                if (phomCard.getCurrentHand().isEmpty()) {
//                    if (handCard.getCurrentHand().size() < 10) {
//                        processGetNextCard(currentUser);
//                    }
//                    processLooseUser();
//                } else {
//                    handleRemoveRandomCard();
//                }
//            } else {
//                if (handCard.getCurrentHand().size() < 10) {
//                    processGetNextCard(currentUser);
//                }
//                handleRemoveRandomCard();
//            }
//
//        } catch (Exception ex) {
//            Logger.error(this.getClass(), ex);
//        }
//    }
    private void HandleEndGetCardUser() {
        try {
            Logger.trace("Enter HandleEndGetCardUser");
            StopTimer();
            String currentUser = m_tableInfo.getCurrentUser();
            processGetNextCard(currentUser);

        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    private void HandleEndShowCardUser() {
        try {
            Logger.trace("Enter HandleEndShowCardUser");
            StopTimer();
            processLooseUser();
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    private void HandleEndRemoveCardUser() {
        try {
            Logger.trace("Enter HandleEndRemoveCardUser");
            StopTimer();
            handleRemoveRandomCard();
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    private void HandleTurn() {
        try {
            Logger.trace("Enter HandleTurn");
            StopTimer();

            processBeforeTurn(m_tableInfo.getCurrentUser());

            if (m_tableInfo.isAllEndGame() == false) {
                m_tableInfo.processNextUserPlaying();
                String nextUser = m_tableInfo.getCurrentUser();
                //response turn for user and players
                Notify_Turn turnRes = new Notify_Turn();

                turnRes.setM_time(m_tableInfo.GET_NEXT_CARD_TIME);
                turnRes.setM_username(nextUser);
                turnRes.AddParam(TALA_REPONSE_NAME.TURN, turnRes.ToSFSObject());
                responseToAllUser(turnRes);

                GlobalValue.sfsServer.send(turnRes.GetReponseName(), turnRes.GetParam(), turnRes.GetListReceiver());

                m_tableInfo.ChangeUserGetCard();

                m_timer = new Timer();
                m_timer.schedule(new EndGetCardTask(), m_tableInfo.GET_NEXT_CARD_TIME);
            } else {
                HandleFinishGame();
            }

        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }
    //Xử lý trường hợp user getPlayerCard nhung card đó ko được hạ phỏm -> đền bài

    private void processBeforeTurn(String userName) {
        if (m_tableInfo.isUserFinishGame(userName)) {
            TaLaCardHand phomHand = m_tableInfo.getMapUserPhomCard(userName);
            ArrayList<Integer> listWinCardId = m_tableInfo.getMapUserWinCard(userName);
            ArrayList<Double> listWinChip = m_tableInfo.getMapUserWinChip(userName);
            ArrayList<String> listWinFromName = m_tableInfo.getMapUserWinFromPlayer(userName);

            String lastFromName = null;//player mà user đã getCard cuối cùng nếu những player(bị getCard) trước đã leave game
            double giveBackChip = 0.0;//số chip được return về cho người cuối cùng nếu chưa leave game.
            double subtractChip = 0.0;
            for (int i = 0; i < listWinCardId.size(); i++) {
                int cardId = listWinCardId.get(i);
                if (!phomHand.IsContain(cardId)) {
                    String fromName = listWinFromName.get(i);
                    double chip = listWinChip.get(i);
                    subtractChip += chip;
                    if (fromName.equals(lastFromName)) {
                        giveBackChip += chip;
                    } else {
                        lastFromName = fromName;
                        giveBackChip = chip;
                    }
                }
            }

            processDenBai(userName, lastFromName, giveBackChip, subtractChip);
        }
    }

    private void processDenBai(String userName, String fromName, double giveBackChip, double subtractChip) {
        if (fromName != null) {
            //update chip for user in database
            //NOT IMPLEMENT

            //response for user
            Notify_DenBai response = new Notify_DenBai();
            response.setM_username(userName).setM_fromName(fromName).setM_giveBackChip(giveBackChip).setM_subtractChip(subtractChip);
            response.AddParam(TALA_REPONSE_NAME.DEN_BAI_RES, response.ToSFSObject());

            for (Desk desk : getTableInfo().getListDesk()) {
                User receiver = desk.getUser();
                if (receiver != null && desk.getDeskState() == DeskState.PLAYING) {
                    response.AddReceiver(receiver);
                }
            }

            GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());
        }
    }

    //khoatd
    private void HandleGetNextCard(User sender, IGameRequest request) {
        processGetNextCard(sender.getName());

    }
    //TEMPORARY
    private boolean isFree = true;

    private void processGetNextCard(String senderName) {
        try {
            if (m_tableInfo.getCurrentUser().equals(senderName) && m_tableInfo.isGetCard() && isFree) {
                Logger.trace("Enter processGetNextCard");
                isFree = false;
                StopTimer();

                ICard newCard = m_tableInfo.getTaLaCardCollection().getNextCard();
                m_tableInfo.getMapUserCard().get(senderName).AddToCurrentHand(newCard);

                int time;
                if (m_tableInfo.isLastTurn(senderName)) {
                    time = m_tableInfo.SHOW_CARD_TIME;
                } else {
                    time = m_tableInfo.REMOVE_CARD_TIME;
                }

                User sender = m_tableInfo.getMapUserDesk().get(senderName).getUser();
                //response for user.
                Reponse_GetNextCardRequest UserResponse = new Reponse_GetNextCardRequest();
                UserResponse.setM_username(senderName).setM_cardId(newCard.getCardId()).setM_time(time).AddParam(TALA_REPONSE_NAME.GET_NEXT_CARD_RES, UserResponse.ToSFSObject());
                UserResponse.AddReceiver(sender);
                GlobalValue.sfsServer.send(UserResponse.GetReponseName(), UserResponse.GetParam(), UserResponse.GetListReceiver());

                //response for player
                Reponse_GetNextCardRequest PlayerResponse = new Reponse_GetNextCardRequest();
                PlayerResponse.setM_username(senderName).setM_cardId(-1).setM_time(time);
                PlayerResponse.AddParam(TALA_REPONSE_NAME.GET_NEXT_CARD_RES, PlayerResponse.ToSFSObject());
                responseToListUserNotSender(PlayerResponse, senderName);
                GlobalValue.sfsServer.send(PlayerResponse.GetReponseName(), PlayerResponse.GetParam(), PlayerResponse.GetListReceiver());

                processAfterGetCard(sender);
                isFree = true;
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    protected void processAfterGetCard(User sender) {
        String senderName = sender.getName();
        List<Integer> listPhom = new ArrayList<Integer>();
        if (CheckFinishUGame(senderName, listPhom)) {
            HandleFinishUGame(senderName, listPhom);
            return;
        }

        if (m_tableInfo.isLastTurn(senderName)) {
            if (CheckLoose(senderName)) {
                processLooseUser();
            } else {
                HandleEndGame(sender);
            }
        } else {
            m_tableInfo.ChangeUserRemoveCard();
            StopTimer();
            m_timer = new Timer();
            m_timer.schedule(new EndRemoveCardTask(), m_tableInfo.REMOVE_CARD_TIME);
        }
    }

    private void HandleGetPlayerCard(User sender, IGameRequest request) {
        processGetPlayerCard(sender, request);

    }
    //khoatd

    private void processGetPlayerCard(User sender, IGameRequest request) {
        try {
            if (m_tableInfo.getCurrentUser().equals(sender.getName()) && m_tableInfo.isGetCard() && isFree) {
                Logger.trace("Enter processGetPlayerCard");
                isFree = true;
                StopTimer();
                GetPlayerCardRequest getPlayerReq = (GetPlayerCardRequest) request;
                String userName = sender.getName();
                String fromName = getPlayerReq.getM_fromUser();
                int cardId = getPlayerReq.getM_cardId();
                if (checkGetPlayerCardValid(userName, fromName, cardId)) {
                    //process caculate, update chip
                    double winChip = processGetChip(userName, fromName, m_tableInfo.getBetChip());

                    //process get card.
                    ICard winCard = m_tableInfo.getMapUserLeaveCard().get(fromName).RemoveACardInHand(cardId);
                    m_tableInfo.getMapUserCard(userName).AddToCurrentHand(winCard);
                    m_tableInfo.getMapUserWinCard(userName).add(cardId);
                    m_tableInfo.getMapUserWinChip(userName).add(winChip);
                    m_tableInfo.getMapUserWinFromPlayer(userName).add(fromName);

                    //process move card
                    moveObj obj = new moveObj();
                    processMoveCard(userName, fromName, obj);
                    processAfterMoveCard(fromName);
                    
                    int time;
                    if (m_tableInfo.isLastTurn(userName)) {
                        time = m_tableInfo.SHOW_CARD_TIME;
                    } else {
                        time = m_tableInfo.REMOVE_CARD_TIME;
                    }

                    //response for user and players
                    Reponse_GetPlayerCardRequest Response = new Reponse_GetPlayerCardRequest();
                    Response.setM_username(userName).setM_fromUser(fromName).setM_cardId(cardId).setM_chip(winChip).setM_time(time).setM_moveFrom(obj.moveFrom).setM_moveCardId(obj.moveCardId).AddParam(TALA_REPONSE_NAME.GET_PLAYER_CARD_RES, Response.ToSFSObject());
                    responseToAllUser(Response);

                    GlobalValue.sfsServer.send(Response.GetReponseName(), Response.GetParam(), Response.GetListReceiver());

                    processAfterGetCard(sender);
                    isFree = true;
                }
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }
    
    //check user get card is valid.

    private boolean checkGetPlayerCardValid(String userName, String fromUser, int cardId) {
        //Condition:
        //      fromUser: LastUser Turn
        //      cardId: Last user leave card
        TaLaCardHand currHand = m_tableInfo.getMapUserCard(userName);
        TaLaCardHand leaveHand = m_tableInfo.getMapUserLeaveCard(fromUser);

        if (leaveHand.IsContain(cardId) && currHand.IsGetACardValid(cardId)) {
            return true;
        } else {
            return false;
        }
    }
    //khoatd: move card to leave card fromUser after user get card.

    private String processMoveCard(String userName, String fromName, moveObj obj) {
        String moveFrom = null;

        TaLaCardHand userLeaveCard = m_tableInfo.getMapUserLeaveCard(userName);
        int numUserLeave = userLeaveCard.getCurrentHand().size();
        TaLaCardHand fromLeaveCard = m_tableInfo.getMapUserLeaveCard(fromName);
        int numFromLeave = fromLeaveCard.getCurrentHand().size();

        if (numFromLeave == numUserLeave - 1) {
            obj.moveCardId = moveLeaveCard(userName, fromName);
            obj.moveFrom = userName;
        } else {
            Desk desk = m_tableInfo.getMapUserDesk().get(userName);
            int i = desk.getDeskId() + 1;
            int icount = 1;
            //check 2 player left
            while (icount < 3) {
                if (i == 4) {
                    i = 0;
                }
                Desk nextDesk = m_tableInfo.getListDesk().get(i);
                if (nextDesk.getUser() != null) {
                    String nextUser = nextDesk.getUser().getName();
                    TaLaCardHand nextUserLeave = m_tableInfo.getMapUserLeaveCard(nextUser);
                    if (nextUserLeave.getCurrentHand().size() > numUserLeave) {
                        obj.moveCardId = moveLeaveCard(nextUser, fromName);
                        obj.moveFrom = nextUser;
                        break;
                    }
                }
                i++;
                icount++;
            }

        }
        return moveFrom;
    }

    //move card from a end game player -> tai luot
    private void processAfterMoveCard(String moveFrom) {
        //TaLaCardHand leaveCard = m_tableInfo.getMapUserLeaveCard(moveFrom);
        boolean isEndGame = m_tableInfo.getListUserNameResult().contains(moveFrom);
        if(isEndGame == true){
            m_tableInfo.removeResult(moveFrom);
        }
    }


    //move trash card

    private int moveLeaveCard(String fromName, String ToName) {
        TaLaCardHand fromLeaveCard = m_tableInfo.getMapUserLeaveCard(fromName);
        int cardId = fromLeaveCard.getCurrentHand().get(0).getCardId();

        ICard leaveCard = fromLeaveCard.RemoveACardInHand(cardId);
        m_tableInfo.getMapUserLeaveCard().get(ToName).AddToCurrentHand(leaveCard);

        return cardId;
    }

    //khoatd: transfer chip from fromUser to user who get card
    private double processGetChip(String userName, String fromName, double betChip) {
        //caculate chip
        int numTurn = m_tableInfo.getMapUserLeaveCard(userName).getCurrentHand().size() + 1;
        double winChip = betChip * numTurn;

        //transfer chip in m_tableInfo
        Desk userDesk = m_tableInfo.getMapUserDesk(userName);
        Double currUserChip = userDesk.getChip();
        currUserChip += winChip;
        userDesk.setChip(currUserChip);

        Desk fromDesk = m_tableInfo.getMapUserDesk(fromName);
        Double currFromChip = fromDesk.getChip();
        currFromChip -= winChip;
        fromDesk.setChip(currFromChip);

        //update user chip in database

        //log transaction
        GlobalValue.dataProxy.logTransactionWinChip(userName, fromName, winChip);

        return winChip;
    }

    private void HandleRemoveCard(User sender, IGameRequest request) {
        try {
            RemoveCardRequest removeRequest = (RemoveCardRequest) request;
            processRemoveCard(sender, removeRequest.getM_cardId());
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    private void handleRemoveRandomCard() {
        try {
            Logger.trace("Enter handleRemoveRandomCard");
            String userName = m_tableInfo.getCurrentUser();
            int cardId = getRandomCard(userName);
            User user = m_tableInfo.getMapUserDesk().get(userName).getUser();
            processRemoveCard(user, cardId);
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    //get a card in user hand card and it isn't win card.
    private int getRandomCard(String userName) {
        int randomCarId = 0;

        for (int i = 0; i < 10; i++) {
            randomCarId = m_tableInfo.getMapUserCard().get(userName).getCurrentHand().get(i).getCardId();
            if (!m_tableInfo.isWinCard(userName, randomCarId)) {
                break;
            }
        }
        return randomCarId;
    }

    private void processRemoveCard(User sender, int cardId) {
        try {
            String userName = sender.getName();
            if (checkRemoveCardValid(userName, cardId)) {
                Logger.trace("Enter processRemoveCard");
                StopTimer();

                ICard card = m_tableInfo.getMapUserCard().get(userName).RemoveACardInHand(cardId);
                TaLaCardHand leaveCards = m_tableInfo.getMapUserLeaveCard(userName);
                leaveCards.AddToCurrentHand(card);

                //response user action for user and players
                Notify_UserAction actionRes = new Notify_UserAction();

                actionRes.setM_cardId(cardId).setM_username(userName);
                actionRes.AddParam(TALA_REPONSE_NAME.USER_ACTION, actionRes.ToSFSObject());
                responseToAllUser(actionRes);

                GlobalValue.sfsServer.send(actionRes.GetReponseName(), actionRes.GetParam(), actionRes.GetListReceiver());

                processAfterRemoveCard(userName);
                
                HandleTurn();
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }
    
    private void processAfterRemoveCard(String userName){
        TaLaCardHand phom = m_tableInfo.getMapUserPhomCard(userName);
        TaLaCardHand leaveCard = m_tableInfo.getMapUserLeaveCard(userName);
        
        if(phom.getCurrentHand().size() > 0 && leaveCard.getCurrentHand().size() == 3){
            //purpose: know who is first show card user.
            m_tableInfo.setUserResult(userName, -1);
        }
    }

    private boolean checkRemoveCardValid(String userName, int cardId) {
        TaLaCardHand handCard = m_tableInfo.getMapUserCard(userName);

        if (userName.equals(m_tableInfo.getCurrentUser()) == false) {
            return false;
        }
        if (handCard.IsContain(cardId) == false) {
            return false;
        }
        if (m_tableInfo.isWinCard(userName, cardId) == true) {
            return false;
        }
        if (isShowingCard(userName) == true) {
            return false;
        }
        if (m_tableInfo.isRemoveCard() == false) {
            return false;
        }
        return true;
    }

    private boolean isShowingCard(String userName) {
        TaLaCardHand leaveCard = m_tableInfo.getMapUserLeaveCard(userName);
        if (leaveCard.getCurrentHand().size() == 3) {
            TaLaCardHand phomHand = m_tableInfo.getMapUserPhomCard(userName);
            if (phomHand.getCurrentHand().isEmpty()) {
                return true;
            }
        }
        return false;
    }

    //khoatd: response usser lượt bóc bài cuối cùng -> show card sau khi bóc -> turn.
    private void HandleEndGame(User sender) {
        try {
            Logger.trace("Enter HandleEndGame");
            //response end game for user
            Notify_EndGame endGameRes = new Notify_EndGame();

            endGameRes.setM_userName(sender.getName()).setM_time(m_tableInfo.SHOW_CARD_TIME);
            endGameRes.AddParam(TALA_REPONSE_NAME.END_GAME, endGameRes.ToSFSObject());
            endGameRes.AddReceiver(sender);

            GlobalValue.sfsServer.send(endGameRes.GetReponseName(), endGameRes.GetParam(), endGameRes.GetListReceiver());

            m_tableInfo.ChangeUserShowCard();
            StopTimer();
            m_timer = new Timer();
            m_timer.schedule(new EndShowCardTask(), m_tableInfo.SHOW_CARD_TIME);
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    private void HandleShowCard(User sender, IGameRequest request) {
        try {
            ShowCardRequest showReq = (ShowCardRequest) request;
            String senderName = sender.getName();
            if (m_tableInfo.getCurrentUser().equals(senderName) && m_tableInfo.isShowCard() && CheckShowCard(senderName, showReq.getM_listCard())) {
                Logger.trace("Enter HandleShowCard");
                //get all cardId on user hand
                ArrayList<Integer> arrListCardId = showReq.getM_listCard();
                for (Integer cardId : arrListCardId) {
                    ICard card = m_tableInfo.getMapUserCard().get(senderName).RemoveACardInHand(cardId);
                    m_tableInfo.getMapUserPhomCard().get(senderName).AddToCurrentHand(card);
                }

//                //purpose: know who is first show card user.
//                m_tableInfo.setUserResult(senderName, -1);

                Notify_ShowCard response = new Notify_ShowCard();

                response.setM_listCard(showReq.getM_listCard()).setM_username(senderName).setM_time(m_tableInfo.REMOVE_CARD_TIME);
                response.AddParam(TALA_REPONSE_NAME.SHOW_CARD, response.ToSFSObject());
                responseToAllUser(response);

                GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());


                TaLaCardHand currHand = m_tableInfo.getMapUserCard(senderName);
                if (currHand.IsExistPhom() == false) {
                    StopTimer();
                    m_tableInfo.ChangeUserRemoveCard();
                    m_timer = new Timer();
                    m_timer.schedule(new EndRemoveCardTask(), m_tableInfo.REMOVE_CARD_TIME);
                }
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    //Check if list show card is in user hand && is valid
    private boolean CheckShowCard(String username, ArrayList<Integer> listCardId) {
        TaLaCardHand currHand = m_tableInfo.getMapUserCard(username);

        //Check show card id exist in user hand card
        for (int i = 0; i < listCardId.size(); ++i) {
            if (!currHand.IsContain(listCardId.get(i))) {
                return false;
            }
        }
        //Check: there is only one win card exist in phom.
        if (m_tableInfo.getNumWinCardInPhom(username, listCardId) > 1) {
            return false;
        }

        boolean result = currHand.IsListCardIdValid(listCardId, null);

        return result;
    }

    //người chơi bị móm -> ko show bài -> hạ bài -> turn.
    private void processLooseUser() {
        try {
            Logger.trace("Enter processLooseUser");
            User looser = m_tableInfo.getMapUser().get(m_tableInfo.getCurrentUser());
            if (looser != null) {
//                Desk currentDesk = m_tableInfo.getMapUserDesk(looser.getName());
//                currentDesk.setResult(4);
                m_tableInfo.addUserResult(looser.getName(), 4);

                //response for user and player.
                Notify_LooseGame looseRes = new Notify_LooseGame();
                looseRes.setM_looseName(looser.getName());
                looseRes.AddParam(TALA_REPONSE_NAME.LOOSE_GAME, looseRes.ToSFSObject());
                responseToAllUser(looseRes);

                GlobalValue.sfsServer.send(looseRes.GetReponseName(), looseRes.GetParam(), looseRes.GetListReceiver());

                HandleTurn();
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }
    //khoatd: người chơi bị móm return true;
    //      1: nếu wincard của user > 1, thì ko móm, vì khi getPlayerCard 
    //      đã kiểm tra bài ăn được có tạo thành 1 phỏm hay ko.
    //      2: kiểm tra handcard có phỏm hay ko.

    private boolean CheckLoose(String userName) {
        TaLaCardHand currHand = m_tableInfo.getMapUserCard(userName);

        if (currHand.IsExistPhom()) {
            return false;
        }

        return true;
    }

    //using in getNextCard && getPlayerCard
    private boolean CheckFinishUGame(String winUser, List<Integer> listPhom) {
        int numPhom = m_tableInfo.GetNumPhom(winUser, listPhom);
        if (numPhom == 3) {
            return true;
        } else {
            return false;
        }
    }

    private void HandleFinishUGame(String winner, List<Integer> listPhom) {
        try {
            Logger.trace("Enter HandleFinishUGame");
            //caculate and update chip for user
            ArrayList<Double> listChip = m_tableInfo.processFinishUGame(winner);
            ArrayList<Integer> listResult = (ArrayList) m_tableInfo.getListResult();
            ArrayList<String> listPlayingUser = (ArrayList) m_tableInfo.getListUserNameResult();
            ArrayList<ArrayList<Integer>> listCardHand = new ArrayList<ArrayList<Integer>>();
            if(listPhom != null)
                listCardHand.add((ArrayList<Integer>) listPhom);

            //update chip for users
            processUpdateChip(listChip);

            //response for users
            Notify_Finish finishRes = new Notify_Finish();
            finishRes.setM_listCard(listCardHand).setM_listUserName(listPlayingUser).setM_listChip(listChip).setM_listResult(listResult);
            finishRes.AddParam(TALA_REPONSE_NAME.FINISH, finishRes.ToSFSObject());
            responseToAllUser(finishRes);
            GlobalValue.sfsServer.send(finishRes.GetReponseName(), finishRes.GetParam(), finishRes.GetListReceiver());

            m_tableInfo.setCurrentUser(winner);
            m_tableInfo.waitingStatus();

            m_tableInfo.ChangeUserFinishGame();
            //enforce user to leave game if not enought chip;
            processLeaveUserLessMinChip();

            //prestart game.
            m_tableInfo.prepareReplayGame();

            m_timer = new Timer();
            m_timer.schedule(new ReplayGameTask(), m_tableInfo.REPLAY);
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    private void HandleFinishGame() {
        try {
            Logger.trace("Enter HandleFinishGame");
            StopTimer();
            ArrayList<Double> listChip = processSummaryGame();

            //update chip for users
            processUpdateChip(listChip);

            //get all card hand of all users.
            ArrayList<Integer> listResult = (ArrayList) m_tableInfo.getListResult();
            ArrayList<String> listPlayingUser = (ArrayList) m_tableInfo.getListUserNameResult();
            ArrayList<ArrayList<Integer>> listCardHand = m_tableInfo.processGetAllCardHand((ArrayList) m_tableInfo.getListUserNameResult());

            //send response
            Notify_Finish finishRes = new Notify_Finish();
            finishRes.setM_listCard(listCardHand).setM_listUserName(listPlayingUser).setM_listChip(listChip).setM_listResult(listResult);
            finishRes.AddParam(TALA_REPONSE_NAME.FINISH, finishRes.ToSFSObject());
            responseToAllUser(finishRes);
            GlobalValue.sfsServer.send(finishRes.GetReponseName(), finishRes.GetParam(), finishRes.GetListReceiver());

            String winner = "";
            for (int i = 0; i < m_tableInfo.getListUserNameResult().size(); i++) {
                if (m_tableInfo.getListResult().get(i) == 0) {
                    winner = m_tableInfo.getListUserNameResult().get(i);
                    break;
                }
            }
            m_tableInfo.setCurrentUser(winner);
            m_tableInfo.waitingStatus();

            m_tableInfo.ChangeUserFinishGame();
            //enforce user to leave game if not enought chip;
            processLeaveUserLessMinChip();

            //prestart game.
            m_tableInfo.prepareReplayGame();

            m_timer = new Timer();
            m_timer.schedule(new ReplayGameTask(), m_tableInfo.REPLAY);
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    private void processLeaveUserLessMinChip() {
        double minChip = m_tableInfo.getBetChip() * 5;

        for (int i = 0; i < m_tableInfo.getListDesk().size(); i++) {
            Desk desk = m_tableInfo.getListDesk().get(i);
            if (desk.getDeskState() == DeskState.PLAYING) {
                if (desk.getChip() < minChip) {
                    processKickUsers(desk.getUser(), 2);
                    m_tableInfo.LeaveUserOut(desk.getUser());
                }
            }
        }
    }

    //***********************************************************************************
    //      khoatd: tính điểm, set thứ hạn, return về list<chip>(-200, 300, -100)
    //***********************************************************************************
    private ArrayList<Double> processSummaryGame() {

        //tinh diem la bai tren tay cac user
        ArrayList<Integer> listScore = m_tableInfo.processCaculateScore();

        //xếp thứ hạng của player
        m_tableInfo.processSetResultForUser(listScore);

        //Caculate chip;
        ArrayList<Double> listChip = m_tableInfo.processCaculateChip();

        return listChip;
    }

    private void processUpdateChip(ArrayList<Double> listChip) {
        //update chip for user in database

        //update chip for user in tableInfo
        String winner = m_tableInfo.processUpdateChip(listChip);

        //log transaction
        for (int i = 0; i < m_tableInfo.getListUserNameResult().size(); i++) {
            String userName = m_tableInfo.getListUserNameResult().get(i);
            Desk desk = m_tableInfo.getMapUserDesk(userName);
            if (desk != null && desk.getDeskState() == DeskState.PLAYING) {
                double addChip = listChip.get(i);
                if (addChip < 0) {
                    GlobalValue.dataProxy.logTransactionWinChip(winner, desk.getUser().getName(), addChip);
                }
            }
        }
    }

    //khoatd: add all user to response
    protected void responseToAllUser(SFSGameReponse response) {
        for (Desk desk : getTableInfo().getListDesk()) {
            User receiver = desk.getUser();
            if (receiver != null) {
                response.AddReceiver(receiver);
            }
        }
    }

    //khoatd: add all user to response without sender
    protected void responseToListUserNotSender(SFSGameReponse response, String sender) {
        for (Desk desk : getTableInfo().getListDesk()) {
            User receiver = desk.getUser();
            if (receiver != null) {
                if (!receiver.getName().equals(sender)) {
                    response.AddReceiver(receiver);
                }
            }
        }
    }

    //khoatd
    private void StopTimer() {
        m_timer.cancel();
        m_timer.purge();
    }

    /**
     * @return the m_tableInfo
     */
    public TaLaTableInfo getTableInfo() {
        return m_tableInfo;
    }

    /**
     * @param m_tableInfo the m_tableInfo to set
     */
    public void setTableInfo(TaLaTableInfo m_tableInfo) {
        this.m_tableInfo = m_tableInfo;
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

    //khoatd
//    class RemoveCardTask extends TimerTask {
//
//        @Override
//        public void run() {
//            RemoveTimer();
//            handleRemoveRandomCard();
//        }
//
//        private void RemoveTimer() {
//            m_timer.cancel();
//            m_timer.purge();
//        }
//    }
    //khoatd
//    class EndTurnUserTask extends TimerTask {
//
//        @Override
//        public void run() {
//            RemoveTimer();
//            HandleEndTurnUser();
//        }
//
//        private void RemoveTimer() {
//            m_timer.cancel();
//            m_timer.purge();
//        }
//    }
    class EndGetCardTask extends TimerTask {

        @Override
        public void run() {
            RemoveTimer();
            HandleEndGetCardUser();
        }

        private void RemoveTimer() {
            m_timer.cancel();
            m_timer.purge();
        }
    }

    class EndRemoveCardTask extends TimerTask {

        @Override
        public void run() {
            RemoveTimer();
            HandleEndRemoveCardUser();
        }

        private void RemoveTimer() {
            m_timer.cancel();
            m_timer.purge();
        }
    }

    class EndShowCardTask extends TimerTask {

        @Override
        public void run() {
            RemoveTimer();
            HandleEndShowCardUser();
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

    //khoatd
    class moveObj {

        String moveFrom;
        int moveCardId;
    }
}
