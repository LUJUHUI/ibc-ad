package com.wondertek.mobilevideo.gke.ad.core.service.impl;

import com.wondertek.mobilevideo.gke.ad.core.dao.AdLogDao;
import com.wondertek.mobilevideo.gke.ad.core.dao.AdMaterialDao;
import com.wondertek.mobilevideo.gke.ad.core.model.AdLog;
import com.wondertek.mobilevideo.gke.ad.core.model.AdMaterial;
import com.wondertek.mobilevideo.gke.ad.core.service.AdMaterialManger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Date;

@Service
public class AdMaterialManagerImpl extends GenericManagerImpl<AdMaterial,Integer> implements AdMaterialManger {

    @Autowired
    private AdMaterialDao adMaterialDao;
    @Autowired
    private AdLogDao adLogDao;
    @Autowired
    public AdMaterialManagerImpl(AdMaterialDao adMaterialDao){
        super(adMaterialDao);
        this.adMaterialDao = adMaterialDao;
    }

    @Transactional
    public void verify(String ids, int type,String userName) throws RuntimeException {
        String[] id_ = ids.split(",");
        for (String id : id_) {
            AdMaterial material = adMaterialDao.get(new Integer(id));
            if(material.getStatus() == AdMaterial.AdMaterialStatus.STATUS_101.getStatus()){
                if (0 == type) {
                    material.setStatus(AdMaterial.AdMaterialStatus.STATUS_102.getStatus());
                }else{
                    material.setStatus(AdMaterial.AdMaterialStatus.STATUS_103.getStatus());
                }
                material.setUpdatePerson(userName);
                material.setUpdateTime(new Date());
                adMaterialDao.saveOrUpdate(material);
                AdLog adLog = new AdLog();
                
            }else {
                throw new RuntimeException();
            }
        }
            
    }
}
