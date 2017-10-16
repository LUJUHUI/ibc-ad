package com.wondertek.mobilevideo.bc;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.springframework.context.ApplicationContext;


public class BcConstants {

	/**
	 * 系统配置
	 */
	public static final String ADMIN_CAMOUFLAGE_CONFIG = "DEFUALT_LONGUSER_CONFIG";
	public static final Long ADMINISTRATOR_ID = new Long(0);
	public static final String ADMINISTRATOR_NAME = "administrator";
	public static String URL_CAS_USER_INFO = "";
	//sso获取到用户权限 和用户组
	public static Map<String, String> ALL_USER_MAP = new HashMap<String, String> ();
	public static Map<String, String> ALL_GROUP_MAP = new HashMap<String, String> ();
	
}

