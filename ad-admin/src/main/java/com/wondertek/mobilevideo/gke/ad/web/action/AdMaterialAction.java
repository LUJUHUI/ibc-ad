package com.wondertek.mobilevideo.gke.ad.web.action;

import com.wondertek.mobilevideo.gke.ad.core.model.AdMaterial;
import com.wondertek.mobilevideo.gke.ad.core.service.AdMaterialManger;
import com.wondertek.mobilevideo.gke.ad.core.utils.PageList;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.Map;

public class AdMaterialAction extends BaseAction {

    @Autowired
    private AdMaterialManger adMaterialMangerImpl;
    private AdMaterial adMaterial;
    private Map<String, Object> params = new HashMap<String,Object>();

    //    查询
    public String getAdMaterial(){
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
            adMaterialMangerImpl.saveOrUpdate(adMaterial);
            resultMap.put("success",true);
        } catch (Exception e) {
            e.printStackTrace();
            resultMap.put("success",false);
        }
        return SUCCESS;
    }

    private void getParams() {
        String id = getRequest().getParameter("id");
        if (StringUtils.isNotBlank(id)) {
            params.put("id", id);
        }
        String materialName = getRequest().getParameter("materialName");
        if (StringUtils.isNotBlank(materialName)) {
            params.put("materialName", materialName);
        }
        String type = getRequest().getParameter("type");
        if (StringUtils.isNotBlank(type)) {
            params.put("type", type);
        }
        String clickHref = getRequest().getParameter("clickHref");
        if (StringUtils.isNotBlank(clickHref)) {
            params.put("clickHref", clickHref);
        }
        String status = getRequest().getParameter("status");
        if (StringUtils.isNotBlank(status)) {
            params.put("status",status);
        }
    }

    public AdMaterialManger getAdMaterialMangerImpl() {
        return adMaterialMangerImpl;
    }

    public void setAdMaterialMangerImpl(AdMaterialManger adMaterialMangerImpl) {
        this.adMaterialMangerImpl = adMaterialMangerImpl;
    }

    public void setAdMaterial(AdMaterial adMaterial) {
        this.adMaterial = adMaterial;
    }

    public void setParams(Map<String, Object> params) {
        this.params = params;
    }
}
