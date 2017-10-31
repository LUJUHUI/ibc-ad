package com.wondertek.mobilevideo.gke.ad.core.service.impl;

import com.wondertek.mobilevideo.gke.ad.core.dao.AdAdDao;
import com.wondertek.mobilevideo.gke.ad.core.dao.AdAdMaterialDao;
import com.wondertek.mobilevideo.gke.ad.core.dao.AdMaterialDao;
import com.wondertek.mobilevideo.gke.ad.core.dao.GenericDao;
import com.wondertek.mobilevideo.gke.ad.core.model.AdAd;
import com.wondertek.mobilevideo.gke.ad.core.model.AdAdMaterial;
import com.wondertek.mobilevideo.gke.ad.core.model.AdMaterial;
import com.wondertek.mobilevideo.gke.ad.core.service.AdAdManager;
import com.wondertek.mobilevideo.gke.ad.core.service.AdAdMaterialManager;
import com.wondertek.mobilevideo.gke.ad.core.utils.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Transient;
import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AdAdMaterailManagerImpl extends  GenericManagerImpl<AdAdMaterial, Long> implements AdAdMaterialManager {

	@Autowired
	private AdAdMaterialDao adAdMaterialDao;
	@Autowired
	private AdMaterialDao adMaterialDao;
	
	@Autowired
	public AdAdMaterailManagerImpl(AdAdMaterialDao adAdMaterialDao) {
		super(adAdMaterialDao);
		this.adAdMaterialDao = adAdMaterialDao;
	}

	@Transactional
	public void save(Long adId, String[] materialIds,String userName) {
		for (String mId : materialIds) {
			AdMaterial adMaterial = adMaterialDao.get(Integer.parseInt(mId));
			save(new AdAdMaterial(new AdAd(adId), adMaterial, userName, userName));
			adMaterial.setStatus(AdMaterial.AdMaterialStatus.STATUS_105.getStatus());
			adMaterialDao.saveOrUpdate(adMaterial);
		}
	}
}
