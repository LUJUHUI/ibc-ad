package com.wondertek.mobilevideo.gke.ad.web.action;


import org.apache.struts2.ServletActionContext;

import java.io.*;

/**
 * create by lujuhui 2017/11/7 14:17
 */
public class UploadAction extends BaseAction implements Serializable {
    /**
     * 文件上传文件名为file+FileName固定写法
     */
    private File[] file;
    private String[] fileFileName;

    public String upload() throws Exception {
        for (int i = 0; i < this.file.length; i++) {
            InputStream is = new FileInputStream(this.file[i]);
            String str = ServletActionContext.getServletContext().getRealPath("/upload");
            File f = new File(str, this.fileFileName[i]);
            OutputStream os = new FileOutputStream(f);

            byte[] b = new byte[10000000];
            while (is.read(b) != -1) {
                System.out.println(b.length);
                os.write(b, 0, b.length);
            }
            is.close();
            os.close();
        }
        return SUCCESS;
    }

    public String[] getFileFileName() {
        return fileFileName;
    }

    public File[] getFile() {
        return file;
    }

    public void setFile(File[] file) {
        this.file = file;
    }

    public void setFileFileName(String[] fileFileName) {
        this.fileFileName = fileFileName;
    }

}
