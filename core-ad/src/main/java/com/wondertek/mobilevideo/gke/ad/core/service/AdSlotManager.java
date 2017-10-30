package com.wondertek.mobilevideo.gke.ad.core.service;

import com.wondertek.mobilevideo.gke.ad.core.model.AdSlot;
 

public interface AdSlotManager  extends GenericManager<AdSlot, Integer>{ 
     public AdSlot save(AdSlot adSlot);
     public void saveOrUpdate(AdSlot adSlot);
     public void deleteSlot(String str,String updatePeople);
     public void useSlot(String str,String updatePeople);
 
}
