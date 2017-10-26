package com.wondertek.mobilevideo.gke.ad.core.service;

import com.wondertek.mobilevideo.gke.ad.core.model.AdMaterial;

public interface AdMaterialManger extends GenericManager<AdMaterial,Integer> {

    public void verify(String ids, int type,String userName)throws RuntimeException;
}
