package com.wondertek.mobilevideo.gke.ad.core.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.wondertek.mobilevideo.gke.ad.core.dao.AdSlotDao;
import com.wondertek.mobilevideo.gke.ad.core.dao.impl.GenericDaoHibernate;
import com.wondertek.mobilevideo.gke.ad.core.model.AdSlot;
import com.wondertek.mobilevideo.gke.ad.core.service.AdSlotManager;
import com.wondertek.mobilevideo.gke.ad.core.utils.PageList;
 

public class AdSlotManagerImpl extends  GenericManagerImpl<AdSlot, Long> implements AdSlotManager {
    
	private AdSlotDao adSlotDao;
	
	public AdSlotManagerImpl(AdSlotDao adSlotDao) {
		super(adSlotDao);
		this.adSlotDao = adSlotDao;
	}
	public void deleteByAdId(Long logId) {
		adSlotDao.deleteByAdId(logId);
	}
	public void saveAdSlot(AdSlot adSlot) {
		adSlotDao.save(adSlot);
	}
	public void updateAdSlot(AdSlot adSlot) {
		adSlotDao.updateAdSlot(adSlot);
	}
	public AdSlot getAdSlotById(Long logId) {
		// TODO Auto-generated method stub
		return adSlotDao.getAdSlotById(logId);       
	}
	public PageList listAdSlot(Map<String, Object> params, Integer pageNo, Integer pageSize, String sort,
			String order) {
		 
		return adSlotDao.listAdSlot(params, pageNo, pageSize, sort, order);
	}
 
}
