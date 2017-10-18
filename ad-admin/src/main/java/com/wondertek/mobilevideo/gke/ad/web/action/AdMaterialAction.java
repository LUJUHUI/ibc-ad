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
    private AdMaterialManger adMaterialManger;
    private AdMaterial adMaterial;
    private Map<String, Object> params = new HashMap<String,Object>();

//    查询
    public String getAd(){
        getParams();
        PageList pageList = new PageList();
        try {
            pageList =  adMaterialManger.getPageList(params,getPageNo(),getPageSize(),getSort(),getOrder());
        }catch (Exception e){

        }
        resultMap.put("rows", pageList.getList());
        resultMap.put("records", pageList.getRecordCount());
        resultMap.put("pageCount", pageList.getPageCount());
        return SUCCESS;
    }

//     增加
    public String addAdMaterial() {
        try {
            adMaterialManger.save(adMaterial);
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
            adMaterialManger.saveOrUpdate(adMaterial);
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
        adMaterialManger.saveOrUpdate(adMaterial);
        resultMap.put("success",true);
    } catch (Exception e) {
        e.printStackTrace();
        resultMap.put("success",false);
    }
    return SUCCESS;
}

    private void getParams() {
        String materialName = getRequest().getParameter("materialName");
        if (StringUtils.isNotBlank(materialName)) {
            params.put("materialName", materialName);
        }
        String type = getRequest().getParameter("type");
        if (StringUtils.isNotBlank(type)) {
            params.put("type", type);
        }
        String status = getRequest().getParameter("status");
        if (StringUtils.isNotBlank(status)) {
            params.put("status",status);
        }
        String clickHref = getRequest().getParameter("clickHref");
        if (StringUtils.isNotBlank(clickHref)) {
            params.put("clickHref", clickHref);
        }
    }

}
