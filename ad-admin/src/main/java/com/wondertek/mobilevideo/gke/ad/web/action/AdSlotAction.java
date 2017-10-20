package com.wondertek.mobilevideo.gke.ad.web.action;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.Preparable;
import com.wondertek.mobilevideo.core.util.StringUtil;
import com.wondertek.mobilevideo.gke.ad.core.model.AdSlot;
import com.wondertek.mobilevideo.gke.ad.core.service.AdLogManager;
import com.wondertek.mobilevideo.gke.ad.core.service.AdSlotManager;
import com.wondertek.mobilevideo.gke.ad.core.utils.PageList;

import jxl.write.DateFormat;


public class AdSlotAction extends BaseAction {

	@Autowired
	private AdSlotManager adSlotManagerImpl;
	@Autowired
	private AdLogManager  adLogManagerImpl;
	
	private Map<String,Object> params = new HashMap<String,Object>();
	private AdSlot adSlot;
	
	public String listAdSlots(){
		getParams();
		PageList pageList = new PageList();
		try {
			pageList =  adSlotManagerImpl.getPageList(params,getPageNo(),getPageSize(),getSort(),getOrder());
		}catch (Exception e){
			
		}
		resultMap.put("rows", pageList.getList());
		resultMap.put("records", pageList.getRecordCount());
		resultMap.put("pageCount", pageList.getPageCount());
		return SUCCESS;

	}

	public String listAdLogs(){
		getParams();
		PageList pageList = new PageList();
		try {
			pageList =  adLogManagerImpl.getPageList(params,getPageNo(),getPageSize(),getSort(),getOrder());
		}catch (Exception e){
			
		}
		resultMap.put("rows", pageList.getList());
		resultMap.put("records", pageList.getRecordCount());
		resultMap.put("pageCount", pageList.getPageCount());
		return SUCCESS;
	}
	public String addAdSlot() {
		try {
			adSlotManagerImpl.save(adSlot);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success",false);
		}
		return SUCCESS;
	}
	
	public String updateAdSlot() {
		try {
			adSlotManagerImpl.saveOrUpdate(adSlot);
			resultMap.put("success",true); 
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success",false);
		}
		return SUCCESS;
	}
	
	public String deleteAdSlot() {
		try {
			adSlotManagerImpl.saveOrUpdate(adSlot);
			resultMap.put("success",true); 
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success",false);
		}
		return SUCCESS;
	}
	
	/*********搜索需要参数**********/
    public void  getParams(){
        String slotName = getRequest().getParameter("slotName");
        if (StringUtils.isNotBlank(slotName)){
            params.put("slotName", slotName);
        }
        
        String navig = getRequest().getParameter("navig");
        if (StringUtils.isNotBlank(navig)){
            params.put("navig", Integer.parseInt(navig));
        }
        
        String type = getRequest().getParameter("type");
        if (StringUtils.isNotBlank(type)){
            params.put("type", Integer.parseInt(type));
        }
        
        String status = getRequest().getParameter("status");
        if (StringUtils.isNotBlank(status)){
            params.put("status", Integer.parseInt(status));
        }
        
        String startCreateTime = getRequest().getParameter("beginDate");
        if (StringUtils.isNotBlank(startCreateTime)){
            params.put("createTime_beginTime", tranDate(startCreateTime));
        }
        
        String endCreateTime = getRequest().getParameter("endDate");
        if (StringUtils.isNotBlank(endCreateTime)){
            params.put("createTime_endTime", tranDate(endCreateTime));
        }
        
        String logId = getRequest().getParameter("logId");
        if (StringUtils.isNotBlank(logId)){
            params.put("logId", Integer.parseInt(logId));
        }
        
        String operResult = getRequest().getParameter("operResult");
        if (StringUtils.isNotBlank(operResult)){
            params.put("operResult", operResult);
        }
        
        String operType = getRequest().getParameter("operType");
        if (StringUtils.isNotBlank(operType)){
            params.put("operType", Integer.parseInt(operType));
        }
    
    }
    public Date tranDate(String string){
    	Date date = null;
    	if(null != string && "" != string){
    	  try {
			date =  new SimpleDateFormat("yyyy-MM-dd").parse(string);
		} catch (ParseException e) {
			e.printStackTrace();
		}
    	}
    	return date;
    }
	public AdSlot getAdSlot() {
		return adSlot;
	}

	public void setAdSlot(AdSlot adSlot) {
		this.adSlot = adSlot;
	}

}
