/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.entity.game_entity.poker_tournament;

import casino.cardgame.entity.game_entity.poker.*;
import casino.cardgame.entity.UserInfo;
import casino.cardgame.entity.game.LevelDetailEntity;
import casino.cardgame.entity.game_entity.Desk;
import casino.cardgame.entity.game_entity.DeskState;
import casino.cardgame.entity.game_entity.ICard;
import casino.cardgame.utils.GlobalValue;
import casino.cardgame.utils.Logger;
import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.entities.data.SFSObject;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 *
 * @author KIDKID @Desc: Hold All Info Of TaLa Table Info Not Thread Safe
 */
public final class TableTournamentInfo {

    // <editor-fold defaultstate="collapsed" desc="VARIABLE SECTION">
    private double m_fee;
    private String m_dealer;
    private String m_sBlinder;
    private String m_bBlinder;
    private int m_sBlindPos;
    // user cược số tiền chuẩn(đầu tiền or lớn nhất) trong game.
    // Có giá trị == "" chỉ khi game dang replay or user cược đầu tiên fold.
//    private String m_bettingUser;
    //số tiền cược chuẩn của mỗi user trong 1 game. (totalBetChip of user)
    private double m_bettingChip;
//    private double m_betChipGame = 0;
    private double m_smallBlind = 0;
    private double m_bigBlind = 0;
    private double m_ante = 0;
    private double m_potChip = 0;
    //Game Đã Bắt Đầu Chưa ?
    protected boolean m_isGameStart;
    //Đang prestart game hay ko? -> nếu user join vào khi game đang prestart thì ko prestart nữa.
    private boolean m_isPrestart;
    //Game đã finish chưa
    protected boolean m_isFinished;
    //Hiện tại đang đến lượt user nào
    protected String m_currentUser;
    //vị trí bàn hiện tại
    private int m_currentPos;
    //Lượt chơi hiện tại chỉ thay doi khi:
    private String m_currentGameTurn;
    //Danh Sách Các Ghế ( vị trí) trong bàn chơi
    protected List<Desk> m_listDesk;
    //Danh Sach UserName Trong Game
    private List<String> m_listUserName;
    //Danh Sác User Trong Game
    private List<User> m_listUser;
    //Dach Sach UserName Dang Choi (Player || ActiveUser)
    protected List<String> m_listActiveUserName;
    //Danh Sach User Dang Choi
    protected List<User> m_listActiveUser;
    //Danh Sach các lá bài chung (giữa bàn)
    private List<ICard> m_listCommunityCard;
    // Map User - Ghế
    protected HashMap<String, Desk> m_mapUserDesk;
    // Map UserName User
    private HashMap<String, User> m_mapUser;
    // TableCardCollection
    private PokerCardCollection m_cardCollection;
    // Danh Sách lá bài các người chơi hiện tại
    private HashMap<String, PokerCardHand> m_mapUserCard;
    //Danh sách lượt chơi.
    private List<String> m_listGameTurn;//BETTING, FLOP, TURN, RIVER, END
    //Lưu trữ lịch sử khi user action
    private HashMap<String, UserBetHistory> m_mapUserBet;
    private HashMap<String, Boolean> m_mapUserBetStatus;
    private HashMap<String, PokerHandComparer> m_mapPokerComparer;
    //list level
    private ArrayList<LevelDetailEntity> m_listLevel;
    private LevelDetailEntity m_currentLevel;
    private int m_currentLevelIndex;
    private boolean m_isTurnNextLevel;
    
    public int PRE_START_TIME = 5 * 1000; //10s
    public int USER_ACTION_TIME = 20 * 1000; // 10s
    public int SHOW_DOWN_TIME = 5 * 1000; // 10s
    public int REPLAY = 5 * 1000; // 10s
    private int NUMBER_DESK = 10;
    private int m_bettedCount;
    private int m_numPlaying;
// </editor-fold>

    public TableTournamentInfo(double fee, ArrayList<LevelDetailEntity> level) {
        m_listUserName = new ArrayList<String>();
        m_listUser = new ArrayList<User>();
        m_listActiveUserName = new ArrayList<String>();
        m_listActiveUser = new ArrayList<User>();
        m_cardCollection = new PokerCardCollection();

        m_mapUserDesk = new HashMap<String, Desk>();
        m_mapUser = new HashMap<String, User>();
        m_mapUserBet = new HashMap<String, UserBetHistory>();
        m_mapUserCard = new HashMap<String, PokerCardHand>();
        m_mapPokerComparer = new HashMap<String, PokerHandComparer>();

        m_mapUserBetStatus = new HashMap<String, Boolean>();

        //Init Desk
        m_listDesk = new ArrayList<Desk>();
        for (int i = 0; i < NUMBER_DESK; ++i) {
            Desk desk = new Desk();
            desk.setDeskState(DeskState.EMPTY).setDeskId(i).setUser(null);//.setResult(-1);
            //khoatd
            m_listDesk.add(i, desk);
        }

        m_listGameTurn = new ArrayList<String>();
        m_listGameTurn.add(PokerGameTurn.BETTING);
        m_listGameTurn.add(PokerGameTurn.FLOP);
        m_listGameTurn.add(PokerGameTurn.TURN);
        m_listGameTurn.add(PokerGameTurn.RIVER);
        m_listGameTurn.add(PokerGameTurn.END);

        m_listCommunityCard = new ArrayList<ICard>();
        //Init Game Variable
        m_currentUser = "";
        m_currentPos = -1;

        m_currentLevelIndex = -1;
        m_isTurnNextLevel = true;
        m_listLevel = level;
//        if (level.size() > 0) {
//            m_currentLevelIndex = 0;
//            m_smallBlind = level.get(m_currentLevelIndex).getSmallBlind();
//            m_bigBlind = level.get(m_currentLevelIndex).getBigBlind();
//            m_ante = level.get(m_currentLevelIndex).getAnte();
//            m_currentLevel = level.get(m_currentLevelIndex);
//            m_isTurnNextLevel = false;
//        }
        m_fee = fee;
        m_bettingChip = 0.0;
//        m_bettingUser = "";
        m_potChip = 0;
        m_isGameStart = false;
        m_isPrestart = false;
        m_isFinished = false;

        m_dealer = "";
        m_sBlinder = "";
        m_bBlinder = "";
        m_sBlindPos = -1;

        m_bettedCount = 0;
        m_numPlaying = 0;
    }

