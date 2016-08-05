/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.entity.game_entity.poker_tournament;

import casino.cardgame.controller.game.table.TableTournamentController;
import casino.cardgame.controller.game.table.PokerTournamentController;
import casino.cardgame.controller.game.table.TableTournamentController;
import casino.cardgame.entity.game.LevelDetailEntity;
import casino.cardgame.entity.game.TournamentEntity;
import casino.cardgame.game_enum.TournamentStatus;
import casino.cardgame.utils.GlobalValue;
import casino.cardgame.utils.Logger;
import com.smartfoxserver.v2.api.CreateRoomSettings;
import com.smartfoxserver.v2.entities.Room;
import com.smartfoxserver.v2.entities.User;
import java.util.ArrayList;
import java.util.HashMap;

/**
 *
 * @author Kenjuzi
 */
public class PokerTournamentInfo {
//    private TournamentEntity m_tourEntity;

    //tournament Name
    private String m_displayName;
    //bet chip of tournament
    private double m_smallBlind;
    private double m_bigBlind;
    private double m_fee;
    private double m_startingChip;
    //numbers of players join in tournament
    private int m_playerCapacity;
    //tournament Name
    private String m_tournamentName;
    //prize of 1st, 2nd, 3rd player.
    private double m_firstPrize;
    private double m_secondPrize;
    private double m_thirdPrize;
    //status of tournament
    private String m_tourStatus;
    //list of table in tournament.
    private HashMap<String, TableTournamentController> m_mapPokerController;
    //list of users registed. this list is a largest list. it contain m_listUserAccepted and m_listUserPlaying;
    private ArrayList<User> m_listUserRegisted;
    //list of users accept invite.
    private ArrayList<String> m_listUserAccepted;
    //list of users playing.
    private ArrayList<String> m_listUserPlaying;
    //list of rooms
    private ArrayList<Room> m_listRoom;
    //list of rooms name
    private ArrayList<String> m_listRoomName;
    //list of user is ordered follow instant of user out of chip.
    private ArrayList<String> m_listUserResult;
    //map of user prize.
    private HashMap<String, Double> m_mapUserPrize;
    //map of Room name -> list of user name
    private HashMap<String, Room> m_mapRoom;
    //map of Room name -> list of user name
    private HashMap<String, ArrayList<User>> m_mapRoomUser;
    //map of User name -> Room name
    private HashMap<String, String> m_mapUserRoom;
    //map of User name -> User
    private HashMap<String, User> m_mapUser;
    //list of moved user.
    private ArrayList<String> m_listMovedUser;
    
    private ArrayList<LevelDetailEntity> m_listLevel;
    private int m_currentLevel;
    
    private int m_numUserReply;
    private double m_totalPot;
    public int NUMBER_DESK = 2;
    public int MIN_USER_IN_ROOM = 1;
    public int PRESTART_TIME = 2 * 1000;
    public int BEGIN_TIME = 8 * 1000;
    public int REPLAY_TOURNAMENT_TIME = 5 * 1000;
    public int NUMBER_OF_WINNER = 3;

//    public static String REGISTRING_STATUS = "WAITING";
//    public static String PRESTART_STATUS = "PRESTART";
//    public static String PLAYING_STATUS = "PLAYING";
//    public static String COMPLETE_STATUS = "COMPLETE";
//    public static String EMPTY_STATUS = "EMPTY";
    public PokerTournamentInfo(TournamentEntity tourEntity, ArrayList<LevelDetailEntity> level) {//, String tourName, double betChip, int capacity, double fee, double startingChip, double firstPrize, double secondPrize, double thirdPrize) {
//        m_tourEntity = tourEntity;

        m_tournamentName = tourEntity.getName();
        m_displayName = tourEntity.getDisplayName();
        m_fee = tourEntity.getFee();
        m_startingChip = tourEntity.getStartingChip();
        m_firstPrize = tourEntity.getFirstPrize();
        m_secondPrize = tourEntity.getSecondPrize();
        m_thirdPrize = tourEntity.getThirdPrize();
        m_playerCapacity = tourEntity.getCapacity();
        m_tourStatus = tourEntity.getStatus();
        //m_betChip = tourEntity.getSmallBlind();
        if (level.size() > 0) {
            m_listLevel = level;
            m_currentLevel = level.get(0).getLevel();
            m_smallBlind = level.get(0).getSmallBlind();
            m_bigBlind = level.get(0).getBigBlind();
        }
        m_mapPokerController = new HashMap<String, TableTournamentController>();
        m_listUserRegisted = new ArrayList<User>();
        m_listUserAccepted = new ArrayList<String>();
        m_listUserPlaying = new ArrayList<String>();
        m_mapRoomUser = new HashMap<String, ArrayList<User>>();
        m_listRoom = new ArrayList<Room>();
        m_listRoomName = new ArrayList<String>();
        m_listUserResult = new ArrayList<String>();
        m_listMovedUser = new ArrayList<String>();
        m_mapRoom = new HashMap<String, Room>();
        m_mapUserRoom = new HashMap<String, String>();
        m_mapUser = new HashMap<String, User>();
        m_mapUserPrize = new HashMap<String, Double>();

//        m_tourStatus = REGISTRING_STATUS;

        m_totalPot = 0;
        m_numUserReply = 0;
    }

