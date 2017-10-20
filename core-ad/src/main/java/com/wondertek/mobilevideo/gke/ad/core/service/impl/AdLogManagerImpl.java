package com.wondertek.mobilevideo.gke.ad.core.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wondertek.mobilevideo.gke.ad.core.dao.AdLogDao;
import com.wondertek.mobilevideo.gke.ad.core.dao.AdSlotDao;
import com.wondertek.mobilevideo.gke.ad.core.dao.impl.GenericDaoHibernate;
import com.wondertek.mobilevideo.gke.ad.core.model.AdLog;
import com.wondertek.mobilevideo.gke.ad.core.model.AdSlot;
import com.wondertek.mobilevideo.gke.ad.core.service.AdLogManager;
import com.wondertek.mobilevideo.gke.ad.core.service.AdSlotManager;
import com.wondertek.mobilevideo.gke.ad.core.utils.PageList;
 
@Service
public class AdLogManagerImpl extends  GenericManagerImpl<AdLog, Long> implements AdLogManager {
    @Autowired
	private AdLogDao adLogDao;
    @Autowired
	public AdLogManagerImpl(AdLogDao adLogDao) {
		super(adLogDao);
		this.adLogDao = adLogDao;
	}
}
