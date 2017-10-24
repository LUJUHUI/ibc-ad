package com.wondertek.mobilevideo.gke.ad.core.service;


import com.wondertek.mobilevideo.gke.ad.core.model.AdAdMaterial;

import java.util.PriorityQueue;

public interface AdAdMaterialManager extends GenericManager<AdAdMaterial, Long>{
    public void save(Long adId, String[] materialIds,String userName);
}
