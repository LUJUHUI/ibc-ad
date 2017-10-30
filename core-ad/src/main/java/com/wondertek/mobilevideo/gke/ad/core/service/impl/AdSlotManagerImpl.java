package com.wondertek.mobilevideo.gke.ad.core.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import com.wondertek.mobilevideo.gke.ad.core.dao.AdLogDao;
import com.wondertek.mobilevideo.gke.ad.core.model.AdLog;
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
	private AdLogDao adLogDao;

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
	public void deleteSlot(String str,String updatePeople) {
		String[] strings = str.split(",");
		for (String slotId : strings) {
			AdSlot slot = adSlotDao.get(Integer.parseInt(slotId));
			slot.setStatus(AdSlot.AdSlotStatus.STATUS_105.get_status());
			slot.setUpdateTime(new Date());
			slot.setUpdatePeople(updatePeople);
			adSlotDao.saveOrUpdate(slot);
		}		
	}
    
    @Transactional
  	public void useSlot(String str,String updatePeople) {
  		String[] strings = str.split(",");
  		for (String slotId : strings) {
			AdSlot slot = adSlotDao.get(Integer.parseInt(slotId));
			slot.setStatus(AdSlot.AdSlotStatus.STATUS_101.get_status());
			slot.setUpdateTime(new Date());
			slot.setUpdatePeople(updatePeople);
			adSlotDao.saveOrUpdate(slot);
		}	
  	}

  	@Transactional
	public void verify(String ids, int type, String userName) throws RuntimeException {
		String[] id_ = ids.split(",");
		for (String id : id_) {
			AdSlot adSlot = adSlotDao.get(new Integer(id));
			if(adSlot.getStatus() == AdSlot.AdSlotStatus.STATUS_101.get_status()){
				AdLog adLog = new AdLog();
				if (0 == type) {
					adSlot.setStatus(AdSlot.AdSlotStatus.STATUS_102.get_status());
					adLog.setOperType(AdLog.adLogOperType.OPER_TYPE_301.getOperType());
				}else{
					adSlot.setStatus(AdSlot.AdSlotStatus.STATUS_104.get_status());
					adLog.setOperType(AdLog.adLogOperType.OPER_TYPE_302.getOperType());
				}
				adSlot.setUpdatePeople(userName);
				adSlot.setUpdateTime(new Date());
				adSlotDao.saveOrUpdate(adSlot);
				adLog.setOperName(userName);
				adLog.setOperResult("成功");
				adLog.setCreateTime(new Date());
				adLogDao.save(adLog);
			}else {
				throw new RuntimeException();
			}
		}
	}
}
