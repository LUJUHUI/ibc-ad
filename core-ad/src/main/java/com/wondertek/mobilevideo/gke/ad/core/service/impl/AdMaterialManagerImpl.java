package com.wondertek.mobilevideo.gke.ad.core.service.impl;

import com.wondertek.mobilevideo.gke.ad.BcConstants;
import com.wondertek.mobilevideo.gke.ad.core.dao.AdLogDao;
import com.wondertek.mobilevideo.gke.ad.core.dao.AdMaterialDao;
import com.wondertek.mobilevideo.gke.ad.core.dao.AdMaterialPicDao;
import com.wondertek.mobilevideo.gke.ad.core.model.AdLog;
import com.wondertek.mobilevideo.gke.ad.core.model.AdMaterial;
import com.wondertek.mobilevideo.gke.ad.core.model.AdMaterialPic;
import com.wondertek.mobilevideo.gke.ad.core.service.AdMaterialManger;
import com.wondertek.mobilevideo.gke.ad.core.utils.FileUtil;

import org.apache.commons.httpclient.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

import java.io.File;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
public class AdMaterialManagerImpl extends GenericManagerImpl<AdMaterial,Integer> implements AdMaterialManger {

    @Autowired
    private AdMaterialDao adMaterialDao;
    @Autowired
    private AdMaterialPicDao adMaterialPicDao;
    @Autowired
    private AdLogDao adLogDao;
    /*有参构造*/
    @Autowired
    public AdMaterialManagerImpl(AdMaterialDao adMaterialDao){
        super(adMaterialDao);
        this.adMaterialDao = adMaterialDao;
    }
    
    @Transactional
    public void saveAdMaterial(AdMaterial adMaterial,List<File> uploadPicList,List<String> uploadPicFileNameList,String userName){
        adMaterial.setCreatePerson(userName); //创建者
        adMaterial.setUpdatePerson(userName);//修改者
        adMaterial.setCreateTime(new Date());//创建时间
        adMaterial.setUpdateTime(new Date());//修改时间
        adMaterial.setStatus(AdMaterial.AdMaterialStatus.STATUS_101.getStatus());
    	AdMaterial material = adMaterialDao.save(adMaterial);
    	  Calendar calendar = Calendar.getInstance();
		    Date thisDate = new Date();
		    if(null != uploadPicList && uploadPicList.size()>0){
		    	 for (int i= 0; i < uploadPicList.size(); i++) {
	    		    String filePath = BcConstants.IMAGE_UPLOAD_PATH + File.separator + calendar.get(Calendar.YEAR) + File.separator + (calendar.get(Calendar.MONTH) + 1) + File.separator + DateUtil.formatDate(thisDate, "yyyyMMdd");
	    		    String name = DateUtil.formatDate(thisDate, "yyyyMMddHHmmssSSS") + uploadPicFileNameList.get(i).substring(uploadPicFileNameList.get(i).lastIndexOf("."), uploadPicFileNameList.get(i).length());
	    			File destFile = new File(BcConstants.APP_BASE_PATH + filePath + uploadPicFileNameList.get(i));
	    		    try {
						FileUtil.fileCopy(uploadPicList.get(i),destFile );
					    log.info("====图片上传成功:" + destFile.getPath());
		    		    AdMaterialPic adMaterialPic = new AdMaterialPic();
		    		    adMaterialPic.setAdMaterialId(material.getId().longValue());
		    		    adMaterialPic.setCreatePeople(userName);
		    		    adMaterialPic.setCreateTime(new Date());
		    		    adMaterialPic.setPicHref(BcConstants.APP_BASE_PATH + filePath + uploadPicFileNameList.get(i));
		    		    adMaterialPic.setPicSrc(uploadPicList.get(i).getPath());
		    		    adMaterialPicDao.save(adMaterialPic);
					} catch (Exception e) {
						log.info("====图片上传失败:");
						e.printStackTrace();
					}
		    	 }
		    } 
    }
    
    @Transactional
    public void updateAdMaterial(AdMaterial adMaterial,String userName){
	    adMaterial.setUpdatePerson(userName);
        adMaterial.setUpdateTime(new Date());
        adMaterial.setStatus(AdMaterial.AdMaterialStatus.STATUS_101.getStatus());
    	adMaterialDao.saveOrUpdate(adMaterial);
    }
    
    @Transactional
    public void verify(String ids, int type,String userName) throws RuntimeException {
        String[] id_ = ids.split(",");//将获取到的ID按照“，”进行分割存储在数组中
        for (String id : id_) {  //对ID数组进行遍历
            AdMaterial material = adMaterialDao.get(new Integer(id));  //获取广告素材的ID号
            if(material.getStatus() == AdMaterial.AdMaterialStatus.STATUS_101.getStatus()){
                AdLog adLog = new AdLog();

                /*按照类型进行判断是否播控通过*/
                if (0 == type) {
                    material.setStatus(AdMaterial.AdMaterialStatus.STATUS_104.getStatus());
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
