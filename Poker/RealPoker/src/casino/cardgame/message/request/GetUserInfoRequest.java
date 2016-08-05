//
//
//  Generated by StarUML(tm) Java Add-In
//
//  @ Project : casino project
//  @ File Name : GetUserInfoRequest.java
//  @ Date : 5/27/2012
//  @ Author : sangdn
//
//
package casino.cardgame.message.request;

import com.smartfoxserver.v2.entities.data.ISFSObject;

public class GetUserInfoRequest extends SFSGameRequest {

    private String userName;
    private String email;
    private String userTitle;
    private String userStatus;
    public static String USER_NAME = "user_name";
    public static String EMAIL = "email";
    public static String USER_STATUS = "user_status";
    public static String USER_TITLE = "user_title";

    @Override
    public SFSGameRequest FromSFSObject(ISFSObject isfso) {
        userName = isfso.getUtfString(USER_NAME);
        email = isfso.getUtfString(EMAIL);
        userTitle = isfso.getUtfString(USER_TITLE);
        userStatus = isfso.getUtfString(USER_STATUS);
        return this;
    }

    @Override
    public String GetRequestName() {
        return GAME_REQUEST_NAME.GET_USER_INFO_REQ;
    }

    /**
     * @return the userName
     */
    public String getUserName() {
        return userName;
    }

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @return the userTitle
     */
    public String getUserTitle() {
        return userTitle;
    }

    /**
     * @return the userStatus
     */
    public String getUserStatus() {
        return userStatus;
    }
}