    public void renewInfo() {
        m_listUserName = new ArrayList<String>();
        m_listUser = new ArrayList<User>();
        m_listActiveUserName = new ArrayList<String>();
        m_listActiveUser = new ArrayList<User>();
        m_cardCollection = new PokerCardCollection();
        m_listCommunityCard = new ArrayList<ICard>();

        m_mapUserDesk = new HashMap<String, Desk>();
        m_mapUser = new HashMap<String, User>();
        m_mapUserBet = new HashMap<String, UserBetHistory>();
        m_mapUserCard = new HashMap<String, PokerCardHand>();
        m_mapPokerComparer = new HashMap<String, PokerHandComparer>();

        m_mapUserBetStatus = new HashMap<String, Boolean>();

        //Init Desk
        m_listDesk = new ArrayList<Desk>();
        for (int i = 0; i < NUMBER_DESK; ++i) {
            Desk desk = new Desk();
            desk.setDeskState(DeskState.EMPTY).setDeskId(i).setUser(null);//.setResult(-1);
            //khoatd
            m_listDesk.add(i, desk);
        }

        //Init Game Variable
        m_currentUser = "";
        m_currentPos = -1;
        m_bettingChip = 0.0;
//        m_bettingUser = "";
        m_potChip = 0;
        m_isGameStart = false;
        m_isPrestart = false;
        m_isFinished = false;

        m_dealer = "";
        m_sBlinder = "";
        m_bBlinder = "";
        m_sBlindPos = -1;

        m_bettedCount = 0;
        m_numPlaying = 0;
    }
    //***********************************************************************************
    // khoatd: Đưa 1 người ngồi vào bàn 
    //***********************************************************************************

    public Boolean SitUserOn(User user, double buyIn) {
        //SangDN: m_listDesk luôn có 4 cái ghế, 

        for (int i = 0; i < m_listDesk.size(); ++i) {
            Desk desk = m_listDesk.get(i);
            if (desk.getDeskState() == DeskState.EMPTY) {
                //put user here
                //Update Deskstate
                desk.setDeskState(DeskState.WAITING);//.setResult(-1);
                desk.setUser(user);

                desk.setChip(buyIn);

                //update dependence variable
                m_mapUserDesk.put(user.getName(), desk);
                getListUserName().add(i, user.getName());
                getListUser().add(i, user);
                m_mapUser.put(user.getName(), user);
                m_mapUserCard.put(user.getName(), new PokerCardHand());
                m_mapUserBet.put(user.getName(), new UserBetHistory());

                m_mapUserBetStatus.put(user.getName(), false);

                return true;
            } //khoatd: nếu uer đã có trong listDesk và trong trạng thái PLAYING thì ko add vào listDesk nữa (stop looping)
            // tránh tình trạng duplicate khi user vào lại bàn.
            else if (desk.getDeskState() == DeskState.PLAYING) {
                if (desk.getUser().getName().equals(user.getName())) {
                    break;
                }
            }
        }
        return false;
    }

    //***********************************************************************************
    // khoatd: Đưa 1 người vào ngồi 1 bàn được chỉ định
    //***********************************************************************************
    public Boolean SitUserOn(User user, int deskId, double buyIn) {
        //SangDN: m_listDesk luôn có 4 cái ghế, 

        Desk desk = m_listDesk.get(deskId);
        if (desk.getDeskState() == DeskState.EMPTY) {
            //put user here
            //Update Deskstate
            desk.setDeskState(DeskState.WAITING);//.setResult(-1);
            desk.setUser(user);

            desk.setChip(buyIn);

            //update involve variable
            if (m_listUserName.contains(user.getName()) == false) {
                m_listUserName.add(user.getName());
                m_listUser.add(user);
                m_mapUser.put(user.getName(), user);
            }
            m_mapUserDesk.put(user.getName(), desk);
            m_mapUserCard.put(user.getName(), new PokerCardHand());
            m_mapUserBet.put(user.getName(), new UserBetHistory());

            return true;
        }
        return false;
    }

    //***********************************************************************************
    // khoatd: Đưa 1 người vào ngồi 1 bàn được chỉ định
    //***********************************************************************************
    public void processSpectatorJoinRoom(User user) {
        //update dependence variable
        m_listUserName.add(user.getName());
        m_listUser.add(user);
        m_mapUser.put(user.getName(), user);
    }
    //***********************************************************************************
    // SangDN: Bỏ 1 người dùng ra khỏi bàn 
    //         case: Dùng để user rời bàn chơi ( lúc đang chơi hoặc ngồi chờ.)
    //***********************************************************************************

