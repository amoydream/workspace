package com.lauvan.apps.event.utils;

import com.baidu.yun.core.log.YunLogEvent;
import com.baidu.yun.core.log.YunLogHandler;
import com.baidu.yun.push.auth.PushKeyPair;
import com.baidu.yun.push.client.BaiduPushClient;
import com.baidu.yun.push.constants.BaiduPushConstants;
import com.baidu.yun.push.model.PushMsgToAllRequest;
import com.baidu.yun.push.model.PushMsgToAllResponse;
import com.baidu.yun.push.model.PushMsgToSingleDeviceRequest;
import com.baidu.yun.push.model.PushMsgToSingleDeviceResponse;

import net.sf.json.JSONObject;

public class SendTask {
	public static String apiKey = "dAcgOSGA22toup3jCf09kFlOaiQ4R12c";
	public static String secretKey = "HfNYgwoya0bxUyAKX2S5KOHPxXSuAnzK";
	
	//向单个设备推送消息
	public static String send(JSONObject notification,String token){
		String result = "1";
		PushKeyPair pair = new PushKeyPair(apiKey, secretKey);
		// 2. 创建BaiduPushClient，访问SDK接口
        BaiduPushClient pushClient = new BaiduPushClient(pair,
                BaiduPushConstants.CHANNEL_REST_URL);

        // 3. 注册YunLogHandler，获取本次请求的交互信息
        pushClient.setChannelLogHandler (new YunLogHandler () {
            @Override
            public void onHandle (YunLogEvent event) {
                System.out.println(event.getMessage());
            }
        });
        
     // 4. 设置请求参数，创建请求实例
        PushMsgToSingleDeviceRequest request = new PushMsgToSingleDeviceRequest().
            addChannelId(token).
            addMsgExpires(new Integer(3600*5)).   //设置消息的有效时间,单位秒,默认3600*5.
            addMessageType(0).             //设置消息类型,0表示透传消息,1表示通知,默认为0.
            addMessage(notification.toString()).
            addDeviceType(3);      //设置设备类型，deviceType => 1 for web, 2 for pc, 
                                   //3 for android, 4 for ios, 5 for wp.
    try {
		// 5. 执行Http请求
		    PushMsgToSingleDeviceResponse response = pushClient.pushMsgToSingleDevice(request);
		// 6. Http请求返回值解析
		    System.out.println("msgId: " + response.getMsgId()
		            + ",sendTime: " + response.getSendTime());
	} catch (Exception e) {
		// TODO Auto-generated catch block
		result = "-1";
		e.printStackTrace();
	}
		return result;
	}
	
	//广播推送
	public static String pushAll(JSONObject notification){	
		String result="1";
		PushKeyPair pair = new PushKeyPair(apiKey, secretKey);
		// 1. 创建百度推送接口
		BaiduPushClient pushClient = new BaiduPushClient(pair,
				BaiduPushConstants.CHANNEL_REST_URL);

		// 2. 注册YunLogHandler，获取本次请求的交互信息
		pushClient.setChannelLogHandler(new YunLogHandler() {
			@Override
			public void onHandle(YunLogEvent event) {
				System.out.println(event.getMessage());
			}
		});

		try {
			// 3. 设置请求参数，创建请求实例
			PushMsgToAllRequest request = new PushMsgToAllRequest()
					.addMsgExpires(new Integer(3600))
					.addMessageType(0)
					.addMessage(notification.toString()) //添加透传消息
					.addDeviceType(3);
			// 4. 执行Http请求
			PushMsgToAllResponse response = pushClient.pushMsgToAll(request);
			// 5.Http请求结果解析打印
			System.out.println("msgId: " + response.getMsgId() + ",sendTime: "
					+ response.getSendTime() + ",timerId: "
					+ response.getTimerId());
		} catch (Exception e) {	
			    result = "-1";
				e.printStackTrace();
		} 
		return result;
	  }
}
