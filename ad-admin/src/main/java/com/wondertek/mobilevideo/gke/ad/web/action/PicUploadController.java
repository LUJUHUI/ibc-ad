package com.wondertek.mobilevideo.gke.ad.web.action;

import com.opensymphony.xwork2.util.logging.Logger;
import com.opensymphony.xwork2.util.logging.LoggerFactory;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import com.wondertek.mobilevideo.gke.ad.core.model.AdMaterial;
import com.wondertek.mobilevideo.gke.ad.web.WebConstants;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.*;

/**
 * create by lujuhui 2017/11/2 16:32
 */
@Controller
@RequestMapping("/upc/manage")
public class PicUploadController {
    private static final Logger LOGGER = LoggerFactory.getLogger(PicUploadController.class);

    @RequestMapping(value = "/picupload.htm", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String picUpload(final HttpServletRequest request, final HttpServletResponse response) {
        MultipartHttpServletRequest multiHttpRequest = (MultipartHttpServletRequest) request;
        MultipartFile file = multiHttpRequest.getFile(multiHttpRequest.getParameter("filename"));
        String allowSuffix = ".jpg|.jpeg|.gif|.bmp|.png";
        long size = 2048L;
        String filename = file.getOriginalFilename();
        String fileNamesuffix = filename.substring(filename.lastIndexOf("."), filename.length()).toLowerCase();

        String uploadFilePath = WebConstants.APP_BASE_PATH;

        long time = System.currentTimeMillis();
        String newFileNm = String.valueOf(time) + fileNamesuffix;
        String prvPath = null;
        if ("idTxtfile".equals(multiHttpRequest.getParameter("filename"))) {
            allowSuffix = ".txt";
            size = 5120L;
            double txtSize = ((double) file.getSize()) / 1024;
            if(txtSize > size || txtSize == 0){
                newFileNm = "errorSize";
            }
            if (allowSuffix.indexOf(fileNamesuffix) == -1) {
                prvPath = "errorImg";
            }
            if(txtSize <= size && txtSize > 0 &&allowSuffix.indexOf(fileNamesuffix) != -1){
                // 获取上传的.txt文件的内容
                BufferedReader bufferInput = null;
                StringBuilder str = new StringBuilder();
                try {
                    bufferInput = new BufferedReader(new InputStreamReader(file.getInputStream(), "GB18030"));
                    String line = bufferInput.readLine();
                    while (line != null) {
                        str.append(line).append("\n");
                        line = bufferInput.readLine();
                    }
                    return str.toString();
                } catch (Exception e) {
                    LOGGER.error("Exception", e);
                } finally {
                    try {
                        bufferInput.close();
                    } catch (Exception e) {
                    }
                }
            }
        } else {
            try {
                long fileSize = Math.round(((double) file.getSize()) / 1024);
                BufferedImage bfImage = ImageIO.read(file.getInputStream());
                if (allowSuffix.indexOf(fileNamesuffix) != -1) {
                    if (bfImage.getWidth() < 320 && bfImage.getHeight() < 180) {
                        FileCopyUtils.copy(file.getBytes(), new File(uploadFilePath + File.separatorChar + newFileNm));
                    } else {
                        uploadImage(file.getInputStream(), uploadFilePath, newFileNm, bfImage.getWidth(),
                                bfImage.getHeight());
                    }
                    //prvPath = AdMaterial.getParameter("upc.imgs.url") + newFileNm;
                } else {
                    prvPath = "errorImg";
                }
                if (fileSize > size) {
                    newFileNm = "errorSize";
                }
            } catch (Exception e) {
                LOGGER.error("Exception", e);
            }
        }
        return "{\"url\":\"" + prvPath + "\",\"picName\":\"" + newFileNm + "\"}";
    }

    // 生成缩略图
    public static boolean uploadImage(InputStream inputStream, String filePath, String fileName, int width, int height)
    {
        int new_w = 318;
        int new_h = 170;
        FileOutputStream out = null;
        try {
            BufferedImage tag = new BufferedImage(new_w, new_h, BufferedImage.TYPE_INT_RGB);
            tag.getGraphics().drawImage(ImageIO.read(inputStream), 0, 0, new_w, new_h, null);
            out = new FileOutputStream(filePath + File.separatorChar + fileName);
            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
            encoder.encode(tag);
        } catch (Exception e) {
            LOGGER.error("Exception:upload pic failed!", e);
        } finally {
            try {
                out.close();
            } catch (Exception e) {
            }
        }
        return true;
    }

}
