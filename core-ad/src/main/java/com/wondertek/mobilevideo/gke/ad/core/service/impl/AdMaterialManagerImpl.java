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
    /*有参构造*/
    public AdMaterialManagerImpl(AdMaterialDao adMaterialDao){
        super(adMaterialDao);
        this.adMaterialDao = adMaterialDao;
    }

    @Transactional
    /*
    *  @Transactional提供一种控制事务管理的快捷手段
    * 事务的传播行为是指，如果在开始当前事务之前，一个事务上下文已经存在，此时有若干选项可以指定一个事务性方法的执行行为.
    */
    public void verify(String ids, int type,String userName) throws RuntimeException {
        String[] id_ = ids.split(",");//将获取到的ID按照“，”进行分割存储在数组中
        for (String id : id_) {  //对ID数组进行遍历
            AdMaterial material = adMaterialDao.get(new Integer(id));  //获取广告素材的ID号
            if(material.getStatus() == AdMaterial.AdMaterialStatus.STATUS_101.getStatus()){
                AdLog adLog = new AdLog();

                /*按照类型进行判断是否播控通过*/
                if (0 == type) {
                    material.setStatus(AdMaterial.AdMaterialStatus.STATUS_102.getStatus());
                    adLog.setOperType(AdLog.adLogOperType.OPER_TYPE_301.getOperType());
                }else{
                    material.setStatus(AdMaterial.AdMaterialStatus.STATUS_103.getStatus());
                    adLog.setOperType(AdLog.adLogOperType.OPER_TYPE_302.getOperType());
                }
                material.setUpdatePerson(userName); //获取修改者ID
                material.setUpdateTime(new Date());//获取修改者时间
                adMaterialDao.saveOrUpdate(material); //保存更新信息
                adLog.setLogType(AdLog.adLogType.AD_LOG_TYPE_401.getLogType());
                adLog.setOperName(userName);
                adLog.setOperResult("成功");
                adLog.setCreateTime(new Date());
                adLogDao.save(adLog);
            }else {
                throw new RuntimeException();
            }
        }
            
    }
}
