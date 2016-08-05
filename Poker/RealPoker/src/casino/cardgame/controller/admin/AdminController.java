/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.controller.admin;

import casino.cardgame.controller.game.GameController;
import casino.cardgame.controller.game.table.PokerTournamentController;
import casino.cardgame.entity.RoomInfo;
import casino.cardgame.entity.TransactionInfo;
import casino.cardgame.entity.UserInfo;
import casino.cardgame.entity.game.LevelDetailEntity;
import casino.cardgame.entity.game.TournamentEntity;
import casino.cardgame.game_enum.*;
import casino.cardgame.message.event.Login;
import casino.cardgame.message.event.SFSGameEvent;
import casino.cardgame.message.reponse.SFSGameReponse;
import casino.cardgame.message.reponse.admin.*;
import casino.cardgame.message.reponse.game.pokreTournament.*;
import casino.cardgame.message.request.GAME_REQUEST_NAME;
import casino.cardgame.message.request.SFSGameRequest;
import casino.cardgame.message.request.admin.*;
import casino.cardgame.utils.GlobalValue;
import casino.cardgame.utils.Logger;
import com.smartfoxserver.v2.api.CreateRoomSettings;
import com.smartfoxserver.v2.entities.Room;
import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.Zone;
import com.smartfoxserver.v2.entities.data.ISFSArray;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.entities.variables.RoomVariable;
import com.smartfoxserver.v2.entities.variables.SFSRoomVariable;
import com.smartfoxserver.v2.entities.variables.SFSUserVariable;
import com.smartfoxserver.v2.entities.variables.UserVariable;
import com.smartfoxserver.v2.exceptions.SFSErrorCode;
import com.smartfoxserver.v2.exceptions.SFSErrorData;
import com.smartfoxserver.v2.exceptions.SFSLoginException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author KIDKID
 */
public class AdminController implements IAdminController {

    protected static AdminController m_instance;
    protected GameController m_GameController;

    protected AdminController() {
        m_GameController = GameController.getInstance();
    }

    public static AdminController getInstance() {
        if (m_instance == null) {
            m_instance = new AdminController();
        }
        return m_instance;
    }

