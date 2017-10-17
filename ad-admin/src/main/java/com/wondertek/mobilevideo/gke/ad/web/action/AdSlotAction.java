package com.wondertek.mobilevideo.gke.ad.web.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.opensymphony.xwork2.Preparable;
import com.wondertek.mobilevideo.core.util.StringUtil;
import com.wondertek.mobilevideo.gke.ad.core.model.AdSlot;
import com.wondertek.mobilevideo.gke.ad.core.service.AdSlotManager;


public class AdSlotAction extends BaseAction {
	private Map<String,Object> params = new HashMap<String,Object>();
	private AdSlotManager adSlotManager;
	private int start;
	private int limit;
	private AdSlot adSlot;
	
	public String listAdSlots(){
		getParams();
		List returnList =  adSlotManager.getPageList(params,getPageNo(), getPageSize(),getOrder(),getOrder());
		resultMap.put("root", returnList);
		resultMap.put("success", true);
		return SUCCESS;
	}
	
	public String listAdLogs(){
		getParams();
		List returnList =  adSlotManager.getPageList(params,getPageNo(), getPageSize(),getOrder(),getOrder());
		resultMap.put("root", returnList);
		resultMap.put("success", true);
		return SUCCESS;
	}
	public String addAdSlot() {
		try {
			adSlotManager.save(adSlot);
			resultMap.put("success",true); 
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success",false);
		}
		return SUCCESS;
	}
	
	public String updateAdSlot() {
		try {
			adSlotManager.saveOrUpdate(adSlot);
			resultMap.put("success",true); 
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success",false);
		}
		return SUCCESS;
	}
	
	public String delateAdSlot() {
		try {
			adSlotManager.saveOrUpdate(adSlot);
			resultMap.put("success",true); 
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success",false);
		}
		return SUCCESS;
	}
	
	/*********搜索需要参数**********/
    public Map<String,String> getParams(){
        Map<String,String> params = new HashMap<String,String>();
        String slotName = getRequest().getParameter("slotName");
        if (StringUtils.isNotBlank(slotName)){
            params.put("slotName", slotName);
        }
        
        String navig = getRequest().getParameter("navig");
        if (StringUtils.isNotBlank(navig)){
            params.put("navig", navig);
        }
        
        String type = getRequest().getParameter("type");
        if (StringUtils.isNotBlank(type)){
            params.put("type", type);
        }
        
        String status = getRequest().getParameter("status");
        if (StringUtils.isNotBlank(status)){
            params.put("status", status);
        }
        
        String startCreateTime = getRequest().getParameter("beginDate");
        if (StringUtils.isNotBlank(startCreateTime)){
            params.put("startCreateTime", startCreateTime);
        }
        
        String endCreateTime = getRequest().getParameter("endDate");
        if (StringUtils.isNotBlank(endCreateTime)){
            params.put("endCreateTime", endCreateTime);
        }
        
        return params;
    }

	public int getPageNo() {
		try {
			int pageNo = Integer.valueOf(getRequest().getParameter("pageNum"));
			if (pageNo == 0) {
				return 1;
			}
			return Integer.valueOf(getRequest().getParameter("pageNum"));
		} catch (Exception e) {
		}
		return 1;
	}

	public int getPageSize() {
		try {
			return Integer.valueOf(getRequest().getParameter("pageSize"));
		} catch (Exception e) {
		}
		return 10;
	}

	public String getOrder() {
		String order = getRequest().getParameter("order");
		if (StringUtils.isBlank(order)) {
			order = getRequest().getParameter("sord");
		}
		return order;
	}

	public String getSort() {
		String sort = getRequest().getParameter("sort");
		if (StringUtils.isBlank(sort)) {
			sort = getRequest().getParameter("sidx");                                                                                                                                                                                                                                                             
		}
		return sort;                                                                                                      
	}
	
	public AdSlotManager getAdSlotManager() {
		return adSlotManager;
	}

	public void setAdSlotManager(AdSlotManager adSlotManager) {
		this.adSlotManager = adSlotManager;
	}

	public AdSlot getAdSlot() {
		return adSlot;
	}

	public void setAdSlot(AdSlot adSlot) {
		this.adSlot = adSlot;
	}

	public void pageUtil(){
		int pageSize = (int) limit;
		//计算当前是第几页
		int pageNo = 1;
		if(start > 1){
			pageNo = start / pageSize+1;
		}
		params.put("pageNo",pageNo);
	}
	
	
}
