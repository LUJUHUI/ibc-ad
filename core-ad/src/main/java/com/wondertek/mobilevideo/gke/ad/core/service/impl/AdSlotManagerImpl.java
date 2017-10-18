package com.wondertek.mobilevideo.gke.ad.core.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wondertek.mobilevideo.gke.ad.core.dao.AdSlotDao;
import com.wondertek.mobilevideo.gke.ad.core.dao.impl.GenericDaoHibernate;
import com.wondertek.mobilevideo.gke.ad.core.model.AdSlot;
import com.wondertek.mobilevideo.gke.ad.core.service.AdSlotManager;
import com.wondertek.mobilevideo.gke.ad.core.utils.PageList;
 
@Service
public class AdSlotManagerImpl extends  GenericManagerImpl<AdSlot, Long> implements AdSlotManager {
    @Autowired
	private AdSlotDao adSlotDao;
    @Autowired
	public AdSlotManagerImpl(AdSlotDao adSlotDao) {
		super(adSlotDao);
		this.adSlotDao = adSlotDao;
	}
}
