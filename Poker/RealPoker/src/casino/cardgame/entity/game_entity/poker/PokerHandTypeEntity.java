/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.entity.game_entity.poker;

/**
 *
 * @author Kenjuzi
 */
public class PokerHandTypeEntity {
    private String _name;
    private int _order;
    private int _value;
    
    public PokerHandTypeEntity(String name, int order, int value){
        _name = name;
        _order = order;
        _value = value;
    }

    public String getName() {
        return _name;
    }

    public int getOrder() {
        return _order;
    }

    /**
     * @return the _value
     */
    public int getValue() {
        return _value;
    }

}
