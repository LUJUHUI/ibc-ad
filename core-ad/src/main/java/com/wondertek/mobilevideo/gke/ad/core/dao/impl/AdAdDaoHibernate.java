package com.wondertek.mobilevideo.gke.ad.core.dao.impl;

import com.wondertek.mobilevideo.gke.ad.core.dao.AdAdDao;
import com.wondertek.mobilevideo.gke.ad.core.model.AdAd;
import org.springframework.stereotype.Repository;

@Repository
public class AdAdDaoHibernate extends GenericDaoHibernate<AdAd, Long> implements AdAdDao{

	public AdAdDaoHibernate() {
		super(AdAd.class);
	}

}
