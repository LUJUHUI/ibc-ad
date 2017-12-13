package com.wondertek.mobilevideo.gke.ad.core.service.impl;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.wondertek.mobilevideo.gke.ad.BcConstants;
import com.wondertek.mobilevideo.gke.ad.core.dao.AdLogDao;
import com.wondertek.mobilevideo.gke.ad.core.dao.AdSlotDao;
import com.wondertek.mobilevideo.gke.ad.core.model.AdLog;
import com.wondertek.mobilevideo.gke.ad.core.model.AdSlot;
import com.wondertek.mobilevideo.gke.ad.core.model.AdSoltLive;
import com.wondertek.mobilevideo.gke.ad.core.model.AdSoltPage;
import com.wondertek.mobilevideo.gke.ad.core.service.AdSlotManager;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
 
@Service
public class AdSlotManagerImpl extends  GenericManagerImpl<AdSlot,Integer> implements AdSlotManager {
    @Autowired
	private AdSlotDao adSlotDao;
    @Autowired
	private AdLogDao adLogDao;
    
	private final static Log log = LogFactory.getLog(AdSlotManagerImpl.class);
    
	@Autowired
	public AdSlotManagerImpl(AdSlotDao adSlotDao) {
		super(adSlotDao);
		this.adSlotDao = adSlotDao;
	}
    @Transactional
    public AdSlot save(AdSlot adSlot){
    	adSlotDao.save(adSlot);
    	return adSlot;
    }
    
    @Transactional
    public void saveOrUpdate(AdSlot adSlot){
    	adSlotDao.saveOrUpdate(adSlot);
    }
    
    @Transactional
	public void deleteSlot(String str,String updatePeople) {
		String[] strings = str.split(",");
		for (String slotId : strings) {
			AdSlot slot = adSlotDao.get(Integer.parseInt(slotId));
			slot.setStatus(AdSlot.AdSlotStatus.STATUS_105.get_status());
			slot.setUpdateTime(new Date());
			slot.setUpdatePeople(updatePeople);
			adSlotDao.saveOrUpdate(slot);
		}		
	}
    
    @Transactional
  	public void useSlot(String str,String updatePeople) {
  		String[] strings = str.split(",");
  		for (String slotId : strings) {
			AdSlot slot = adSlotDao.get(Integer.parseInt(slotId));
			slot.setStatus(AdSlot.AdSlotStatus.STATUS_101.get_status());
			slot.setUpdateTime(new Date());
			slot.setUpdatePeople(updatePeople);
			adSlotDao.saveOrUpdate(slot);
		}	
  	}

