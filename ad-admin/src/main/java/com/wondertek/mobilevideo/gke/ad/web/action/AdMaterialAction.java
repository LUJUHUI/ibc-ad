package com.wondertek.mobilevideo.gke.ad.web.action;

import com.wondertek.mobilevideo.core.util.DateUtil;
import com.wondertek.mobilevideo.gke.ad.core.model.AdMaterial;
import com.wondertek.mobilevideo.gke.ad.core.service.AdMaterialManger;
import com.wondertek.mobilevideo.gke.ad.core.utils.PageList;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.*;

public class AdMaterialAction extends BaseAction {

    @Autowired
    private AdMaterialManger adMaterialMangerImpl;

    private AdMaterial adMaterial;
    private Map<String, Object> params = new HashMap<String,Object>();
    //    查询
    public String getAdMaterials(){
        getParams();
        PageList pageList = new PageList();
        try {
            pageList =  adMaterialMangerImpl.getPageList(params,getPageNo(),getPageSize(),getSort(),getOrder());
        }catch (Exception e){
            e.printStackTrace();
        }
        resultMap.put("rows", pageList.getList());
        resultMap.put("records", pageList.getRecordCount());
        resultMap.put("pageCount", pageList.getPageCount());
        return SUCCESS;
    }
    //     增加
    public String addAdMaterial() {
        try {
            adMaterial.setCreatePerson(getUsername()); //创建者
            adMaterial.setUpdatePerson(getUsername());//修改者
            adMaterial.setCreateTime(new Date());//创建时间
            adMaterial.setUpdateTime(new Date());//修改时间
            adMaterial.setStatus(AdMaterial.AdMaterialStatus.STATUS_101.getStatus());
            adMaterialMangerImpl.save(adMaterial);
            resultMap.put("success",true);
        } catch (Exception e) {
            e.printStackTrace();
            resultMap.put("success",false);
        }
        return SUCCESS;
    }

    //    修改
    public String updateAdMaterial() {
        try {
            adMaterial.setUpdatePerson(getUsername());
            adMaterial.setUpdateTime(new Date());
            adMaterial.setStatus(AdMaterial.AdMaterialStatus.STATUS_101.getStatus());
            adMaterialMangerImpl.saveOrUpdate(adMaterial);
            resultMap.put("success",true);
        } catch (Exception e) {
            e.printStackTrace();
            resultMap.put("success",false);
        }
        return SUCCESS;
    }
    //    删除
    public String delateAdMaterial() {
        try {
            String[] ids = getRequest().getParameter("materialIds").split(",");
            for (String adMaterialId: ids) {
                AdMaterial material = adMaterialMangerImpl.get(Integer.parseInt(adMaterialId));
                /*删除之后保存修改者的时间与ID*/
                material.setUpdatePerson(getUsername());
                material.setUpdateTime(new Date());
                material.setStatus(AdMaterial.AdMaterialStatus.STATUS_106.getStatus());
                adMaterialMangerImpl.saveOrUpdate(material);
            }
            resultMap.put("success",true);
        } catch (Exception e) {
            e.printStackTrace();
            resultMap.put("success",false);
        }
        return SUCCESS;
    }
    //审核
    public String verify() {
        resultMap.put("success", true);
        try {
            String materialId = getRequest().getParameter("ids");
            String verifyType = getRequest().getParameter("type");//0:通过，1：驳回
            try {
                adMaterialMangerImpl.verify(materialId, Integer.parseInt(verifyType),getUsername());
                resultMap.put("code", 101);
            } catch (RuntimeException e2) {
                e2.printStackTrace();
                resultMap.put("code", 102);
            }
        } catch (Exception e) {
            resultMap.put("success", false);
            e.printStackTrace();
        }
        return SUCCESS;
    }

    public String getById() {
        String id = getRequest().getParameter("id");
        AdMaterial material = adMaterialMangerImpl.get(Integer.parseInt(id));
        resultMap.put("root", material);
        return  SUCCESS;
    }

    private void getParams() {
        String materialId = getRequest().getParameter("materialId");
        if (StringUtils.isNotBlank(materialId)) {
            params.put("materialId", materialId);
        }
        String materialName = getRequest().getParameter("materialName");
        if (StringUtils.isNotBlank(materialName)) {
            params.put("materialName", materialName);
        }
        String type = getRequest().getParameter("type");
        if (StringUtils.isNotBlank(type)) {
            params.put("type", Integer.parseInt(type));
        }
        String status = getRequest().getParameter("status");
        if (StringUtils.isNotBlank(status)) {
            params.put("status",Integer.parseInt(status));
        }
        String beginDate = getRequest().getParameter("beginDate");
        if (StringUtils.isNotBlank(beginDate)) {
            params.put("createTime_beginTime",DateUtil.parseDate(DateUtil.DATE_TIME_PATTERN,beginDate) );
        }
        String endDate = getRequest().getParameter("endDate");
        if (StringUtils.isNotBlank(endDate)) {
            params.put("createTime_endTime",DateUtil.parseDate(DateUtil.DATE_TIME_PATTERN,endDate) );
        }
        String status_notIn = getRequest().getParameter("status_not");
        if (StringUtils.isNotBlank(status_notIn)) {
            List<Integer> list = new ArrayList<Integer>();
            list.add(new Integer(status_notIn));
            params.put("status_notIn",list);
        }

    }


    public void setAdMaterial(AdMaterial adMaterial) {
        this.adMaterial = adMaterial;
    }

    public AdMaterial getAdMaterial() {
        return adMaterial;
    }

    public void setParams(Map<String, Object> params) {
        this.params = params;
    }
}
