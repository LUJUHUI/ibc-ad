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
import com.wondertek.mobilevideo.core.util.DateUtil;
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
			pageList =  adSlotManagerImpl.getPageList(params,getPageNo(),getPageSize(),getOrder(),getSort());
		}catch (Exception e){
			e.printStackTrace();
			resultMap.put("success",false);
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
			pageList =  adLogManagerImpl.getPageList(params,getPageNo(),getPageSize(),getOrder(),getSort());
		}catch (Exception e){
			e.printStackTrace();
			resultMap.put("success",false);
		}
		resultMap.put("rows", pageList.getList());
		resultMap.put("records", pageList.getRecordCount());
		resultMap.put("pageCount", pageList.getPageCount());
		return SUCCESS;
	}
	
	public String addAdSlot() {
		try {
			adSlot.setStatus(AdSlot.AdSlotStatus.STATUS_101.get_status());
			adSlot.setCreateTime(new Date());
			adSlot.setCreatePeople(getUsername());
			adSlot.setUpdatePeople(getUsername());
			adSlot.setUpdateTime(new Date());
			adSlotManagerImpl.save(adSlot);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success",false);
		}
		return SUCCESS;
	}
	
	public String updateAdSlot() {
		try {
			adSlot.setUpdatePeople(getUsername());
			adSlot.setUpdateTime(new Date());
			adSlot.setStatus(AdSlot.AdSlotStatus.STATUS_101.get_status());
			adSlotManagerImpl.saveOrUpdate(adSlot);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success",false);
		}
		return SUCCESS;
	}
	
	public String deleteAdSlot() {
		try {
		String  str =getRequest().getParameter("deleteIds");
		adSlotManagerImpl.deleteSlot(str,getUsername());
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success",false);
		}
		return SUCCESS;
	}
	
	public String useAdSlot() {
		try {
		String  str =getRequest().getParameter("useIds");
		adSlotManagerImpl.useSlot(str,getUsername());
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success",false);
		}
		return SUCCESS;
	}
	//审核
	public String verify() {
		resultMap.put("success", true);
		try {
			String slotId = getRequest().getParameter("ids");
			String verifyType = getRequest().getParameter("type");//0:通过，1：驳回
			try {
				adSlotManagerImpl.verify(slotId, Integer.parseInt(verifyType),getUsername());
				resultMap.put("code", 101);
			} catch (RuntimeException e2) {
				e2.printStackTrace();
				resultMap.put("code", 102);
			}
		} catch (Exception e) {
			resultMap.put("success", false);
			e.printStackTrace();
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
            params.put("status",Integer.parseInt(status));
        }
        
        String startCreateTime = getRequest().getParameter("startDate");
        if (StringUtils.isNotBlank(startCreateTime)){
            params.put("createTime_beginTime", DateUtil.parseDate(DateUtil.DATE_TIME_PATTERN,startCreateTime));
        }
        
        String endCreateTime = getRequest().getParameter("endDate");
        if (StringUtils.isNotBlank(endCreateTime)){
            params.put("createTime_endTime", DateUtil.parseDate(DateUtil.DATE_TIME_PATTERN,endCreateTime));
        }
        
        String logId = getRequest().getParameter("logId");
        if (StringUtils.isNotBlank(logId)){
            params.put("id", Integer.parseInt(logId));
        }
        
        String operResult = getRequest().getParameter("operResult");
        if (StringUtils.isNotBlank(operResult)){
            params.put("operResult", operResult);
        }
        
        String operType = getRequest().getParameter("operType");
        if (StringUtils.isNotBlank(operType)){
            params.put("operType", Integer.parseInt(operType));
        }
        
        String logType = getRequest().getParameter("logType");
        if (StringUtils.isNotBlank(logType)){
            params.put("logType", Integer.parseInt(logType));
        }
        
		String status_notIn = getRequest().getParameter("status_not");
		if (StringUtils.isNotBlank(status_notIn)) {
			List<Integer> list = new ArrayList<Integer>();
			list.add(new Integer(status_notIn));
			params.put("status_notIn",list);
		}
    }
    
	public AdSlot getAdSlot() {
		return adSlot;
	}

	public void setAdSlot(AdSlot adSlot) {
		this.adSlot = adSlot;
	}

}
