package com.wondertek.mobilevideo.gke.ad.web.action;

import com.wondertek.mobilevideo.core.util.DateUtil;
import com.wondertek.mobilevideo.gke.ad.core.model.AdMaterial;
import com.wondertek.mobilevideo.gke.ad.core.service.AdMaterialManger;
import com.wondertek.mobilevideo.gke.ad.core.utils.PageList;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
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

   /* *//*上传图片start*//*
    @RequestMapping(value = "/uploadHeadImg", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String uploadHeadImg(@RequestParam(value = "img", required = false) MultipartFile file,
                                @RequestParam(value = "xCoordinate", required = false) Integer xCoordinate,
                                @RequestParam(value = "yCoordinate", required = false) Integer yCoordinate,
                                @RequestParam(value = "width", required = false) Integer width,
                                @RequestParam(value = "imgName", required = false) String imgName,
                                @RequestParam(value = "height", required = false) Integer height,
                                HttpServletRequest request, ModelMap model) {
        String result = "";
        EmpMessageRes msg = new EmpMessageRes();
        *//*获得工程下面upload资源包路径，当然这个包是已经存在的了*//*
        String path = request.getSession().getServletContext().getRealPath("upload/trainer_picture");
        *//*上传的图片的名称*//*
        String fileName = file.getOriginalFilename();
        String newfileName = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
        *//*下面是upload路径盘符的转化*//*
        StringBuffer importPath = new StringBuffer();
        String temp[] = path.split("\\\\");

        for (int i = 0; i < temp.length; i++) {
            importPath.append(temp[i]);
            importPath.append("/");
        }

        importPath.append(newfileName);
        *//*看是否存在upload包，没有则会新建一个upload包，作为资源上传的路径*//*
        File targetFile = new File(path, newfileName);
        if (!targetFile.exists()) {
            targetFile.mkdirs();
        }
        *//*文件上传*//*
        try {
            file.transferTo(targetFile);
            msg.setResult("true");
            msg.setResultDesc("头像上传成功");
            msg.setImgUrl(newfileName);
            result = msg.getImgUrl();
        } catch (Exception e) {
            msg.setResult("false");
            msg.setResultDesc("头像上传失败");
            e.printStackTrace();
        }
        if (imgName != null) {
            File later = new File(path, imgName);
            if (later != null)
                later.delete();
        }
        return result;
    }
    *//*上传图片end*/

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
