package com.lauvan.apps.massms.service;

import javax.xml.rpc.ServiceException;

public class MasReport {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		 try {
		SMsgService service=new SMsgServiceLocator();
			SMsg_PortType client=service.getSMsg();
			System.out.println(client.recvRPT("hyyj", "hyyj", "hyyj"));
			System.out.println(client.recvMo("hyyj", "hyyj", "hyyj"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
