package com.wondertek.mobilevideo.gke.ad.web.listener;

import com.wondertek.mobilevideo.core.util.Configuration;
import com.wondertek.mobilevideo.gke.ad.web.WebConstants;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Created by 张诚 on 2017/6/7.
 */
public class StartUpListener implements ServletContextListener{
	
	private static final Log log = LogFactory.getLog(StartUpListener.class);
	
    public void contextInitialized(ServletContextEvent servletContextEvent) {
    	log.debug("Initializing context...");
		ServletContext context = servletContextEvent.getServletContext();
    	ApplicationContext ctx = WebApplicationContextUtils.getRequiredWebApplicationContext(context);
    	String[] beanDefinitionNames = ctx.getBeanDefinitionNames();
    	for (String string : beanDefinitionNames) {
    		log.info("====" + string);
		}
		//初始化项目路径
		WebConstants.APP_BASE_PATH = context.getRealPath("/");

		//WebConstants.config = new Configuration("/config.properties");
		//WebConstants.MOBILE_PLAT_NOTICE_PUBLISH_SERVICE_URL = WebConstants.config.getProperty("mobile.plat.notice.publish.service");
		

	}

   
    
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
