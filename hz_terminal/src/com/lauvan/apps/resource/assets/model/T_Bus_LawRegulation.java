package com.lauvan.apps.resource.assets.model;

import java.io.File;
import java.util.List;

import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Model;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.core.annotation.TableBind;

/**
 * 法律法规
 * @author Bob
 *
 */
@TableBind(name = "t_bus_lawregulation", pk = "lr_id")
public class T_Bus_LawRegulation extends Model<T_Bus_LawRegulation> {

	private static final long			serialVersionUID	= 1L;
	public static T_Bus_LawRegulation	dao					= new T_Bus_LawRegulation();

	/**
	 * 删除法律法规
	 *
	 * @param ids
	 *            法律法规id
	 * @return
	 */
	public boolean delete(Integer[] ids) throws Exception {
		try {
			boolean flag = false;
			for(Integer id : ids) {
				try {
					T_Bus_LawRegulation lr = dao.findById(id);
					// 附件列表
					List<T_Attachment> attlist = T_Attachment.dao.getListByIds(lr.getStr("lr_attachmentid"));
					// 删除数据库所有附件信息
					if(attlist != null) {
						for(T_Attachment model : attlist) {
							String url = model.getStr("url");
							if(!url.startsWith("/") && url.indexOf(":") != 1) {
								url = PathKit.getWebRootPath() + "/" + model.getStr("url");
							}
							File file = new File(url);
							if(file.exists()) {
								file.delete();
							}
							model.delete();
						}
					}
					flag = dao.deleteById(id);

				} catch(Exception e) {
					// log.error("附件删除错误！id：" + id);
					e.printStackTrace();
				}
			}

			return flag;
		} catch(Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
	}

}
