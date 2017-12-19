package com.wondertek.mobilevideo.gke.ad.core.dao.impl;

import com.wondertek.mobilevideo.gke.ad.core.dao.AdMaterialPicDao;
import com.wondertek.mobilevideo.gke.ad.core.model.AdMaterialPic;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdMaterialPicDaoHibernate extends GenericDaoHibernate<AdMaterialPic,Long> implements AdMaterialPicDao{

	public AdMaterialPicDaoHibernate() {
		super(AdMaterialPic.class);
	}

}
