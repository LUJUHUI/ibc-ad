package com.wondertek.mobilevideo.gke.ad.core.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import com.wondertek.mobilevideo.gke.ad.core.dao.AdLogDao;
import com.wondertek.mobilevideo.gke.ad.core.model.AdLog;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wondertek.mobilevideo.gke.ad.core.dao.AdSlotDao;
import com.wondertek.mobilevideo.gke.ad.core.dao.impl.GenericDaoHibernate;
import com.wondertek.mobilevideo.gke.ad.core.model.AdSlot;
import com.wondertek.mobilevideo.gke.ad.core.model.AdSoltLive;
import com.wondertek.mobilevideo.gke.ad.core.model.AdSoltPage;
import com.wondertek.mobilevideo.gke.ad.core.service.AdSlotManager;
import com.wondertek.mobilevideo.gke.ad.core.utils.PageList;
import com.wondertek.mobilevideo.gke.ad.core.utils.XmlUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
 
@Service
public class AdSlotManagerImpl extends  GenericManagerImpl<AdSlot,Integer> implements AdSlotManager {
    @Autowired
	private AdSlotDao adSlotDao;
    @Autowired
	private AdLogDao adLogDao;
    
	private final static Log log = LogFactory.getLog(AdSlotManagerImpl.class);
    
    private String HMOE_PAGE_CAHNNELID = "http://m.cctv4g.com/cntv/resource/cltv2/channel.jsp?nodeId=844";
    private String lIVE_CAHNNELID = "http://m.cctv4g.com/cntv/resource/cltv2/liveClassify.jsp";
    
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
		String responsexml = httpClientPost(HMOE_PAGE_CAHNNELID);
		JSONObject	jsonObj_school = new JSONObject().fromObject(responsexml);//解析JSON字符串
		List<AdSoltPage> list = new ArrayList<AdSoltPage>();
		if(jsonObj_school.get("resultCode").equals("0000")){
			JSONArray jsonObject = jsonObj_school.getJSONArray("fixChannel");
			if(null != jsonObject){
			  for (int i = 0; i < jsonObject.size(); i++) {
				  AdSoltPage adSoltPage = new AdSoltPage();
				  adSoltPage.setNodeId(jsonObject.getJSONObject(i).get("nodeId").toString());
				  adSoltPage.setName(jsonObject.getJSONObject(i).get("name").toString());
				  adSoltPage.setType(jsonObject.getJSONObject(i).get("type").toString());
				  adSoltPage.setTheme(jsonObject.getJSONObject(i).get("theme").toString());
				  adSoltPage.setRequestURL(jsonObject.getJSONObject(i).get("requestURL").toString());
				  adSoltPage.setImageURL(jsonObject.getJSONObject(i).get("imageURL").toString());
				  list.add(adSoltPage);
			  }
			}
			JSONArray jsonCommon = jsonObj_school.getJSONArray("commonChannel");
			if(null != jsonCommon){
			  for (int i = 0; i < jsonCommon.size(); i++) {
				  AdSoltPage adSoltPage = new AdSoltPage();
				  adSoltPage.setNodeId(jsonCommon.getJSONObject(i).get("nodeId").toString());
				  adSoltPage.setName(jsonCommon.getJSONObject(i).get("name").toString());
				  adSoltPage.setType(jsonCommon.getJSONObject(i).get("type").toString());
				  adSoltPage.setTheme(jsonCommon.getJSONObject(i).get("theme").toString());
				  adSoltPage.setRequestURL(jsonCommon.getJSONObject(i).get("requestURL").toString());
				  adSoltPage.setImageURL(jsonCommon.getJSONObject(i).get("imageURL").toString());
				  list.add(adSoltPage);
			  }
			}
			
			JSONArray jsonOther = jsonObj_school.getJSONArray("otherChannel");
				if(null != jsonOther){
				  for (int i = 0; i < jsonOther.size(); i++) {
					  AdSoltPage adSoltPage = new AdSoltPage();
					  adSoltPage.setNodeId(jsonOther.getJSONObject(i).get("nodeId").toString());
					  adSoltPage.setName(jsonOther.getJSONObject(i).get("name").toString());
					  adSoltPage.setType(jsonOther.getJSONObject(i).get("type").toString());
					  adSoltPage.setTheme(jsonOther.getJSONObject(i).get("theme").toString());
					  adSoltPage.setRequestURL(jsonOther.getJSONObject(i).get("requestURL").toString());
					  adSoltPage.setImageURL(jsonOther.getJSONObject(i).get("imageURL").toString());
					  list.add(adSoltPage);
				  }
				}
		}
		return list;
	}
	//获取直播的频道ID
	public List<AdSoltLive>   getLiveChannelId( ) {
		List<AdSoltLive> list = new ArrayList<AdSoltLive>();
		String responsexml = httpClientPost(lIVE_CAHNNELID);
		JSONObject	jsonObj_school = new JSONObject().fromObject(responsexml);//解析JSON字符串
		if(jsonObj_school.get("resultCode").equals("0000")){
		JSONArray jsonObject = jsonObj_school.getJSONArray("classifyList");
		  for (int i = 0; i < jsonObject.size(); i++) {
			  AdSoltLive adSoltLive = new AdSoltLive();
			  adSoltLive.setName((String) jsonObject.getJSONObject(i).get("name").toString());
			  adSoltLive.setClassType(jsonObject.getJSONObject(i).get("classType").toString());
			  adSoltLive.setRequestURL(jsonObject.getJSONObject(i).get("requestURL").toString());
			  list.add(adSoltLive);
		  }
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
