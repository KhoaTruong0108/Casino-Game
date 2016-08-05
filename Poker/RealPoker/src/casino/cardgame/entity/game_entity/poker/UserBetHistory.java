/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.entity.game_entity.poker;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Kenjuzi
 * Log all action of user include 4 game turn: BETTING, FLOP, TURN, RIVER (class PokerGameTurn)
 */
public class UserBetHistory implements IUserBetHistory {

    private List<UserBetObject> m_listBet;// danh sách gồm 4 phần tử.
    private double m_totalBetChip;

    public UserBetHistory() {
        m_listBet = new ArrayList<UserBetObject>();
    }

    @Override
    public void setUserAction(String turnName, String type, double chip) {
        UserBetObject lastAction = getLastAction();
        if (lastAction != null) {
            if (lastAction.getTurnName().equals(turnName)) {
                UserBetObject betObj = getLastAction();
                betObj.setChip(betObj.getChip() + chip);
                betObj.setActionType(type);
            } else {
                UserBetObject betObj = new UserBetObject();
                betObj.setActionType(type);
                betObj.setChip(chip);
                betObj.setTurnName(turnName);
                m_listBet.add(betObj);
            }
        } else {
            UserBetObject betObj = new UserBetObject();
            betObj.setActionType(type);
            betObj.setChip(chip);
            betObj.setTurnName(turnName);
            m_listBet.add(betObj);
        }
        m_totalBetChip += chip;
    }

    @Override
    public UserBetObject getLastAction() {
        if (m_listBet.size() > 0) {
            return getListBet().get(getListBet().size() - 1);
        }
        return null;
    }

    @Override
    public void removeLastAction() {
        getListBet().remove(getListBet().size() - 1);
    }

    public List<UserBetObject> getListBet() {
        return m_listBet;
    }

    @Override
    public UserBetObject getUserBetByTurnIndex(int index) {
        if (index >= getListBet().size()) {
            return null;
        }

        return getListBet().get(index);
    }

    @Override
    public UserBetObject getUserBetByTurnName(String name) {
        if (name.equals(PokerGameTurn.BETTING)) {
            return getListBet().get(0);
        } else if (name.equals(PokerGameTurn.FLOP)) {
            return getListBet().get(1);
        } else if (name.equals(PokerGameTurn.TURN)) {
            return getListBet().get(2);
        } else if (name.equals(PokerGameTurn.RIVER)) {
            return getListBet().get(3);
        } else if (name.equals(PokerGameTurn.END)) {
            return getListBet().get(4);
        }
        return null;
    }

    @Override
    public void renewBetHistory() {
        m_totalBetChip = 0;
        getListBet().clear();
    }

    /**
     * @return the m_totalBetChip
     */
    public double getTotalBetChip() {
        return m_totalBetChip;
    }
}
