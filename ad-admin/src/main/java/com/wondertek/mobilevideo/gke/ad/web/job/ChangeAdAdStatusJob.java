package com.wondertek.mobilevideo.gke.ad.web.job;

import com.wondertek.mobilevideo.gke.ad.core.model.AdAd;
import com.wondertek.mobilevideo.gke.ad.core.service.AdAdManager;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/6/15.
 */
@Component
public class ChangeAdAdStatusJob {
	
    private Log log = LogFactory.getLog(ChangeAdAdStatusJob.class);
    
    @Autowired
	private AdAdManager adAdManagerImpl;
    
	public void excute(){
		log.debug("Method ChangeAdAdStatusJob execute  started");
		try{
		//将待投放的广告修改为投放中
	    Map<String,Object> params = new HashMap<String,Object>();
		params.put("startTime_startTime",new Date());
		params.put("endTime_lastTime",new Date());
		params.put("status", AdAd.AdadStatus.STATUS_102.getAdStatus());
		List<AdAd> adRedayList = adAdManagerImpl.find(params);
		if(null != adRedayList && adRedayList.size()>0){
		for (AdAd adAd : adRedayList) {
			adAd.setStatus(AdAd.AdadStatus.STATUS_103.getAdStatus());
			adAdManagerImpl.saveOrUpdate(adAd);
		}
		}
		//将投放中的广告修改为投放完成
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("endTime_startTime",new Date());
		param.put("status", AdAd.AdadStatus.STATUS_103.getAdStatus());
		List<AdAd> adList = adAdManagerImpl.find(param);
		if(null != adList && adList.size()>0){
		for (AdAd adAd : adList) {
			adAd.setStatus(AdAd.AdadStatus.STATUS_104.getAdStatus());
			adAdManagerImpl.saveOrUpdate(adAd);
		}
		}
		}catch (Exception e) {
			log.error(e.getMessage(),e);
		} finally {
			log.debug("Method ChangeAdAdStatusJob execute  end");
		}
	}
 
}