    public void addNewRoom(Room room) {
        TableTournamentController newPokerCtrl = new TableTournamentController(m_fee, getListLevel());
        m_mapPokerController.put(room.getName(), newPokerCtrl);
        m_listRoom.add(room);
        m_listRoomName.add(room.getName());
        m_mapRoom.put(room.getName(), room);
    }

    public void handleUserRegistry(User user) {
        m_listUserRegisted.add(user);
        m_mapUser.put(user.getName(), user);
    }

    public void handleUserUnregistry(User user) {
        m_listUserRegisted.remove(user);
        m_mapUser.remove(user.getName());
    }

    public void handleUserAccept(User user) {
        m_listUserAccepted.add(user.getName());
        m_numUserReply++;
    }

    public void handleUserRefuse(User user) {
        m_listUserAccepted.remove(user.getName());
        m_numUserReply++;
    }

    public void handleUserJoin(User user, Room room) {

        String roomName = room.getName();
        m_mapUserRoom.put(user.getName(), roomName);
        m_mapRoomUser.get(roomName).add(user);
    }

    public void initTotalPot() {
        m_totalPot = m_startingChip * m_playerCapacity;
    }

    public void handleGroupUserIntoRoom() {
        Logger.trace("PokerTournamenInfo:: handleGroupUserIntoRoom");
        for (int i = 0; i < m_listRoomName.size(); i++) {
            String roomName = m_listRoomName.get(i);
            ArrayList<User> listUser = new ArrayList<User>();
            for (int j = 0; j < NUMBER_DESK; j++) {
                int index = i * NUMBER_DESK + j;
                if (index < m_listUserAccepted.size()) {
                    User user = m_mapUser.get(m_listUserAccepted.get(index));
                    listUser.add(user);
                    m_mapUserRoom.put(user.getName(), roomName);

                    m_listUserPlaying.add(user.getName());
                }
            }
            m_mapRoomUser.put(roomName, listUser);
        }
    }

    public ArrayList<String> getListRegisterName() {
        ArrayList<String> listRegister = new ArrayList<String>();
        for (int i = 0; i < m_listUserRegisted.size(); i++) {
            listRegister.add(m_listUserRegisted.get(i).getName());
        }
        return listRegister;
    }

    //tìm room có số người ít nhất, return về số người.
    public int findMinOfUserInRoom() {
        int min;

        String roomName = m_listRoomName.get(0);
        min = m_mapRoomUser.get(roomName).size();
        for (int i = 1; i < m_listRoomName.size(); i++) {
            roomName = m_listRoomName.get(i);
            int iSize = getListUserInRoom(roomName).size();
            if (min > iSize) {
                min = iSize;
            }
        }

        return min;
    }

    //sort increase room follow user in room
    public ArrayList<String> sortRoom() {
        ArrayList<String> listRoom = new ArrayList<String>();

        for (int i = 0; i < m_listRoomName.size(); i++) {
            String roomName = m_listRoomName.get(i);
            listRoom.add(roomName);
        }

        for (int i = 0; i < listRoom.size() - 1; i++) {
            for (int j = i + 1; j < listRoom.size(); j++) {
                int roomSize1 = getListUserInRoom(listRoom.get(i)).size();
                int roomSize2 = getListUserInRoom(listRoom.get(j)).size();
                if (roomSize1 > roomSize2) {
                    String temp = listRoom.get(i);
                    listRoom.set(i, listRoom.get(j));
                    listRoom.set(j, temp);
                }
            }
        }

        return listRoom;
    }

