/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.utils.data;

import casino.cardgame.entity.LeaderBoardInfo;
import casino.cardgame.entity.LoginHistory;
import casino.cardgame.entity.RoomHistory;
import casino.cardgame.entity.ServerStateHistory;
import casino.cardgame.entity.TableResult;
import casino.cardgame.entity.TopWinnerInfo;
import casino.cardgame.entity.TransactionInfo;
import casino.cardgame.entity.UserInfo;
import casino.cardgame.entity.game.TableHistory;
import casino.cardgame.utils.Logger;
import hirondelle.date4j.DateTime;
import java.util.AbstractList;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 *
 * @author KIDKID DESCRIPTION: Hold All Data In Process Memory By Init Map &
 * List to keep data The Next version would be hold data in other process at
 * same | other server using MemCache
 */
public class MyMemCached implements IMemoryCached {

    protected HashMap<String, UserInfo> mapUserInfo;
    protected HashMap<String, String> mapUserPassword;
    protected HashMap<String, TableResult> mapTableResult;
    protected HashMap<String, TransactionInfo> mapTransactionInfo;
    protected List<LoginHistory> listLoginHistory;
    protected List<TableHistory> listTableHistory;
    protected List<RoomHistory> listRoomHistory;
    protected List<LeaderBoardInfo> listLeaderBoardInfo;
    protected List<TopWinnerInfo> listTopWinnerInfo;

    public MyMemCached() {
        //SangDN: Init Data
        mapUserInfo = new HashMap<String, UserInfo>();
        mapUserPassword = new HashMap<String, String>();
        mapTableResult = new HashMap<String, TableResult>();
        mapTransactionInfo = new HashMap<String, TransactionInfo>();
        listLoginHistory = new ArrayList<LoginHistory>();
        listTableHistory = new ArrayList<TableHistory>();
        listRoomHistory = new ArrayList<RoomHistory>();
        listLeaderBoardInfo = new ArrayList<LeaderBoardInfo>();
        listTopWinnerInfo = new ArrayList<TopWinnerInfo>();
    }
    //*************************************************************************************
    //                          MEMCACHE INTERFACE API
    //*************************************************************************************

    @Override
    public UserInfo GetUserInfo(String strUserName) {
        try {
            if (mapUserInfo.containsKey(strUserName)) {
                return mapUserInfo.get(strUserName);
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
        return null;
    }

    @Override
    public String GetUserPassword(String strUserName) {
        try {
            if (mapUserPassword.containsKey(strUserName)) {
                return mapUserPassword.get(strUserName);
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        }
        return null;
    }

    @Override
    public TableResult GetTableResult(String tblId) {
        try {
            String key = tblId;
            if (mapTableResult.containsKey(key)) {
                return mapTableResult.get(key);
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        } finally {
            return null;
        }
    }

    @Override
    public TransactionInfo GetTransactionInfo(String strOwnerName) {
        try {
            if (mapTransactionInfo.containsKey(strOwnerName)) {
                return mapTransactionInfo.get(strOwnerName);
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        } finally {
            return null;
        }
    }

    @Override
    public List<TransactionInfo> GetTransactionHistory(String strOwnerName, DateTime fromDate, DateTime toDate) {
        try {
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        } finally {
            return null;
        }
    }

    @Override
    public List<TransactionInfo> GetTransactionHistory(String strOwnerName, int fromIndex, int numRecord) {
        try {
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        } finally {
            return null;
        }
    }

    @Override
    public TableHistory GetTableHistory(String tableID) {
        try {
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        } finally {
            return null;
        }
    }

    @Override
    public List<LoginHistory> GetLoginHistory(String strUserName, DateTime fromDate, DateTime toDate) {
        try {
            return null;
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        } finally {
            return null;
        }
    }

    @Override
    public List<LoginHistory> GetLoginHistory(String strUserName, int fromIndex, int numRecord) {
        try {
            return null;
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        } finally {
            return null;
        }
    }

    @Override
    public List<RoomHistory> GetCreatedRoomHistory(DateTime fromDate, DateTime toDate) {
        try {
            return null;
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        } finally {
            return null;
        }
    }

    @Override
    public List<RoomHistory> GetCreatedRoomHistory(int fromIndex, int numRecord) {
        try {
            return null;
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        } finally {
            return null;
        }
    }

    @Override
    public List<ServerStateHistory> GetServerStateHistory(DateTime fromDate, DateTime toDate) {
        try {
            return null;
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        } finally {
            return null;
        }
    }

    @Override
    public List<ServerStateHistory> GetServerStateHistory(int fromIndex, int numRecord) {
        try {
            return null;
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        } finally {
            return null;
        }
    }

    @Override
    public List<LeaderBoardInfo> GetLeaderBoard() {
        try {
            return null;
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        } finally {
            return null;
        }
    }

    @Override
    public List<TopWinnerInfo> GetTopWiner() {
        try {
            return null;
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
        } finally {
            return null;
        }
    }
    //*************************************************************************************
    //                      ADD OBJECT TO MEMCACHED
    //*************************************************************************************

    @Override
    public void cacheUserInfo(UserInfo info) {
        if (info != null) {
            mapUserInfo.put(info.getUserName(), info);
        }
    }

    @Override
    public void cacheUserPass(String strUserName, String pass) {
        if (strUserName != null && pass != null) {
            mapUserPassword.put(strUserName, pass);
        }
    }

    @Override
    public void cacheTableResult(TableResult result) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void cacheTransactionInfo(TransactionInfo trans) {
        
    }

    @Override
    public void cacheTableHistory(TableHistory tblHistory) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void cacheLoginHistory(LoginHistory loginHistory) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void cacheRoomHistory(RoomHistory room) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void cacheLeaderBoardInfo(List<LeaderBoardInfo> list) {
        listLeaderBoardInfo = list;
    }

    @Override
    public void cacheTopWinnerInfo(List<TopWinnerInfo> list) {
        listTopWinnerInfo = list;
    }

    //*************************************************************************************
    //                 KHOATD     UPDATE OBJECT TO MEMCACHED
    //*************************************************************************************
    public boolean updateUserInfo(UserInfo user) {
        try {
            if (user != null && mapUserInfo.containsKey(user.getUserName())) {
                mapUserInfo.put(user.getUserName(), user);
                return true;
            } else {
                return false;
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
            return false;
        }
    }
    
    public boolean deleteUserInfo(String userName) {
        try {
            if (mapUserInfo.containsKey(userName)) {
                mapUserInfo.remove(userName);
                return true;
            } else {
                return false;
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
            return false;
        }
    }
    
    public boolean updateUserChip(String userName, double chip) {
        try {
            if (mapUserInfo.containsKey(userName)) {
                mapUserInfo.get(userName).setChip(chip);
                return true;
            } else {
                return false;
            }
        } catch (Exception ex) {
            Logger.error(this.getClass(), ex);
            return false;
        }
    }
}
