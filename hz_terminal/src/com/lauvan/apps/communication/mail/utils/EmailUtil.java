package com.lauvan.apps.communication.mail.utils;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Flags;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Part;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import org.apache.log4j.Logger;

import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.communication.mail.model.T_Bus_Mail_Rece;
import com.lauvan.config.JFWebConfig;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.FileUtils;

/**
 * 邮件收发工具类
 * */
public class EmailUtil {
	private static final Logger log = Logger.getLogger(EmailUtil.class);
	private static HashMap<String, String>	attrMap		= JFWebConfig.attrMap;
	public static String mailhost =attrMap.get("mailhost");// "smtp.163.com";
	public static String mailprot = attrMap.get("mailprot");//"smtp";
	
	public static String mailhost_re = attrMap.get("mailhost_re"); //"pop.163.com";
	public static String mailprotocol_re = attrMap.get("mailprotocol_re");//"pop3";
	public static String mailprot_re = attrMap.get("mailprot_re"); //"995";
	//主邮件地址
	public static String mailuser = attrMap.get("mailuser"); //"jmailcs@163.com";
	public static String mailpwd = attrMap.get("mailpwd");//"jmail123";  jmailcs123
	
	/**
	 * 邮件发送
	 * Message.addRecipient(Message.Recipient recipient, Address address); 发邮件的时候指定收件人和收件人的角色 
	 * Message.RecipientType.TO 收件人 
	 * Message.RecipientType.CC 抄送，即发邮件的时候顺便给另一个人抄一份，不用回复！但是，上边的收件人可以看到你都抄送给了谁 
	 * Message.RecipientType.BCC 暗送，也是发邮件的时候顺便给另一个人暗发一份，但是，不同于上边的是，收件人不能看到你都暗送给了谁 
	 * */
	public static boolean send(String address_to,String address_cc,String subject,String conhtml,List<String> filepath){
		boolean flag = true;
		Properties props = new Properties();  
        // 开启debug调试  
        //props.setProperty("mail.debug", "true");  
        // 发送服务器需要身份验证  
        props.setProperty("mail.smtp.auth", "true");  
        // 设置邮件服务器主机名  
        props.setProperty("mail.host", mailhost);  
        // 发送邮件协议名称  
        props.setProperty("mail.transport.protocol", mailprot);  
          
        try {
			// 设置环境信息  
			//Session session = Session.getInstance(props);  
			//使用Authenticator把用户名和密码封装起来，不透明
			Session session = Session.getInstance(props, new Authenticator() { 
			      protected PasswordAuthentication getPasswordAuthentication() { 
			        return new PasswordAuthentication(mailuser, mailpwd); 
			      } 
			    });
			MimeMessage msg = new MimeMessage(session);// 声明一个邮件体 
		    msg.setFrom(new InternetAddress(mailuser)); 
		    msg.setSubject(subject);//设置邮件主题 
		    //收件人
		    if(address_to!=null && !"".equals(address_to)){
		    	msg.setRecipients(MimeMessage.RecipientType.TO, InternetAddress.parse(address_to));
		    }
		    //msg.setRecipients(MimeMessage.RecipientType.TO, 
		    //		InternetAddress.parse(MimeUtility.encodeText("王翔攀")+"<wangxiangpan@126.com>,"+MimeUtility.encodeText("三毛")+"<492134880@qq.com>")); 
		    //抄送人
		    if(address_cc!=null && !"".equals(address_cc)){
		    	msg.setRecipients(MimeMessage.RecipientType.CC, InternetAddress.parse(address_cc));
		    }
		    
		    
		    MimeMultipart msgMultipart = new MimeMultipart();
		    msg.setContent(msgMultipart);// 设置邮件体 
		    
		    // 邮件的正文，混合体（图片+文字） 
		    MimeBodyPart content = new MimeBodyPart();
		    
		    if(conhtml==null){
		    	conhtml="";
		    }
		    
		    content.setContent(conhtml, "text/html; charset=utf-8");
		    msgMultipart.addBodyPart(content); 
		    
		    if(filepath!=null && filepath.size()>0){
		    	for(int i=0;i<filepath.size();i++){
		    		MimeBodyPart attch = new MimeBodyPart();
			    	// 设置附件 
		    		String fpath = filepath.get(i);
				    DataSource ds = new FileDataSource(fpath);// 指定附件的数据源 
				    DataHandler dh = new DataHandler(ds);// 附件的信息 
				    attch.setDataHandler(dh);// 指定附件
				    String fname = ds.getName();
				    attch.setFileName(MimeUtility.encodeText(fname)); 
			    	// 将附件和正文设置到这个邮件体中
			    	msgMultipart.addBodyPart(attch); 
		    	}
		    	
		    }
		   
		    Transport.send(msg);   
			
		}  catch (Exception e) {
			flag = false;
			//e.printStackTrace();
			log.error(e.getMessage());
		} 
        return flag;
	}
	/**
	 * 邮件接收
	 * @param startnum 接收邮件开始序号,序号从1开始
	 * @param fjpath   附件存储路径（绝对路径）
	 * return 返回已接受邮件数
	 * */
	public static Integer receive(Integer startnum,String fjpath){
		Properties props = new Properties();
        props.put("mail.pop3.ssl.enable", "true");
        props.put("mail.pop3.host", mailhost_re);
        props.put("mail.pop3.port", mailprot_re);
        
        Session session = Session.getDefaultInstance(props);
        
        Store store = null;
        Folder folder = null;
        try {
            store = session.getStore(mailprotocol_re);
            store.connect(mailuser, mailpwd);
       
            folder = store.getFolder("INBOX");
            folder.open(Folder.READ_ONLY);
       
            int size = folder.getMessageCount();
            if(size>0 && startnum<size){
            	//Message message = folder.getMessage(size);
            	startnum = startnum +1;
                Message message[] = folder.getMessages(startnum, size);
                if(message!=null && message.length>0){
                	for(int i=0;i<message.length;i++){
                		//判断邮件文件夹是否打开
                		if(!message[i].getFolder().isOpen()){
                			message[i].getFolder().open(Folder.READ_ONLY);
                		}
                		//获取发件人信息
                		InternetAddress address[] = (InternetAddress[]) message[i].getFrom();   
                        String from = address[0].getAddress();   
                        if (from == null)   
                            from = "";   
                        String personal = address[0].getPersonal();   
                        if (personal == null)   
                            personal = "";   
                        String fromaddr = personal + "<" + from + ">";
                        //主题
                        String subject = message[i].getSubject();
                        //发送时间
                        Date date = message[i].getSentDate();
                        
                        //获得邮件的收件人，抄送，的地址和姓名
                        String address_to = getAddress(message[i],Message.RecipientType.TO);
                        String address_cc = getAddress(message[i],Message.RecipientType.CC);
                        
                        T_Bus_Mail_Rece rece = new T_Bus_Mail_Rece();
                        rece.set("subject", subject);
                        rece.set("sender", fromaddr);
                        rece.set("address_to", address_to);
                        rece.set("address_cc", address_cc);
                        rece.set("send_time", DateTimeUtil.formatDate(date, DateTimeUtil.Y_M_D_HMS_FORMAT));
                        rece.set("emseq", startnum+i);
                        rece.set("msgid", ((MimeMessage)message[i]).getMessageID());
                        //内容
                        StringBuffer content = new StringBuffer();
                        getMailContent(content,(Part)message[i]);
                        rece.set("content", content.toString());
                        
                        if(isContainAttach((Part)message[i])){
                        	//插入附件
                        	StringBuffer fjids = new StringBuffer();
                        	saveAttachMent((Part)message[i],fjpath+"/mail"+(startnum+i),fjids);
                        	rece.set("fjids", fjids.toString());
                        }
                        ((com.sun.mail.pop3.POP3Message)message[i]).invalidate(true);//使缓存失效,解决OutOfMemory 异常
                        T_Bus_Mail_Rece.dao.insert(rece);
                        
                	} 
                }
            }
            return size;
          } catch (Exception e) {
            //e.printStackTrace();
            log.error(e.getMessage());
            return 0;
          } finally {
            try {
              if (folder != null) {
                folder.close(false);
              }
              if (store != null) {
                store.close();
              }
            } catch (Exception e) {
              //e.printStackTrace();
              log.error(e.getMessage());
            }
          }
       
	}
	/**
	 * 获得邮件的收件人，抄送，的地址和姓名
	 * */
	public static String getAddress(Message message,RecipientType type){
		StringBuffer addto = new StringBuffer();
		InternetAddress[] address_to = null;
		try {
			address_to = (InternetAddress[])message.getRecipients(type);
			if(address_to!=null && address_to.length>0){
				for(InternetAddress a : address_to){
					String email = a.getAddress();   
			        if (email == null)   
			            email = "";   
			        else {   
			            email = MimeUtility.decodeText(email);   
			        }   
			        String aname = a.getPersonal();   
			        if (aname == null)   
			        	aname = "";   
			        else {   
			        	aname = MimeUtility.decodeText(aname);   
			        }   
			        if(addto.length()>0){
			        	addto.append(",");
			        }
			        addto.append(aname + "<" + email + ">");
				}
			}
			return addto.toString();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public static boolean checkHasHtml(Multipart part) throws MessagingException, IOException{
		  boolean hasHtml = false;
		  int count = part.getCount();
		  for(int i = 0 ; i < count ; i++ ){
		   Part bodyPart = part.getBodyPart(i);
		   if (bodyPart.isMimeType("text/html")) {
		    hasHtml = true;
		    break;
		   }
		  }
		  return hasHtml;
		 }
	
	 /**  
   * 判断此邮件是否包含附件  
   */  
  public static boolean isContainAttach(Part part) throws Exception {   
      boolean attachflag = false;   
      //String contentType = part.getContentType();   
      if (part.isMimeType("multipart/*")) {   
          Multipart mp = (Multipart) part.getContent();   
          for (int i = 0; i < mp.getCount(); i++) {   
              BodyPart mpart = mp.getBodyPart(i);   
              String disposition = mpart.getDisposition();   
              if ((disposition != null)   
                      && ((disposition.equals(Part.ATTACHMENT)) || (disposition   
                              .equals(Part.INLINE))))   
                  attachflag = true;   
              else if (mpart.isMimeType("multipart/*")) {   
                  attachflag = isContainAttach((Part) mpart);   
              } else {   
                  String contype = mpart.getContentType();   
                  if (contype.toLowerCase().indexOf("application") != -1)   
                      attachflag = true;   
                  if (contype.toLowerCase().indexOf("name") != -1)   
                      attachflag = true;   
              }   
          }   
      } else if (part.isMimeType("message/rfc822")) {   
          attachflag = isContainAttach((Part) part.getContent());   
      }   
      return attachflag;   
  }
	
	/**
	 * 获取邮件内容
	 * */
	public static void getMailContent (StringBuffer content,Part message){
		 try {
			String contenttype = message.getContentType();   
			 int nameindex = contenttype.indexOf("name");   
			 boolean conname = false;   
			 if (nameindex != -1){
				 conname = true;
			 }     
			 if (message.isMimeType("text/plain") && !conname) {   
				 content.append((String) message.getContent());   
			 } else if (message.isMimeType("text/html") && !conname) {   
				content.append((String) message.getContent());   
			 } else if (message.isMimeType("multipart/*")) {   
			    Multipart multipart = (Multipart) message.getContent();   
			    int counts = multipart.getCount();
			    boolean hasHtml = checkHasHtml(multipart);//这里校验是否有text/html内容
			    for (int i = 0; i < counts; i++) {
			    	Part temp = multipart.getBodyPart(i);
			        if(temp.isMimeType("text/plain")&&hasHtml){
			        //有html格式的则不显示无格式文档的内容
			        }else{
			        	getMailContent(content,multipart.getBodyPart(i));  
			        }
			        
			    }   
			} else if (message.isMimeType("message/rfc822")) {   
			    getMailContent(content,(Part)message.getContent());   
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}    
	}
	
    
    /**   
     * 【保存邮件附件】   
     */   
    public static void saveAttachMent(Part part,String mailfjPath,StringBuffer fjids) throws Exception {   
        String fileName = "";
        
        File mpath = new File(mailfjPath);
        if(!mpath.exists()){
        	mpath.mkdirs();
        }
        
        if (part.isMimeType("multipart/*")) {   
            Multipart mp = (Multipart) part.getContent();   
            for (int i = 0; i < mp.getCount(); i++) {   
                BodyPart mpart = mp.getBodyPart(i);   
                String disposition = mpart.getDisposition();   
                if ((disposition != null)   
                        && ((disposition.equals(Part.ATTACHMENT)) || (disposition   
                                .equals(Part.INLINE)))) {   
                    fileName = mpart.getFileName();   
                    if (fileName.toLowerCase().startsWith("=?gb") || fileName.toLowerCase().startsWith("=?utf")) {
                    	fileName = fileName.replace("\r","").replace("\n","");
                        fileName = MimeUtility.decodeText(fileName);   
                    }   
                    //saveFile(fileName, mpart.getInputStream());
                    
                    String fmailfjPath = mailfjPath+"/"+fileName;
                    File file = new File(fmailfjPath);
                    if(!file.exists()){
                    	file.createNewFile();
                    }
                    BufferedOutputStream bos = null;  
                    BufferedInputStream bis = null;
                    bos = new BufferedOutputStream(new FileOutputStream(file));  
                    bis = new BufferedInputStream(mpart.getInputStream());  
                    int c;  
                    while ((c = bis.read()) != -1) {  
                        bos.write(c);  
                        bos.flush();  
                    }
					bos.close();
                    bis.close();
        			
        			File afile = new File(fmailfjPath);
        			String m_type = fileName.substring(fileName.lastIndexOf('.') + 1);
        			String m_size = FileUtils.getFileSize(afile.length());
        			System.out.println("url:"+fmailfjPath+",name:"+fileName+",m_type:"+m_type+",m_size:"+m_size);
        			T_Attachment t = new T_Attachment();
        			t.set("name", fileName);
        			t.set("url", fmailfjPath);
        			t.set("m_type", m_type);
        			t.set("m_size", m_size);
        			String id = T_Attachment.dao.insert(t);
        			if(id!=null && !"".equals(id)){
        				if(fjids.length()>0){
        					fjids.append(",");
        				}
        				fjids.append(id);
        			}
                } else if (mpart.isMimeType("multipart/*")) {   
                    saveAttachMent(mpart,mailfjPath,fjids);   
                } else {   
                    fileName = mpart.getFileName();   
                    if ((fileName != null)   
                            && (fileName.toLowerCase().startsWith("=?gb") || fileName.toLowerCase().startsWith("=?utf"))) {
                    	fileName = fileName.replace("\r","").replace("\n","");
                        fileName = MimeUtility.decodeText(fileName);   
                        //saveFile(fileName, mpart.getInputStream());
                       
                        String fmailfjPath = mailfjPath+"/"+fileName;
                        File file = new File(fmailfjPath);
                        if(!file.exists()){
                        	file.createNewFile();
                        }
                        BufferedOutputStream bos = null;  
                        BufferedInputStream bis = null;
                        bos = new BufferedOutputStream(new FileOutputStream(file));  
                        bis = new BufferedInputStream(mpart.getInputStream());
                        int c;  
                        while ((c = bis.read()) != -1) {  
                            bos.write(c);  
                            bos.flush();  
                        }
    					bos.close();
                        bis.close();
            			File afile = new File(fmailfjPath);
            			String m_type = fileName.substring(fileName.lastIndexOf('.') + 1);
            			String m_size = FileUtils.getFileSize(afile.length());
            			System.out.println("url:"+fmailfjPath+",name:"+fileName+",m_type:"+m_type+",m_size:"+m_size);
            			T_Attachment t = new T_Attachment();
            			t.set("name", fileName);
            			t.set("url", fmailfjPath);
            			t.set("m_type", m_type);
            			t.set("m_size", m_size);
            			String id = T_Attachment.dao.insert(t);
            			if(id!=null && !"".equals(id)){
            				if(fjids.length()>0){
            					fjids.append(",");
            				}
            				fjids.append(id);
            			}
                    }   
                }   
            }   
        } else if (part.isMimeType("message/rfc822")) {   
            saveAttachMent((Part) part.getContent(),mailfjPath,fjids);   
        }   
    } 
	
    /**
     * 删除邮件
     * */
    public static boolean deleteMail(String messageids){
    	boolean result = true;
    	Properties props = new Properties();  
        props.put("mail.pop3.ssl.enable", "true");
        props.put("mail.pop3.host", mailhost_re);
        props.put("mail.pop3.port", mailprot_re);
        
        Session session = Session.getDefaultInstance(props);
        
        Store store = null;
        Folder folder = null;
        try {
            store = session.getStore(mailprotocol_re);
            store.connect(mailuser, mailpwd);
       
            folder = store.getFolder("INBOX");
            folder.open(Folder.READ_WRITE);
       
            int size = folder.getMessageCount();
            System.out.println(size);
            if(size>0){
                Message message[] = folder.getMessages(1, size);
                if(message!=null && message.length>0){
                	for(int i=0;i<message.length;i++){
                		//判断邮件文件夹是否打开
                		if(!message[i].getFolder().isOpen()){
                			message[i].getFolder().open(Folder.READ_WRITE);
                		}
                		String mgsid = ((MimeMessage)message[i]).getMessageID();
                		if((","+messageids+",").indexOf(","+mgsid+",")>=0){
                			message[i].setFlag(Flags.Flag.DELETED, true);
                		}
                	}
               }
            }
            return result;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
          } finally {
            try {
              if (folder != null) {
                folder.close(true);
              }
              if (store != null) {
                store.close();
              }
            } catch (Exception e) {
              e.printStackTrace();
            }
          }
    	
    }
    
	public static void main(String[] args) {
		//String address_to="86354099@qq.com";
		//List<String> fj = new ArrayList<String>();
		//fj.add("E:\\lauvan/arrow.gif");
		//fj.add("E:\\lauvan/惠州医疗保险办事须知（2016年第2版）.doc");
		//send(address_to,"katylink@163.com","纯附件邮件","纯附件邮件！hello，123,有附件",fj);
		//System.out.println("发送成功！");
		//receive(2,"E:\\lauvan\\mail");
		deleteMail("<1552642348.69613.1482017611567.JavaMail.javamailuser@localhost>");
	}
}
