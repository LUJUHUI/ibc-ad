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
}
