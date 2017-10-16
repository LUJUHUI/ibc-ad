package com.wondertek.mobilevideo.bc.web.test;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;

import javax.xml.namespace.QName;
import javax.xml.rpc.ParameterMode;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.apache.axis.encoding.ser.BeanDeserializerFactory;
import org.apache.axis.encoding.ser.BeanSerializerFactory;

import com.wondertek.mobilevideo.bc.core.utils.POIUtil;

public class test {
	
	
	public static void main(String[] args) {
		try {
			File file = new File("E://需重新注入的文件/mapping缺失的.xlsx");
			List<String[]> list = POIUtil.readExcel(file);
			for (String[] strings : list) {
				System.out.println(strings[0]+"|"+strings[1]+"|"+strings[2]+"|"+strings[3]+"|"+strings[4]+"|"+strings[5]+"|");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
	}
	
	
	public static void test5(){
		
	}
	
	private static int getRandom(int count) {
		 return (int) Math.round(Math.random() * (count));	
	}
	 
	private static String string = "abcdefghijklmnopqrstuvwxyz";   
	 
	private static String getRandomString(int length){
	    StringBuffer sb = new StringBuffer();
	    int len = string.length();
	    for (int i = 0; i < length; i++) {
	        sb.append(string.charAt(getRandom(len-1)));
	    }
	    return sb.toString();
	}

	public static void test1() {
		try {
//			Service service = new Service();
//			Call call = (Call) service.createCall();
//			call.setOperationName(new QName("http://localhost:8080/bc-plat/services/HelloService/", "sayHello"));
//			call.setTargetEndpointAddress(new URL("http://localhost:8080/bc-plat/services/HelloService?wsdl"));
//			call.setUseSOAPAction(true);
//			QName qn = new QName("CSPResult", "CSPResult");
//			call.registerTypeMapping(ExecCmdResponse.class, qn, new BeanSerializerFactory(ExecCmdResponse.class, qn),
//					new BeanDeserializerFactory(ExecCmdResponse.class, qn));
//			call.addParameter("param", XMLType.XSD_STRING, ParameterMode.IN);
//			call.setReturnType(qn, ExecCmdResponse.class);
//			call.setReturnType(qn,ExecCmdReturn.class);
//			Object o  =  call.invoke(new Object[] {"a"});
//			//CSPResult cspResult = (CSPResult) o;
//			System.out.println("=="+o.toString());
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void test2() {
		try {
			Service service = new Service();
//			Call call = (Call) service.createCall();
//			call.setOperationName(new QName("http://localhost:8080/bc-plat/services/CSPResponseService/", "ResultNotify"));
//			call.setTargetEndpointAddress(new URL("http://localhost:8080/bc-plat/services/CSPResponseService?wsdl"));
//			call.setUseSOAPAction(true);
//			QName qn = new QName("ExecCmdResponse", "ExecCmdResponse");
//			call.registerTypeMapping(ExecCmdResponse.class, qn, new BeanSerializerFactory(ExecCmdResponse.class, qn),
//					new BeanDeserializerFactory(ExecCmdResponse.class, qn));
//			call.addParameter("param1", XMLType.XSD_STRING, ParameterMode.IN);
//			call.addParameter("param2", XMLType.XSD_STRING, ParameterMode.IN);
//			call.addParameter("param3", XMLType.XSD_STRING, ParameterMode.IN);
//			call.addParameter("param4", XMLType.XSD_INT, ParameterMode.IN);
//			call.addParameter("param5", XMLType.XSD_STRING, ParameterMode.IN);
//			call.setReturnType(qn, ExecCmdResponse.class);
			//120000000020,120000000020,90002515945,,-1,ftp://zxin10:zxin10@172.16.3.62:21//home/zxin10/service378/notify/4_4

//			call.invoke(new Object[] { "120000000020", "120000000020", "90002515945", -1, "ftp://zxin10:zxin10@172.16.3.62:21//home/zxin10/service378/notify/4_4" });
			System.out.println("==.....");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void test3(){
		try {
			Service service = new Service();
			Call call = (Call) service.createCall();
			call.setOperationName(new QName("http://localhost:8080/bc-plat/services/HelloService/", "createContent2"));
			call.setTargetEndpointAddress(new URL("http://localhost:8080/bc-plat/services/HelloService?wsdl"));
			call.setUseSOAPAction(true);
			QName qn = new QName("urn:CSPResult", "CSPResult");
			call.registerTypeMapping(CSPResult.class, qn, new BeanSerializerFactory(CSPResult.class, qn),
					new BeanDeserializerFactory(CSPResult.class, qn));
			call.addParameter("ns1", qn, ParameterMode.IN);
			call.setReturnType(qn, CSPResult.class);
			CSPResult evt = new CSPResult();
			evt.setResult(0);
			evt.setErrorDescription("000");
			CSPResult cspResult = (CSPResult) call.invoke(new Object[] {evt});
			System.out.println("=="+cspResult.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public void test4(){
		try {
			File f = new File("E:/code/bc/bestv/doc/03_design/0501ALL.TXT");
    		if (f.exists()) {
    			BufferedReader br = null;
    			try {
    				String line;
    				br = new BufferedReader(new InputStreamReader(new FileInputStream(f), "GBK"));
    				int number=0;
    				while ((line = br.readLine()) != null) {
    					//每行数据
    					line = line.trim();
    					if(line.startsWith("Channel")){
    						System.out.println(line.substring(8, line.length()));
    					}else if(line.startsWith("Date")){
    						System.out.println(line.substring(5, line.length()));
    					}else{
    						System.out.println(line);
    						String str[] = line.split("\\|");
    						String data[] = str[0].split("-");
    						System.out.println(data[0]+","+data[1]);
    						System.out.println(str[1]);
    						
    					}
    					
    					number++;
    				}
    				System.out.println("== 文件处理完成，总行数："+number);
    			} catch (Exception e) {
    				e.printStackTrace();
    			} finally {
    				if(br != null){
    					try {
    						br.close();
    					} catch (Exception e) {
    					}
    				}
    			}
    		}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void downloadFile(String path,String fileName){
		int byteread = 0;
		try {
			URL url = new URL(path);
			URLConnection conn = url.openConnection();
            InputStream inStream = conn.getInputStream();
            FileOutputStream fs = new FileOutputStream(fileName);

            byte[] buffer = new byte[1204];
            while ((byteread = inStream.read(buffer)) != -1) {
                fs.write(buffer, 0, byteread);
            }
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	 public static String xml2String(File file){
	        StringBuilder result = new StringBuilder();
	        try{
	            BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file), "utf-8"));//构造一个BufferedReader类来读取文件
	            String s = null;
	            while((s = br.readLine())!=null){//使用readLine方法，一次读一行
	                result.append(System.lineSeparator()+s);
	            }
	            br.close();    
	        }catch(Exception e){
	            e.printStackTrace();
	        }
	        return result.toString();
    }
	
	
	
}

