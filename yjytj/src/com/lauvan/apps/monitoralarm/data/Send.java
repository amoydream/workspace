package com.lauvan.apps.monitoralarm.data;

import java.io.IOException;
import java.io.OutputStream;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;

import com.jfinal.core.Controller;


public class Send extends Controller implements Runnable{
	
	private byte[] sendByte ;
	private String fileName;
	public void setSendData(byte[] sendByte,String fileName){
		this.sendByte = sendByte;
		this.fileName = fileName;
	}

	@Override
	public void run() {
		List<String> head = new ArrayList<String>();  //固定文件头
		int r = 0;
		do{
			Socket soc = null;
			try {
				soc = new Socket("172.12.11.240", 8000);
			} catch (UnknownHostException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			r++;
		    int length = sendByte.length;
			for(int i = 43*(r-1); i<43*r||i<length; i++){
				//文件片段byte数组元素转成integer并插入到list中
				head.add(String.valueOf(sendByte[i]));   
				try {
					OutputStream out = soc.getOutputStream();
					
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			
		}
		while(r== 1);
		
	}

}
