/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.entity.game_entity.poker;

/**
 *
 * @author Kenjuzi
 */
public interface IUserBetHistory {
    public void setUserAction(String turnName, String type, double chip);
    public UserBetObject getLastAction();
    public void removeLastAction();
    public UserBetObject getUserBetByTurnIndex(int index);
    public UserBetObject getUserBetByTurnName(String name);
    public void renewBetHistory();
}
