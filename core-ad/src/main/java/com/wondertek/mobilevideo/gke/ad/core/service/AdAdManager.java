package com.wondertek.mobilevideo.gke.ad.core.service;


import com.wondertek.mobilevideo.gke.ad.core.model.AdAd;

public interface AdAdManager extends GenericManager<AdAd, Long>{

    public AdAd save(AdAd object,String materialId);
}
