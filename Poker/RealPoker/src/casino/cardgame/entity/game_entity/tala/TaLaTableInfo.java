/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.entity.game_entity.tala;

import casino.cardgame.entity.UserInfo;
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
public final class TaLaTableInfo {

    private boolean m_isGetCard = false;
    private boolean m_isShowCard = false;
    private boolean m_isRemoveCard = false;
    //Game Đã Bắt Đầu Chưa ?
    protected boolean m_isGameStart = false;
    //Đang prestart game hay ko? -> nếu user join vào khi game đang prestart thì ko prestart nữa.
    private boolean m_isPrestart = false;
    //Tiền cược
    private double m_betChip = 0;
    private double m_potChip = 0;
    //Hiện tại đang đến lượt user nào
    protected String m_currentUser;
    //vị trí bàn hiện tại
    private int m_currentPos;
    //Danh Sách Các Ghế ( vị trí) trong bàn chơi
    protected List<Desk> m_listDesk;
    //Danh Sach UserName Trong Game
    protected List<String> m_listUserName;
    //Danh Sác User Trong Game
    protected List<User> m_listUser;
    //Dach Sach UserName Dang Choi (Player || ActiveUser)
    protected List<String> m_listActiveUserName;
    //Danh Sach User Dang Choi
    protected List<User> m_listActiveUser;
    //Danh sách các user đã có kết quả.( nhất, nhì, móm,...)
    //  được sắp xếp theo thứ tự hạ bài(móm).
    //0 - first; 1 - second; 2 - third; 3 - last; 4 - Loose(móm); 5 - bị đền ù; 6 - ù; -1 - no result.
    private List<String> m_listUserNameResult;
    private List<Integer> m_listResult;
    // Map User - Ghế
    protected HashMap<String, Desk> m_mapUserDesk;
    // Map UserName User
    private HashMap<String, User> m_mapUser;
    // TableCardCollection
    protected TaLaCardCollection m_talaCardCollection;
    // Danh Sách lá bài các người chơi hiện tại
    protected HashMap<String, TaLaCardHand> m_mapUserCard;
    //Danh sách các lá bài bỏ của người chơi hiện tại
    protected HashMap<String, TaLaCardHand> m_mapUserLeaveCard;
    //Danh sách các lá bài ăn được của người chơi
    //sẽ fix sau vì có lỗi khi ù đền mà người ăn bài bị disconnect
    private HashMap<String, TaLaCardHand> m_mapUserPhomCard;
    //NewUpdate: dùng để xác định là bài trên tay user có phải là winCard hay ko
    private HashMap<String, ArrayList<Integer>> m_mapUserWinCard;
    private HashMap<String, ArrayList<Double>> m_mapUserWinChip;//synchronize with m_mapUserWinCard
    //Dùng để xác định user đã ăn bài của player nào (tránh trường hợp player bị ăn bài và leave ra khỏi room).
    private HashMap<String, ArrayList<String>> m_mapUserWinFromPlayer;//synchronize with m_mapUserWinCard
    //Id Lá bài cuối cùng được leave
    protected int m_lastLeaveCard;
    protected String m_lastUserLeaveCard;
    public int PRE_START_TIME = 10 * 1000; //10s
    public int GET_NEXT_CARD_TIME = 15 * 1000;//10s
    public int REMOVE_CARD_TIME = 25 * 1000;//10s
    public int SHOW_CARD_TIME = 20 * 1000; // 10s
    public int REPLAY = 10 * 1000; // 10s

    public TaLaTableInfo() {
        m_listDesk = new ArrayList<Desk>();
        m_mapUserDesk = new HashMap<String, Desk>();

        m_listUserName = new ArrayList<String>();
        m_listUser = new ArrayList<User>();
        m_listActiveUserName = new ArrayList<String>();
        m_listActiveUser = new ArrayList<User>();
        m_listUserNameResult = new ArrayList<String>();
        m_listResult = new ArrayList<Integer>();
        m_mapUser = new HashMap<String, User>();
        m_talaCardCollection = new TaLaCardCollection();
        m_mapUserCard = new HashMap<String, TaLaCardHand>();
        m_mapUserLeaveCard = new HashMap<String, TaLaCardHand>();
        m_mapUserPhomCard = new HashMap<String, TaLaCardHand>();
        m_mapUserWinCard = new HashMap<String, ArrayList<Integer>>();
        m_mapUserWinChip = new HashMap<String, ArrayList<Double>>();
        m_mapUserWinFromPlayer = new HashMap<String, ArrayList<String>>();

        //Init Desk
        for (int i = 0; i < 4; ++i) {
            Desk desk = new Desk();
            desk.setDeskState(DeskState.EMPTY).setDeskId(i).setUser(null);//.setResult(-1);
            //khoatd
            m_listDesk.add(i, desk);
        }
        //Init Game Variable
        m_currentUser = "";
        m_currentPos = -1;
        m_isGameStart = false;
        m_isPrestart = false;
        m_betChip = 0;

    }

    //***********************************************************************************
    //          API SECTION
    //***********************************************************************************
    //***********************************************************************************
    // SangDN: Lấy danh sách người chơi hiện tại trong game ( gồm đang chơi && ngưng bài)         
    //         case: Để cập nhập thông tin game khi 1 người vào xem
    //          ****NOTE***: Tạm thời ko tính người ngưng bài
    //***********************************************************************************
    public List<User> GetListActiveUser() {
        return m_listActiveUser;
    }
    //***********************************************************************************
    // SangDN: Lấy danh sách người chơi hiện tại trong game ( gồm đang chơi && ngưng bài)         
    //          case: Để cập nhật thông tin game khi 1 người vào xem
    //          ****NOTE***: Tạm thời ko tính người ngưng bài
    //***********************************************************************************

    public List<String> GetListActiveUserName() {
        return m_listActiveUserName;
    }
    //***********************************************************************************
    // SangDN: Lấy danh sách user trong game (người chơi && người xem)
    //         case: Dùng để hiển thị thông tin game cho tất cả mọi nguười
    //***********************************************************************************

