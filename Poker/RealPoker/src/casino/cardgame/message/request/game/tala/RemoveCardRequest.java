//
//
//  Generated by StarUML(tm) Java Add-In
//
//  @ Project : casino project
//  @ File Name : RemoveCardRequest.java
//  @ Date : 6/7/2012
//  @ Author : sangdn
//
//  @ Desc: Request to remove a card from Player CardCollection
//          This request occur after user RequestGetPlayerCard or RequestGetNextCard
package casino.cardgame.message.request.game.tala;

import casino.cardgame.message.request.SFSGameRequest;
import com.smartfoxserver.v2.entities.data.ISFSObject;

public class RemoveCardRequest extends casino.cardgame.message.request.SFSGameRequest {
    //id card được hạ xuống.
    // cần kiểm tra id có nằm trong Player CardCollection hay ko ? Nếu ko -> Hack

    private int m_cardId;
    public static String CARD_ID = "card_id";
    @Override
    public SFSGameRequest FromSFSObject(ISFSObject isfso) {
        setM_cardId((int) isfso.getInt(CARD_ID));
        return this;
    }

    @Override
    public String GetRequestName() {
        return TALA_REQUEST_NAME.REMOVE_CARD;
    }

    public int getM_cardId() {
        return m_cardId;
    }

    public void setM_cardId(int m_cardId) {
        this.m_cardId = m_cardId;
    }
}