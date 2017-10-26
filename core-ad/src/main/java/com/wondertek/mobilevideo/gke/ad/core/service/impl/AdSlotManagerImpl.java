package com.wondertek.mobilevideo.gke.ad.core.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wondertek.mobilevideo.gke.ad.core.dao.AdSlotDao;
import com.wondertek.mobilevideo.gke.ad.core.dao.impl.GenericDaoHibernate;
import com.wondertek.mobilevideo.gke.ad.core.model.AdSlot;
import com.wondertek.mobilevideo.gke.ad.core.service.AdSlotManager;
import com.wondertek.mobilevideo.gke.ad.core.utils.PageList;
 
@Service
public class AdSlotManagerImpl extends  GenericManagerImpl<AdSlot,Integer> implements AdSlotManager {
    @Autowired
	private AdSlotDao adSlotDao;
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
	public void deleteSlot(String str) {
		String[] strings = str.split(",");
		for (String slotId : strings) {
			AdSlot slot = adSlotDao.get(Integer.parseInt(slotId));
			slot.setStatus(AdSlot.AdSlotStatus.STATUS_105.get_status());
			slot.setUpdateTime(new Date());
			adSlotDao.saveOrUpdate(slot);
		}		
	}
    
    @Transactional
  	public void useSlot(String str) {
  		String[] strings = str.split(",");
  		for (String slotId : strings) {
			AdSlot slot = adSlotDao.get(Integer.parseInt(slotId));
			slot.setStatus(AdSlot.AdSlotStatus.STATUS_101.get_status());
			slot.setUpdateTime(new Date());
			adSlotDao.saveOrUpdate(slot);
		}	
  	}
}
