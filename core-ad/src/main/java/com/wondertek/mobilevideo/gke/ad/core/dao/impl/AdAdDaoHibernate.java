package com.wondertek.mobilevideo.gke.ad.core.dao.impl;

import com.wondertek.mobilevideo.gke.ad.core.dao.AdAdDao;
import com.wondertek.mobilevideo.gke.ad.core.model.AdAd;
import com.wondertek.mobilevideo.gke.ad.core.utils.PageList;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository
public class AdAdDaoHibernate extends GenericDaoHibernate<AdAd, Long> implements AdAdDao{

	public AdAdDaoHibernate() {
		super(AdAd.class);
	}

}
