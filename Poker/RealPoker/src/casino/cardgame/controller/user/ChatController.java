/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.controller.user;

import casino.cardgame.message.event.SFSGameEvent;

/**
 *
 * @author KIDKID
 */
public class ChatController implements IChatController{
    
    protected static ChatController m_instance;
    protected ChatController(){
        
    }
    @Override
    public void HandlePrivateMessage(SFSGameEvent sfse) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void HandlePublicMessage(SFSGameEvent sfse) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    
    public static ChatController getInstance() {
        if(m_instance == null){
            m_instance = new ChatController();
        }
        return m_instance;
    }
    
}