    public Boolean LeaveUserOut(User user) {
        //SangDN: m_listDesk luôn có 4 cái ghế,
        try {
            String username = user.getName();

            StandUserUp(user);
            m_listUserName.remove(username);
            m_listUser.remove(user);
            m_mapUser.remove(username);

            return true;
        } catch (Exception ex) {
//            Logger.error(m_PokerCardCollection.getClass(), ex);
            return false;
        }
    }

    //***********************************************************************************
    // khoatd: user roi khoi ghe (player->spectator)
    //***********************************************************************************
    public Boolean StandUserUp(User user) {
        //SangDN: m_listDesk luôn có 4 cái ghế, 
        String username = user.getName();
        Desk desk = m_mapUserDesk.get(username);
        if (desk != null) {
            //add all buy in of leaving user to pot.
            double buyIn = desk.getChip();
            m_potChip += buyIn;

            //put user here
            //Update Deskstate
            Boolean isBetted = false;
            if (desk.getDeskState() == DeskState.PLAYING
                    || desk.getDeskState() == DeskState.WAITING || desk.getDeskState() == DeskState.READY) {
                //Just remove the user, not need to use stop playing now.
                //desk.setDeskState(DeskState.STOP_PLAYING);
                desk.setDeskState(DeskState.EMPTY).setUser(null);//.setResult(-1);
                m_mapUserDesk.remove(username);
                m_listActiveUser.remove(user);
                m_listActiveUserName.remove(username);
                //khoatd
                m_mapUserCard.remove(user.getName());
                m_mapUserBet.remove(user.getName());
                m_mapPokerComparer.remove(user.getName());

                isBetted = m_mapUserBetStatus.remove(user.getName());
            }

            if (m_dealer.equals(username)) {
                m_dealer = "";
            } else if (m_sBlinder.equals(username)) {
                m_sBlinder = "";
            } else if (getBigBlinder().equals(username)) {
                m_bBlinder = "";
            }

            m_numPlaying = countUserNotFoldnAllIn();
            if (isBetted) {
                m_bettedCount--;
            }

            return true;
        }
        return false;
    }
//get list user is not include users have last action is fold

    public int countUserNotFold() {
        int numbUser = 0;
        for (int i = 0; i < m_listActiveUserName.size(); i++) {
            String userName = m_listActiveUserName.get(i);
            UserBetObject lastBet = m_mapUserBet.get(userName).getLastAction();
            if (lastBet == null) {
                numbUser++;
            } else if (lastBet.getActionType().equals(UserActionType.FOLD) == false) {
                numbUser++;
            }

        }
        return numbUser;
    }
    //get list user is not include users have last action is fold

    public int countUserNotFoldnAllIn() {
        int numbUser = 0;
        for (int i = 0; i < m_listActiveUserName.size(); i++) {
            String userName = m_listActiveUserName.get(i);
            UserBetObject lastBet = m_mapUserBet.get(userName).getLastAction();
            if (lastBet == null) {
                numbUser++;
            } else if (lastBet.getActionType().equals(UserActionType.FOLD) == false
                    && lastBet.getActionType().equals(UserActionType.ALL_IN) == false) {
                numbUser++;
            }

        }
        return numbUser;
    }
    
    //only be used in finish game.

    public void prepareReplayGame() {
        setCardCollection(new PokerCardCollection());

        setPotChip(0);
        m_bettingChip = m_smallBlind;
//        m_bettingUser = "";
//        m_sBlinder = getNextPlayerName(m_sBlinder);
//        if (m_sBlinder == null) {
//            m_sBlinder = "";
//        }
        m_sBlindPos = getNextSmallBlindPosition(m_sBlindPos);
        if (m_sBlindPos == -1) {
            m_sBlinder = "";
        } else {
            m_sBlinder = m_listDesk.get(m_sBlindPos).getUser().getName();
        }
        m_bBlinder = "";
        m_dealer = "";
        m_currentGameTurn = PokerGameTurn.BETTING;
        m_listCommunityCard.clear();

        for (int i = 0; i < m_listDesk.size(); i++) {
            Desk desk = m_listDesk.get(i);
            if (desk.getUser() != null) {
                desk.setDeskState(DeskState.WAITING);//.setResult(-1);
            }
        }

        for (int i = 0; i < m_listActiveUserName.size(); i++) {
            getMapUserCard().get(m_listActiveUserName.get(i)).setCurrentHand(new ArrayList<ICard>());
            getMapUserBet().get(m_listActiveUserName.get(i)).renewBetHistory();
        }

        m_numPlaying = m_listActiveUser.size();
        resetUserBetStatus();
        m_bettedCount = 0;
    }

    protected void resetUserBetStatus() {
        for (int i = 0; i < m_listActiveUserName.size(); i++) {
            String userName = m_listActiveUserName.get(i);
            m_mapUserBetStatus.put(userName, false);
        }
    }

    protected void setUserBetStatus(String userName, Boolean status) {
        m_mapUserBetStatus.put(userName, status);
    }

    //***********************************************************************************
    //      khoatd: Get Next Player fromUser In Desk position
    //***********************************************************************************
    public String getNextPlayerName(String fromUser) {
        String nextUserName = null;
        Desk desk = m_mapUserDesk.get(fromUser);
        int i;
        if (desk != null) {
            i = desk.getDeskId() + 1;
        } else {
            i = m_currentPos + 1;
        }
        int icount = 1;
        while (icount < NUMBER_DESK) {
            if (i == NUMBER_DESK) {
                i = 0;
            }

            Desk nextDesk = m_listDesk.get(i);
          if (checkDeskValid(nextDesk)) {
                nextUserName = nextDesk.getUser().getName();
                m_currentPos = nextDesk.getDeskId();
                break;
            }
            i++;
            icount++;
        }
        return nextUserName;
    }

