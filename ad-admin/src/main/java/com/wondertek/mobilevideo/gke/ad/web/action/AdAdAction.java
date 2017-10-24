package com.wondertek.mobilevideo.gke.ad.web.action;

import com.wondertek.mobilevideo.core.util.DateUtil;
import com.wondertek.mobilevideo.gke.ad.core.model.AdAd;
import com.wondertek.mobilevideo.gke.ad.core.model.AdAdMaterial;
import com.wondertek.mobilevideo.gke.ad.core.model.AdMaterial;
import com.wondertek.mobilevideo.gke.ad.core.model.AdSlot;
import com.wondertek.mobilevideo.gke.ad.core.service.AdAdManager;
import com.wondertek.mobilevideo.gke.ad.core.service.AdAdMaterialManager;
import com.wondertek.mobilevideo.gke.ad.core.service.AdMaterialManger;
import com.wondertek.mobilevideo.gke.ad.core.service.AdSlotManager;
import com.wondertek.mobilevideo.gke.ad.core.utils.PageList;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdAdAction extends BaseAction{

	@Autowired
	private AdAdManager adAdManagerImpl;
	@Autowired
	private AdSlotManager adSlotManagerImpl;
	@Autowired
	private AdMaterialManger adMaterialMangerImpl;
	@Autowired
	private AdAdMaterialManager adAdMaterialManagerImpl;
	
	
	private AdAd adAd;
	
	private Map<String, Object> params = new HashMap<String,Object>();
	
	public String getAd(){
		getParams();
		PageList pageList = new PageList();
		try {
			pageList =  adAdManagerImpl.getPageList(params,getPageNo(),getPageSize(),getSort(),getOrder());
		}catch (Exception e){
			e.printStackTrace();
		}
		resultMap.put("rows", pageList.getList());
		resultMap.put("records", pageList.getRecordCount());
		resultMap.put("pageCount", pageList.getPageCount());
		return SUCCESS;
	}

	public String getAdSlot() {
		List<AdSlot> adSlots = new ArrayList<>();
		try {
            params.put("status", "1");
			adSlots = adSlotManagerImpl.find(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		resultMap.put("root", adSlots);
		return SUCCESS;
	}

	public String getAdMaterial() {
		PageList pageList = new PageList();
		try {
            params.put("status", 102);
			pageList = adMaterialMangerImpl.getPageList(params, getPageNo(), getPageSize(), getSort(), getOrder());
		} catch (Exception e) {
			e.printStackTrace();
		}
		resultMap.put("rows", pageList.getList());
		resultMap.put("records", pageList.getRecordCount());
		resultMap.put("pageCount", pageList.getPageCount());
		return  SUCCESS;
	}

	public String save() {
		resultMap.put("success", true);
		try {
			String materialId = getRequest().getParameter("materialId");
			adAd.setStatus(StringUtils.isNotBlank(materialId) ? AdAd.AdadStatus.STATUS_102.getAdStatus():AdAd.AdadStatus.STATUS_102.getAdStatus());
			adAd.setCreateId(getUsername());
			adAd.setUpdateId(getUsername());
			adAdManagerImpl.save(adAd,materialId);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		return SUCCESS;
	}

	public String addAdMaterial() {
		resultMap.put("success",true);
		try {
			Long adId = Long.valueOf(getRequest().getParameter("adId"));
			String[] materialIds = getRequest().getParameter("materailIds").split(",");
			adAdMaterialManagerImpl.save(adId,materialIds,getUsername());
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success",false);
		}
		return SUCCESS;
	}

	/**
	 * 
	 * return code：101 删除成功，102，删除失败，投放中广告不能删除
	 * @return 
	 */
	public String deleteAd() {
		resultMap.put("success",true);
		try {
			String[] adId = getRequest().getParameter("id").split(",");
			try {
				adAdManagerImpl.remove(adId,getUsername());
				resultMap.put("code",101);
			} catch (RuntimeException e) {
				resultMap.put("code",102);
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success",false);
		}
		return SUCCESS;
	}
	
	private void getParams() {
		String startTime = getRequest().getParameter("startTime");
		if (StringUtils.isNotBlank(startTime)) {
			params.put("startTime_beginTime", DateUtil.parseDate(DateUtil.DATE_YYYY_MM_DD_PATTERN,startTime));
		}
		String endTime = getRequest().getParameter("endTime");
		if (StringUtils.isNotBlank(endTime)) {
			params.put("endTime_endTime", DateUtil.parseDate(DateUtil.DATE_YYYY_MM_DD_PATTERN,endTime));
		}
		String status = getRequest().getParameter("status");
		if (StringUtils.isNotBlank(status)) {
			params.put("status",Integer.parseInt(status));
		}
		String adName = getRequest().getParameter("adName");
		if (StringUtils.isNotBlank(adName)) {
			params.put("adName", adName);
		}
	}

	public AdAd getAdAd() {
		return adAd;
	}

	public void setAdAd(AdAd adAd) {
		this.adAd = adAd;
	}
}