    public List<User> GetListPlayer() {
        return m_listUser;
    }
    //***********************************************************************************
    // SangDN: Đưa 1 người ngồi vào bàn 
    //         case: Dùng để user vào bàn chơi && vào bàn ngồi chờ
    //***********************************************************************************

    public Boolean SitUserOn(User user) {
        //SangDN: m_listDesk luôn có 4 cái ghế, 

        for (int i = 0; i < m_listDesk.size(); ++i) {
            Desk desk = m_listDesk.get(i);
            if (desk.getDeskState() == DeskState.EMPTY) {
                //put user here
                //Update Deskstate
                desk.setDeskState(DeskState.WAITING);//.setResult(-1);
                desk.setUser(user);

                UserInfo info = GlobalValue.dataProxy.GetUserInfo(user.getName());
                if (info != null) {
                    desk.setChip(info.getChip());
                }

                //update dependence variable
                m_mapUserDesk.put(user.getName(), desk);
                m_listUserName.add(i, user.getName());
                m_listUser.add(i, user);
                m_mapUser.put(user.getName(), user);
                //khoatd: update map variables
                m_mapUserCard.put(user.getName(), new TaLaCardHand());
                m_mapUserLeaveCard.put(user.getName(), new TaLaCardHand());
                m_mapUserPhomCard.put(user.getName(), new TaLaCardHand());
                m_mapUserWinCard.put(user.getName(), new ArrayList<Integer>());
                m_mapUserWinChip.put(user.getName(), new ArrayList<Double>());
                m_mapUserWinFromPlayer.put(user.getName(), new ArrayList<String>());

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
    // SangDN: Bỏ 1 người dùng ra khỏi bàn 
    //         case: Dùng để user rời bàn chơi ( lúc đang chơi hoặc ngồi chờ.)
    //***********************************************************************************

    public Boolean LeaveUserOut(User user) {
        //SangDN: m_listDesk luôn có 4 cái ghế,
        try {
            String username = user.getName();
            Desk desk = m_mapUserDesk.get(username);
            if (desk == null) {
                return false;
            }
            //Leave User
            //Incase: Player Is Playing
            if (desk.getDeskState() == DeskState.PLAYING
                    || desk.getDeskState() == DeskState.WAITING || desk.getDeskState() == DeskState.READY) {
                //Just remove the user, not need to use stop playing now.
                //desk.setDeskState(DeskState.STOP_PLAYING);
                desk.setDeskState(DeskState.EMPTY).setUser(null);//.setResult(-1);
                m_mapUserDesk.remove(username);
                m_listUserName.remove(username);
                m_listUser.remove(user);
                m_mapUser.remove(username);
                m_listActiveUser.remove(user);
                m_listActiveUserName.remove(username);
                //khoatd
                m_mapUserCard.remove(user.getName());
                m_mapUserLeaveCard.remove(user.getName());
                m_mapUserPhomCard.remove(user.getName());
                m_mapUserWinCard.remove(user.getName());
                m_mapUserWinChip.remove(user.getName());
                m_mapUserWinFromPlayer.remove(user.getName());

                //removeUserResult(username);
                removeResult(username);
            }
            return true;
        } catch (Exception ex) {
            Logger.error(m_talaCardCollection.getClass(), ex);

            return false;
        }
    }

    public void addUserResult(String userName, int result) {
        m_listUserNameResult.add(m_listUserNameResult.size(), userName);
        m_listResult.add(m_listResult.size(), result);
    }

    public void setUserResult(String userName, int result) {
        int index = m_listUserNameResult.indexOf(userName);
        if (index != -1) {
            m_listResult.set(index, result);
        } else {
            addUserResult(userName, result);
        }

    }

//    public boolean removeUserResult(String userName) {
//        for (int i = 0; i < m_listUserNameResult.size(); i++) {
//            if (m_listUserNameResult.get(i).equals(userName)) {
//                m_listUserNameResult.remove(i);
//                m_listResult.remove(i);
//                return true;
//            }
//        }
//        return false;
//    }
    //***********************************************************************************
    // SangDN: Làm mới lại thông tin bàn để bắt đầu ván bài
    //         case: Khi start game, renew card collection, user card hand,is game start ...
    //***********************************************************************************

    public Boolean RenewInfo() {

        m_mapUserDesk.clear();

        m_listUserName.clear();
        m_listUser.clear();
        getMapUser().clear();

        m_mapUserCard.clear();
        m_mapUserLeaveCard.clear();
        getMapUserPhomCard().clear();
        m_mapUserWinCard.clear();
        m_mapUserWinChip.clear();
        m_mapUserWinFromPlayer.clear();
        //Init Desk
        for (int i = 0; i < 4; ++i) {
            Desk desk = new Desk();
            desk.setDeskState(DeskState.EMPTY).setDeskId(i).setUser(null);//.setResult(-1);
            //khoatd
            m_listDesk.add(i, desk);
        }
        m_talaCardCollection.renew();

        m_isGameStart = false;
        m_isPrestart = false;
        m_currentUser = "";
        setBetChip(0);
        return true;
    }

    //only be used in finish game.
    public void prepareReplayGame() {
        m_talaCardCollection = new TaLaCardCollection();

        for (int i = 0; i < m_listDesk.size(); i++) {
            Desk desk = m_listDesk.get(i);
            if (desk.getUser() != null) {
                desk.setDeskState(DeskState.WAITING);//.setResult(-1);
            }
        }

        for (int i = 0; i < m_listUserName.size(); i++) {
            m_mapUserCard.get(m_listUserName.get(i)).setCurrentHand(new ArrayList<ICard>());
            m_mapUserLeaveCard.get(m_listUserName.get(i)).setCurrentHand(new ArrayList<ICard>());
            m_mapUserPhomCard.get(m_listUserName.get(i)).setCurrentHand(new ArrayList<ICard>());
            m_mapUserWinCard.get(m_listUserName.get(i)).clear();
            m_mapUserWinChip.get(m_listUserName.get(i)).clear();
            m_mapUserWinFromPlayer.get(m_listUserName.get(i)).clear();
        }

        m_listUserNameResult.clear();
        m_listResult.clear();
        m_potChip = 0;
    }

    public boolean isUserEndGame(String userName) {
        if (m_mapUserLeaveCard.get(userName).getCurrentHand().size() == 4) {
            return true;
        } else {
            return false;
        }
    }

    public boolean isUserFinishGame(String userName) {
        if (m_listUserNameResult.contains(userName)) {
            return true;
        } else {
            return false;
        }
    }

    public boolean isLastTurn(String userName) {
        if (m_mapUserLeaveCard.get(userName).getCurrentHand().size() == 3) {
            return true;
        } else {
            return false;
        }
    }

    public boolean isPhomValid(ArrayList<Integer> ListCardId) {
        boolean result = false;

        //check dong luong
        for (int i = 0; i < ListCardId.size(); i++) {
            int cardId = ListCardId.get(i);
            List<Integer> dongLuong = GetListDongLuongDaiNhat(ListCardId, cardId);
            if (dongLuong != null && dongLuong.size() > 2) {
                result = true;
            } else {
                result = false;
            }
        }
        if (result) {
            return result;
        }

        //check dong chat lien tiep
        result = true;
        SortIncreaseCardId(ListCardId);
        for (int i = 0; i < ListCardId.size() - 1; i++) {
            int id1 = ListCardId.get(i);
            int id2 = ListCardId.get(i + 1);
            if (id2 - id1 != 10) {
                result = false;
                break;
            }
        }
        return result;
    }
    //copy from talacardhand

    protected List<Integer> GetListDongLuongDaiNhat(ArrayList<Integer> listCardId, int cardId) {
        List<Integer> result = new ArrayList<Integer>();
        for (int i = 0; i < listCardId.size(); ++i) {
            int id = listCardId.get(i);
            if (IsDongLuong(id, cardId)) {
                result.add(id);
            }
        }
        if (result.size() > 0) {
            //result.add(cardId);
            return result;
        }
        return null;
    }
    //copy from talacardhand

    protected Integer GetCardDongChatLienTiep(ArrayList<Integer> listCardId, int cardId) {
        for (int i = 0; i < listCardId.size(); ++i) {
            int id = listCardId.get(i);
            int distance = id - cardId;
            if (distance == 0xA || distance == -120) {
                return id;
            }
        }
        return null;
    }

    public boolean isWinCard(String userName, int id) {
        return m_mapUserWinCard.get(userName).contains(id);
    }

    protected boolean IsDongLuong(int card1, int card2) {
        if (Math.abs(card1 - card2) < 4) {
            return true;
        }
        return false;
    }

    //***********************************************************************************
    //      SangDN: Process for username leave a cardId
    //          Pre Condition: Username is in turn
    //          If cardId is not contain in user card hand -> return false ( process hack)
    //***********************************************************************************
    public boolean LeaveACard(String username, int cardId) {
        try {
            ICard card = this.m_mapUserCard.get(username).RemoveACardInHand(cardId);
            if (card == null) {
                return false;
            }
            this.m_mapUserCard.get(username).AddToCurrentHand(card);
            //note the last user leave card
            m_lastLeaveCard = cardId;
            m_lastUserLeaveCard = username;
            return true;
        } catch (Exception ex) {
            Logger.error(TaLaTableInfo.class, ex);
            return false;
        }

    }
    //***********************************************************************************
    //      SangDN: Process move a card from "fromuser" to "toUser"
    //          Pre Condition: toUser is in turn
    //          If fromUser is not lastUserLeaveCard -> return false( process hack)
    //          If cardId is not last leave card -> return false ( process hack)
    //***********************************************************************************
//    public boolean MoveAWinCard(String fromUser,String toUser, int cardId){
//        try{
//            if(fromUser.equalsIgnoreCase(m_lastUserLeaveCard) == false ||
//                    m_lastLeaveCard != cardId)
//                return false;
//            ICard card = m_mapUserLeaveCard.get(fromUser).RemoveACardInHand(cardId);
//            if(card == null)
//                return false;
//            m_mapUserWinCard.get(toUser).AddToCurrentHand(card);
//            return true;
//        }catch(Exception ex){
//            Logger.error(TaLaTableInfo.class, ex);
//            return false;
//        }
//    }
    //***********************************************************************************
    //      SangDN: Check if a listhand is valid to show, list hand is from 3-5 cards.    
    //      PreCondition: user is in turn
    //***********************************************************************************
//    public boolean IsAHandValid(String username, ArrayList<Integer> listCardId){
//        try{
//            TaLaCardHand hand = m_mapUserCard.get(username);
//            TaLaCardHand winHand = m_mapUserWinCard.get(username);
//            return hand.IsListCardIdValid(listCardId, winHand);
//            
//        }catch(Exception ex){
//            Logger.error(TaLaTableInfo.class, ex);
//            return false;
//        }
//    }

    //***********************************************************************************
    //      SangDN: is need to refresh leave card. 
    //          return UserName which to move leave card to lastUserLeaveCard, null if not
    //***********************************************************************************
    public String IsNeedToRefreshLeaveCard() {
        try {
            String current = m_lastUserLeaveCard;
            int num = m_mapUserLeaveCard.get(current).getCurrentHand().size();
            String next = getNextPlayerName(current);
            while (true) {
                if (next.equals(m_lastUserLeaveCard)) {
                    break;
                }
                int numNext = m_mapUserLeaveCard.get(next).getCurrentHand().size();
                if (numNext > num) {
                    return next;
                }
                current = next;
                next = getNextPlayerName(current);
            }
            return null;

        } catch (Exception ex) {
            Logger.error(TaLaTableInfo.class, ex);
            return null;
        }

    }
    //***********************************************************************************
    //      SangDN: is need to refresh leave card. 
    //          return last leave card from username
    //***********************************************************************************

    public ICard RemoveLastLeaveCard(String username) {
        try {
            return m_mapUserLeaveCard.get(username).RemoveLastCard();
        } catch (Exception ex) {
            Logger.error(TaLaTableInfo.class, ex);
            return null;
        }

    }
    
    public boolean isAllEndGame() {
        for (int i = 0; i < m_listDesk.size(); i++) {
            Desk desk = m_listDesk.get(i);
            if (desk.getDeskState() == DeskState.PLAYING) {
                TaLaCardHand leaveHand = m_mapUserLeaveCard.get(desk.getUser().getName());
                if (leaveHand != null) {
                    if (leaveHand.getCurrentHand().size() < 4
                            && m_listUserNameResult.contains(desk.getUser().getName()) == false) {
                        return false;
                    }
                    
//                    if (leaveHand.getCurrentHand().size() < 4) {
//                        return false;
//                    }
                }
            }
        }
        return true;
    }
    //***********************************************************************************
    //      SangDN: Add a card to leave card in last player 
    //          return last leave card from username
    //***********************************************************************************

    public boolean AddLeaveCardToLastPlayer(String fromUserName, ICard card) {
        try {
            m_mapUserLeaveCard.get(fromUserName).AddToCurrentHand(card);
            return true;
        } catch (Exception ex) {
            Logger.error(TaLaTableInfo.class, ex);
            return false;
        }

    }

    //***********************************************************************************
    //      SangDN: Get Next Player fromUser In Desk position
    //***********************************************************************************
    private String getNextPlayerName(String fromUser) {
        String nextUserName = null;
        Desk desk = m_mapUserDesk.get(fromUser);
        int i = desk.getDeskId() + 1;
        int icount = 1;
        while (icount < 4) {
            if (i == 4) {
                i = 0;
            }

            Desk nextDesk = m_listDesk.get(i);
            if (nextDesk.getDeskState() == DeskState.PLAYING
                    && nextDesk.getUser() != null
                    && isUserEndGame(nextDesk.getUser().getName())) {
                nextUserName = nextDesk.getUser().getName();
                break;
            }
            i++;
            icount++;
        }
        return nextUserName;
    }
    //***********************************************************************************
    //      SangDN: GetNumPhom of username
    //          return 0 if user don't contain any PhOM
    //          return 1,2,3 if user contain 1,2,3 valid PHOM (if 3 -> it's BINGO (Ù)
    //          return -1 if user "get a player card" but this card is not in PHOM
    //***********************************************************************************

    public int GetNumPhom(String username, List<Integer> listPhom) {
        try {
            List<ICard> listCard = m_mapUserCard.get(username).getCurrentHand();
            ArrayList<Integer> listCardId = new ArrayList<Integer>();
            for (int i = 0; i < listCard.size(); i++) {
                ICard card = listCard.get(i);
                listCardId.add(card.getCardId());
            }
            return GetNumPhom(listCardId);
//            return GetNumPhom2(listCardId, listPhom);
        } catch (Exception ex) {
            Logger.error(TaLaTableInfo.class, ex);
            return 0;
        }

    }

    public int GetNumPhom(List<Integer> listCardId) {
        try {
            SortIncreaseCardId(listCardId);
            int num = 4;
            if (listCardId.size() <= 3) {
                num = listCardId.size();
            }
            for (int i = 0; i < num; ++i) {

                int cardId = listCardId.get(i);
                //Incase Xi, add to end of array
                if (cardId < 15) {
                    //Find right K
                    int KCardId = cardId + 120;
                    if (listCardId.contains(KCardId)) //If contain right K then add Fake A to check Q K A
                    {
                        listCardId.add(new Integer(cardId + 130));
                    }
                }
            }
            return _GetNumPhom(listCardId, 1);
        } catch (Exception ex) {
            Logger.error(TaLaTableInfo.class, ex);

            return 0;
        }

    }
//***********************************************************************************
    //      SangDN: GetNumPhom of ListCardId
    //      PreCondition: listCardId contain valid && exclusive cardId
    //      listPhom: Contain array phom, num phom = listPhom.size()/3
    //***********************************************************************************

    public int GetNumPhom2(List<Integer> listCardId, List<Integer> listPhom) {
        try {
            SortIncreaseCardId(listCardId);
            int num = 4;
            if (listCardId.size() <= 3) {
                num = listCardId.size();
            }
            for (int i = 0; i < num; ++i) {

                int cardId = listCardId.get(i);
                //Incase Xi, add to end of array
                if (cardId < 15) {
                    //Find right K
                    int KCardId = cardId + 120;
                    if (listCardId.contains(KCardId)) //If contain right K then add Fake A to check Q K A
                    {
                        listCardId.add(new Integer(cardId + 130));
                    }
                }
            }

            if (listPhom == null) {
                listPhom = new ArrayList<Integer>();
            }
            int total = _GetNumPhom2(listCardId, listPhom, 0);
            if (listPhom.size() != total * 3) {
                Logger.error(TaLaTableInfo.class, "get num phom error");
                return 0;
            }
            for (int i = 0; i < listPhom.size(); ++i) {
                if (listPhom.get(i) > 140) {
                    listPhom.set(i, listPhom.get(i) - 130);
                }
            }
            return total;
        } catch (Exception ex) {
            Logger.error(TaLaTableInfo.class, ex);

            return 0;
        }

    }
//***********************************************************************************
    //      SangDN: GetNumPhom of username
    //          Pre Condition: listCardId need to sort increase
    //***********************************************************************************

    public int _GetNumPhom(List<Integer> listCardId, int level) {
        int numDongLuong = 0;
        int numDongChat = 0;
        int numKhongPhom = 0;
        int card1 = -1;
        int currentNum = -1;
        boolean debug = false;
        if (debug) {
            System.out.print(String.format("\n[%d]Process List[%d]: ", level, listCardId.size()));
            PrintList(listCardId);
        }
        try {
            if (listCardId.size() < 3) {
                return 0;
            }
            //Remove card to process
            card1 = listCardId.remove(0);
            int card2 = listCardId.get(0);
            int card3 = listCardId.get(1);
            boolean isDongLuong = false;

            boolean isDongChat = false;

            //Check Dong Luong
            if (IsDongLuong2(card1, card2)) {
                if (IsDongLuong2(card2, card3)) {
                    isDongLuong = true;
                }
            }
            if (isDongLuong == true) {
                numDongLuong = 1;
                //remove card2 && card3
                listCardId.remove(0);
                listCardId.remove(0);
                //System.out.printf("\nProcess Dong Luong");
                int numRest = _GetNumPhom(listCardId, level + 1);

                listCardId.add(0, card3);
                listCardId.add(0, card2);
                numDongLuong += numRest;
                if (numDongLuong >= 3) {
                    return numDongLuong;
                }
            }
            //Check Dong Chat
            card2 = -1;
            card3 = -1;
            int pos2 = -1;
            int pos3 = -1;
            for (int i = 0; i < listCardId.size(); ++i) {
                if (IsDongChat(card1, listCardId.get(i))) {
                    card2 = listCardId.get(i);
                    pos2 = i;
                    break;
                }
            }
            if (card2 != -1) {
                for (int i = 0; i < listCardId.size(); ++i) {
                    int temp = listCardId.get(i);
                    if (temp != card1 && IsDongChat2(card2, temp)) {
                        card3 = listCardId.get(i);
                        pos3 = i;
                        isDongChat = true;
                        break;
                    }
                }
            }

            if (isDongChat == true) {
                numDongChat = 1;
                //remove card2 && card3
                if (pos2 < pos3) {
                    listCardId.remove(pos2);
                    listCardId.remove(pos3 - 1);
                } else {
                    listCardId.remove(pos3);
                    listCardId.remove(pos2 - 1);
                }
                //System.out.printf("\nProcess Dong Chat");
                int numRest = _GetNumPhom(listCardId, level + 1);
                //add card2 && card3
                if (pos2 < pos3) {
                    listCardId.add(pos2, card2);
                    listCardId.add(pos3, card3);
                } else {
                    listCardId.add(pos3, card2);
                    listCardId.add(pos2, card2);
                }
                numDongChat += numRest;
                if (numDongChat >= 3) {
                    return numDongChat;
                }
            }

            currentNum = numDongChat;
            if (numDongLuong > currentNum) {
                currentNum = numDongLuong;
            }
            if (currentNum >= 3) {
                return currentNum;
            }
            //System.out.printf("\nProcess 0 Phom");
            numKhongPhom = _GetNumPhom(listCardId, level + 1);
            listCardId.add(0, card1);
            if (numKhongPhom > currentNum) {
                currentNum = numKhongPhom;
            }
            return currentNum;
        } catch (Exception ex) {
            Logger.error(TaLaTableInfo.class, ex);
            return 0;
        } finally {
            //System.out.print("Num Phom: " + currentNum);
        }
    }
    //***********************************************************************************
    //      SangDN: GetNumPhom of username
    //          Pre Condition: listCardId need to sort increase
    //                         listPhom != null
    //          Out: listPhom contains phom
    //               total = 0 at first called.
    //***********************************************************************************

    protected int _GetNumPhom2(List<Integer> listCardId, List<Integer> listPhom, int total) {
        int numDongLuong = 0;
        int numDongChat = 0;
        int numKhongPhom = 0;
        int card1 = -1;
        int currentNum = -1;
        boolean debug = false;
        List<Integer> listDongLuong = new ArrayList<Integer>();
        List<Integer> listDongChat = new ArrayList<Integer>();
        List<Integer> listKhongChon = new ArrayList<Integer>();
        if (debug) {
            System.out.print(String.format("\n[%d]Process List[%d]: ", total, listCardId.size()));
            PrintList(listCardId);
        }
        try {
            if (listCardId.size() < 3 || total >= 3) {
                return 0;
            }
            //Remove card to process
            card1 = listCardId.remove(0);
            int card2 = listCardId.get(0);
            int card3 = listCardId.get(1);
            boolean isDongLuong = false;

            boolean isDongChat = false;

            //Check Dong Luong
            if (IsDongLuong2(card1, card2)) {
                if (IsDongLuong2(card2, card3)) {
                    isDongLuong = true;
                }
            }
            if (isDongLuong == true) {
                numDongLuong = 1;
                //remove card2 && card3
                listCardId.remove(0);
                listCardId.remove(0);
                //System.out.printf("\nProcess Dong Luong");
                int numRest = _GetNumPhom2(listCardId, listDongLuong, total + 1);
                //add phom
                listDongLuong.add(card1);
                listDongLuong.add(card2);
                listDongLuong.add(card3);
                numDongLuong += numRest;
                if (numDongLuong >= 3) {
                    listPhom.addAll(listDongLuong);
                    return numDongLuong;
                }
            }
            //Check Dong Chat
            int card4 = -1;
            int card5 = -1;
            int pos2 = -1;
            int pos3 = -1;
            for (int i = 0; i < listCardId.size(); ++i) {
                if (IsDongChat(card1, listCardId.get(i))) {
                    card4 = listCardId.get(i);
                    pos2 = i;
                    break;
                }
            }
            if (card4 != -1) {
                for (int i = 0; i < listCardId.size(); ++i) {
                    int temp = listCardId.get(i);
                    if (temp != card1 && IsDongChat2(card4, temp)) {
                        card5 = listCardId.get(i);
                        pos3 = i;
                        isDongChat = true;
                        break;
                    }
                }
            }

            if (isDongChat == true) {
                numDongChat = 1;
                //remove card4 && card5
                if (pos2 < pos3) {
                    listCardId.remove(pos2);
                    listCardId.remove(pos3 - 1);
                } else {
                    listCardId.remove(pos3);
                    listCardId.remove(pos2 - 1);
                }
                //System.out.printf("\nProcess Dong Chat");
                int numRest = _GetNumPhom2(listCardId, listDongChat, total + 1);
                //add card4 && card5
                if (pos2 < pos3) {
                    listCardId.add(pos2, card4);
                    listCardId.add(pos3, card5);
                } else {
                    listCardId.add(pos3, card5);
                    listCardId.add(pos2, card4);
                }
                numDongChat += numRest;
                listDongChat.add(card1);
                listDongChat.add(card4);
                listDongChat.add(card5);
                if (numDongChat >= 3) {
                    //add phom
                    listPhom.addAll(listDongChat);
                    return numDongChat;
                }
            }

            currentNum = numDongChat;
            //Quyet dinh chon loai nao de lay phom
            boolean selectDongLuong = false;
            if (numDongLuong > currentNum) {
                currentNum = numDongLuong;
                selectDongLuong = true;
            }
            if (currentNum >= 3) {
                if (selectDongLuong == true) {
                    listPhom.addAll(listDongLuong);
                } else {
                    listPhom.addAll(listDongChat);
                }
                return currentNum;
            }

            //System.out.printf("\nProcess 0 Phom");
            numKhongPhom = _GetNumPhom2(listCardId, listKhongChon, total);
            listCardId.add(0, card1);
            if (numKhongPhom > currentNum) {
                currentNum = numKhongPhom;
                listPhom.addAll(listKhongChon);
            } else {
                if (selectDongLuong == true) {
                    listPhom.addAll(listDongLuong);
                }
            }
            return currentNum;
        } catch (Exception ex) {
            Logger.error(TaLaTableInfo.class, ex);
            return 0;
        } finally {
            //System.out.print("Num Phom: " + currentNum);
        }
    }

    protected void PrintList(List<Integer> list) {
        for (int i = 0; i < list.size(); ++i) {
            System.out.print(list.get(i) + ",");
        }

    }

    //Kiem tra 2 la bai la dong chat
    // ex: 3 bich - 4 bich || 3 bich - 2 bich
    protected boolean IsDongChat(int id1, int id2) {
        //sx id1 > id2        
        int temp = id1;
        if (id1 < id2) {
            id1 = id2;
            id2 = temp;
        }
        int distance = id1 - id2;
        if (distance == 0xA || distance == 120) {
            return true;
        }
        return false;

    }
    // Kbich && Abich not dong chat ( Fake Abich to Abich' id=141 to use this function

    protected boolean IsDongChat2(int id1, int id2) {
        //sx id1 > id2        
        int temp = id1;
        if (id1 < id2) {
            id1 = id2;
            id2 = temp;
        }
        int distance = id1 - id2;
        if (distance == 0xA) {
            return true;
        }
        return false;

    }

    protected boolean IsDongLuong2(int card1, int card2) {
        if (Math.abs(card1 - card2) < 4 && card1 < 135) {
            return true;
        }
        return false;
    }

    protected void SortIncrease(List<ICard> list) {
        for (int i = 0; i < list.size() - 1; ++i) {
            int minIndex = i;
            for (int j = i + 1; j < list.size(); ++j) {
                if (list.get(minIndex).getCardId() > list.get(j).getCardId()) {
                    minIndex = j;
                }
            }
            if (minIndex == i) {
                continue;
            }
            ICard value = list.get(i);
            list.set(i, list.get(minIndex));
            list.set(minIndex, value);
        }
    }

    protected void SortIncreaseCardId(List<Integer> list) {
        for (int i = 0; i < list.size() - 1; ++i) {
            int minIndex = i;
            for (int j = i + 1; j < list.size(); ++j) {
                if (list.get(minIndex) > list.get(j)) {
                    minIndex = j;
                }
            }
            if (minIndex == i) {
                continue;
            }
            int value = list.get(i);
            list.set(i, list.get(minIndex));
            list.set(minIndex, value);
        }
    }

    //***********************************************************************************
    //      khoatd: get number of win card in list card id
    //***********************************************************************************
    public int getNumWinCardInPhom(String userName, ArrayList<Integer> listCardId) {
        ArrayList<Integer> listWinCardId = m_mapUserWinCard.get(userName);

        int winCount = 0;
        for (int i = 0; i < listCardId.size(); i++) {
            int cardId = listCardId.get(i);
            if (listWinCardId.contains(cardId)) {
                winCount++;
            }
        }

        return winCount;
    }

    //***********************************************************************************
    //      khoatd: find and set current user is next user in next turn
    //              last user is currentUser before turn.
    //                  if(user is removed) then use currentPos to find next user
    //***********************************************************************************
    public void processNextUserPlaying() {
        String lastUser = m_currentUser;
        Desk desk = m_mapUserDesk.get(lastUser);
        int i;
        if (desk != null) {
            i = desk.getDeskId() + 1;
        } else {
            i = m_currentPos + 1;
        }

        int icount = 1;
        while (icount < 4) {
            if (i == 4) {
                i = 0;
            }

            Desk nextDesk = m_listDesk.get(i);
            if (nextDesk.getDeskState() == DeskState.PLAYING && nextDesk.getUser() != null && !isUserEndGame(nextDesk.getUser().getName())) {
                m_currentUser = nextDesk.getUser().getName();
                m_currentPos = nextDesk.getDeskId();
                break;
            }
            i++;
            icount++;
        }

    }

    //***********************************************************************************
    //      khoatd: set resutl for other player (set result = 5) and user is Ù set result = 6
    //              finally : caculate chip
    //         
    //***********************************************************************************
    public ArrayList<Double> processFinishUGame(String winnerName) {
        m_listUserNameResult.clear();
        m_listResult.clear();

        m_listUserNameResult.add(winnerName);
        m_listResult.add(6);

        for (int i = 0; i < m_listActiveUserName.size(); i++) {
            String playerName = m_listActiveUserName.get(i);
            if (winnerName.equals(playerName) == false) {
                m_listUserNameResult.add(playerName);
                m_listResult.add(5);
            }
        }

        //caculate chip
        ArrayList<Double> listChip = new ArrayList<Double>();
        for (int i = 1; i < m_listUserNameResult.size(); i++) {
            if (m_listResult.get(i) != 6) {
                double looseChip = m_betChip * m_listResult.get(i);
                m_potChip += looseChip;
                listChip.add(-looseChip);
            }
        }
        listChip.add(0, m_potChip);

        return listChip;
    }

    //***********************************************************************************
    //      khoatd: caculate and return a list Scores of all card on user hand 
    //          follow listDesk order.
    //***********************************************************************************
    public ArrayList<Integer> processCaculateScore() {
        ArrayList<Integer> listScore = new ArrayList<Integer>();
        for (int i = 0; i < m_listActiveUserName.size(); i++) {
            String userName = m_listActiveUserName.get(i);
            int score = 0;
            if (getUserResult(userName) == 4) {
                score = 999;
            } else {
                List<ICard> listCard = m_mapUserCard.get(userName).getCurrentHand();
                for (int j = 0; j < listCard.size(); j++) {
                    score += listCard.get(j).getCardValue();
                }
            }
            listScore.add(score);
        }
        return listScore;
    }

    protected int getUserResult(String userName) {
        for (int i = 0; i < m_listUserNameResult.size(); i++) {
            if (m_listUserNameResult.get(i).equals(userName)) {
                return m_listResult.get(i);
            }
        }
        return -1;
    }
    //***********************************************************************************
    //      khoatd: find and set order for user (not include loose user(mom'))
    //          Ex: 32, 44, 11, 52 -> 3, 1, 0, 2
    //***********************************************************************************

    public void processSetResultForUser(ArrayList<Integer> listScore) {
        for (int i = 0; i < m_listActiveUserName.size(); i++) {
            String userName = m_listActiveUserName.get(i);
            int index = m_listUserNameResult.indexOf(userName);
            if (index != -1) {
                if (m_listResult.get(index) == -1) {
                    //set resutl for user show phom
                    int score = listScore.get(i);
                    int result = FindResult(listScore, score);
                    setUserResult(userName, result);
                }
            } else {
                //user ko hạ phỏm và để hết giờ -> loose.
                setUserResult(userName, 4);
            }
        }
    }
    
    public void removeResult(String userName){
        int index = m_listUserNameResult.indexOf(userName);
        if (index != -1) {
            m_listUserNameResult.remove(index);
            m_listResult.remove(index);
        }
    }

    private int FindResult(ArrayList<Integer> listScore, Integer score) {
        int result = 0;
        for (int i = 0; i < listScore.size(); i++) {
            if (score > listScore.get(i)) {
                result++;
            }
        }
        return result;
    }
    //***********************************************************************************
    //      khoatd: find and set order for user (not include loose user(mom'))
    //          Ex: 32, 44, 11, 52 -> 3, 1, 0, 2
    //***********************************************************************************

    public ArrayList<Double> processCaculateChip() {
        ArrayList<Double> listChip = new ArrayList<Double>();
        if (isAllLooseGame()) {
            m_listResult.set(0, 0);
        } else if (isMoreWinner()) {
            //find first winner showing card and set others winner's result = 1.
            boolean isFirst = false;
            for (int i = 0; i < m_listResult.size(); i++) {
                if (m_listResult.get(i) == 0) {
                    if (isFirst == false) {
                        isFirst = true;
                    } else {
                        m_listResult.set(i, 1);
                    }
                }
            }
        }

        int winnerIndex = -1;
        for (int i = 0; i < m_listUserNameResult.size(); i++) {
            if (m_listResult.get(i) != 0) {
                double looseChip = m_betChip * m_listResult.get(i);
                m_potChip += looseChip;
                listChip.add(-looseChip);
            } else {
                winnerIndex = i;
            }
        }
        if (winnerIndex != -1) {
            listChip.add(winnerIndex, m_potChip);
        }
        //warning:else clause

        return listChip;
    }

    protected boolean isAllLooseGame() {
        int countLoose = 0;
        for (int i = 0; i < m_listResult.size(); i++) {
            if (m_listResult.get(i) == 4) {
                countLoose++;
            }
        }
        if (countLoose == m_listResult.size()) {
            return true;
        } else {
            return false;
        }
    }

    protected boolean isMoreWinner() {
        int countWinner = 0;
        for (int i = 0; i < m_listResult.size(); i++) {
            if (m_listResult.get(i) == 0) {
                countWinner++;
            }
        }
        if (countWinner > 1) {
            return true;
        } else {
            return false;
        }
    }

    //***********************************************************************************
    //      khoatd: update date chip for user -> return winner
    //***********************************************************************************
    public String processUpdateChip(ArrayList<Double> listChip) {
        String winner = null;
        for (int i = 0; i < m_listUserNameResult.size(); i++) {
            String userName = m_listUserNameResult.get(i);
            Desk desk = m_mapUserDesk.get(userName);
            if (desk != null && desk.getDeskState() == DeskState.PLAYING) {
                double addChip = listChip.get(i);
                double currentChip = desk.getChip();

                desk.setChip(currentChip + addChip);
                if (addChip > 0) {
                    winner = desk.getUser().getName();
                }
            }
        }
        return winner;
    }
    //***********************************************************************************
    //      khoatd: get all current card on hand of all user.
    //***********************************************************************************

    public ArrayList<ArrayList<Integer>> processGetAllCardHand(ArrayList<String> listUserName) {
        ArrayList<ArrayList<Integer>> listCardHand = new ArrayList<ArrayList<Integer>>();
        for (int i = 0; i < listUserName.size(); i++) {
            TaLaCardHand cardHand = m_mapUserCard.get(listUserName.get(i));
            if (cardHand != null) {
                List<ICard> listCard = cardHand.getCurrentHand();
                ArrayList<Integer> listCardId = new ArrayList<Integer>();
                for (ICard card : listCard) {
                    listCardId.add(card.getCardId());
                }
                listCardHand.add(listCardId);
            }
        }
        return listCardHand;
    }

    //***********************************************************************************
    //      khoatd: Change game status block
    //***********************************************************************************
    public void prestartStatus() {
        m_isPrestart = true;
        m_isGameStart = false;
    }

    public void waitingStatus() {
        m_isPrestart = false;
        m_isGameStart = false;
    }

    public void startGameStatus() {
        m_isPrestart = false;
        m_isGameStart = true;
    }

    //***********************************************************************************
    //      khoatd: Change user status block
    //***********************************************************************************
    public void ChangeUserGetCard() {
        m_isGetCard = true;
        m_isShowCard = false;
        m_isRemoveCard = false;
    }

    public void ChangeUserShowCard() {
        m_isGetCard = false;
        m_isShowCard = true;
        m_isRemoveCard = false;
    }

    public void ChangeUserRemoveCard() {
        m_isGetCard = false;
        m_isShowCard = false;
        m_isRemoveCard = true;
    }

    public void ChangeUserFinishGame() {
        m_isGetCard = false;
        m_isShowCard = false;
        m_isRemoveCard = false;
    }

    //***********************************************************************************
    //          GETTER && SETTER SECTION
    //***********************************************************************************
    // <editor-fold defaultstate="collapsed" desc="GETTER && SETTER SETTION">
    public boolean IsGameStart() {
        return m_isGameStart;
    }

    public void setIsGameStart(boolean IsGameStart) {
        this.m_isGameStart = IsGameStart;
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

    public List<Desk> getListDesk() {
        return m_listDesk;
    }

    public void setListDesk(List<Desk> ListDesk) {
        this.m_listDesk = ListDesk;
    }

    public HashMap<String, Desk> getMapUserDesk() {
        return m_mapUserDesk;
    }

    //return a desk of user
    public Desk getMapUserDesk(String userName) {
        return m_mapUserDesk.get(userName);
    }

    public void setMapUserDesk(HashMap<String, Desk> MapUserDesk) {
        this.m_mapUserDesk = MapUserDesk;
    }

    public TaLaCardCollection getTaLaCardCollection() {
        return m_talaCardCollection;
    }

    public void setTaLaCardCollection(TaLaCardCollection TaLaCardCollection) {
        this.m_talaCardCollection = TaLaCardCollection;
    }

    public HashMap<String, TaLaCardHand> getMapUserCard() {
        return m_mapUserCard;
    }
    //Return list current card of user

    public TaLaCardHand getMapUserCard(String username) {
        return m_mapUserCard.get(username);
    }

    public void setMapUserCard(HashMap<String, TaLaCardHand> MapUserCard) {
        this.m_mapUserCard = MapUserCard;
    }

    public HashMap<String, TaLaCardHand> getMapUserLeaveCard() {
        return m_mapUserLeaveCard;
    }
    //Return list leave card of user

    public TaLaCardHand getMapUserLeaveCard(String username) {
        return m_mapUserLeaveCard.get(username);
    }

    public void setMapUserLeaveCard(HashMap<String, TaLaCardHand> MapUserLeaveCard) {
        this.m_mapUserLeaveCard = MapUserLeaveCard;
    }

    public HashMap<String, TaLaCardHand> getMapUserPhomCard() {
        return m_mapUserPhomCard;
    }

    public TaLaCardHand getMapUserPhomCard(String username) {
        return m_mapUserPhomCard.get(username);
    }

    public void setMapUserPhomCard(HashMap<String, TaLaCardHand> m_mapUserPhomCard) {
        this.m_mapUserPhomCard = m_mapUserPhomCard;
    }

    public double getBetChip() {
        return m_betChip;
    }

    public void setBetChip(double BetChip) {
        this.m_betChip = BetChip;
    }

    public HashMap<String, ArrayList<Integer>> getMapUserWinCard() {
        return m_mapUserWinCard;
    }
    //Return list leave card of user

    public ArrayList<Integer> getMapUserWinCard(String username) {
        return m_mapUserWinCard.get(username);
    }

    public void setMapUserWinCard(HashMap<String, ArrayList<Integer>> MapUserWinCard) {
        this.m_mapUserWinCard = MapUserWinCard;
    }

    public HashMap<String, User> getMapUser() {
        return m_mapUser;
    }

    public User getMapUser(String userName) {
        return m_mapUser.get(userName);
    }

    public void setMapUser(HashMap<String, User> MapUser) {
        this.m_mapUser = MapUser;
    }

    public boolean isPrestart() {
        return m_isPrestart;
    }

    public void setIsPrestart(boolean IsPrestart) {
        this.m_isPrestart = IsPrestart;
    }
    //***********************************************************************************
    //      SangDN: Set A User To Active User (Player)           
    //          case: After user check ready to start game

    public void processUserReady(User user) {
        m_mapUserDesk.get(user.getName()).setDeskState(DeskState.READY);
        if (!m_listActiveUserName.contains(user.getName())) {
            m_listActiveUser.add(user);
            m_listActiveUserName.add(user.getName());
        }
    }

    //***********************************************************************************
    //      SangDN: Proces User to Play State       
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
    //      SangDN: Proces User to Play State       
    //          case: After user check ready to start game

    public void ProcessUserLeaveGame(User user) {
        //Process User Stop Game
        //Remove all infor etc ....
        m_listActiveUser.remove(user);
        m_listActiveUserName.remove(user.getName());
        m_mapUserDesk.get(user.getName()).setDeskState(DeskState.EMPTY);
        //MapUser;
        //MapUserCard;
        //MapUserLeaveCard;
        //MapUserWinCard;

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

    public double getPotChip() {
        return m_potChip;
    }

    public void setPotChip(double m_potChip) {
        this.m_potChip = m_potChip;
    }

    public int getCurrentPos() {
        return m_currentPos;
    }

    public void setCurrentPos(int m_currentPos) {
        this.m_currentPos = m_currentPos;
    }

    /**
     * @return the m_listUserNameResult
     */
    public List<String> getListUserNameResult() {
        return m_listUserNameResult;
    }

    /**
     * @param m_listUserNameResult the m_listUserNameResult to set
     */
    public void setListUserNameResult(List<String> m_listUserNameResult) {
        this.m_listUserNameResult = m_listUserNameResult;
    }

    /**
     * @return the m_listResult
     */
    public List<Integer> getListResult() {
        return m_listResult;
    }

    public HashMap<String, ArrayList<Double>> getMapUserWinChip() {
        return m_mapUserWinChip;
    }

    public ArrayList<Double> getMapUserWinChip(String userName) {
        return m_mapUserWinChip.get(userName);
    }

    public void setMapUserWinChip(HashMap<String, ArrayList<Double>> m_mapUserWinChip) {
        this.m_mapUserWinChip = m_mapUserWinChip;
    }

    public HashMap<String, ArrayList<String>> getMapUserWinFromPlayer() {
        return m_mapUserWinFromPlayer;
    }

    public ArrayList<String> getMapUserWinFromPlayer(String userName) {
        return m_mapUserWinFromPlayer.get(userName);
    }

    public void setMapUserWinFromPlayer(HashMap<String, ArrayList<String>> m_mapUserWinFromPlayer) {
        this.m_mapUserWinFromPlayer = m_mapUserWinFromPlayer;
    }

    /**
     * @return the m_isGetCard
     */
    public boolean isGetCard() {
        return m_isGetCard;
    }

    /**
     * @return the m_isShowCard
     */
    public boolean isShowCard() {
        return m_isShowCard;
    }

    /**
     * @return the m_isRemoveCard
     */
    public boolean isRemoveCard() {
        return m_isRemoveCard;
    }
}
