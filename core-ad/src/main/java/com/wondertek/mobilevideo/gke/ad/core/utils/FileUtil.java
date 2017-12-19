package com.wondertek.mobilevideo.gke.ad.core.utils;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.io.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class FileUtil {
    private static final Log log = LogFactory.getLog(FileUtil.class);
    private static final byte[] UTF_8_BOM = new byte[]{-17, -69, -65};

    public FileUtil() {
    }

    public static int deleteFile(File file) {
        if(file == null) {
            return -1;
        } else if(file.exists()) {
            if(file.isFile()) {
                file.delete();
            }

            if(file.isDirectory()) {
                File[] subFiles = file.listFiles();
                if(subFiles != null) {
                    for(int i = 0; i < subFiles.length; ++i) {
                        deleteFile(subFiles[i]);
                    }
                }

                file.delete();
            }

            return 0;
        } else {
            return -1;
        }
    }

    public static void fileCopy(File srcFile, File tarFile) throws Exception {
        FileInputStream is = null;
        FileOutputStream os = null;

        try {
            createNewFile(tarFile);
            is = new FileInputStream(srcFile);
            os = new FileOutputStream(tarFile);
            //int bytesRead = false;
            byte[] buffer = new byte[8192];

            int bytesRead;
            while((bytesRead = is.read(buffer, 0, 8192)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
        } catch (FileNotFoundException var17) {
            throw var17;
        } catch (IOException var18) {
            throw var18;
        } finally {
            try {
                if(is != null) {
                    is.close();
                }
            } catch (Exception var15) {
                throw var15;
            }

            try {
                if(os != null) {
                    os.close();
                }
            } catch (Exception var16) {
                throw var16;
            }

        }

    }

    public static void writeFileByString(String filePath, String fileContent, String encoding) {
        writeFileByString(filePath, fileContent, encoding, false);
    }

    public static void writeFileByString(String filePath, String fileContent, String encoding, boolean append) {
        PrintWriter out = null;

        try {
            if(filePath != null && fileContent != null && fileContent.length() > 0) {
                File tempFile = new File(filePath);
                if(append) {
                    if(!tempFile.exists()) {
                        tempFile.getParentFile().mkdirs();
                        tempFile.createNewFile();
                    }
                } else {
                    createNewFile(tempFile);
                }

                tempFile.setReadable(true);
                tempFile.setWritable(true);
                if(encoding != null && encoding.trim().length() > 0) {
                    out = new PrintWriter(new BufferedWriter(new OutputStreamWriter(new FileOutputStream(filePath, append), encoding)), true);
                } else {
                    out = new PrintWriter(new FileWriter(filePath));
                }

                out.print(fileContent);
                out.close();
                return;
            }

            log.error("into writeFileByString [filePath=" + filePath + ",filePath=" + fileContent + "] is null return!!!");
        } catch (Exception var9) {
            log.error("writeFileByString Exception:" + var9, var9);
            return;
        } finally {
            if(out != null) {
                out.close();
            }

        }

    }

    public static void writeFileToString(String filePath, String fileContent, String encoding, boolean append) throws Exception {
        PrintWriter out = null;

        try {
            if(filePath != null && fileContent != null && fileContent.length() > 0) {
                File tempFile = new File(filePath);
                if(!tempFile.exists()) {
                    tempFile.getParentFile().mkdirs();
                    tempFile.createNewFile();
                }

                if(encoding != null && encoding.trim().length() > 0) {
                    out = new PrintWriter(new BufferedWriter(new OutputStreamWriter(new FileOutputStream(filePath, append), encoding)), true);
                } else {
                    out = new PrintWriter(new FileWriter(filePath));
                }

                out.print(fileContent);
                out.close();
                return;
            }

            log.error("into writeFileByString [filePath=" + filePath + ",filePath=" + fileContent + "] is null return!!!");
        } catch (Exception var9) {
            log.error("writeFileByString Exception:" + var9, var9);
            throw var9;
        } finally {
            if(out != null) {
                out.close();
            }

        }

    }

    public static void writeFileByString(String filePath, String fileContent, String encoding, boolean append, boolean isNewLine) {
        PrintWriter out = null;

        try {
            if(filePath != null && fileContent != null && fileContent.length() > 0) {
                if(append) {
                    File tempFile = new File(filePath);
                    if(!tempFile.exists()) {
                        tempFile.getParentFile().mkdirs();
                        tempFile.createNewFile();
                    }
                } else {
                    createNewFile(new File(filePath));
                }

                if(encoding != null && encoding.trim().length() > 0) {
                    out = new PrintWriter(new BufferedWriter(new OutputStreamWriter(new FileOutputStream(filePath, append), encoding)), true);
                } else {
                    out = new PrintWriter(new FileWriter(filePath));
                }

                if(isNewLine) {
                    out.println();
                }

                out.print(fileContent);
                out.close();
                return;
            }

            log.error("into writeFileByString [filePath=" + filePath + ",filePath=" + fileContent + "] is null return!!!");
        } catch (Exception var10) {
            log.error("writeFileByString Exception:" + var10, var10);
            return;
        } finally {
            if(out != null) {
                out.close();
            }

        }

    }

    public static String loadAFileToString(File f) {
        InputStream is = null;
        String ret = null;

        try {
            is = new BufferedInputStream(new FileInputStream(f));
            long contentLength = f.length();
            ByteArrayOutputStream outstream = new ByteArrayOutputStream(contentLength > 0L?(int)contentLength:1024);
            byte[] buffer = new byte[4096];

            int len;
            while((len = is.read(buffer)) > 0) {
                outstream.write(buffer, 0, len);
            }

            outstream.close();
            ret = new String(outstream.toByteArray(), "utf-8");
        } catch (IOException var16) {
            ret = "";
        } finally {
            if(is != null) {
                try {
                    is.close();
                } catch (Exception var15) {
                    ;
                }
            }

        }

        return ret;
    }

    public static String loadAFileToString2(File f) {
        InputStream is = null;
        String ret = "";
        if(f.exists()) {
            BufferedReader br = null;

            try {
                is = new FileInputStream(f);
                InputStreamReader read = new InputStreamReader(is, "utf-8");

                String line;
                for(br = new BufferedReader(read); (line = br.readLine()) != null; ret = ret + line + "\r\n") {
                    ;
                }
            } catch (Exception var14) {
                ret = "";
            } finally {
                if(is != null) {
                    try {
                        is.close();
                    } catch (Exception var13) {
                        ;
                    }
                }

            }
        }

        return ret;
    }

    public static void createNewFile(File f) throws IOException {
        if(f.exists()) {
            f.delete();
        }

        f.getParentFile().mkdirs();
        f.createNewFile();
    }

    public static boolean checkFileExists(String fileName) {
        File file = new File(fileName);
        return file.exists();
    }

    public static void checkDirExists(String dirPath) {
        File dirFile = new File(dirPath);
        if(!dirFile.isDirectory()) {
            dirFile.mkdirs();
        }

    }

    public static double getFileSize(File f) throws IOException {
        FileInputStream fis = null;

        try {
            fis = new FileInputStream(f);
            BigDecimal b = new BigDecimal(Integer.toString(fis.available()));
            BigDecimal s = new BigDecimal("1048576");
            double var4 = b.divide(s).doubleValue();
            return var4;
        } catch (Exception var9) {
            ;
        } finally {
            if(fis != null) {
                fis.close();
            }

        }

        return 0.0D;
    }

    public static boolean isUTF8(File f) {
        boolean isUtf8 = false;

        try {
            FileInputStream fis = new FileInputStream(f);
            byte[] bom = new byte[3];
            fis.read(bom);
            fis.close();
            if(null != bom && bom.length > 2 && bom[0] == UTF_8_BOM[0] && bom[1] == UTF_8_BOM[1] && bom[2] == UTF_8_BOM[2]) {
                isUtf8 = true;
            }

            return isUtf8;
        } catch (Exception var4) {
            return false;
        }
    }

    public static void writeFileByFileWithUtf(File sorceFile, File despFile) {
        long sourceLength = sorceFile.length();
        if(sourceLength != 0L) {
            InputStream is = null;
            FileOutputStream fos = null;
            byte[] bytes = new byte[4096];
            boolean var7 = false;

            try {
                double fileSize = getFileSize(despFile);
                is = new FileInputStream(sorceFile);
                fos = new FileOutputStream(despFile, true);
                if(fileSize == 0.0D) {
                    byte[] bom = new byte[]{-17, -69, -65};
                    fos.write(bom);
                }

                int numRead;
                while((numRead = is.read(bytes, 0, 4096)) >= 0) {
                    if(numRead < 4096) {
                        String str = new String(bytes);
                        String pattern = "\\x00+$";
                        Pattern p = Pattern.compile(pattern);
                        Matcher m = p.matcher(str);
                        str = m.replaceAll("");
                        bytes = str.getBytes();
                    }

                    fos.write(bytes, 0, bytes.length);
                    bytes = new byte[4096];
                }
            } catch (Exception var26) {
                var26.printStackTrace();
            } finally {
                if(is != null) {
                    try {
                        is.close();
                    } catch (IOException var25) {
                        var25.printStackTrace();
                    }
                }

                if(fos != null) {
                    try {
                        fos.close();
                    } catch (IOException var24) {
                        var24.printStackTrace();
                    }
                }

            }

        }
    }

    public static boolean writeFileAppend(String filePath, String content) {
        boolean res = true;
        BufferedWriter out = null;

        try {
            out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(filePath, true), "UTF-8"));
            out.write(content);
        } catch (Exception var13) {
            log.error(var13.getMessage());
            res = false;
        } finally {
            try {
                if(out != null) {
                    out.close();
                }
            } catch (IOException var12) {
                var12.printStackTrace();
            }

        }

        return res;
    }

    public static boolean isFileHead(String content) {
        byte[] b = content.trim().getBytes();
        return b.length != 3?false:(b[0] != -17?false:(b[1] != -69?false:b[2] == -65));
    }

    public static void appendTextToFile(String fileName, String text) throws IOException {
        if(text.length() != 0) {
            File despFile = new File(fileName);
            if(!checkFileExists(fileName)) {
                File f = new File(fileName);
                createNewFile(f);
            }

            InputStream is = null;
            FileOutputStream fos = null;
            byte[] bytes = new byte[4096];
            boolean var6 = false;

            try {
                double fileSize = getFileSize(despFile);
                is = new ByteArrayInputStream(text.getBytes());
                fos = new FileOutputStream(despFile, true);
                if(fileSize == 0.0D) {
                    byte[] bom = new byte[]{-17, -69, -65};
                    fos.write(bom);
                }

                int numRead;
                while((numRead = is.read(bytes, 0, 4096)) >= 0) {
                    if(numRead < 4096) {
                        String str = new String(bytes);
                        String pattern = "\\x00+$";
                        Pattern p = Pattern.compile(pattern);
                        Matcher m = p.matcher(str);
                        str = m.replaceAll("");
                        bytes = str.getBytes();
                    }

                    fos.write(bytes, 0, bytes.length);
                    bytes = new byte[4096];
                }
            } catch (Exception var25) {
                var25.printStackTrace();
            } finally {
                if(is != null) {
                    try {
                        is.close();
                    } catch (IOException var24) {
                        var24.printStackTrace();
                    }
                }

                if(fos != null) {
                    try {
                        fos.close();
                    } catch (IOException var23) {
                        var23.printStackTrace();
                    }
                }

            }

        }
    }

    public static String loadFileToStr(File f) throws FileNotFoundException {
        InputStream is = null;
        String ret = "";
        if(f.exists()) {
            BufferedReader br = null;

            try {
                is = new FileInputStream(f);
                InputStreamReader read = new InputStreamReader(is, "utf-8");
                br = new BufferedReader(read);

                String line;
                while((line = br.readLine()) != null) {
                    ret = ret + line + "\r\n";
                    log.debug(ret);
                }
            } catch (Exception var14) {
                ret = "";
            } finally {
                if(is != null) {
                    try {
                        is.close();
                    } catch (Exception var13) {
                        ;
                    }
                }

            }
        }

        return ret;
    }

    public static File createFile(String filepath) throws Exception {
        File file = new File(filepath);
        if(file.exists()) {
            if(!file.isDirectory()) {
                file.createNewFile();
            }
        } else {
            File file2 = new File(file.getParent());
            file2.mkdirs();
            if(!file.isDirectory()) {
                file.createNewFile();
            }
        }

        return file;
    }

    public static ArrayList<File> getFileArrayList(ArrayList<File> arrayList, File file) {
        log.info("Method getFileArrayList started");
        if(file.exists() && file.isDirectory()) {
            File[] arr$ = file.listFiles();
            int len$ = arr$.length;

            for(int i$ = 0; i$ < len$; ++i$) {
                File subFile = arr$[i$];
                getFileArrayList(arrayList, subFile);
            }
        } else {
            arrayList.add(file);
        }

        log.info("Method getFileArrayList ended");
        return arrayList;
    }

    public static String convertSize(long size) {
        if(size < 1024L) {
            return size + "B";
        } else {
            String fs = null;
            String unit = "KB";
            if(size < 1048576L) {
                fs = String.valueOf((float)size * 1.0F / 1024.0F);
            } else {
                fs = String.valueOf((float)size * 1.0F / 1048576.0F);
                unit = "MB";
            }

            int point = fs.indexOf(".");
            return point != -1 && point < fs.length() - 3?fs.substring(0, point + 2) + unit:fs + unit;
        }
    }

    public static List<String> SegTextFile(int rows, String sourceFilePath, String targetDirectoryPath) {
        List<String> lists = new ArrayList();
        if(targetDirectoryPath != null && !targetDirectoryPath.equals("") && !targetDirectoryPath.endsWith("/")) {
            targetDirectoryPath = targetDirectoryPath + "/";
        }

        File sourceFile = new File(sourceFilePath);
        File targetFile = new File(targetDirectoryPath);
        if(sourceFile.exists() && rows > 0 && !sourceFile.isDirectory()) {
            if(targetFile.exists()) {
                if(!targetFile.isDirectory()) {
                    return lists;
                }
            } else {
                targetFile.mkdirs();
            }

            try {
                String fileName = sourceFile.getName();
                String prefixn = fileName.substring(0, fileName.lastIndexOf("."));
                String suffixn = fileName.substring(fileName.lastIndexOf("."), fileName.length());
                String targetFilePath = targetFile.getAbsolutePath() + "/";
                String name = null;
                String targetName = null;
                BufferedReader br = new BufferedReader(new FileReader(sourceFile));
                StringBuffer str = new StringBuffer();
                String tempData = br.readLine();
                int i = 1;

                int s;
                for(s = 1; tempData != null; tempData = br.readLine()) {
                    str.append(tempData).append("\r\n");
                    if(i % rows == 0) {
                        targetName = prefixn + "_" + s + suffixn;
                        name = targetFilePath + targetName;
                        writeFileByString(name, str.toString(), "UTF-8");
                        str.setLength(0);
                        ++s;
                        i = 0;
                        lists.add(targetName);
                    }

                    ++i;
                }

                if(str.length() > 0) {
                    targetName = prefixn + "_" + s + suffixn;
                    name = targetFilePath + targetName;
                    writeFileByString(name, str.toString(), "UTF-8");
                    ++s;
                    lists.add(targetName);
                }
            } catch (Exception var17) {
                ;
            }

            return lists;
        } else {
            return lists;
        }
    }

    public static void main(String[] args) {
        List<String> names = SegTextFile(30000, "E:/mywork/PJ375/BK/sync/NODE_CONT_201211230300_101/NODE_CONT_201211230300_101.TXT", "E:/mywork/PJ375/BK/sync/NODE_CONT_201211230300_101/NODE_CONT_201211230300_101");
        System.out.print(names.size());
    }
}