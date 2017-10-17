package com.wondertek.mobilevideo.gke.ad.web.action;

import com.wondertek.mobilevideo.gke.ad.core.service.AdAdManager;
import org.springframework.beans.factory.annotation.Autowired;

public class AdAdAction extends BaseAction{

	@Autowired
	private AdAdManager adAdManager;
	
	public String getAd(){
		resultMap.put("root", adAdManager.getAll());		
		return SUCCESS;
	}
	
}
