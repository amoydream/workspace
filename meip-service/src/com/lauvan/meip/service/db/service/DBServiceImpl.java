package com.lauvan.meip.service.db.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.lauvan.meip.service.db.dao.DfsdlDao;
import com.lauvan.meip.service.db.dao.Jsdl2Dao;
import com.lauvan.meip.service.db.dao.JsdlDao;
import com.lauvan.meip.service.db.dao.MsgDao;
import com.lauvan.meip.service.db.dao.ReceiveFailedDao;
import com.lauvan.meip.service.db.dao.StatuReportDao;
import com.lauvan.meip.service.db.dao.YfsdlDao;
import com.lauvan.meip.service.item.DfsdlItem;
import com.lauvan.meip.service.item.DfsdlResult;
import com.lauvan.meip.service.item.Jsdl2Item;
import com.lauvan.meip.service.item.Jsdl2Result;
import com.lauvan.meip.service.item.JsdlItem;
import com.lauvan.meip.service.item.JsdlResult;
import com.lauvan.meip.service.item.MsgItem;
import com.lauvan.meip.service.item.MsgResult;
import com.lauvan.meip.service.item.ReceiveFailedItem;
import com.lauvan.meip.service.item.ReceiveFailedResult;
import com.lauvan.meip.service.item.StatuReportItem;
import com.lauvan.meip.service.item.StatuReportResult;
import com.lauvan.meip.service.item.YfsdlItem;
import com.lauvan.meip.service.item.YfsdlResult;
import com.lauvan.meip.service.util.Utils;

@Service("dbService")
public class DBServiceImpl implements DBService {
	@Autowired
	private DfsdlDao			dfsdlDao;

	@Autowired
	private YfsdlDao			yfsdlDao;

	@Autowired
	private JsdlDao				jsdlDao;

	@Autowired
	private Jsdl2Dao			jsdl2Dao;

	@Autowired
	private MsgDao				msgDao;

	@Autowired
	private ReceiveFailedDao	receiveFailedDao;

	@Autowired
	private StatuReportDao		statuReportDao;

	@Autowired
	private Properties			config;

