/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.controller;

import java.util.logging.Level;
import org.apache.log4j.Logger;
import org.eclipse.jetty.server.Connector;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.nio.SelectChannelConnector;
import org.eclipse.jetty.servlet.ServletHandler;
import org.eclipse.jetty.util.thread.QueuedThreadPool;


/**
 *
 * @author KIDKID
 */
public class CasinoWebServer {
    protected static CasinoWebServer _instance = null;
    protected static Logger _logger = Logger.getLogger(CasinoWebServer.class);
    protected Server m_server;
    protected int m_listenPort;
    protected int m_nMaxThread;
    protected int m_nMaxIdleTime;
    
    protected CasinoWebServer(){
        //Init Data 
        m_listenPort = 8008;
        m_nMaxThread = 100;
        m_nMaxIdleTime = 5000;
        //Init Server
        m_server = new Server();
        QueuedThreadPool qtp = new QueuedThreadPool();
        qtp.setMaxThreads(m_nMaxThread);
        
        m_server.setThreadPool(qtp);
        
        SelectChannelConnector connector = new SelectChannelConnector();
        connector.setPort(m_listenPort);
        connector.setMaxIdleTime(m_nMaxIdleTime);
        
        m_server.setConnectors(new Connector[]{connector});
        //Set Handler
        ServletHandler handler = new ServletHandler();
        handler.addServletWithMapping("casino.cardgame.controller.web.Register", "/register");
        //handler.addServletWithMapping("casino.cardgame.controller.web.UploadFile", "/uploadfile");
        handler.addServletWithMapping("casino.cardgame.controller.web.Upload", "/upload");
        
        m_server.setHandler(handler);
        m_server.setStopAtShutdown(true);
    }
    /**
     * @description:
     *      + get a casinowebserver
     *      + singleton pattern
     * @return
     */
    public static synchronized CasinoWebServer getInstance(){
        try {
            if (_instance == null) {
                _instance = new CasinoWebServer();
            }
            return _instance;
        } catch (Exception e) {
            _logger.error("CasinoWebserver::getInstance" + e.getMessage());
            return null;
        }
    }
    /**
     * Start WebServer && Listen Connect From Client
     *      + listen port: 8008
     */
    public void Start(){
        try {
            m_server.start();
            m_server.join();
        } catch (Exception ex) {
            _logger.error("CasinoWebServer::Start " + ex.getMessage());
        }
    }
    
    public void Stop(){
        try {
            m_server.stop();
        } catch (Exception ex) {
            _logger.error("CasinoWebServer::Start " + ex.getMessage());
        }
    }
    
}
