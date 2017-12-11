package com.wondertek.mobilevideo.gke.ad.web.action;


import com.wondertek.mobilevideo.core.util.FileUtil;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


/**
 * create by lujuhui 2017/11/6 17:58
 */
public class PicUploadAction extends BaseAction{
    private File picUpload;
    private String picUploadFileName;

    public String createPicUpload(){
       // File uploadPath = new File("D:/test/1.jpg");
        File outPicPath = new File("D:/test/"+picUploadFileName);
        if(outPicPath.exists()){
            outPicPath.delete();
        }else {
            try {
                outPicPath.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
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

    public String fileUp(MultipartFile[] files, HttpServletRequest request){
        List<String> list = new ArrayList<>();
        if(files !=null&files.length>0){
            for (int i = 0;i<files.length;i++){
                MultipartFile file = files[i];
                list = saveFile(request,file,list);
            }
        }
        return null;
    }

    private List<String> saveFile(HttpServletRequest request, MultipartFile file, List<String> list) {
        if(!file.isEmpty()){
            try {
                String filePath = request.getSession().getServletContext().getRealPath("/") + "upload/" + file.getOriginalFilename();
                list.add(file.getOriginalFilename());
                File saveDir = new File(filePath);
                if(!saveDir.getParentFile().exists()){
                    saveDir.getParentFile().mkdirs();

                    file.transferTo(saveDir);
                    return list;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
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
