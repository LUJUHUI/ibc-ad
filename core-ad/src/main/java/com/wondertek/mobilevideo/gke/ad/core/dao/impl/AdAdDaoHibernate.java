package com.wondertek.mobilevideo.gke.ad.core.dao.impl;

import com.wondertek.mobilevideo.gke.ad.core.dao.AdAdDao;
import com.wondertek.mobilevideo.gke.ad.core.model.AdAd;
import org.springframework.stereotype.Repository;

/**
 * Created by D11 on 2017/6/7.
 */
@Repository
public class AdAdDaoHibernate extends GenericDaoHibernate<AdAd,Long> implements AdAdDao {

	public AdAdDaoHibernate() {
		super(AdAd.class);
	}

}
