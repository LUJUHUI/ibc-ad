package com.wondertek.mobilevideo.gke.ad.web.job;

import com.wondertek.mobilevideo.gke.ad.core.model.AdAd;
import com.wondertek.mobilevideo.gke.ad.core.model.AdAdMaterial;
import com.wondertek.mobilevideo.gke.ad.core.model.AdMaterial;
import com.wondertek.mobilevideo.gke.ad.core.model.AdSlot;
import com.wondertek.mobilevideo.gke.ad.core.service.AdAdManager;
import com.wondertek.mobilevideo.gke.ad.core.service.AdAdMaterialManager;
import com.wondertek.mobilevideo.gke.ad.core.service.AdMaterialManger;
import com.wondertek.mobilevideo.gke.ad.core.service.AdSlotManager;
import com.wondertek.mobilevideo.gke.ad.core.utils.RedisService;
import com.wondertek.mobilevideo.gke.ad.core.utils.impl.RedisServiceImpl;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
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
    @Autowired
	private AdSlotManager adSlotManagerImpl;
    @Autowired
  	private AdAdMaterialManager  AdAdMaterialManagerImpl;
    @Autowired
   	private AdMaterialManger  AdMaterialManagerImpl;
    @Autowired
    private RedisServiceImpl redisServiceImpl;
	public void execute(){
		log.debug("Method ChangeAdAdStatusJob execute  started");
		try{
			//将投放中的广告修改为投放完成
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("endTime_startTime",new Date());
			param.put("status", AdAd.AdadStatus.STATUS_103.getAdStatus());
			List<AdAd> adList = adAdManagerImpl.find(param);
			if(null != adList && adList.size()>0){
			for (AdAd adAd : adList) {
				adAd.setStatus(AdAd.AdadStatus.STATUS_104.getAdStatus());
				adAdManagerImpl.saveOrUpdate(adAd);
				//根据广告Id查找所有广告位
				Map<String,Object> slotParam = new HashMap<String,Object>();
				slotParam.put("id", adAd.getSoltId().intValue());
				List<AdSlot> allAdSlot = adSlotManagerImpl.find(slotParam);
				//将广告位封装进map
				for (AdSlot adSlot : allAdSlot) {
					String slotStr = "";
				    if(adSlot.getType() == AdSlot.AdSlotType.TYPE_301.get_type()){
				    	slotStr = "start";
					}else if(adSlot.getType() == AdSlot.AdSlotType.TYPE_302.get_type()){
						if(adSlot.getNavig() == AdSlot.AdSlotNavig.NAVIG_201.get_navig()){
							slotStr = "home_"+adSlot.getChannelId();
						}else if(adSlot.getNavig() == AdSlot.AdSlotNavig.NAVIG_202.get_navig()){
							slotStr = "live_"+adSlot.getChannelId();
						}else if(adSlot.getNavig() == AdSlot.AdSlotNavig.NAVIG_203.get_navig()){
							slotStr = "vip";
						}
					}else if(adSlot.getType() == AdSlot.AdSlotType.TYPE_303.get_type()){
						if(adSlot.getNavig() == AdSlot.AdSlotNavig.NAVIG_201.get_navig()){
							slotStr = "home";
						}else if(adSlot.getNavig() == AdSlot.AdSlotNavig.NAVIG_202.get_navig()){
							slotStr = "live";
						}else if(adSlot.getNavig() == AdSlot.AdSlotNavig.NAVIG_203.get_navig()){
							slotStr = "vip";
						}
					}
				    log.debug(" detele redis adSlot start"+slotStr);
				    redisServiceImpl.delContentMapField(slotStr);
				    log.debug(" detele redis adSlot end");
				}
			}
			}	
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
				//将广告信息放入到Map中
				Map<String,Object> adAdMap = new HashMap<String,Object>();
				adAdMap.put("id", adAd.getId());
				adAdMap.put("adName", adAd.getAdName());
				adAdMap.put("remark", adAd.getRemark());
				//根据广告Id查找所有广告素材
				Map<String,Object> AdAdMaterialParam = new HashMap<String,Object>();
				AdAdMaterialParam.put("adId.id", adAd.getId());
				List<AdAdMaterial> allAdAdMaterial = AdAdMaterialManagerImpl.find(AdAdMaterialParam);
				List<Map<String,Object>> adMaterialMap = new  ArrayList();
				//将广告素材放入map中
				if(null != allAdAdMaterial && allAdAdMaterial.size()>0 ){
					for (AdAdMaterial adAdMaterial : allAdAdMaterial) {
						Map<String,Object> AdMaterialParam = new HashMap<String,Object>();
						AdMaterialParam.put("id", adAdMaterial.getMaterialId().getId());
						List<AdMaterial> allAdMaterial = AdMaterialManagerImpl.find(AdMaterialParam);
						for (AdMaterial adMaterial : allAdMaterial) {
							Map<String,Object> adMap = new HashMap<String,Object>();
							adMap.put("id", adMaterial.getId());
							adMap.put("materialName", adMaterial.getMaterialName());
							adMap.put("type", adMaterial.getType());
							adMap.put("clickHref", adMaterial.getClickHref());
							adMaterialMap.add(adMap);
						}
					}
				}
				//根据广告Id查找所有广告位
				Map<String,Object> slotParam = new HashMap<String,Object>();
				slotParam.put("id", adAd.getSoltId().intValue());
				List<AdSlot> allAdSlot = adSlotManagerImpl.find(slotParam);
				//将广告位封装进map
				for (AdSlot adSlot : allAdSlot) {
						Map<String,Object> allSlotInfo  = new HashMap<String,Object>();
						allSlotInfo.put("id", adSlot.getId());
						allSlotInfo.put("slotName", adSlot.getSlotName());
						allSlotInfo.put("height", adSlot.getHeight());
						allSlotInfo.put("remark", adSlot.getRemark());
						allSlotInfo.put("adAd", adAdMap);
						allSlotInfo.put("adMaterial",adMaterialMap);
				    String adSlotStr = "";
				    if(adSlot.getType() == AdSlot.AdSlotType.TYPE_301.get_type()){
				    		adSlotStr = "start";
					}else if(adSlot.getType() == AdSlot.AdSlotType.TYPE_302.get_type()){
						if(adSlot.getNavig() == AdSlot.AdSlotNavig.NAVIG_201.get_navig()){
							adSlotStr = "home_"+adSlot.getChannelId();
						}else if(adSlot.getNavig() == AdSlot.AdSlotNavig.NAVIG_202.get_navig()){
							adSlotStr = "live_"+adSlot.getChannelId();
						}else if(adSlot.getNavig() == AdSlot.AdSlotNavig.NAVIG_203.get_navig()){
							adSlotStr = "vip";
						}
					}else if(adSlot.getType() == AdSlot.AdSlotType.TYPE_303.get_type()){
						if(adSlot.getNavig() == AdSlot.AdSlotNavig.NAVIG_201.get_navig()){
							adSlotStr = "home";
						}else if(adSlot.getNavig() == AdSlot.AdSlotNavig.NAVIG_202.get_navig()){
							adSlotStr = "live";
						}else if(adSlot.getNavig() == AdSlot.AdSlotNavig.NAVIG_203.get_navig()){
							adSlotStr = "vip";
						}
					}
				    JSONObject jsonObject = JSONObject.fromObject(allSlotInfo);
				    log.debug("put adsolt in redis start----"+jsonObject.toString());
				    redisServiceImpl.setContentMap(adSlotStr, jsonObject.toString());
				    log.debug("put adsolt in redis end");
				}
			}
		}
		}catch (Exception e) {
			log.error(e.getMessage(),e);
		}  
			log.debug("Method ChangeAdAdStatusJob execute  end");
	}
 
}
