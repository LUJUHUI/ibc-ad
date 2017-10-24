package com.wondertek.mobilevideo.gke.ad.core.dao.impl;

import com.wondertek.mobilevideo.gke.ad.core.dao.AdAdDao;
import com.wondertek.mobilevideo.gke.ad.core.dao.AdAdMaterialDao;
import com.wondertek.mobilevideo.gke.ad.core.model.AdAd;
import com.wondertek.mobilevideo.gke.ad.core.model.AdAdMaterial;
import org.springframework.stereotype.Repository;

@Repository
public class AdAdMaterialDaoHibernate extends GenericDaoHibernate<AdAdMaterial, Long> implements AdAdMaterialDao{

	public AdAdMaterialDaoHibernate() {
		super(AdAdMaterial.class);
	}

}
