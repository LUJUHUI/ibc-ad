package com.wondertek.mobilevideo.gke.ad.core.service;

import java.util.List;
import java.util.Map;

import com.wondertek.mobilevideo.gke.ad.core.model.AdSlot;
import com.wondertek.mobilevideo.gke.ad.core.model.AdSoltLive;
import com.wondertek.mobilevideo.gke.ad.core.model.AdSoltPage;
 

public interface AdSlotManager  extends GenericManager<AdSlot, Integer>{ 
     public AdSlot save(AdSlot adSlot);
     public void saveOrUpdate(AdSlot adSlot);
     public void deleteSlot(String str,String updatePeople);
     public void useSlot(String str,String updatePeople);
     public void verify(String ids, int type,String userName)throws RuntimeException;
     public List<AdSoltPage>  getHomePageChannelId(); 
     public List<AdSoltLive>  getLiveChannelId();
}