    //***********************************************************************************
    //      khoatd: get Next Small Blind Position
    //          return -1 if nobody in room
    //***********************************************************************************

    public int getNextSmallBlindPosition(int currentPos) {
        if (currentPos == -1) {
            for (int i = 0; i < m_listDesk.size(); i++) {
                Desk desk = m_listDesk.get(i);
                if (checkDeskValid(desk)) {
                    return desk.getDeskId();
                }
            }
            return -1;
        }
        
        int nextPos = currentPos + 1;
        int icount = 1;
        while (icount < NUMBER_DESK) {
            if (nextPos == NUMBER_DESK) {
                nextPos = 0;
            }
            
            Desk nextDesk = m_listDesk.get(nextPos);
            if (checkDeskValid(nextDesk)) {
                return nextPos;
            }
            nextPos++;
            icount++;
        }
        return -1;
    }
    
    //this desk is: there is user sitting, desk is playing or ready.
    public boolean checkDeskValid(Desk desk) {
        if (desk == null) {
            return false;
        }
        if ((desk.getDeskState() == DeskState.PLAYING || desk.getDeskState() == DeskState.READY)
                && desk.getUser() != null) {
            return true;
        }
        
        return false;
    }
    //***********************************************************************************
    //      khoatd: Get previous Player fromUser In Desk position
    //***********************************************************************************
    public String getPreviousPlayerName(String fromUser) {
        String previousUserName = null;
        Desk desk = m_mapUserDesk.get(fromUser);
        int i;
        if (desk != null) {
            i = desk.getDeskId() - 1;
        } else {
            i = m_currentPos - 1;
        }
        int icount = 1;
        while (icount < NUMBER_DESK) {
            if (i == -1) {
                i = NUMBER_DESK - 1;
            }

            Desk previousDesk = m_listDesk.get(i);
            if ((previousDesk.getDeskState() == DeskState.PLAYING || previousDesk.getDeskState() == DeskState.READY)
                    && previousDesk.getUser() != null) {
                previousUserName = previousDesk.getUser().getName();
                m_currentPos = previousDesk.getDeskId();
                break;
            }
            i--;
            icount++;
        }
        return previousUserName;
    }

    //***********************************************************************************
    //      khoatd: Set A User To Active User (Player)           
    //          case: After user check ready to start game
    public void processUserReady(User user) {
        m_mapUserDesk.get(user.getName()).setDeskState(DeskState.READY);
        if (!m_listActiveUserName.contains(user.getName())) {
            m_listActiveUser.add(user);
            m_listActiveUserName.add(user.getName());
        }
    }

    //***********************************************************************************
    //      khoatd: Proces User to Play State       
    //          case: After user check ready to start game
    public void ProcessUserPlay(User user) {
        m_mapUserDesk.get(user.getName()).setDeskState(DeskState.PLAYING);
    }
    //***********************************************************************************
    //      SangDN: Proces User to Play State       
    //          case: After user check ready to start game

    public void ProcessUserWaiting(User user) {
        m_mapUserDesk.get(user.getName()).setDeskState(DeskState.WAITING);
    }
    //***********************************************************************************
    //      khoatd: Proces User to Play State       
    //          case: After user check ready to start game

    public void ProcessUserLeaveGame(User user) {
        //Process User Stop Game
        m_listActiveUser.remove(user);
        m_listActiveUserName.remove(user.getName());
        m_mapUserDesk.get(user.getName()).setDeskState(DeskState.EMPTY);

    }

    //***********************************************************************************
    //      khoatd: Change game status block
    //***********************************************************************************
    public void processGamePrestart() {
        m_isPrestart = true;
        m_isGameStart = false;
//        m_isFinished = false;
    }

    public void processGameWaiting() {
        m_isPrestart = false;
        m_isGameStart = false;
//        m_isFinished = false;
    }

    public void processGameStart() {
        m_isPrestart = false;
        m_isGameStart = true;

        m_bettedCount = 0;
        m_numPlaying = m_listActiveUserName.size();
    }
    
    public void processGameEmpty() {
        m_isPrestart = false;
        m_isGameStart = false;

        renewInfo();
    }

    //log user action to tableinfo
    //WARNING: check totalBetChip + chip == bettingChip
    public void processUserAction(String turnName, String userName, String type, double chip) {
        UserBetHistory betHis = getMapUserBet().get(userName);
//        if (betHis.getTotalBetChip() + chip == m_bettingChip) {
        betHis.setUserAction(turnName, type, chip);
        double totalUserBet = betHis.getTotalBetChip();

        Desk desk = m_mapUserDesk.get(userName);
        if (desk != null) {
            double currentchip = desk.getChip();
            if (currentchip >= chip) {
                desk.setChip(currentchip - chip);
            } else {
                desk.setChip(0.0);
            }
        }

        m_potChip += chip;

        if (type.equals(UserActionType.FOLD)) {
            m_numPlaying--;
        } else if (type.equals(UserActionType.ALL_IN)) {
            if (chip > m_bettingChip) {
                m_bettedCount = 0;
                resetUserBetStatus();
            }
            m_numPlaying--;
        } else if (type.equals(UserActionType.RAISE)) {
            m_bettedCount = 1;
            resetUserBetStatus();
            setUserBetStatus(userName, true);
        } else if (type.equals(UserActionType.CALL)) {
            m_bettedCount++;
            setUserBetStatus(userName, true);
        }
        processUserBet(userName, totalUserBet);

    }

