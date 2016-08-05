/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.entity.game_entity.poker;

/**
 *
 * @author Kenjuzi
 * This class contains all information about last user action in a game turn.
 */
public class UserBetObject {
    private String ActionType;//reference UserActionType class.
    private Double Chip;
    private String TurnName;

    public String getActionType() {
        return ActionType;
    }

    public void setActionType(String ActionType) {
        this.ActionType = ActionType;
    }

    public Double getChip() {
        return Chip;
    }

    public void setChip(Double Chip) {
        this.Chip = Chip;
    }

    public String getTurnName() {
        return TurnName;
    }

    public void setTurnName(String TurnName) {
        this.TurnName = TurnName;
    }
}
