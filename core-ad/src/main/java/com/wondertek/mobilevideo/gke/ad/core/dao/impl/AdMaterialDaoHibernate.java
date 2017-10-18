package com.wondertek.mobilevideo.gke.ad.core.dao.impl;

import com.wondertek.mobilevideo.gke.ad.core.dao.AdMaterialDao;
import com.wondertek.mobilevideo.gke.ad.core.model.AdMaterial;
import org.springframework.stereotype.Repository;

/**
 * create by lujuhui 2017/10/18 9:48
 */
@Repository
public class AdMaterialDaoHibernate extends GenericDaoHibernate<AdMaterial,Long> implements AdMaterialDao{
    public AdMaterialDaoHibernate() {
        super(AdMaterial.class);
    }

}
