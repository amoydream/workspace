package com.lauvan.meip.service.db.dao;

import com.lauvan.meip.service.item.StatuReportItem;
import com.lauvan.meip.service.item.StatuReportResult;

public abstract interface StatuReportDao extends BaseDao {
	public abstract StatuReportResult getStatuReportById(Integer id);

	public abstract StatuReportResult getALLStatuReport();

	public abstract StatuReportResult getStatuReportByItem(StatuReportItem item);

	public abstract StatuReportResult getStatuReportPage(StatuReportItem item);

	public abstract StatuReportResult delete(Integer[] idArr);

	public abstract StatuReportResult physicalDelete(Integer[] idArr);
}