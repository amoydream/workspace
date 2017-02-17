package com.lauvan.apps.geographic.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.xml.namespace.QName;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
/**
 * 获取天气预报
 */
public class WeatherUtil {

	private static String url = "http://www.webxml.com.cn/WebServices/WeatherWebService.asmx";
	private static String soapaction = "http://WebXml.com.cn/";
	
	@SuppressWarnings("unchecked")
	public static List<String> getWeather(String city){
		Service service = new Service();
		try{
			 List<String> result = new ArrayList<String>();
			 Call call=(Call)service.createCall(); 
			 call.setTargetEndpointAddress(url);
			 call.setOperationName(new QName(soapaction, "getWeatherbyCityName"));
			 call.addParameter(new QName(soapaction, "theCityName"),
					 org.apache.axis.encoding.XMLType.XSD_STRING,
					 javax.xml.rpc.ParameterMode.IN);
			 call.setReturnType(new QName(soapaction, "getWeatherbyCityName"), Vector.class);
			 call.setUseSOAPAction(true);
			 call.setSOAPActionURI(soapaction + "getWeatherbyCityName");
			 
			 Vector v = (Vector)call.invoke(new Object[]{city});
			 String[] arr = v.get(10).toString().split("；");
			 int len = arr.length-1;
			 for(int i=0; i<len; i++){
				 if(i==0){
					 result.add(arr[i].substring(7));
				 }else{
					 result.add(arr[i]);
				 }
			 }
			 return result;
		}catch(Exception ex){
			
		}
		return null;
	}

	public static void main(String[] args) {
		List<String> result = WeatherUtil.getWeather("惠州");
		for(String str : result){
			System.out.println(str);
		}
	}
}
