package com.wondertek.mobilevideo.gke.ad.web.action;


import com.wondertek.mobilevideo.core.util.FileUtil;

import java.io.File;


/**
 * create by lujuhui 2017/11/6 17:58
 */
public class PicUploadAction extends BaseAction{
    private File picUpload;
    private String picUploadFileName;

    public String createPicUpload(){
       // File uploadPath = new File("D:/test/1.jpg");
        File outPicPath = new File("D:/test/222/"+picUploadFileName);
        try {
            FileUtil.fileCopy(picUpload,outPicPath);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return  SUCCESS;
    }

    public String test(){
        // File uploadPath = new File("D:/test/1.jpg");
        return  SUCCESS;
    }


    public File getPicUpload() {
        return picUpload;
    }

    public void setPicUpload(File picUpload) {
        this.picUpload = picUpload;
    }

    public String getPicUploadFileName() {
        return picUploadFileName;
    }

    public void setPicUploadFileName(String picUploadFileName) {
        this.picUploadFileName = picUploadFileName;
    }
}
