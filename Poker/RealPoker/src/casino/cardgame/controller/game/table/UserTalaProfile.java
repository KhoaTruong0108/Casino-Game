/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.controller.game.table;

import casino.cardgame.entity.game_entity.ICard;
import java.util.List;

/**
 *
 * @author KIDKID
 * @Desc: Profile Of User In Game
 *        Each Type Of Game Would Have A Different Profile
 */
public class UserTalaProfile {
    //Danh sách bài hiện có trong tay
    protected List<ICard> m_listActiveCard;
    //Danh sách bài bỏ xuống ( gồm bài đánh xuống && bài chuyển từ người khác qua)
    protected List<ICard> m_listRemoveCard;
    //Danh sách bài ăn được từ người khác.
    protected List<ICard> m_listWinCard;
    //Có phải chủ ván bài hiện tại không ?
    protected boolean m_isHolder;
    
    
    
    
}
