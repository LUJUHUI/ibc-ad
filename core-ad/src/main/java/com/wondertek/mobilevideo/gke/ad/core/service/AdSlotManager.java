package com.wondertek.mobilevideo.gke.ad.core.service;

import java.util.List;
import java.util.Map;

import com.wondertek.mobilevideo.gke.ad.core.model.AdSlot;
import com.wondertek.mobilevideo.gke.ad.core.utils.PageList;
 

public interface AdSlotManager  extends GenericManager<AdSlot, Long>{

	/**
	 * 获取广告位
	 * @param params
	 * @return
	 */
	/**
	 * 按页获取列表
	 * @param params
	 * @param start
	 * @param limit
	 * @return
	 * 
	 */
	public PageList listAdSlot(Map<String, Object> params, Integer pageNo, Integer pageSize, String sort, String order);
	public void deleteByAdId(Long logId);
	public void saveAdSlot(AdSlot adSlot);
	public void updateAdSlot(AdSlot adSlot);
	public AdSlot getAdSlotById(Long logId);
 
}
