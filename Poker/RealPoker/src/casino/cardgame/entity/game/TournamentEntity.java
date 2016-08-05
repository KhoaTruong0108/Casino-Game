/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.entity.game;

import casino.cardgame.game_enum.TournamentInfoParams;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import hirondelle.date4j.DateTime;

/**
 *
 * @author Kenjuzi
 */
public class TournamentEntity {

    private String _name;
    private String _displayName;
    private double _fee;
    private int _capacity;
    private int _playerCount;
    private String _status;
//    private double _smallBlind;
//    private double _bigBlind;
//    private double _betChip;
    private int _levelType;
    private int _beginLevel;
    private int _endLevel;
    private double _startingChip;
    private double _firstPrize;
    private double _secondPrize;
    private double _thirdPrize;
    private String _createBy;
    private DateTime _createDate;

    public TournamentEntity() {
    }

//    public TournamentEntity(String name, String display, int capacity, Double fee, Double startingChip, Double betChip, Double smallBlind, Double bigBlind, Double first, Double second, Double third, String createBy, DateTime createDate) {
//        _name = name;
//        _displayName = display;
//        _capacity = capacity;
//        _fee = fee;
//        _startingChip = startingChip;
//        _betChip = betChip;
//        _smallBlind = smallBlind;
//        _bigBlind = bigBlind;
//        _createDate = createDate;
//        _createBy = createBy;
//    }
    public TournamentEntity(String name, String display, int capacity, Double fee, Double startingChip, int levelType, int beginLevel, int endLevel, Double first, Double second, Double third, String createBy, DateTime createDate) {
        _name = name;
        _displayName = display;
        _capacity = capacity;
        _fee = fee;
        _startingChip = startingChip;
        _levelType = levelType;
        _beginLevel = beginLevel;
        _endLevel = endLevel;
        _createDate = createDate;
        _createBy = createBy;
    }

    public static TournamentEntity fromSFSObject(ISFSObject sfsObj) {
        TournamentEntity tournament = new TournamentEntity();

        if (sfsObj.containsKey(TournamentInfoParams.NAME)) {
            tournament.setName(sfsObj.getUtfString(TournamentInfoParams.NAME));
        }
        if (sfsObj.containsKey(TournamentInfoParams.DISPLAY_NAME)) {
            tournament.setDisplayName(sfsObj.getUtfString(TournamentInfoParams.DISPLAY_NAME));
        }
        if (sfsObj.containsKey(TournamentInfoParams.CAPACITY)) {
            tournament.setCapacity(sfsObj.getInt(TournamentInfoParams.CAPACITY));
        }
        if (sfsObj.containsKey(TournamentInfoParams.FEE)) {
            tournament.setFee(Double.parseDouble(sfsObj.getUtfString(TournamentInfoParams.FEE)));
        }
        if (sfsObj.containsKey(TournamentInfoParams.STARTING_CHIP)) {
            tournament.setStartingChip(Double.parseDouble(sfsObj.getUtfString(TournamentInfoParams.STARTING_CHIP)));
        }
        if (sfsObj.containsKey(TournamentInfoParams.LEVEL_TYPE)) {
            tournament.setLevelType(sfsObj.getInt(TournamentInfoParams.LEVEL_TYPE));
        }
        if (sfsObj.containsKey(TournamentInfoParams.BEGIN_LEVEL)) {
            tournament.setBeginLevel(sfsObj.getInt(TournamentInfoParams.BEGIN_LEVEL));
        }
        if (sfsObj.containsKey(TournamentInfoParams.END_LEVEL)) {
            tournament.setEndLevel(sfsObj.getInt(TournamentInfoParams.END_LEVEL));
        }
//        if (sfsObj.containsKey(TournamentInfoParams.BET_CHIP)) {
//            tournament.setBetChip(sfsObj.getDouble(TournamentInfoParams.BET_CHIP));
//        }
//        if (sfsObj.containsKey(TournamentInfoParams.SMALL_BLIND)) {
//            tournament.setSmallBlind(sfsObj.getDouble(TournamentInfoParams.SMALL_BLIND));
//        }
//        if (sfsObj.containsKey(TournamentInfoParams.BIG_BLIND)) {
//            tournament.setBigBlind(sfsObj.getDouble(TournamentInfoParams.BIG_BLIND));
//        }
        if (sfsObj.containsKey(TournamentInfoParams.STATUS)) {
            tournament.setStatus(sfsObj.getUtfString(TournamentInfoParams.STATUS));
        }
        if (sfsObj.containsKey(TournamentInfoParams.FIRST_PRIZE)) {
            tournament.setFirstPrize(Double.parseDouble(sfsObj.getUtfString(TournamentInfoParams.FIRST_PRIZE)));
        }
        if (sfsObj.containsKey(TournamentInfoParams.SECOND_PRIZE)) {
            tournament.setSecondPrize(Double.parseDouble(sfsObj.getUtfString(TournamentInfoParams.SECOND_PRIZE)));
        }
        if (sfsObj.containsKey(TournamentInfoParams.THIRD_PRIZE)) {
            tournament.setThirdPrize(Double.parseDouble(sfsObj.getUtfString(TournamentInfoParams.THIRD_PRIZE)));
        }
        if (sfsObj.containsKey(TournamentInfoParams.CREATE_BY)) {
            tournament.setCreateBy(sfsObj.getUtfString(TournamentInfoParams.CREATE_BY));
        }
        if (sfsObj.containsKey(TournamentInfoParams.PLAYER_IN_GAME)) {
            tournament.setPlayerCount(sfsObj.getInt(TournamentInfoParams.PLAYER_IN_GAME));
        }

        return tournament;
    }

