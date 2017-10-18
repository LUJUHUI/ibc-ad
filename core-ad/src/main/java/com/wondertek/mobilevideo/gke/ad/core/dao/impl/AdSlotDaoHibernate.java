package com.wondertek.mobilevideo.gke.ad.core.dao.impl;

import com.wondertek.mobilevideo.gke.ad.core.dao.AdAdDao;
import com.wondertek.mobilevideo.gke.ad.core.dao.AdSlotDao;
import com.wondertek.mobilevideo.gke.ad.core.model.AdAd;
import com.wondertek.mobilevideo.gke.ad.core.model.AdSlot;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdSlotDaoHibernate extends GenericDaoHibernate<AdSlot, Long> implements AdSlotDao{

	public AdSlotDaoHibernate() {
		super(AdSlot.class);
	}
	
}
