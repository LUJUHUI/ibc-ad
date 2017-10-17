package com.wondertek.mobilevideo.gke.ad.core.dao;


import java.util.List;
import java.util.Map;

import com.wondertek.mobilevideo.gke.ad.core.model.AdAd;
import com.wondertek.mobilevideo.gke.ad.core.model.AdSlot;
import com.wondertek.mobilevideo.gke.ad.core.model.AuthVerifyLog;
import com.wondertek.mobilevideo.gke.ad.core.utils.PageList;

public interface AdSlotDao extends GenericDao<AdSlot, Long>{
	public PageList listAdSlot(Map<String, Object> params, Integer pageNo, Integer pageSize, String sort, String order);
	public void deleteByAdId(Long logId);
	public void saveAdSlot(AdSlot adSlot);
	public void updateAdSlot(AdSlot adSlot);
	public AdSlot getAdSlotById(Long logId);
	
}