	@Override
	public DfsdlResult send(DfsdlItem item) {
		DfsdlResult result = new DfsdlResult();
		String content = item.getContent();
		List<String> contents = new ArrayList<>();
		String limit = config.getProperty("meip.msglength_limit");
		int lengthLimit = 500;
		if(limit != null) {
			try {
				lengthLimit = Integer.parseInt(config.getProperty("meip.msglength_limit"));
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		if(lengthLimit < 3) {
			lengthLimit = 500;
		}
		if(content.length() > lengthLimit) {
			int i = lengthLimit - 3;
			String substr = null;
			while((substr = content.substring(0, i)) != null) {
				contents.add(substr + "...");
				content = content.substring(i);
				if(content != null && content.length() > 0 && content.length() <= lengthLimit) {
					contents.add(content);
					break;
				}
			}
		} else {
			contents.add(content);
		}
		try {
			String eid = config.getProperty("meip.eid");
			String userid = config.getProperty("meip.userid");
			String password = config.getProperty("meip.password");
			String userport = config.getProperty("meip.userport");
			String deadtime_minute = config.getProperty("meip.deadtime_minute");
			Date deadtime = null;
			Calendar c = Calendar.getInstance();
			c.set(12, c.get(12) + Integer.parseInt(deadtime_minute));
			deadtime = c.getTime();
			item.setEid(eid);
			item.setUserid(userid);
			item.setPassword(password);
			item.setUserport(userport);
			item.setDeadtime(deadtime);
			for(String cont : contents) {
				DfsdlItem it = new DfsdlItem();
				BeanUtils.copyProperties(item, it);
				it.setContent(cont);
				result = dfsdlDao.send(it);
				if(!result.isSuccess()) {
					return result;
				}
			}
		} catch(Exception e) {
			result.setSuccess(false);
			result.setMsg("短信服务异常: " + e.getMessage());
			return result;
		}

		result.setMsg("信息已提交");
		result.setSuccess(true);

		return result;
	}

	@Override
	public DfsdlResult resend(Integer[] idArr) {
		return dfsdlDao.resend(idArr);
	}

	@Override
	public JsdlResult updateJsdlStatus(Integer id) {
		return jsdlDao.updateJsdlStatus(id);
	}

	@Override
	public DfsdlResult getDfsdlById(Integer id) {
		return dfsdlDao.getDfsdlById(id);
	}

	@Override
	public YfsdlResult getYfsdlById(Integer id) {
		return yfsdlDao.getYfsdlById(id);
	}

	@Override
	public JsdlResult getJsdlById(Integer id) {
		return jsdlDao.getJsdlById(id);
	}

	@Override
	public JsdlResult getLatestJsdl() {
		return jsdlDao.getLatestJsdl();
	}

	@Override
	public Jsdl2Result getJsdl2ById(Integer id) {
		return jsdl2Dao.getJsdl2ById(id);
	}

	@Override
	public MsgResult getMsgById(Integer id) {
		return msgDao.getMsgById(id);
	}

	@Override
	public ReceiveFailedResult getReceiveFailedById(Integer id) {
		return receiveFailedDao.getReceiveFailedById(id);
	}

	@Override
	public StatuReportResult getStatuReportById(Integer id) {
		return statuReportDao.getStatuReportById(id);
	}

	@Override
	public DfsdlResult getAllDfsdl() {
		return dfsdlDao.getALLDfsdl();
	}

	@Override
	public YfsdlResult getAllYfdl() {
		return yfsdlDao.getALLYfsdl();
	}

	@Override
	public JsdlResult getAllJsdl() {
		return jsdlDao.getALLJsdl();
	}

	@Override
	public Jsdl2Result getAllJsdl2() {
		return jsdl2Dao.getALLJsdl2();
	}

	@Override
	public MsgResult getAllMsg() {
		return msgDao.getALLMsg();
	}

	@Override
	public ReceiveFailedResult getAllReceiveFailed() {
		return receiveFailedDao.getALLReceiveFailed();
	}

	@Override
	public StatuReportResult getAllStatuReport() {
		return statuReportDao.getALLStatuReport();
	}

	@Override
	public DfsdlResult getDfsdlByItem(DfsdlItem item) {
		return dfsdlDao.getDfsdlByItem(item);
	}

	@Override
	public YfsdlResult getYfsdlByItem(YfsdlItem item) {
		return yfsdlDao.getYfsdlByItem(item);
	}

	@Override
	public JsdlResult getJsdlByItem(JsdlItem item) {
		return jsdlDao.getJsdlByItem(item);
	}

	@Override
	public Jsdl2Result getJsdl2ByItem(Jsdl2Item item) {
		return jsdl2Dao.getJsdl2ByItem(item);
	}

	@Override
	public MsgResult getMsgByItem(MsgItem item) {
		return msgDao.getMsgByItem(item);
	}

	@Override
	public ReceiveFailedResult getReceiveFailedByItem(ReceiveFailedItem item) {
		return receiveFailedDao.getReceiveFailedByItem(item);
	}

	@Override
	public StatuReportResult getStatuReportByItem(StatuReportItem item) {
		return statuReportDao.getStatuReportByItem(item);
	}

	@Override
	public DfsdlResult getDfsdlPage(DfsdlItem item) {
		return dfsdlDao.getDfsdlPage(item);
	}

	@Override
	public YfsdlResult getYfsdlPage(YfsdlItem item) {
		return yfsdlDao.getYfsdlPage(item);
	}

	@Override
	public JsdlResult getJsdlPage(JsdlItem item) {
		return jsdlDao.getJsdlPage(item);
	}

	@Override
	public Jsdl2Result getJsdl2Page(Jsdl2Item item) {
		return jsdl2Dao.getJsdl2Page(item);
	}

	@Override
	public MsgResult getMsgPage(MsgItem item) {
		return msgDao.getMsgPage(item);
	}

	@Override
	public MsgResult getMsgGroupPage(MsgItem item) {
		return msgDao.getMsgGroupPage(item);
	}

	@Override
	public ReceiveFailedResult getReceiveFailedPage(ReceiveFailedItem item) {
		return receiveFailedDao.getReceiveFailedPage(item);
	}

	@Override
	public StatuReportResult getStatuReportPage(StatuReportItem item) {
		return statuReportDao.getStatuReportPage(item);
	}

	@Override
	public DfsdlResult deleteDfsdl(Integer[] idArr) {
		return dfsdlDao.delete(idArr);
	}

	@Override
	public YfsdlResult deleteYfsdl(Integer[] idArr) {
		return yfsdlDao.delete(idArr);
	}

	@Override
	public JsdlResult deleteJsdl(Integer[] idArr) {
		return jsdlDao.delete(idArr);
	}

	@Override
	public Jsdl2Result deleteJsdl2(Integer[] idArr) {
		return jsdl2Dao.delete(idArr);
	}

	@Override
	public MsgResult deleteMsg(String[] idArr) {
		MsgResult result = new MsgResult();
		try {
			if(idArr != null && idArr.length > 0) {
				List<Integer> idList1 = new ArrayList<>();
				List<Integer> idList2 = new ArrayList<>();
				List<Integer> idList3 = new ArrayList<>();
				for(String id : idArr) {
					id = id.trim();
					if(!StringUtils.isEmpty(id)) {
						if(id.startsWith("1_")) {
							id = id.replaceFirst("1_", "");
							if(!StringUtils.isEmpty(id) && Utils.isNumber(id)) {
								idList1.add(Integer.valueOf(Integer.parseInt(id)));
							}
						} else if(id.startsWith("2_")) {
							id = id.replaceFirst("2_", "");
							if(!StringUtils.isEmpty(id) && Utils.isNumber(id)) {
								idList2.add(Integer.valueOf(Integer.parseInt(id)));
							}
						} else if(id.startsWith("3_")) {
							id = id.replaceFirst("3_", "");
							if(!StringUtils.isEmpty(id) && Utils.isNumber(id)) {
								idList3.add(Integer.valueOf(Integer.parseInt(id)));
							}
						}
					}
				}

				YfsdlResult result1 = null;
				JsdlResult result2 = null;
				Jsdl2Result result3 = null;
				if(idList1.size() + idList2.size() + idList3.size() == 0) {
					result.setSuccess(true);
					result.setMsg("未删除任何数据");
				} else {
					if(idList1.size() > 0) {
						result1 = yfsdlDao.delete(idList1.toArray(new Integer[0]));
					}

					if(idList1.size() > 0) {
						result2 = jsdlDao.delete(idList2.toArray(new Integer[0]));
					}

					if(idList1.size() > 0) {
						result3 = jsdl2Dao.delete(idList3.toArray(new Integer[0]));
					}

					if(result1 != null && result1.isSuccess() || result2 != null && result2.isSuccess() || result3 != null && result3.isSuccess()) {
						result.setSuccess(true);
						if(idList1.size() + idList2.size() + idList3.size() < idArr.length) {
							result.setMsg("部分数据未删除");
						} else {
							result.setMsg("删除成功");
						}
					} else {
						result.setSuccess(false);
						result.setMsg("短信服务异常: 删除失败");
					}
				}
			} else {
				result.setSuccess(true);
				result.setMsg("未删除任何数据");
			}
		} catch(Exception e) {
			result.setSuccess(false);
			result.setMsg("短信服务异常: " + e.getMessage());
		}

		return result;
	}

	@Override
	public ReceiveFailedResult deleteReceiveFailed(Integer[] idArr) {
		return receiveFailedDao.delete(idArr);
	}

	@Override
	public StatuReportResult deleteStatuReport(Integer[] idArr) {
		return statuReportDao.delete(idArr);
	}

	@Override
	public DfsdlResult physicalDeleteDfsdl(Integer[] idArr) {
		return dfsdlDao.physicalDelete(idArr);
	}

	@Override
	public YfsdlResult physicalDeleteYfsdl(Integer[] idArr) {
		return yfsdlDao.physicalDelete(idArr);
	}

	@Override
	public JsdlResult physicalDeleteJsdl(Integer[] idArr) {
		return jsdlDao.physicalDelete(idArr);
	}

	@Override
	public Jsdl2Result physicalDeleteJsdl2(Integer[] idArr) {
		return jsdl2Dao.physicalDelete(idArr);
	}

	@Override
	public MsgResult physicalDeleteMsg(String[] idArr) {
		MsgResult result = new MsgResult();
		try {
			if(idArr != null && idArr.length > 0) {
				List<Integer> idList1 = new ArrayList<>();
				List<Integer> idList2 = new ArrayList<>();
				List<Integer> idList3 = new ArrayList<>();
				for(String id : idArr) {
					id = id.trim();
					if(!StringUtils.isEmpty(id)) {
						if(id.startsWith("1_")) {
							id = id.replaceFirst("1_", "");
							if(!StringUtils.isEmpty(id) && Utils.isNumber(id)) {
								idList1.add(Integer.valueOf(Integer.parseInt(id)));
							}
						} else if(id.startsWith("2_")) {
							id = id.replaceFirst("2_", "");
							if(!StringUtils.isEmpty(id) && Utils.isNumber(id)) {
								idList2.add(Integer.valueOf(Integer.parseInt(id)));
							}
						} else if(id.startsWith("3_")) {
							id = id.replaceFirst("3_", "");
							if(!StringUtils.isEmpty(id) && Utils.isNumber(id)) {
								idList3.add(Integer.valueOf(Integer.parseInt(id)));
							}
						}
					}
				}

				YfsdlResult result1 = null;
				JsdlResult result2 = null;
				Jsdl2Result result3 = null;
				if(idList1.size() + idList2.size() + idList3.size() == 0) {
					result.setSuccess(true);
					result.setMsg("未删除任何数据");
				} else {
					if(idList1.size() > 0) {
						result1 = yfsdlDao.physicalDelete(idList1.toArray(new Integer[0]));
					}

					if(idList1.size() > 0) {
						result2 = jsdlDao.physicalDelete(idList2.toArray(new Integer[0]));
					}

					if(idList1.size() > 0) {
						result3 = jsdl2Dao.physicalDelete(idList3.toArray(new Integer[0]));
					}

					if(result1 != null && result1.isSuccess() || result2 != null && result2.isSuccess() || result3 != null && result3.isSuccess()) {
						result.setSuccess(true);
						if(idList1.size() + idList2.size() + idList3.size() < idArr.length) {
							result.setMsg("部分数据未删除");
						} else {
							result.setMsg("删除成功");
						}
					} else {
						result.setSuccess(false);
						result.setMsg("短信服务异常: 删除失败");
					}
				}
			} else {
				result.setSuccess(true);
				result.setMsg("未删除任何数据");
			}
		} catch(Exception e) {
			result.setSuccess(false);
			result.setMsg("短信服务异常: " + e.getMessage());
		}
		return result;
	}

	@Override
	public ReceiveFailedResult physicalDeleteReceiveFailed(Integer[] idArr) {
		return receiveFailedDao.physicalDelete(idArr);
	}

	@Override
	public StatuReportResult physicalDeleteStatuReport(Integer[] idArr) {
		return statuReportDao.physicalDelete(idArr);
	}
}