package com.wondertek.mobilevideo.gke.ad.core.service.impl;

import com.wondertek.mobilevideo.gke.ad.core.dao.AdMaterialPicDao;
import com.wondertek.mobilevideo.gke.ad.core.model.AdMaterialPic;
import com.wondertek.mobilevideo.gke.ad.core.service.AdMaterialPicManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdMaterialPicManagerImpl extends GenericManagerImpl<AdMaterialPic, Long> implements AdMaterialPicManager {
	@Autowired
	private AdMaterialPicDao adMaterialPicDao;

    @Autowired
	public AdMaterialPicManagerImpl(AdMaterialPicDao adMaterialPicDao) {
		super(adMaterialPicDao);
		this.adMaterialPicDao = adMaterialPicDao;
	}


}