    public void processMoveUser(User user, Room fromRoom, Room toRoom) {
        m_mapRoomUser.get(toRoom.getName()).add(user);

        m_mapRoomUser.remove(fromRoom.getName());
        m_mapUserRoom.put(user.getName(), toRoom.getName());
        m_listRoom.remove(fromRoom);
        m_listRoomName.remove(fromRoom.getName());
        m_mapRoom.remove(fromRoom.getName());

        m_listMovedUser.add(user.getName());
    }

    public void processRemoveRoom(Room room) {
        m_mapRoomUser.remove(room.getName());
        m_listRoom.remove(room);
        m_listRoomName.remove(room.getName());
        m_mapRoom.remove(room.getName());
    }

    public boolean isBeginTournament() {
        if (m_listUserRegisted.size() == m_playerCapacity) {
            return true;
        } else {
            return false;
        }
    }

    //finish for each user, occur when user out of chip and leave room
    public void processUserLeaveGame(User user, String leaveRoom) {

        String roomName = m_mapUserRoom.get(user.getName());
        if (roomName.equals(leaveRoom)) {
            //trường hợp user leave game vì được move vào room khác
            String userName = user.getName();
            m_listUserResult.add(0, userName);
            m_listUserRegisted.remove(user);

            m_mapUserRoom.remove(userName);

            m_listUserPlaying.remove(userName);

            ArrayList<User> listUser = m_mapRoomUser.get(roomName);
            if (listUser != null) {
                listUser.remove(user);
            }
        }

//        }
    }

    //finish for the whole tournament
    public void processFinishTournament(User lastUser, String lastRoom) {
        processUserLeaveGame(lastUser, lastRoom);

        m_tourStatus = TournamentStatus.COMPLETE;

        double first = Math.round((m_firstPrize * m_totalPot) / 100);
        double second = Math.round((m_secondPrize * m_totalPot) / 100);
        double third = Math.round((m_thirdPrize * m_totalPot) / 100);

        m_mapUserPrize.put(m_listUserResult.get(0), first);
        m_mapUserPrize.put(m_listUserResult.get(1), second);
        m_mapUserPrize.put(m_listUserResult.get(2), third);


    }

    public void processReplayTournament() {
        for(int i = 0; i < m_listRoom.size(); i++){
            Room room = m_listRoom.get(i);
            TableTournamentController ctrl = m_mapPokerController.get(room.getName());
            ctrl.destruction(room); 
        }
        
        m_listUserPlaying.clear();
        m_listRoom.clear();
        m_listRoomName.clear();
        m_listUserRegisted.clear();
        m_listUserResult.clear();
        m_listUserAccepted.clear();
        m_listMovedUser.clear();

       m_mapPokerController.clear();
        m_mapRoom.clear();
        m_mapRoomUser.clear();
        m_mapUserPrize.clear();
        m_mapUserRoom.clear();
        m_mapUser.clear();

        m_totalPot = 0;

        m_numUserReply = 0;

//        m_tourStatus = TournamentStatus.WAITING;
    }
    
    public void processPrestartTour() {
        m_tourStatus = TournamentStatus.PRESTART;
    }

    public void processBeginTour() {
        m_tourStatus = TournamentStatus.PLAYING;
    }

    public void processCompleteTour() {
        m_tourStatus = TournamentStatus.COMPLETE;
    }

    public void processWaitingTour() {
        m_tourStatus = TournamentStatus.WAITING;
    }
    
    public void processStopTour() {
        m_tourStatus = TournamentStatus.STOPPING;
    }

