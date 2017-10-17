package com.wondertek.mobilevideo.gke.ad.web.action;

import com.wondertek.mobilevideo.core.util.StringUtil;
import com.wondertek.mobilevideo.gke.ad.core.service.AdAdManager;
import com.wondertek.mobilevideo.gke.ad.core.utils.PageList;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.Map;

public class AdAdAction extends BaseAction{

	@Autowired
	private AdAdManager adAdManager;

	private Map<String, Object> params = new HashMap<String,Object>();
	
	public String getAd(){
		getParams();
		PageList pageList = new PageList();
		try {
			pageList =  adAdManager.getPageList(params,getPageNo(),getPageSize(),getSort(),getOrder());
		}catch (Exception e){
			
		}
		resultMap.put("rows", pageList.getList());
		resultMap.put("records", pageList.getRecordCount());
		resultMap.put("pageCount", pageList.getPageCount());

		return SUCCESS;
	}

	private void getParams() {
		String startTime = getRequest().getParameter("startTime");
		if (StringUtils.isNotBlank(startTime)) {
			params.put("startTime", startTime);
		}
		String endTime = getRequest().getParameter("endTime");
		if (StringUtils.isNotBlank(endTime)) {
			params.put("endTime", endTime);
		}
		String status = getRequest().getParameter("status");
		if (StringUtils.isNotBlank(status)) {
			params.put("status",status);
		}
		String adName = getRequest().getParameter("adName");
		if (StringUtils.isNotBlank(status)) {
			params.put("adName", adName);
		}
	}
	
}
