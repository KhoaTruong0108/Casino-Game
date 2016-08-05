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
public class LeaderBoardInfo {
    private String m_name;
    private Double m_chip;

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
     * @return the m_chip
     */
    public Double getM_chip() {
        return m_chip;
    }

    /**
     * @param m_chip the m_chip to set
     */
    public void setM_chip(Double m_chip) {
        this.m_chip = m_chip;
    }
    
    //KhoaTD: to SFSObject to send to client
    public SFSObject ToSFSObject(){
        SFSObject obj = new SFSObject();
        obj.putUtfString("name", m_name);
        return obj;
    }
}