    protected ArrayList<User> getUserInTour() {
        try {
            Logger.trace("Enter getUserInTour");

            ArrayList<User> listUser = new ArrayList<User>();
            for (int i = 0; i < m_listRoomName.size(); i++) {
                //ArrayList<User> usreInRoom = new ArrayList<User>();

                listUser.addAll(m_listRoom.get(i).getUserList());
            }

            return listUser;

        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
        return null;
    }

    protected void renewInfo() {
        m_listUserPlaying.clear();
        m_listRoom.clear();
        m_listRoomName.clear();
        m_listUserRegisted.clear();
        m_listUserResult.clear();

        m_mapPokerController.clear();
        m_mapRoom.clear();
        m_mapRoomUser.clear();
        m_mapUserPrize.clear();

        m_totalPot = 0;
        m_numUserReply = 0;
    }

//    public void processRewardForUser(){
//        try {
//            Logger.trace("processRewardForUser");
//
//            for (int i = 0; i < NUMBER_OF_WINNER; i++) {
//                String winner = m_listUserResult.get(i);
//                String roomName = m_listRoomName.get(0);
//                double prize = m_mapUserPrize.get(winner);
//                
//                TableTournamentController ctrl = m_mapPokerController.get(roomName);
//
//                ctrl.handleRewardForUser(winner, prize);
//            }
//        } catch (Exception ex) {
//            Logger.error(this.getClass(), ex);
//        }
//    }
    public ArrayList<User> getListWinner() {
        ArrayList<User> listWinners = new ArrayList<User>();

        for (int i = 0; i < NUMBER_OF_WINNER; i++) {
            User winner = m_mapUser.get(m_listUserResult.get(i));
            listWinners.add(winner);
        }

        return listWinners;
    }

    public int getNumberUserRegisted() {
        return m_listUserRegisted.size();
    }

    public ArrayList<User> getListUserInRoom(String roomName) {
        return m_mapRoomUser.get(roomName);
    }

    public HashMap<String, TableTournamentController> getMapPokerController() {
        return m_mapPokerController;
    }

    public TableTournamentController getMapPokerController(String roomName) {
        return m_mapPokerController.get(roomName);
    }

    public double getSmallBlind() {
        return m_smallBlind;
    }

    public int getPlayerCapacity() {
        return m_playerCapacity;
    }

    public String getTournamentName() {
        return m_tournamentName;
    }

    public double getFirstPrize() {
        return m_firstPrize;
    }

    public double getSecondPrize() {
        return m_secondPrize;
    }

    public double getThirdPrize() {
        return m_thirdPrize;
    }

    public ArrayList<User> getListUserRegisted() {
        return m_listUserRegisted;
    }

    public HashMap<String, ArrayList<User>> getMapRoomUser() {
        return m_mapRoomUser;
    }

    public ArrayList<User> getMapRoomUser(String roomName) {
        return m_mapRoomUser.get(roomName);
    }

    public ArrayList<Room> getListRoom() {
        return m_listRoom;
    }

    public ArrayList<String> getListUserPlaying() {
        return m_listUserPlaying;
    }

    public String getTourStatus() {
        return m_tourStatus;
    }

    public ArrayList<String> getListRoomName() {
        return m_listRoomName;
    }

    public HashMap<String, Room> getMapRoom() {
        return m_mapRoom;
    }

    public Double getMapUserPrize(String userName) {
        return m_mapUserPrize.get(userName);
    }

    public ArrayList<String> getListUserAccepted() {
        return m_listUserAccepted;
    }

    public ArrayList<String> getListMovedUser() {
        return m_listMovedUser;
    }

    public double getFee() {
        return m_fee;
    }

    public double getStartingChip() {
        return m_startingChip;
    }

    public String getMapUserRoom(String userName) {
        return m_mapUserRoom.get(userName);
    }

    public double getTotalPot() {
        return m_totalPot;
    }

    public User getMapUser(String userName) {
        return m_mapUser.get(userName);
    }

    public int getNumUserReply() {
        return m_numUserReply;
    }

    public TournamentEntity getTournamentEntity() {
        TournamentEntity tourEntity = new TournamentEntity();
        tourEntity.setCapacity(m_playerCapacity);
        tourEntity.setDisplayName(getDisplayName());
        tourEntity.setFee(m_fee);
        tourEntity.setFirstPrize(m_firstPrize);
        tourEntity.setName(m_tournamentName);
        tourEntity.setSecondPrize(m_secondPrize);
        tourEntity.setThirdPrize(m_thirdPrize);
        tourEntity.setStartingChip(m_startingChip);
        tourEntity.setStatus(m_tourStatus);

        return tourEntity;
    }

    public ArrayList<LevelDetailEntity> getListLevel() {
        return m_listLevel;
    }

    public String getDisplayName() {
        return m_displayName;
    }
}
