/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.controller.server;

import casino.cardgame.controller.admin.AdminController;
import casino.cardgame.controller.game.GameController;
import casino.cardgame.controller.user.ChatController;
import casino.cardgame.controller.user.UserController;

/**
 *
 * @author KIDKID
 */
public abstract class ServerController implements IServerController{
    protected UserController m_userController;
    protected GameController m_gameController;
    protected AdminController m_adminController;
    protected ChatController m_chatController;
    
    protected ServerController(){
        m_userController = UserController.getInstance();
        m_gameController =  GameController.getInstance();
        m_adminController =  AdminController.getInstance();
        m_chatController =  ChatController.getInstance();
    }
    
    /**
     * @return the m_userController
     */
    public UserController getM_userController() {
        return m_userController;
    }

    /**
     * @return the m_gameController
     */
    public GameController getM_gameController() {
        return m_gameController;
    }

    /**
     * @return the m_adminController
     */
    public AdminController getM_adminController() {
        return m_adminController;
    }

    /**
     * @return the m_chatController
     */
    public ChatController getM_chatController() {
        return m_chatController;
    }
}
