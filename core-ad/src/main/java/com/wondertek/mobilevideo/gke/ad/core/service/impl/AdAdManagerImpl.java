package com.wondertek.mobilevideo.gke.ad.core.service.impl;

import com.wondertek.mobilevideo.gke.ad.core.dao.AdAdDao;
import com.wondertek.mobilevideo.gke.ad.core.dao.AdAdMaterialDao;
import com.wondertek.mobilevideo.gke.ad.core.model.AdAd;
import com.wondertek.mobilevideo.gke.ad.core.model.AdAdMaterial;
import com.wondertek.mobilevideo.gke.ad.core.model.AdMaterial;
import com.wondertek.mobilevideo.gke.ad.core.service.AdAdManager;
import com.wondertek.mobilevideo.gke.ad.core.utils.PageList;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.Transient;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class AdAdManagerImpl extends  GenericManagerImpl<AdAd, Long> implements AdAdManager {
    
	@Autowired
	private AdAdDao adAdDao;
	@Autowired
	private AdAdMaterialDao adAdMaterialDao;
	
	
	@Autowired
	public AdAdManagerImpl(AdAdDao adAdDao) {
		super(adAdDao);
		this.adAdDao = adAdDao;
	}


	@Transient
	public AdAd save(AdAd object, String materialId) {
        Date date = new Date();
        object.setCreateTime(date);
        object.setUpdateTime(date);
        object = adAdDao.save(object);
        if (StringUtils.isNotBlank(materialId)) {
            AdAdMaterial adAdMaterial = new AdAdMaterial();
            adAdMaterial.setAdId(object);
            adAdMaterial.setMaterialId(new AdMaterial(Integer.parseInt(materialId)));
            adAdMaterial.setCreateId(object.getCreateId());
            adAdMaterial.setUpdateId(object.getUpdateId());
            adAdMaterial.setCreateTime(date);
            adAdMaterial.setUpdateTime(date);
            adAdMaterialDao.save(adAdMaterial);
        }
		return object;
	}

	@Transient
	public void remove(String[] ids, String userName) throws Exception {
		for (String id: ids) {
			AdAd adAd = adAdDao.get(Long.valueOf(id));
			if (AdAd.AdadStatus.STATUS_103.getAdStatus() != adAd.getStatus()) {
				adAd.setStatus(AdAd.AdadStatus.STATUS_105.getAdStatus());
				adAd.setUpdateTime(new Date());
				adAdDao.saveOrUpdate(adAd);
			}else{
				throw new RuntimeException();
			}
		}
	}
}
