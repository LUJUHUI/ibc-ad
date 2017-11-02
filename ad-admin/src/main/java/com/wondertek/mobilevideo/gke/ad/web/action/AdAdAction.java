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
			List<Integer> status=new ArrayList<Integer>();
			status.add(AdSlot.AdSlotStatus.STATUS_102.get_status());
			status.add(AdSlot.AdSlotStatus.STATUS_103.get_status());
            params.put("status_in", status);
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

			List<Integer> statusList=new ArrayList<Integer>();
			statusList.add(AdMaterial.AdMaterialStatus.STATUS_104.getStatus());
			statusList.add(AdMaterial.AdMaterialStatus.STATUS_105.getStatus());
			params.put("status_in", statusList);
			pageList = adMaterialMangerImpl.getPageList(params, getPageNo(), getPageSize(), getSort(), getOrder());
		} catch (Exception e) {
			e.printStackTrace();
		}
		resultMap.put("root", pageList);
		return  SUCCESS;
	}

	public String getAdMaterialByPage() {
		PageList pageList = new PageList();
		try {
			getParams();
			String adId = getRequest().getParameter("adId");
			if (StringUtils.isNotBlank(adId)) {
				//获取已经关联的素材
				params.put("adId.id",Long.valueOf(getRequest().getParameter("adId")));
				List<AdAdMaterial> adAdMaterials = adAdMaterialManagerImpl.find(params);
				params.remove("adId.id");
				List<Integer> adMaterList=new ArrayList<Integer>();
				for (AdAdMaterial adAdMaterial : adAdMaterials) {
					adMaterList.add(adAdMaterial.getMaterialId().getId());
				}
				params.put("id_notIn", adMaterList);
			}

			List<Integer> statusList=new ArrayList<Integer>();
			statusList.add(AdMaterial.AdMaterialStatus.STATUS_104.getStatus());
			statusList.add(AdMaterial.AdMaterialStatus.STATUS_105.getStatus());
            params.put("status_in", statusList);
			pageList = adMaterialMangerImpl.getPageList(params, getPageNo(), getPageSize(), getSort(), getOrder());
		} catch (Exception e) {
			e.printStackTrace();
		}
		resultMap.put("rows", pageList.getList());
		resultMap.put("records", pageList.getRecordCount());
		resultMap.put("pageCount", pageList.getPageCount());
		return  SUCCESS;
	}

	/**
	 * code:101保存成功，102：保存失败，广告位在这段时间内已存在素材，103:保存失败，系统发生错误
	 * @return
	 */
	public String save() {
		resultMap.put("success", true);
		try {
			//保存广告之前要确保，关联的广告位置在同一时间没有重复的广告
			Map<String, Object> conditions = new HashMap<String, Object>();
			conditions.put("soltId", adAd.getSoltId());
			conditions.put("startTime", adAd.getStartTime());
			conditions.put("startTime", adAd.getEndTime());
			List<AdAd> adAds = adAdManagerImpl.find(conditions);
			if (adAds.isEmpty()) {
				String materialId = getRequest().getParameter("materialId");
				adAd.setStatus(StringUtils.isNotBlank(materialId) ? AdAd.AdadStatus.STATUS_102.getAdStatus() : AdAd.AdadStatus.STATUS_101.getAdStatus());
				adAd.setCreateId(getUsername());
				adAd.setUpdateId(getUsername());
				adAdManagerImpl.save(adAd, materialId);
				resultMap.put("code", 101);
			} else {
				resultMap.put("code", 102);
			} 
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success", false);
			resultMap.put("code", 103);
		}
		return SUCCESS;
	}

    /**
     * 关联素材
     * @return
     */
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
			params.put("startTime_beginTime", DateUtil.parseDate(DateUtil.DATE_TIME_PATTERN,startTime));
		}
		String endTime = getRequest().getParameter("endTime");
		if (StringUtils.isNotBlank(endTime)) {
			params.put("endTime_endTime", DateUtil.parseDate(DateUtil.DATE_TIME_PATTERN,endTime));  
		}
		String status = getRequest().getParameter("status");
		if (StringUtils.isNotBlank(status)) {
			params.put("status",Integer.parseInt(status));
		}
		String adName = getRequest().getParameter("adName");
		if (StringUtils.isNotBlank(adName)) {
			params.put("adName", adName);
		}
		String createTime = getRequest().getParameter("createTime");
		if (StringUtils.isNotBlank(createTime)) {
			params.put("createTime_beginTime", DateUtil.parseDate(DateUtil.DATE_TIME_PATTERN,createTime));
		}
		String createTimeEnd = getRequest().getParameter("createTime_end");
		if (StringUtils.isNotBlank(createTimeEnd)) {
			params.put("createTime_endTime", DateUtil.parseDate(DateUtil.DATE_TIME_PATTERN,createTimeEnd));
		}
		String materialName = getRequest().getParameter("materialName");
		if (StringUtils.isNotBlank(materialName)) {
			params.put("materialName",materialName);
		}
		String type = getRequest().getParameter("type");
		if (StringUtils.isNotBlank(type)) {
			params.put("type",Integer.parseInt(type));
		}
	}

	public AdAd getAdAd() {
		return adAd;
	}

	public void setAdAd(AdAd adAd) {
		this.adAd = adAd;
	}
}
