package com.wondertek.mobilevideo.gke.ad.core.service.impl;

import com.wondertek.mobilevideo.gke.ad.core.dao.AdAdDao;
import com.wondertek.mobilevideo.gke.ad.core.model.AdAd;
import com.wondertek.mobilevideo.gke.ad.core.service.AdAdManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class AdAdManagerImpl extends GenericManagerImpl<AdAd,Long> implements AdAdManager {
    
	private AdAdDao adAdDao;

	@Autowired
	public AdAdManagerImpl(AdAdDao adAdDao) {
		super(adAdDao);
		this.adAdDao = adAdDao;
	}
}
