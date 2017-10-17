package com.wondertek.mobilevideo.gke.ad.core.service.impl;

import com.wondertek.mobilevideo.gke.ad.core.dao.AdAdDao;
import com.wondertek.mobilevideo.gke.ad.core.dao.AdSlotDao;
import com.wondertek.mobilevideo.gke.ad.core.model.AdAd;
import com.wondertek.mobilevideo.gke.ad.core.model.AdSlot;
import com.wondertek.mobilevideo.gke.ad.core.service.AdAdManager;
import com.wondertek.mobilevideo.gke.ad.core.service.AdSlotManager;
import com.wondertek.mobilevideo.gke.ad.core.utils.PageList;

import java.util.Map;


public class AdAdManagerImpl extends  GenericManagerImpl<AdAd, Long> implements AdAdManager {
    
	private AdAdDao adAdDao;
	
	public AdAdManagerImpl(AdAdDao adAdDao) {
		super(adAdDao);
		this.adAdDao = adAdDao;
	}
	
 
}