    public void processUserBet(String userName, double chip) {
        if (chip >= m_bettingChip) {
            //m_bettingUser = userName;
            m_bettingChip = m_mapUserBet.get(userName).getTotalBetChip();
        }
    }

    public void processSetSmallBlind(String smallBlind) {
        //set small blind, big blind, dealer and current user

        m_sBlinder = smallBlind;
        m_sBlindPos = m_mapUserDesk.get(smallBlind).getDeskId();
        processUserAction(PokerGameTurn.BETTING, smallBlind, UserActionType.BETTING, m_smallBlind);
        
        String bigBlind = getNextPlayerName(smallBlind);
        m_bBlinder = bigBlind;
        processUserAction(PokerGameTurn.BETTING, bigBlind, UserActionType.BETTING, m_bigBlind);
        m_bettingChip = m_bigBlind;
        
        String dealer = getPreviousPlayerName(smallBlind);
        if (dealer != null) {
            m_dealer = dealer;
        } else {
            Logger.trace("ERROR     PokerTableInfo:: processSetSmallBlind  can't not find dealer");
            printImportantData();
        }
        
        String currentUser = getNextPlayerName(bigBlind);
        if (currentUser == null) {
            currentUser = smallBlind;
        }
        m_currentUser = currentUser;
//        m_bettingUser = currentUser;
    }
    
    //process go next turn and return a list of community card
    public ArrayList<Integer> processGoingNextGameTurn(String nextUser) {
//        m_bettingUser = nextUser;
        //m_bettingChip = 0;
        m_currentUser = nextUser;

        for (int i = 0; i < getListGameTurn().size() - 1; i++) {
            if (m_currentGameTurn.equals(m_listGameTurn.get(i))) {
                setCurrentGameTurn(getListGameTurn().get(i + 1));
                break;
            }
        }

        int numbCards = 0;
        if (m_currentGameTurn.equals(PokerGameTurn.FLOP)) {
            numbCards = 3;
        } else if (m_currentGameTurn.equals(PokerGameTurn.TURN)) {
            numbCards = 1;
        } else if (m_currentGameTurn.equals(PokerGameTurn.RIVER)) {
            numbCards = 1;
        }

        ArrayList<Integer> listCardId = new ArrayList<Integer>();
        if (numbCards != 0) {
            List<ICard> listCards = m_cardCollection.getNextCard(numbCards);
            for (int i = 0; i < listCards.size(); i++) {
                listCardId.add(listCards.get(i).getCardId());
            }
            m_listCommunityCard.addAll(listCards);
        }

        m_bettedCount = 0;

        return listCardId;
    }

    /*
     * Mỗi player sẽ có 2 cây bài private card của riêng mình - được lưu trong
     * biến global m_mapPlayerCard và sẽ được kết hợp với 5 cây bài community
     * card - lưu trong biến global m_arrComCard để tạo thành poker hand(bộ 5
     * cây bài)
     *
     * Nhiệm vụ của hàm: kết hợp 2 pri_card vs 5 com_card => 21 poker hand trả
     * về HashMap chứa poker hand lớn nhất ứng với từng người
     */
    public HashMap<String, PokerHand> findUserPokerHand() {
        int nComCard = m_listCommunityCard.size();
        if (nComCard < 5) {
            return null;
        }
        // Tìm poker hand của từng player
        HashMap<String, PokerHand> mapUserPokerHand = new HashMap<String, PokerHand>();
        for (int i = 0; i < m_listActiveUserName.size(); i++) {
            String userName = m_listActiveUserName.get(i);

            ///KHONG DUYET NHUNG USER UP BO
            UserBetObject betObj = m_mapUserBet.get(userName).getLastAction();
            if (betObj.getActionType().equals(UserActionType.FOLD) == false) {
                try {
                    PokerHandComparer pokerHand = new PokerHandComparer();
                    pokerHand.setPokerData(getAllCardOfUser(userName));
                    pokerHand.findThePokerHand();
                    mapUserPokerHand.put(userName, pokerHand.getThePokerHand());
                    m_mapPokerComparer.put(userName, pokerHand);
                } catch (Exception ex) {
                    Logger.error(this.getClass(), ex);
                }

            }
        }
        return mapUserPokerHand;
    }

    protected int[] getAllCardOfUser(String userName) {
        int[] listCardId = new int[7];
        PokerCardHand cardHand = m_mapUserCard.get(userName);
        listCardId[0] = preprocessCard(m_listCommunityCard.get(0).getCardId());
        listCardId[1] = preprocessCard(m_listCommunityCard.get(1).getCardId());
        listCardId[2] = preprocessCard(m_listCommunityCard.get(2).getCardId());
        listCardId[3] = preprocessCard(m_listCommunityCard.get(3).getCardId());
        listCardId[4] = preprocessCard(m_listCommunityCard.get(4).getCardId());
        listCardId[5] = preprocessCard(cardHand.getCurrentHand().get(0).getCardId());
        listCardId[6] = preprocessCard(cardHand.getCurrentHand().get(1).getCardId());
        return listCardId;
    }
    //pokerhand and pokerHandComparer is in another version -> Id of A card is 14(141, 142,143, 144) , not 1(11,12,13,14).
    //this function to transfer A card to A card of this version