  	@Transactional
	public void verify(String ids, int type, String userName) throws RuntimeException {
		String[] id_ = ids.split(",");
		for (String id : id_) {
			AdSlot adSlot = adSlotDao.get(new Integer(id));
			if(adSlot.getStatus() == AdSlot.AdSlotStatus.STATUS_101.get_status()){
				AdLog adLog = new AdLog();
				if (0 == type) {
					adSlot.setStatus(AdSlot.AdSlotStatus.STATUS_102.get_status());
					adLog.setOperType(AdLog.adLogOperType.OPER_TYPE_301.getOperType());
				}else{
					adSlot.setStatus(AdSlot.AdSlotStatus.STATUS_104.get_status());
					adLog.setOperType(AdLog.adLogOperType.OPER_TYPE_302.getOperType());
				}
				adSlot.setUpdatePeople(userName);
				adSlot.setUpdateTime(new Date());
				adSlotDao.saveOrUpdate(adSlot);
				adLog.setOperName(userName);
				adLog.setLogType(AdLog.adLogType.AD_LOG_TYPE.getLogType());
				adLog.setOperResult("成功");
				adLog.setCreateTime(new Date());
				adLogDao.save(adLog);
			}else {
				throw new RuntimeException();
			}
		}
	}
  	//调用channelId接口，获取channelId
	public List<AdSoltPage>  getHomePageChannelId() {
		String responsexml = httpClientPost(BcConstants.HMOE_PAGE_CAHNNELID);
		log.debug("--首页频道列表--"+responsexml);
		ObjectMapper mapper = new ObjectMapper();
		List<AdSoltPage> list = new ArrayList<AdSoltPage>();
		JsonNode readTree = null;
		try {
			readTree = mapper.readTree(responsexml);
			if(null != readTree){
				if(readTree.get("resultCode").textValue().equals("0000")){
					JsonNode jsonObject = readTree.get("fixChannel");
					if(null != jsonObject && jsonObject.size()>0){
					  for (int i = 0; i < jsonObject.size(); i++) {
						  AdSoltPage adSoltPage = new AdSoltPage();
						  adSoltPage.setNodeId(jsonObject.get(i).get("nodeId").textValue());
						  adSoltPage.setName(jsonObject.get(i).get("name").textValue());
						  adSoltPage.setType(jsonObject.get(i).get("type").textValue());
						  adSoltPage.setTheme(jsonObject.get(i).get("theme").textValue());
						  adSoltPage.setRequestURL(jsonObject.get(i).get("requestURL").textValue());
						  adSoltPage.setImageURL(jsonObject.get(i).get("imageURL").textValue());
						  list.add(adSoltPage);
					  }
					}
					JsonNode jsonCommon = readTree.get("commonChannel");
					if(null != jsonCommon && jsonCommon.size()>0){
					  for (int i = 0; i < jsonCommon.size(); i++) {
						  AdSoltPage adSoltPage = new AdSoltPage();
						  adSoltPage.setNodeId(jsonCommon.get(i).get("nodeId").textValue());
						  adSoltPage.setName(jsonCommon.get(i).get("name").textValue());
						  adSoltPage.setType(jsonCommon.get(i).get("type").textValue());
						  adSoltPage.setTheme(jsonCommon.get(i).get("theme").textValue());
						  adSoltPage.setRequestURL(jsonCommon.get(i).get("requestURL").textValue());
						  adSoltPage.setImageURL(jsonCommon.get(i).get("imageURL").textValue());
						  list.add(adSoltPage);
					  }
					}
					
					JsonNode jsonOther = readTree.get("otherChannel");
					if(null != jsonOther && jsonOther.size()>0){
					  for (int i = 0; i < jsonOther.size(); i++) {
						  AdSoltPage adSoltPage = new AdSoltPage();
						  adSoltPage.setNodeId(jsonOther.get(i).get("nodeId").textValue());
						  adSoltPage.setName(jsonOther.get(i).get("name").textValue());
						  adSoltPage.setType(jsonOther.get(i).get("type").textValue());
						  adSoltPage.setTheme(jsonOther.get(i).get("theme").textValue());
						  adSoltPage.setRequestURL(jsonOther.get(i).get("requestURL").textValue());
						  adSoltPage.setImageURL(jsonOther.get(i).get("imageURL").textValue());
						  list.add(adSoltPage);
					  }
					}
				}
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return list;
	}
	//获取直播的频道ID
	public List<AdSoltLive>   getLiveChannelId( ) {
		List<AdSoltLive> list = new ArrayList<AdSoltLive>();
		String responsexml = httpClientPost(BcConstants.lIVE_CAHNNELID);
		log.debug("--直播频道列表--"+responsexml);
		ObjectMapper mapper = new ObjectMapper();
		JsonNode readTree = null;
		try {
			readTree = mapper.readTree(responsexml);
			if(null != readTree){
				if(readTree.get("resultCode").textValue().equals("0000")){
					JsonNode jsonObject = readTree.get("classifyList");
					if(null != jsonObject && jsonObject.size()>0){
						for (int i = 0; i < jsonObject.size(); i++) {
							AdSoltLive adSoltLive = new AdSoltLive();
							adSoltLive.setName(jsonObject.get(i).get("name").textValue());
							adSoltLive.setClassType(jsonObject.get(i).get("classType").textValue());
							adSoltLive.setRequestURL(jsonObject.get(i).get("requestURL").textValue());
							String[] nodeId = jsonObject.get(i).get("requestURL").textValue().split("nodeId=");
							adSoltLive.setNodeId(nodeId[1]);
							list.add(adSoltLive);
						}
					}
			   }
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
					
	public static String httpClientPost(String url) {
		HttpClient httpClient = new HttpClient();
		PostMethod postMethod = new PostMethod(url);
		String response="";
		try {
			postMethod.releaseConnection();
			httpClient.executeMethod(postMethod);
			response= postMethod.getResponseBodyAsString();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			postMethod.releaseConnection();
		}
		 return response;
	}
	 
}