    public String getName() {
        return _name;
    }

    public void setName(String name) {
        this._name = name;
    }

    public double getFee() {
        return _fee;
    }

    public void setFee(double fee) {
        this._fee = fee;
    }

    public int getCapacity() {
        return _capacity;
    }

    public void setCapacity(int capacity) {
        this._capacity = capacity;
    }

    public String getStatus() {
        return _status;
    }

    public void setStatus(String status) {
        this._status = status;
    }

    public double getStartingChip() {
        return _startingChip;
    }

    public void setStartingChip(double startingChip) {
        this._startingChip = startingChip;
    }

    public double getFirstPrize() {
        return _firstPrize;
    }

    public void setFirstPrize(double firstPrize) {
        this._firstPrize = firstPrize;
    }

    public double getSecondPrize() {
        return _secondPrize;
    }

    public void setSecondPrize(double secondPrize) {
        this._secondPrize = secondPrize;
    }

    public double getThirdPrize() {
        return _thirdPrize;
    }

    public void setThirdPrize(double thirdPrize) {
        this._thirdPrize = thirdPrize;
    }

    public int getPlayerCount() {
        return _playerCount;
    }

    public void setPlayerCount(int playerCount) {
        this._playerCount = playerCount;
    }

    public String getDisplayName() {
        return _displayName;
    }

    public void setDisplayName(String displayName) {
        this._displayName = displayName;
    }

    public String getCreateBy() {
        return _createBy;
    }

    public void setCreateBy(String createBy) {
        this._createBy = createBy;
    }

    public DateTime getCreateDate() {
        return _createDate;
    }

    public void setCreateDate(DateTime createDate) {
        this._createDate = createDate;
    }

    public int getLevelType() {
        return _levelType;
    }

    public void setLevelType(int levelType) {
        this._levelType = levelType;
    }

    public int getBeginLevel() {
        return _beginLevel;
    }

    public void setBeginLevel(int beginLevel) {
        this._beginLevel = beginLevel;
    }

    public int getEndLevel() {
        return _endLevel;
    }

    public void setEndLevel(int endLevel) {
        this._endLevel = endLevel;
    }
}
