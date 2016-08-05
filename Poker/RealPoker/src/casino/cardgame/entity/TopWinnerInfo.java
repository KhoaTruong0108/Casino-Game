/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package casino.cardgame.entity;

import com.smartfoxserver.v2.entities.data.SFSObject;

/**
 *
 * @author KIDKID
 */
public class TopWinnerInfo {
    private String m_name; 
    private int m_numWin; //So tran thang

    /**
     * @return the m_name
     */
    public String getM_name() {
        return m_name;
    }

    /**
     * @param m_name the m_name to set
     */
    public void setM_name(String m_name) {
        this.m_name = m_name;
    }

    /**
     * @return the m_numWin
     */
    public int getM_numWin() {
        return m_numWin;
    }

    /**
     * @param m_numWin the m_numWin to set
     */
    public void setM_numWin(int m_numWin) {
        this.m_numWin = m_numWin;
    }
    //KhoaTD: to SFSObject to send to client
    public SFSObject ToSFSObject(){
        SFSObject obj = new SFSObject();
        obj.putUtfString("name", m_name);
        obj.putInt("num_win", m_numWin);
        return obj;
    }
}