    @Override
    public void HandleStartServerRequest(SFSGameRequest sfsreq) {
        try {
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    @Override
    public void HandleStopServerRequest(SFSGameRequest sfsreq) {
        try {
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    @Override
    public void HandleAdminLogin(SFSGameEvent sfse) throws SFSLoginException {
        Login evt = (Login) sfse;
        String adminName = evt.getM_name();
        String password = evt.getM_password();

        String adminPass = GlobalValue.dataProxy.GetAdminPassword(adminName);
        if (adminPass == null || GlobalValue.sfsServer.getApi().checkSecurePassword(evt.getM_session(), password, adminPass)) {
            SFSErrorData sfsLoginError = new SFSErrorData(SFSErrorCode.LOGIN_BAD_USERNAME);
            sfsLoginError.addParameter(adminName);
            throw new SFSLoginException("Your admin or password is incorrect", sfsLoginError);
        }
    }

    @Override
    public void HandleAdminLogout(SFSGameEvent igame) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void HandleAdminMessageRequest(SFSGameRequest sfsreq) {
        try {
            User sender = sfsreq.getM_user();
            if (sfsreq.GetRequestName().equals(ADMIN_REQUEST_NAME.CREATE_ROOM_REQ)) {
                handleCreateRoom(sender, sfsreq);
            } else if (sfsreq.GetRequestName().equals(ADMIN_REQUEST_NAME.CREATE_TOUR_REQ)) {
                handleCreateTournament(sender, sfsreq);
            } else if (sfsreq.GetRequestName().equals(ADMIN_REQUEST_NAME.CREATE_USER_REQ)) {
                handleCreateUser(sender, sfsreq);
            } else if (sfsreq.GetRequestName().equals(ADMIN_REQUEST_NAME.DELETE_ROOM_REQ)) {
                handleDeleteRoom(sender, sfsreq);
            } else if (sfsreq.GetRequestName().equals(ADMIN_REQUEST_NAME.DELETE_TOUR_REQ)) {
                handleDeleteTournament(sender, sfsreq);
            } else if (sfsreq.GetRequestName().equals(ADMIN_REQUEST_NAME.DELETE_USER_REQ)) {
                handleDeleteUser(sender, sfsreq);
            } else if (sfsreq.GetRequestName().equals(ADMIN_REQUEST_NAME.GET_LIST_ROOM_REQ)) {
                handleGetListRoom(sender, sfsreq);
            } else if (sfsreq.GetRequestName().equals(ADMIN_REQUEST_NAME.GET_LIST_TOURNAMENT_REQ)) {
                handleGetListTournament(sender, sfsreq);
            } else if (sfsreq.GetRequestName().equals(ADMIN_REQUEST_NAME.GET_LIST_LEVEL_REQ)) {
                handleGetListLevel(sender, sfsreq);
            } else if (sfsreq.GetRequestName().equals(ADMIN_REQUEST_NAME.GET_LEVEL_COLLECTION_REQ)) {
                handleGetLevelCollection(sender, sfsreq);
            } else if (sfsreq.GetRequestName().equals(ADMIN_REQUEST_NAME.GET_LIST_USER_REQ)) {
                handleGetListUser(sender, sfsreq);
            } else if (sfsreq.GetRequestName().equals(ADMIN_REQUEST_NAME.GET_TRANSACTION_REQ)) {
                handleGetTransaction(sender, sfsreq);
            } else if (sfsreq.GetRequestName().equals(ADMIN_REQUEST_NAME.UPDATE_ROOM_REQ)) {
                handleUpdateRoom(sender, sfsreq);
            } else if (sfsreq.GetRequestName().equals(ADMIN_REQUEST_NAME.UPDATE_TOUR_REQ)) {
                handleUpdateTournament(sender, sfsreq);
            } else if (sfsreq.GetRequestName().equals(ADMIN_REQUEST_NAME.UPDATE_USER_REQ)) {
                handleUpdateUser(sender, sfsreq);
            } else if (sfsreq.GetRequestName().equals(ADMIN_REQUEST_NAME.UPDATE_TOUR_STATUS_REQ)) {
                handleActiveTournament(sender, sfsreq);
            } else if (sfsreq.GetRequestName().equals(ADMIN_REQUEST_NAME.ADD_CHIP_FOR_USER_REQ)) {
                handleAddChipForUser(sender, sfsreq);
            } else if (sfsreq.GetRequestName().equals(ADMIN_REQUEST_NAME.CREATE_LEVEL_REQ)) {
                handleCreateLevel(sender, sfsreq);
            } else if (sfsreq.GetRequestName().equals(ADMIN_REQUEST_NAME.DELETE_LEVEL_REQ)) {
                handleDeleteLevel(sender, sfsreq);
            } else if (sfsreq.GetRequestName().equals(ADMIN_REQUEST_NAME.UPDATE_LEVEL_REQ)) {
                handleUpdateLevel(sender, sfsreq);
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    private boolean checkAdminValid(User sender) {
        if (sender.isSuperUser()) {
            return true;
        } else {
            return false;
        }
//        return true;
    }

    private void responseSuccessCreating(User receiver, String objType) {
        CreateResponse response = new CreateResponse();
        response.setMessage("create successful!");
        response.setObjCreated(objType);
        response.AddParam(ADMIN_RESPONSE_TYPE.CREATE_RES, response.ToSFSObject());
        response.AddReceiver(receiver);
        GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());
    }

    private void responseErrorCreating(User receiver, String msg) {
        CreateErrorResponse response = new CreateErrorResponse();
        response.setMessage(msg);
        response.AddParam(ADMIN_RESPONSE_TYPE.CREATE_ERROR_RES, response.ToSFSObject());
        response.AddReceiver(receiver);
        GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());
    }

    private void responseSuccessUpdating(User receiver, String objType) {
        UpdateResponse response = new UpdateResponse();
        response.setMessage("update successful!");
        response.setObjUpdated(objType);
        response.AddParam(ADMIN_RESPONSE_TYPE.UPDATE_RES, response.ToSFSObject());
        response.AddReceiver(receiver);
        GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());
    }

    private void responseErrorUpdating(User receiver, String msg) {
        UpdateErrorResponse response = new UpdateErrorResponse();
        response.setMessage(msg);
        response.AddParam(ADMIN_RESPONSE_TYPE.UPDATE_ERROR_RES, response.ToSFSObject());
        response.AddReceiver(receiver);
        GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());
    }

    private void responseSuccessDeleting(User receiver, String objType) {
        DeleteResponse response = new DeleteResponse();
        response.setMessage("delete successful!");
        response.setObjDeleted(objType);
        response.AddParam(ADMIN_RESPONSE_TYPE.DELETE_RES, response.ToSFSObject());
        response.AddReceiver(receiver);
        GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());
    }

    private void responseErrorDeleting(User receiver, String msg, String objType) {
        DeleteErrorResponse response = new DeleteErrorResponse();
        response.setMessage(msg);
        response.setObjDeleted(objType);
        response.AddParam(ADMIN_RESPONSE_TYPE.DELETE_ERROR_RES, response.ToSFSObject());
        response.AddReceiver(receiver);
        GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());
    }

    public CreateRoomSettings CreateSettingRoom(RoomInfo newRoom) {
        try {
            Logger.trace("create SettingRoom");
            CreateRoomSettings setting = new CreateRoomSettings();
            setting.setName(newRoom.getRoomName());
            setting.setMaxUsers(newRoom.getMaxUsers());
            setting.setMaxVariablesAllowed(20);
            setting.setGame(true);
            setting.setGroupId("game_poker");

            ArrayList<RoomVariable> roomVariable = new ArrayList<RoomVariable>();
            roomVariable.add(new SFSRoomVariable(RoomVariableDetail.DISPLAY_NAME, newRoom.getDisplayName()));
            roomVariable.add(new SFSRoomVariable(RoomVariableDetail.PASSWORD, newRoom.getPassword()));
            roomVariable.add(new SFSRoomVariable(RoomVariableDetail.BET_CHIP, newRoom.getBetChip()));
            roomVariable.add(new SFSRoomVariable(RoomVariableDetail.MIN_BUYIN, newRoom.getMinBuyin()));
            roomVariable.add(new SFSRoomVariable(RoomVariableDetail.MAX_BUYIN, newRoom.getMaxBuyin()));
            roomVariable.add(new SFSRoomVariable(RoomVariableDetail.NO_LIMIT, newRoom.getNoLimit()));

            setting.setRoomVariables(roomVariable);
            return setting;
        } catch (Exception ex) {
            Logger.error("TestedController::CreateSettingRoom", ex);
            return null;
        }
    }

    private void handleCreateUser(User sender, SFSGameRequest sfsreq) {
        try {
            CreateUserRequest request = (CreateUserRequest) sfsreq;

            if (checkAdminValid(sender)) {
                Logger.trace("Enter AdminController:: handleCreateUser");
                UserInfo newUser = request.getUser();

                GlobalValue.dataProxy.addUserInfo(newUser);

                responseSuccessCreating(sender, ManagedObject.USER);
            } else {
                Logger.trace("admin have not permission");
                responseErrorCreating(sender, "admin have not permission!");
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
            responseErrorCreating(sender, ex.getMessage());
        }
    }

    private void handleDeleteUser(User sender, SFSGameRequest sfsreq) {
        try {
            DeleteUserRequest request = (DeleteUserRequest) sfsreq;

            if (checkAdminValid(sender)) {
                Logger.trace("Enter AdminController:: handleDeleteUser");
                String userName = request.getUserName();

                //insert new room in database
                GlobalValue.dataProxy.deleteUser(userName);

                responseSuccessDeleting(sender, ManagedObject.USER);
            } else {
                Logger.trace("admin have not permission");
                responseErrorDeleting(sender, "admin have not permission!", ManagedObject.USER);
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
            responseErrorDeleting(sender, ex.getMessage(), ManagedObject.USER);
        }
    }

    private void handleUpdateUser(User sender, SFSGameRequest sfsreq) {
        try {
            UpdateUserRequest request = (UpdateUserRequest) sfsreq;

            if (checkAdminValid(sender)) {
                UserInfo user = request.getUser();

                //update room in database
                GlobalValue.dataProxy.updateUser(user);

                //response
                responseSuccessUpdating(sender, ManagedObject.USER);
            } else {
                Logger.trace("admin have not permission");
                responseErrorUpdating(sender, "admin have not permission!");
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
            responseErrorUpdating(sender, ex.getMessage());
        }
    }

    private void handleCreateRoom(User sender, SFSGameRequest sfsreq) {
        try {
            CreateRoomRequest request = (CreateRoomRequest) sfsreq;

            if (checkAdminValid(sender)) {
                RoomInfo newRoom = request.getRoom();

                //insert new room in database
                GlobalValue.dataProxy.createRoom(newRoom);

                //create sfsRoom
                CreateRoomSettings roomSetting = CreateSettingRoom(newRoom);
                CreateRoom(newRoom.getRoomName(), roomSetting, sender);

                //response
                responseSuccessCreating(sender, ManagedObject.ROOM);
            } else {
                Logger.trace("admin have not permission");
                responseErrorCreating(sender, "admin have not permission!");
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
            responseErrorCreating(sender, ex.getMessage());
        }
    }

    //create room in smartfox
    protected boolean CreateRoom(String newRoomName, CreateRoomSettings setting, User owner) {
        Zone currentZone = GlobalValue.smartfoxServer.getZoneManager().getZoneByName("RealPokerServer");
        Logger.trace("create sfsRoom: " + newRoomName);
        try {
            GlobalValue.smartfoxServer.getAPIManager().getSFSApi().createRoom(currentZone, setting, owner);
            return true;
        } catch (Exception exc) {
            Logger.error(exc);
            return false;
        }
    }

    private void handleDeleteRoom(User sender, SFSGameRequest sfsreq) {
        try {
            DeleteRoomRequest request = (DeleteRoomRequest) sfsreq;

            if (checkAdminValid(sender)) {
                String roomName = request.getRoomName();
                if (checkRoomAlterablity(roomName)) {
                    Logger.trace("Enter AdminController:: handleDeleteRoom");

                    GlobalValue.dataProxy.deleteRoom(roomName);

                    DeleteRoom(roomName);

                    //responsee
                    responseSuccessDeleting(sender, ManagedObject.ROOM);
                } else {
                    Logger.trace("room is busy");
                    responseErrorUpdating(sender, "room is busy!");
                }
            } else {
                Logger.trace("admin have not permission");
                responseErrorDeleting(sender, "admin have not permission!", ManagedObject.ROOM);
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
            responseErrorDeleting(sender, ex.getMessage(), ManagedObject.ROOM);
        }
    }

    //delete rom in smartfox
    protected boolean DeleteRoom(String roomName) {
        Zone currentZone = GlobalValue.smartfoxServer.getZoneManager().getZoneByName("RealPokerServer");
        Logger.trace("delete sfsRoom: " + roomName);
        try {
            Room room = currentZone.getRoomByName(roomName);
            GlobalValue.smartfoxServer.getAPIManager().getSFSApi().removeRoom(room);
            return true;
        } catch (Exception exc) {
            Logger.error(exc);
            return false;
        }
    }

    private void handleUpdateRoom(User sender, SFSGameRequest sfsreq) {
        try {
            UpdateRoomRequest request = (UpdateRoomRequest) sfsreq;

            if (checkAdminValid(sender)) {
                RoomInfo room = request.getRoom();

                if (checkRoomAlterablity(room.getRoomName())) {
                    //update room in database
                    GlobalValue.dataProxy.updateRoom(room);

                    //update sfsRoom
                    UpdateRoom(sender, room);

                    //response
                    responseSuccessUpdating(sender, ManagedObject.ROOM);
                } else {
                    Logger.trace("room is busy");
                    responseErrorUpdating(sender, "room is busy!");
                }
            } else {
                Logger.trace("admin have not permission");
                responseErrorUpdating(sender, "admin have not permission!");
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
            responseErrorUpdating(sender, ex.getMessage());
        }
    }

//    protected boolean checkRoomAlterablity(String name) {
//        Zone currentZone = GlobalValue.smartfoxServer.getZoneManager().getZoneByName("RealPokerServer");
//        Room room = currentZone.getRoomByName(name);
//        int userCount = room.getUserList().size();
//        int spectatorCount = room.getSpectatorsList().size();
//        if (userCount + spectatorCount > 0) {
//            return false;
//        }
//        return true;
//    }
    protected boolean checkRoomAlterablity(String name) {
        RoomInfo roomInfo = GlobalValue.dataProxy.getRoomInfo(name);
        if (roomInfo != null && roomInfo.getStatus().equals(RoomStatus.EMPTY)) {
            return true;
        }
        return true;
    }

    protected boolean UpdateRoom(User sender, RoomInfo roomInfo) throws Exception {
        Zone currentZone = GlobalValue.smartfoxServer.getZoneManager().getZoneByName("RealPokerServer");
        Logger.trace("update sfsRoom: " + roomInfo.getRoomName());

        Room room = currentZone.getRoomByName(roomInfo.getRoomName());
        if (room != null) {
            GlobalValue.smartfoxServer.getAPIManager().getSFSApi().removeRoom(room);

            CreateRoomSettings setting = CreateSettingRoom(roomInfo);
            CreateRoom(roomInfo.getRoomName(), setting, sender);

            return true;
        }

        return false;
    }
//    protected boolean UpdateRoom(User sender, RoomInfo roomInfo) throws Exception {
//        Zone currentZone = GlobalValue.smartfoxServer.getZoneManager().getZoneByName("RealPokerServer");
//        Logger.trace("update sfsRoom: " + roomInfo.getRoomName());
////        try {
//        Room room = currentZone.getRoomByName(roomInfo.getRoomName());
//        User owner = room.getOwner();
//        GlobalValue.smartfoxServer.getAPIManager().getSFSApi().changeRoomCapacity(owner, room, roomInfo.getMaxUsers(), roomInfo.getMaxUsers());
//        GlobalValue.smartfoxServer.getAPIManager().getSFSApi().changeRoomName(owner, room, roomInfo.getRoomName());
//        GlobalValue.smartfoxServer.getAPIManager().getSFSApi().changeRoomPassword(owner, room, roomInfo.getPassword());
//
//
//        GlobalValue.smartfoxServer.getAPIManager().getSFSApi().setRoomVariables(sender, room, null);
//
//        return true;
////        } catch (Exception exc) {
////            Logger.error(exc);
////            return false;
////        }
//    }

    private void handleCreateTournament(User sender, SFSGameRequest sfsreq) {
        try {
            CreateTournamentRequest request = (CreateTournamentRequest) sfsreq;

            if (checkAdminValid(sender)) {
                Logger.trace("Enter AdminController:: handleCreateTournament");
                TournamentEntity newTour = request.getTournament();

                String errorMsg = checkInputTourData(newTour);
                if (errorMsg == null) {
                    //insert new room in database
                    GlobalValue.dataProxy.createTournament(newTour);

                    //create tournament in gamecontroller
                    m_GameController.processCreateTournament(newTour);

                    responseSuccessCreating(sender, ManagedObject.TOURNAMENT);

                    //response for client.
                    TourAddedRes response = new TourAddedRes();
                    response.setTourInfo(newTour);
                    response.AddParam(POKER_TOUR_RESPONSE_NAME.TOUR_ADDED_RES, response.ToSFSObject());
                    responseForAllUser(response);
                } else {
                    Logger.trace(errorMsg);
                    responseErrorCreating(sender, errorMsg);
                }
            } else {
                Logger.trace("admin have not permission");
                responseErrorCreating(sender, "admin have not permission!");
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
            responseErrorCreating(sender, ex.getMessage());
        }
    }

    private String checkInputTourData(TournamentEntity tour) {

        int levelType = tour.getLevelType();
        int beginLvl = tour.getBeginLevel();
        int endLvl = tour.getEndLevel();

        if (beginLvl >= endLvl) {
            return "Begin level must smaller end level";
        }

        ArrayList<LevelDetailEntity> listLevel = GlobalValue.dataProxy.getLevelDetailByType(levelType, beginLvl, endLvl);
        if (listLevel.size() <= 0) {
            return "Level is invalid";
        }

        double firstBigLind = listLevel.get(0).getBigBlind();
        if (tour.getStartingChip() < firstBigLind) {
            return "Starting chip must larger big blind in first level";
        }

        return null;
    }

    private void responseForAllUser(SFSGameReponse response) {
        Zone currentZone = GlobalValue.smartfoxServer.getZoneManager().getZoneByName("RealPokerServer");
        List<User> listUser = (List) currentZone.getUserList();
        for (User user : listUser) {
            response.AddReceiver(user);
        }
        GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());
    }

    protected boolean checkTourAlterablity(String name) {
        ISFSArray sfsArr = GlobalValue.dataProxy.getTournamentInfo(name);
        if (sfsArr != null && sfsArr.size() == 1) {
            ISFSObject sfsObj = sfsArr.getSFSObject(0);
            String status = sfsObj.getUtfString(TournamentInfoParams.STATUS);
            if (TournamentStatus.STOPPING.equals(status)) {
                return true;
            }
        }
        return false;
    }

    private void handleDeleteTournament(User sender, SFSGameRequest sfsreq) {
        try {
            DeleteTournamentRequest request = (DeleteTournamentRequest) sfsreq;

            if (checkAdminValid(sender)) {
                Logger.trace("Enter AdminController:: handleDeleteTournament");
                String tourName = request.getTournamentName();
                if (checkTourAlterablity(tourName)) {

                    GlobalValue.dataProxy.deleteTournament(tourName);

                    //remove tournament in gameController
                    m_GameController.removeTournament(tourName);

                    responseSuccessDeleting(sender, ManagedObject.TOURNAMENT);

                    //response for clients
                    TourRemovedRes response = new TourRemovedRes();
                    response.setTourName(tourName);
                    response.AddParam(POKER_TOUR_RESPONSE_NAME.TOUR_DELETE_RES, response.ToSFSObject());
                    responseForAllUser(response);
                } else {
                    Logger.trace("Tournament is busy");
                    responseErrorDeleting(sender, "Tournament is busy!", ManagedObject.TOURNAMENT);
                }
            } else {
                Logger.trace("admin have not permission");
                responseErrorDeleting(sender, "admin have not permission!", ManagedObject.TOURNAMENT);
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
            responseErrorDeleting(sender, ex.getMessage(), ManagedObject.TOURNAMENT);
        }
    }

    private void handleUpdateTournament(User sender, SFSGameRequest sfsreq) {
        try {
            UpdateTournamentRequest request = (UpdateTournamentRequest) sfsreq;

            if (checkAdminValid(sender)) {
                Logger.trace("Enter AdminController:: handleUpdateTournament");
                TournamentEntity tour = request.getTournament();

                if (checkTourAlterablity(tour.getName())) {

                    String errorMsg = checkInputTourData(tour);
                    if (errorMsg == null) {
                        //update room in database
                        GlobalValue.dataProxy.updateTournament(tour);

                        //update tournament in gameController
                        m_GameController.getMapTournamentController(tour.getName()).handleUpdateTour(tour);

                        //response for admin
                        responseSuccessUpdating(sender, ManagedObject.TOURNAMENT);

                        //response for clients
                        TourUpdatedRes response = new TourUpdatedRes();
                        response.setTourInfo(tour);
                        response.AddParam(POKER_TOUR_RESPONSE_NAME.TOUR_UPDATE_RES, response.ToSFSObject());
                        responseForAllUser(response);
                    } else {
                        Logger.trace(errorMsg);
                        responseErrorUpdating(sender, errorMsg);
                    }
                } else {
                    Logger.trace("Tournament is busy");
                    responseErrorUpdating(sender, "Tournament is busy!");
                }
            } else {
                Logger.trace("admin have not permission");
                responseErrorUpdating(sender, "admin have not permission!");
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
            responseErrorUpdating(sender, ex.getMessage());
        }
    }

    private void handleActiveTournament(User sender, SFSGameRequest sfsreq) {
        try {
            UpdateTourStatusRequest request = (UpdateTourStatusRequest) sfsreq;

            if (checkAdminValid(sender)) {
                Logger.trace("Enter AdminController:: handleActiveTournament");
                String tourName = request.getTournamentName();
//                String currStatus = GlobalValue.dataProxy.getTournamentInfo(tourName).getSFSObject(0).getUtfString(TournamentInfoParams.STATUS);
//                if (checkActiveTour(currStatus, request.isActive())) {
                    String newStatus;
                    if (request.isActive()) {
                        newStatus = TournamentStatus.WAITING;
                    } else {
                        newStatus = TournamentStatus.STOPPING;
                    }

                    //update tournament in gameController
                    m_GameController.getMapTournamentController(tourName).handleActiveTour(request.isActive());

                    //update room in database
                    GlobalValue.dataProxy.UpdateTourStatus(tourName, newStatus);
                    
                    //response for admin
                    responseSuccessUpdating(sender, ManagedObject.TOURNAMENT);

                    //response for all users
                    UpdateTourStatusRes response = new UpdateTourStatusRes();
                    response.setName(tourName);
                    response.setStatus(newStatus);
                    response.AddParam(POKER_TOUR_RESPONSE_NAME.UPDATE_TOUR_STATUS_RES, response.ToSFSObject());
                    responseForAllUser(response);
//                } else {
//                    Logger.trace("Tournament is busy");
//                    responseErrorUpdating(sender, "Tournament is busy!");
//                }
            } else {
                Logger.trace("admin have not permission");
                responseErrorUpdating(sender, "admin have not permission!");
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
            responseErrorUpdating(sender, ex.getMessage());
        }
    }

    protected boolean checkActiveTour(String status, boolean isActive) {
        if (isActive == false && (status.equals(TournamentStatus.WAITING) || status.equals(TournamentStatus.COMPLETE))) {
            return true;
        }
        if (isActive && status.equals(TournamentStatus.STOPPING)) {
            return true;
        }

        return false;
    }

    private void handleCreateLevel(User sender, SFSGameRequest sfsreq) {
        try {
            CreateLevelRequest request = (CreateLevelRequest) sfsreq;

            if (checkAdminValid(sender)) {
                Logger.trace("Enter AdminController:: handleCreateLevel");
                LevelDetailEntity level = request.getLevel();

                GlobalValue.dataProxy.createNewLevel(level);

                responseSuccessCreating(sender, ManagedObject.LEVEL);
            } else {
                Logger.trace("admin have not permission");
                responseErrorCreating(sender, "admin have not permission!");
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
            responseErrorCreating(sender, ex.getMessage());
        }
    }

    private void handleDeleteLevel(User sender, SFSGameRequest sfsreq) {
        try {
            DeleteLevelRequest request = (DeleteLevelRequest) sfsreq;

            if (checkAdminValid(sender)) {
                Logger.trace("Enter AdminController:: handleDeleteLevel");
                int id = request.getId();

                //insert new room in database
                GlobalValue.dataProxy.deleteLevel(id);

                responseSuccessDeleting(sender, ManagedObject.LEVEL);
            } else {
                Logger.trace("admin have not permission");
                responseErrorDeleting(sender, "admin have not permission!", ManagedObject.USER);
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
            responseErrorDeleting(sender, ex.getMessage(), ManagedObject.USER);
        }
    }

    private void handleUpdateLevel(User sender, SFSGameRequest sfsreq) {
        try {
            UpdateLevelRequest request = (UpdateLevelRequest) sfsreq;

            if (checkAdminValid(sender)) {
                Logger.trace("Enter AdminController:: handleUpdateLevel");
                LevelDetailEntity level = request.getLevel();

                //update room in database
                GlobalValue.dataProxy.updateLevel(level);

                //response
                responseSuccessUpdating(sender, ManagedObject.LEVEL);
            } else {
                Logger.trace("admin have not permission");
                responseErrorUpdating(sender, "admin have not permission!");
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
            responseErrorUpdating(sender, ex.getMessage());
        }
    }

    private void handleGetAllTransaction(User sender, SFSGameRequest sfsreq) {
        try {
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    private void handleGetListRoom(User sender, SFSGameRequest sfsreq) {
        try {
            GetListRoomRequest request = (GetListRoomRequest) sfsreq;

            ISFSArray arrRoom = GlobalValue.dataProxy.getRoomList(request.getName(), request.getIndex(), request.getNumRow());

            GetListRoomResponse response = new GetListRoomResponse();
            response.setArrRooms(arrRoom);
            response.AddParam(ADMIN_RESPONSE_TYPE.GET_LIST_ROOM_RES, response.ToSFSObject());
            response.AddReceiver(sender);
            GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    private void handleGetListTournament(User sender, SFSGameRequest sfsreq) {
        try {
            GetListTournamentRequest request = (GetListTournamentRequest) sfsreq;

            ISFSArray arrTour = GlobalValue.dataProxy.getTournamentList(request.getName(), request.getIndex(), request.getNumRow());

            GetListTournamentResponse response = new GetListTournamentResponse();
            response.setArrTournaments(arrTour);
            response.AddParam(ADMIN_RESPONSE_TYPE.GET_LIST_TOURNAMENT_RES, response.ToSFSObject());
            response.AddReceiver(sender);
            GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    private void handleGetListLevel(User sender, SFSGameRequest sfsreq) {
        try {
            GetListLevelRequest request = (GetListLevelRequest) sfsreq;

            ISFSArray arrLevel = GlobalValue.dataProxy.getListLevel(request.getLevelType(), request.getIndex(), request.getNumRow());

            GetListLevelResponse response = new GetListLevelResponse();
            response.setArrLevel(arrLevel);
            response.AddParam(ADMIN_RESPONSE_TYPE.GET_LIST_LEVEL_RES, response.ToSFSObject());
            response.AddReceiver(sender);
            GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    private void handleGetLevelCollection(User sender, SFSGameRequest sfsreq) {
        try {
            GetLevelCollectionRequest request = (GetLevelCollectionRequest) sfsreq;

            ISFSArray arrLevelCollection = GlobalValue.dataProxy.getListLevelCollection();

            GetLeveCollectionResponse response = new GetLeveCollectionResponse();
            response.setArrLevelCollection(arrLevelCollection);
            response.AddParam(ADMIN_RESPONSE_TYPE.GET_LEVEL_COLLECTION_RES, response.ToSFSObject());
            response.AddReceiver(sender);
            GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    private void handleGetListUser(User sender, SFSGameRequest sfsreq) {
        try {
            GetListUserRequest request = (GetListUserRequest) sfsreq;

            ISFSArray arrUser = GlobalValue.dataProxy.getUserList(request.getName(), request.getIndex(), request.getNumRow());

            GetListUserResponse response = new GetListUserResponse();
            response.setArrUsers(arrUser);
            response.AddParam(ADMIN_RESPONSE_TYPE.GET_LIST_USER_RES, response.ToSFSObject());
            response.AddReceiver(sender);
            GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
    }

    private void handleAddChipForUser(User sender, SFSGameRequest sfsreq) {
        String responseMessage = "";
        boolean result = false;
        try {
            AddChipForUserRequest request = (AddChipForUserRequest) sfsreq;

            TransactionInfo trans = request.getTransaction();

            UserInfo userInfo = GlobalValue.dataProxy.GetUserInfo(trans.getUserName());
            Double chip = userInfo.getChip();
            if (trans.getAmount() < 0 && chip < Math.abs(trans.getAmount())) {
                result = false;
                responseMessage = "fail, withdraw chip to much!!";
            } else {
                GlobalValue.dataProxy.addChipForUser(trans.getUserName(), trans.getAmount());

                GlobalValue.dataProxy.addTransactionInfo(trans);

                //update user variable
                User user = GlobalValue.smartfoxServer.getAPIManager().getSFSApi().getUserByName(trans.getUserName());
                if (user != null) {
                    //user is online
                    List<UserVariable> vars = user.getVariables();

                    UserVariable oldVar = user.getVariable("chip");
                    vars.remove(oldVar);
                    Double currchip = oldVar.getDoubleValue();
                    currchip += trans.getAmount();

                    vars.add(new SFSUserVariable("chip", currchip));
                    GlobalValue.smartfoxServer.getAPIManager().getSFSApi().setUserVariables(user, vars);
                }
                result = true;
                responseMessage = "success!!";
//            AddUserChipResponse response = new AddUserChipResponse();
//            response.setResult(true);
//            response.setMessage("success!!");
//            response.AddParam(ADMIN_RESPONSE_TYPE.ADD_CHIP_FOR_USER_RES, response.ToSFSObject());
//            response.AddReceiver(sender);
//            GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);

            result = false;
            responseMessage = "false!!";
//            AddUserChipResponse response = new AddUserChipResponse();
//            response.setResult(false);
//            response.setMessage("false!!");
//            response.AddParam(ADMIN_RESPONSE_TYPE.ADD_CHIP_FOR_USER_RES, response.ToSFSObject());
//            response.AddReceiver(sender);
//            GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());
        } finally {
            AddUserChipResponse response = new AddUserChipResponse();
            response.setResult(result);
            response.setMessage(responseMessage);
            response.AddParam(ADMIN_RESPONSE_TYPE.ADD_CHIP_FOR_USER_RES, response.ToSFSObject());
            response.AddReceiver(sender);
            GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());
        }
    }

    private void handleGetTransaction(User sender, SFSGameRequest sfsreq) {
        try {
            GetTransactionRequest request = (GetTransactionRequest) sfsreq;
            String userName = request.getUserName();
            String byAdmin = request.getByAdmin();
            String fromDate = request.getFromDate();
            String toDate = request.getToDate();
            int index = request.getIndex();
            int numRow = request.getNumRow();

            ISFSArray arrTrans = GlobalValue.dataProxy.getTransaction(userName, byAdmin, fromDate, toDate, index, numRow);

            GetTransactionResponse response = new GetTransactionResponse();
            response.setArrTrasactions(arrTrans);
            response.AddParam(ADMIN_RESPONSE_TYPE.GET_TRANSACTION_RES, response.ToSFSObject());
            response.AddReceiver(sender);
            GlobalValue.sfsServer.send(response.GetReponseName(), response.GetParam(), response.GetListReceiver());

        } catch (Exception exc) {
            Logger.error(this.getClass(), exc);
        }
    }
}
