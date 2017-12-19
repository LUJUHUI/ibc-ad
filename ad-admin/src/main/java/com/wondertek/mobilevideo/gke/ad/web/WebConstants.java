package com.wondertek.mobilevideo.gke.ad.web;

import org.springframework.context.ApplicationContext;

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
 
    public static ApplicationContext ctx = null;
	/**文件上传ftp*/
	public static FtpServer uploadFtp = null;
	
	public static String CSPID = "";
	public static String LSPID = "";
	
	public static final String FPT_URL_PREFIX = "ftp://smg001:smg001@221.130.163.21:21/";

}
