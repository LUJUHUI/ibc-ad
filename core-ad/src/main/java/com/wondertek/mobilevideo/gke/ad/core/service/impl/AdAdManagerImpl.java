package com.wondertek.mobilevideo.gke.ad.core.service.impl;

import com.wondertek.mobilevideo.gke.ad.core.dao.AdAdDao;
import com.wondertek.mobilevideo.gke.ad.core.dao.AdAdMaterialDao;
import com.wondertek.mobilevideo.gke.ad.core.dao.AdMaterialDao;
import com.wondertek.mobilevideo.gke.ad.core.model.AdAd;
import com.wondertek.mobilevideo.gke.ad.core.model.AdAdMaterial;
import com.wondertek.mobilevideo.gke.ad.core.model.AdMaterial;
import com.wondertek.mobilevideo.gke.ad.core.service.AdAdManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Date;

@Service
public class AdAdManagerImpl extends  GenericManagerImpl<AdAd, Long> implements AdAdManager {
    
	@Autowired
	private AdAdDao adAdDao;
	@Autowired
	private AdAdMaterialDao adAdMaterialDao;
	@Autowired
	private AdMaterialDao adMaterialDao;
	
	
	@Autowired
	public AdAdManagerImpl(AdAdDao adAdDao) {
		super(adAdDao);
		this.adAdDao = adAdDao;
	}


	@Transactional
	public AdAd save(AdAd object, String materialId) {
        Date date = new Date();
        object.setCreateTime(date);
        object.setUpdateTime(date);
        
        object = adAdDao.save(object);
		String[] materialIds = materialId.split(",");
		for (String id : materialIds) {

			AdMaterial adMaterial = adMaterialDao.get(Integer.parseInt(id));
			
			AdAdMaterial adAdMaterial = new AdAdMaterial();
			adAdMaterial.setAdId(object);
			adAdMaterial.setMaterialId(adMaterial);
			adAdMaterial.setCreateId(object.getCreateId());
			adAdMaterial.setUpdateId(object.getUpdateId());
			adAdMaterial.setCreateTime(date);
			adAdMaterial.setUpdateTime(date);
			adAdMaterialDao.save(adAdMaterial);
			
			if (adMaterial.getStatus() != AdMaterial.AdMaterialStatus.STATUS_105.getStatus()) {
				//修改素材状态为使用中
				adMaterial.setStatus(AdMaterial.AdMaterialStatus.STATUS_105.getStatus());
				adMaterial.setUpdateTime(date);
				adMaterial.setUpdatePerson(object.getCreateId());
				adMaterialDao.saveOrUpdate(adMaterial);
			}
			
		}
		return object;
	}

	@Transactional
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
