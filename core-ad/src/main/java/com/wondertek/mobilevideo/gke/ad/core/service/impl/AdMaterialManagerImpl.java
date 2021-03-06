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
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    
    //保存素材
    @Transactional
    public void saveAdMaterial(AdMaterial adMaterial,List<File> uploadPicList,List<String> uploadPicFileNameList,List<String> imageUploadSrc,String userName){
        adMaterial.setCreatePerson(userName); //创建者
        adMaterial.setUpdatePerson(userName);//修改者
        adMaterial.setCreateTime(new Date());//创建时间
        adMaterial.setUpdateTime(new Date());//修改时间
        adMaterial.setStatus(AdMaterial.AdMaterialStatus.STATUS_101.getStatus());
    	AdMaterial material = adMaterialDao.save(adMaterial);
    	Calendar calendar = Calendar.getInstance();
		    if(null != uploadPicList && uploadPicList.size()>0){
		    	 for (int i= 0; i < uploadPicList.size(); i++) {
		    		 uploadPic(uploadPicList.get(i),uploadPicFileNameList.get(i),imageUploadSrc.get(i),userName,calendar,material.getId().longValue());
		    	 }
		    } 
    }
    
    //上传图片，并将图片入库
    public void uploadPic(File file,String fileName,String imageUploadSrc,String createPeople,Calendar calendar,Long adMaterialId){
  		Date thisDate = new Date();
  		String filePath = BcConstants.IMAGE_UPLOAD_PATH + File.separator + calendar.get(Calendar.YEAR) + File.separator + (calendar.get(Calendar.MONTH) + 1) + File.separator + DateUtil.formatDate(thisDate, "yyyyMMdd");
  		String name = DateUtil.formatDate(thisDate, "yyyyMMddHHmmssSSS") + fileName.substring(fileName.lastIndexOf("."), fileName.length());
  		File destFile = new File(BcConstants.APP_BASE_PATH + filePath + name);
  		try {
		FileUtil.fileCopy(file,destFile );
	    log.info("====图片上传成功:" + destFile.getPath());
	    AdMaterialPic adMaterialPic = new AdMaterialPic();
	    adMaterialPic.setAdMaterialId(adMaterialId);
	    adMaterialPic.setCreatePeople(createPeople);
	    adMaterialPic.setCreateTime(new Date());
	    adMaterialPic.setPicHref(filePath + name);
	    adMaterialPic.setPicSrc(imageUploadSrc);
	    adMaterialPicDao.save(adMaterialPic);
  		} catch (Exception e) {
		log.info("====图片上传失败:");
		e.printStackTrace();
  		}
    }
    
    //修改素材
    @Transactional
    public void updateAdMaterial(AdMaterial adMaterial,List<File> uploadPicList,List<String> uploadPicFileNameList,List<String> imageUploadSrc,List<String> imageListId,String userName){
    	//将广告素材修改
    	adMaterial.setUpdatePerson(userName);
        adMaterial.setUpdateTime(new Date());
        adMaterial.setStatus(AdMaterial.AdMaterialStatus.STATUS_101.getStatus());
    	adMaterialDao.saveOrUpdate(adMaterial);
    	//查询数据库已有的图片
    	Map picMap = new HashMap<String,Object>();
	  	picMap.put("adMaterialId", adMaterial.getId().longValue());
	  	List<AdMaterialPic> imageAll = adMaterialPicDao.find(picMap);
	  	Calendar calendar = Calendar.getInstance();
	  	//图片修改后,有ID
    	if(null != imageListId && imageListId.size()>0 && null != imageAll){
    		//图片没有发生改变，不变或者是跳转路径改变
    		if(imageAll.size() == imageListId.size() && null == uploadPicList ){
    			updateAdMaterialPic(imageListId,imageUploadSrc);
    		//图片没有发生改变， 有新增图片
    		}else if(imageAll.size() == imageListId.size() && null != uploadPicList && uploadPicList.size()>0){
    			updateAdMaterialPic(imageListId,imageUploadSrc);
    			List<String> imageUploadSrcList = new  ArrayList<String>();
    			for (int i = imageListId.size(); i < imageUploadSrc.size(); i++) {
    				imageUploadSrcList.add(imageUploadSrc.get(i));
				}
    			for (int i = 0; i < uploadPicList.size(); i++) {
    				 uploadPic(uploadPicList.get(i),uploadPicFileNameList.get(i),imageUploadSrcList.get(i),userName,calendar,adMaterial.getId().longValue());
				}
    		//图片删除一部分
    		}else if(imageAll.size() != imageListId.size() &&  null  == uploadPicList ){
    			for (int i = 0; i < imageAll.size(); i++) {
					if(!imageListId.contains(imageAll.get(i).getId().toString())){
						removeAdMaterialPic(imageAll.get(i).getId());
					}
				}
    		//图片有删除和修改和新增
    		}else if(imageAll.size() != imageListId.size() &&  null  != uploadPicList ){
    			List<String> newSrcPic = new ArrayList<String>();
    			List<String> noChangeSrc = new ArrayList<String>();
    			//将修改或者删除的图片删除，并将对应的图片跳转地址放入新的LIST
    			for (int i = 0; i < imageAll.size(); i++) {
					if(!imageListId.contains(imageAll.get(i).getId().toString())){ 
						removeAdMaterialPic(imageAll.get(i).getId());
					} 
					if(!imageListId.contains(imageAll.get(i).getId().toString()) && imageUploadSrc.contains(imageAll.get(i).getPicSrc())){
						newSrcPic.add(imageUploadSrc.get(i));
					}else if(imageListId.contains(imageAll.get(i).getId().toString()) && imageUploadSrc.contains(imageAll.get(i).getPicSrc())){
						noChangeSrc.add(imageUploadSrc.get(i));
					}
				}
    			//先删除再修改和只有修改
    			if(uploadPicList.size() == newSrcPic.size() ){
	    			for (int i = 0; i < uploadPicList.size(); i++) {
	    				 uploadPic(uploadPicList.get(i),uploadPicFileNameList.get(i),newSrcPic.get(i),userName,calendar,adMaterial.getId().longValue());
					}
    			}
    			//删除修改并添加新的图片或修改添加
    			if(uploadPicList.size() > newSrcPic.size()){
    				int num = uploadPicList.size() - newSrcPic.size();
    				List<String> newAddPicSrc= new ArrayList<String>();
    				List<File> newAddPic = new ArrayList<File>();
    				List<File> updatePic = new ArrayList<File>();
    				List<String> newAddPicName = new ArrayList<String>();
    				List<String> updatePicName = new ArrayList<String>();
    				for (int i = imageUploadSrc.size()-num; i < imageUploadSrc.size(); i++) {
    					newAddPicSrc.add(imageUploadSrc.get(i));
    				}
    				for (int i = newSrcPic.size(); i < uploadPicList.size(); i++) {
    					newAddPic.add(uploadPicList.get(i));
    					newAddPicName.add(uploadPicFileNameList.get(i));
    				}
    				for(int i = 0; i < newSrcPic.size(); i++){
    					updatePic.add(uploadPicList.get(i));
    					updatePicName.add(uploadPicFileNameList.get(i));
    				}
    				if(newAddPic.size()>0){
	    				for (int i = 0; i < newAddPic.size(); i++) {
		    				 uploadPic(newAddPic.get(i),newAddPicName.get(i),newAddPicSrc.get(i),userName,calendar,adMaterial.getId().longValue());
						}
    				}
    				if(updatePic.size()>0){
	    				for (int i = 0; i < updatePic.size(); i++) {
		    				 uploadPic(updatePic.get(i),updatePicName.get(i),newSrcPic.get(i),userName,calendar,adMaterial.getId().longValue());
						}
    				}
    			}
    				//将没有改变的图片ID重新插入到表中，包含跳转地址改变
    				updateAdMaterialPic(imageListId,noChangeSrc);
    		} 
    	//图片全部删除掉，没有上传
    	}else if(null == imageListId && null == uploadPicList){
    		if(null != imageAll && imageAll.size()>0){
	    		for (AdMaterialPic adMaterialPic : imageAll) {
	    			removeAdMaterialPic(adMaterialPic.getId());
				}
    		}
    	//图片修改完或删除完后,没有ID,有上传新的图片
    	}else if(null == imageListId && null != uploadPicList){
    		if(null != imageAll && imageAll.size()>0){
	    		for (AdMaterialPic adMaterialPic : imageAll) {
	    			removeAdMaterialPic(adMaterialPic.getId());
				}
    		}
    		for (int i = 0; i < uploadPicList.size(); i++) {
				 uploadPic(uploadPicList.get(i),uploadPicFileNameList.get(i),imageUploadSrc.get(i),userName,calendar,adMaterial.getId().longValue());
			}
    	}
    }
    //将没有发生图片变动的数据发到表中，其中包含图片的跳转地址发生改变
    public void updateAdMaterialPic(List<String> imageListId,List<String> imageUploadSrc){
    	  for(int i=0; i<imageListId.size();i++){
        	Map picMap = new HashMap<String,Object>();
    	  	picMap.put("id", Long.parseLong(imageListId.get(i)));
    	  	List<AdMaterialPic> imageAll = adMaterialPicDao.find(picMap);
			if(null != imageAll && imageAll.size()>0){
				AdMaterialPic adMaterialPic = imageAll.get(0);
				adMaterialPic.setPicSrc(imageUploadSrc.get(i));
			    adMaterialPicDao.save(adMaterialPic);
			}
		}
    }
    //移除图片
    public void removeAdMaterialPic(Long imageId){
    	Map<String, Object> conditions = new HashMap<>();
    	conditions.put("id", imageId);
    	adMaterialPicDao.remove(conditions);
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
