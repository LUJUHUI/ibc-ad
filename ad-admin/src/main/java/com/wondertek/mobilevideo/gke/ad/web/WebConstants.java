package com.wondertek.mobilevideo.bc.web;

import com.wondertek.mobilevideo.core.util.Configuration;
import com.wondertek.mobilevideo.core.util.ftp.FtpServer;

/**
 * Created by Administrator on 2017/6/13.
 */
public class WebConstants {
    public static final String CONFIG = "appConfig";
    public static final String PREFERRED_LOCALE_KEY = "org.apache.struts2.action.LOCALE";
    public static final String ADMIN_ROLE = "ROLE_ADMIN";
    public static final String CSS_THEME = "csstheme";

    public static final Integer _SSO_USERID = 0;
    public static final String _sso_username = "administrator";
    
    public static final String service_postfix = "?wsdl";
    public static String MOBILE_PLAT_NOTICE_PUBLISH_SERVICE_URL="";

	public static Configuration config = null;
	public static String APP_BASE_PATH="";
	public static String PUBLISH_FILE_PATH = "";
	public static String CALLBACK_XML_PATH = "";
	public static String TEMP_PATH = "";
	
	/**文件上传ftp*/
	public static FtpServer uploadFtp = null;
	
	public static String CSPID = "";
	public static String LSPID = "";
	
	public static final String FPT_URL_PREFIX = "ftp://smg001:smg001@221.130.163.21:21/";
    
}