    protected int preprocessCard(int cardId) {
        if (cardId > 10 && cardId < 15) {
            return cardId + 130;
        }
        return cardId;
    }

    /*
     * Dữ liệu đầu vào mapUserPokerHand: HashMap chứ pokerhand của từng user trả
     * về list Id của những người thắng cuộc (trường hợp có nhiều người đồng bài
     * lớn nhất)
     *
     * Description: + Get All non null player + Find the highest pokerhand in
     * player list
     *
     */
    public ArrayList<String> findListWinner() {
        HashMap<String, PokerHand> mapUserPokerHand = findUserPokerHand();
        ArrayList<String> listWinner = new ArrayList<String>();
        int nComCard = m_listCommunityCard.size();
        try {
            if (nComCard < 5) {
                return null;
            }

            PokerHand winnerPokerHand = null;
            for (int i = 0; i < m_listActiveUserName.size(); i++) {
                String userName = m_listActiveUserName.get(i);
                UserBetObject betObj = m_mapUserBet.get(userName).getLastAction();
                if (betObj.getActionType().equals(UserActionType.FOLD) == false) {
                    PokerHand pokerHand = mapUserPokerHand.get(userName);
                    pokerHand = pokerHand.compare(winnerPokerHand);
                    if (pokerHand != null && pokerHand != winnerPokerHand) {
                        winnerPokerHand = pokerHand;
                    }
                }
            }

            if (winnerPokerHand != null) {
                // Tìm những người có poker hand == winnerPokerHand đưa vào listWinnerId
                for (int i = 0; i < m_listActiveUserName.size(); i++) {
                    String userName = m_listActiveUserName.get(i);
                    UserBetObject betObj = m_mapUserBet.get(userName).getLastAction();
                    if (betObj.getActionType().equals(UserActionType.FOLD) == false) {
                        PokerHand pokerHand = mapUserPokerHand.get(userName);
                        if (winnerPokerHand.compare(pokerHand) == null) {
                            listWinner.add(userName);
                        }
                    }
                }
            } else {
                if (m_listActiveUserName.size() <= 0) {
                    //case1: room is empty
                    return null;
                } else {
                    //case2: all of users are fold -> log error -> split pot chip for each player
                    Logger.trace("ERROR     PokerTableInfo:: findListWinner: all of user are fold");
                    printImportantData();

                    listWinner = (ArrayList<String>) m_listActiveUserName;
                }
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
        return listWinner;
    }

    public ArrayList<Double> processCaculateChip(ArrayList<String> listWinners, ArrayList<String> listLoser) {
        ArrayList<Double> listChip = new ArrayList<Double>();

        double numSplit = listWinners.size();

        HashMap<String, ArrayList<Double>> clonner = cloneBetHistory();
        sortIncreaseWinnerBet(listWinners);

        ArrayList<Double> listLoseChip = new ArrayList<Double>();

        //caculate chip for winner
        for (int i = 0; i < listWinners.size(); i++) {
            double winChip = 0.0;
            String winner = listWinners.get(i);
            double totalBet = m_mapUserBet.get(winner).getTotalBetChip();

            for (int j = 0; j < listLoser.size(); j++) {
                String loser = listLoser.get(j);
                ArrayList<Double> listBetChip = clonner.get(loser);
                double loseChip = caculateUserLoseChip(listBetChip, winner, loser, numSplit);
                winChip += loseChip;
                if (j < listLoseChip.size()) {
                    listLoseChip.set(j, listLoseChip.get(j) + loseChip);
                } else {
                    listLoseChip.add(loseChip);
                }
            }

            winChip += totalBet;
            listChip.add(winChip);
            numSplit--;
        }

        //caculate chip for loser
        for (int j = 0; j < listLoser.size(); j++) {
            String loser = listLoser.get(j);
            double looseChip = listLoseChip.get(j);
            if (looseChip < m_mapUserBet.get(loser).getTotalBetChip()) {
                listChip.add(m_mapUserBet.get(loser).getTotalBetChip() - looseChip);
            } else {
                listChip.add(-m_mapUserBet.get(loser).getTotalBetChip());
            }
        }

        return listChip;
    }

    private HashMap<String, ArrayList<Double>> cloneBetHistory() {
        HashMap<String, ArrayList<Double>> cloneBet = new HashMap<String, ArrayList<Double>>();

        for (int i = 0; i < m_listActiveUserName.size(); i++) {
            String userName = m_listActiveUserName.get(i);
            ArrayList<Double> newListBetChip = new ArrayList<Double>();
            ArrayList<UserBetObject> orgListBetChip = (ArrayList<UserBetObject>) m_mapUserBet.get(userName).getListBet();

            for (int j = 0; j < orgListBetChip.size(); j++) {
                newListBetChip.add(orgListBetChip.get(j).getChip());
            }
            cloneBet.put(userName, newListBetChip);
        }

        return cloneBet;
    }

    //sắp xếp danh sách winner tăng dần dựa theo tổng số tiền đã cược
    private void sortIncreaseWinnerBet(ArrayList<String> listWinners) {
        if (listWinners.size() > 1) {
            for (int i = 0; i < listWinners.size() - 1; i++) {
                for (int j = 1; j < listWinners.size(); j++) {
                    String iWinner = listWinners.get(i);
                    String jWinner = listWinners.get(j);
                    if (m_mapUserBet.get(iWinner).getTotalBetChip() > m_mapUserBet.get(jWinner).getTotalBetChip()) {
                        listWinners.set(i, jWinner);
                        listWinners.set(j, iWinner);
                    }
                }
            }
        }
    }

    private double caculateUserLoseChip(ArrayList<Double> listBetChip, String winner, String loser, double numSplit) {
        double loseChip = 0.0;

        ArrayList<UserBetObject> listUserBetObj = (ArrayList<UserBetObject>) m_mapUserBet.get(loser).getListBet();
        ArrayList<UserBetObject> listWinnerBetObj = (ArrayList<UserBetObject>) m_mapUserBet.get(winner).getListBet();
        for (int i = 0; i < listWinnerBetObj.size(); i++) {
            if (i >= listUserBetObj.size()) {
                break;
            }

            UserBetObject winnerBet = listWinnerBetObj.get(i);
            UserBetObject userBet = listUserBetObj.get(i);

            double d = 0.0;
            if (winnerBet.getChip() >= userBet.getChip()) {
                d = listBetChip.get(i) / numSplit;
            } else {
                d = winnerBet.getChip() / numSplit;
            }
            listBetChip.set(i, listBetChip.get(i) - d);
            loseChip += d;
        }

        return loseChip;
    }

    public boolean isExist(ArrayList<String> listObj, String e) {
        for (int i = 0; i < listObj.size(); i++) {
            if (e.equals(listObj.get(i))) {
                return true;
            }
        }
        return false;
    }

    public ArrayList<Integer> getAllRemainCommunityCard() {
        ArrayList<Integer> listComCardId = new ArrayList<Integer>();

        int numCurCard = m_listCommunityCard.size();
        if (numCurCard < 5) {
            List<ICard> remainCards = m_cardCollection.getNextCard(5 - numCurCard);

            m_listCommunityCard.addAll(remainCards);

            for (int i = 0; i < remainCards.size(); i++) {
                listComCardId.add(remainCards.get(i).getCardId());
            }
        }
        return listComCardId;
    }

    public void processAddChipForUser(String userName, double chip) {
        //add and update chip to database.
    }

    //***********************************************************************************
    // khoatd: check this user is a spectator.
    //***********************************************************************************
    public boolean isSpectator(User user) {
        return m_mapUserDesk.get(user.getName()) == null;
    }

    public int countUserReady() {
        int count = 0;
        for (int i = 0; i < m_listUserName.size(); i++) {
            Desk desk = m_mapUserDesk.get(m_listUserName.get(i));
            if (desk != null && desk.getDeskState() == DeskState.READY) {
                count++;
            }
        }
        return count;
    }

    public int countUserSitting() {
        int count = 0;
        for (int i = 0; i < m_listUserName.size(); i++) {
            Desk desk = m_mapUserDesk.get(m_listUserName.get(i));
            if (desk != null) {
                count++;
            }
        }
        return count;
    }

    public void turnToNextLevel() {
        int nextLevelIndex = m_currentLevelIndex + 1;
        setCurrentLevel(nextLevelIndex);
        m_isTurnNextLevel = false;
    }

    public void setCurrentLevel(int index) {
        if (index >= 0 && index < getListLevel().size()) {
            m_currentLevelIndex = index;
            m_smallBlind = getListLevel().get(getCurrentLevelIndex()).getSmallBlind();
            m_bigBlind = getListLevel().get(getCurrentLevelIndex()).getBigBlind();
            m_ante = getListLevel().get(getCurrentLevelIndex()).getAnte();
            m_currentLevel = getListLevel().get(getCurrentLevelIndex());
        }
    }

    public void setEndLevelTimeLife(boolean isEnd) {
        m_isTurnNextLevel = isEnd;
    }

    public void applyAntesForUser() {
        for (int i = 0; i < m_listActiveUserName.size(); i++) {
            String userName = m_listActiveUserName.get(i);
            Desk desk = m_mapUserDesk.get(userName);
            if (desk != null) {
                double currentchip = desk.getChip();
                if (currentchip >= m_ante) {
                    desk.setChip(currentchip - m_ante);
                } else {
                    desk.setChip(0.0);
                }
            }

            m_potChip += m_ante;
        }
    }
    
    public void printImportantData() {
        Logger.trace("PokerTableInfo:: PRINT_IMPORTANT_DATA");
        int i;
        String listComCard = "";
        for (i = 0; i < m_listCommunityCard.size(); i++) {
            listComCard += m_listCommunityCard.get(i).toString();
            listComCard += "; ";
        }
        Logger.trace("list Community card: " + listComCard);

        Logger.trace("tableInfo data: numPlaying:" + m_numPlaying
                + " && bettedCount: " + m_bettedCount
                + " && potChip: " + m_potChip);

        Logger.trace("tableInfo data DSB: Dealer:" + m_dealer
                + " && SBlind: " + m_smallBlind
                + " && BBlind: " + m_bigBlind);

        for (i = 0; i < m_listActiveUserName.size(); i++) {
            String userName = m_listActiveUserName.get(i);

            UserBetObject lastUserAction = m_mapUserBet.get(userName).getLastAction();
            if (lastUserAction != null) {
                String lastGameTurn = m_mapUserBet.get(userName).getLastAction().getTurnName();
                Logger.trace(" :: Last action of " + userName + ": " + lastUserAction.getActionType()
                        + " in GameTurn: " + lastGameTurn
                        + " with currentChip: " + m_mapUserDesk.get(userName).getChip());
            } else {
                Logger.trace(" :: user:" + userName + " have not act yet");
            }

            String listUserCard = "";
            List<ICard> userCards = m_mapUserCard.get(userName).getCurrentHand();
            if (userCards != null) {
                for (int j = 0; j < userCards.size(); j++) {
                    listUserCard += userCards.get(i);
                    listUserCard += "; ";
                }
                Logger.trace(" :: list cards of " + userName + ": " + listUserCard);
            } else {
                Logger.trace(" :: user:" + userName + " don't have cards");
            }
        }
    }
    //***********************************************************************************
    //      GET & SET SECTION
    //***********************************************************************************
    
    // <editor-fold defaultstate="collapsed" desc="GET & SET SECTION">

    public Desk getMapUserDesk(String userName) {
        return m_mapUserDesk.get(userName);
    }

    public List<Desk> getListDesk() {
        return m_listDesk;
    }

    public boolean IsGameStart() {
        return m_isGameStart;
    }

    public String getCurrentUser() {
        return m_currentUser;
    }

    public void setCurrentUser(String CurrentUser) {
        this.m_currentUser = CurrentUser;
        Desk desk = m_mapUserDesk.get(CurrentUser);
        if (desk != null) {
            m_currentPos = desk.getDeskId();
        }
    }

    public List<String> GetListActiveUserName() {
        return m_listActiveUserName;
    }

    public List<User> GetListActiveUser() {
        return m_listActiveUser;
    }

    public boolean isPrestart() {
        return m_isPrestart;
    }

    public List<ICard> getListCommunicateCard() {
        return m_listCommunityCard;
    }

    //khoatd: get how many user sitting.
    public int getNumberUserSitting() {
        int count = 0;
        for (int i = 0; i < m_listDesk.size(); i++) {
            if (m_listDesk.get(i).getDeskState() != DeskState.EMPTY) {
                count++;
            }
        }
        return count;
    }

    public String getSmallBlinder() {
        return m_sBlinder;
    }

    public void setSmallBlinder(String m_smallBlinder) {
        this.m_sBlinder = m_smallBlinder;
    }

    public String getBigBlinder() {
        return m_bBlinder;
    }

    public void setBigBlinder(String m_bigBlinder) {
        this.m_bBlinder = m_bigBlinder;
    }

    public double getSmallBlind() {
        return m_smallBlind;
    }

    public double getPotChip() {
        return m_potChip;
    }

    public void setPotChip(double m_potChip) {
        this.m_potChip = m_potChip;
    }

//    public String getBettingUser() {
//        return m_bettingUser;
//    }

//    public void setBettingUser(String m_bettingUser) {
//        this.m_bettingUser = m_bettingUser;
//    }

    public double getBettingChip() {
        return m_bettingChip;
    }

    public void setBettingChip(double m_bettingChip) {
        this.m_bettingChip = m_bettingChip;
    }

    public PokerCardCollection getCardCollection() {
        return m_cardCollection;
    }

    public void setCardCollection(PokerCardCollection m_cardCollection) {
        this.m_cardCollection = m_cardCollection;
    }

    public HashMap<String, PokerCardHand> getMapUserCard() {
        return m_mapUserCard;
    }

    public PokerCardHand getMapUserCard(String userName) {
        return m_mapUserCard.get(userName);
    }

    public String getCurrentGameTurn() {
        return m_currentGameTurn;
    }

    public HashMap<String, PokerHandComparer> getMapPokerComparer() {
        return m_mapPokerComparer;
    }

    public PokerHandComparer getMapPokerComparer(String userName) {
        return m_mapPokerComparer.get(userName);
    }

    /**
     * @param m_listCommunityCard the m_listCommunityCard to set
     */
    public void setListCommunityCard(List<ICard> m_listCommunityCard) {
        this.m_listCommunityCard = m_listCommunityCard;
    }

    /**
     * @return the m_mapUserBet
     */
    public HashMap<String, UserBetHistory> getMapUserBet() {
        return m_mapUserBet;
    }

    public UserBetHistory getMapUserBet(String userName) {
        return m_mapUserBet.get(userName);
    }

    /**
     * @return the m_listGameTurn
     */
    public List<String> getListGameTurn() {
        return m_listGameTurn;
    }

    /**
     * @param m_currentGameTurn the m_currentGameTurn to set
     */
    public void setCurrentGameTurn(String m_currentGameTurn) {
        this.m_currentGameTurn = m_currentGameTurn;
    }

    public List<String> getListUserName() {
        return m_listUserName;
    }

    public List<User> getListUser() {
        return m_listUser;
    }

    public void setDealer(String m_dealer) {
        this.m_dealer = m_dealer;
    }

    public String getDealer() {
        return m_dealer;
    }

    public int getBettedCount() {
        return m_bettedCount;
    }

    public int getNumPlaying() {
        return m_numPlaying;
    }

    public double getFee() {
        return m_fee;
    }

    public double getBigBlind() {
        return m_bigBlind;
    }

    public LevelDetailEntity getCurrentLevel() {
        return m_currentLevel;
    }

    // </editor-fold>
    public double getAnte() {
        return m_ante;
    }

    public boolean isTurnNextLevel() {
        return m_isTurnNextLevel;
    }

    public int getCurrentLevelIndex() {
        return m_currentLevelIndex;
    }

    public ArrayList<LevelDetailEntity> getListLevel() {
        return m_listLevel;
    }
    
    public int getSBlindPos() {
        return m_sBlindPos;
    }
}
