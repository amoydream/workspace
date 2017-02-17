package com.lauvan.event.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class EventInfoVo {

	private Integer	ev_id;
	/**
	 * 事件名称
	 */
	private String	ev_name;
	/**
	 * 事件地点
	 */
	private String	ev_address;
	/**
	 * 事发地点所在镇
	 */
	private String ev_address_town;
	/**
	 * 事发时间
	 */
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date	ev_date;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date	ev_dateBegin;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date	ev_dateEnd;
	/**
	 * 接报时间
	 */
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date	ev_reportDate;
	/**
	 * 事件类型
	 */
	private Integer	eventTypeId;
	private String	et_name;
	/**
	 * 事发单位
	 */
	private Integer	organId;
	/**
	 * 事件级别
	 */
	private String	ev_level;
	/**
	 * 接报方式
	 */
	private String	ev_reportMode;
	/**
	 * 受灾面积(㎡)
	 */
	private Double	ev_affectedArea;
	/**
	 * 参与（受灾）人数
	 */
	private Integer	ev_participationNumber;
	/**
	 * 受伤人数
	 */
	private Integer	ev_injuredPeople;
	/**
	 * 死亡人数
	 */
	private Integer	ev_deathToll;
	/**
	 * 经济损失(万元)
	 */
	private Double	ev_economicLoss;

	/**
	 * 经度
	 */
	private Double	ev_longitude;
	/**
	 * 纬度
	 */
	private Double	ev_latitude;
	/**
	 * 报告人姓名
	 */
	private String	ev_reportName;
	/**
	 * 报告人职务
	 */
	private String	ev_reportPost;
	/**
	 * 报告人单位
	 */
	private String	ev_reportUnit;
	/**
	 * 报告人电话
	 */
	private String	ev_reportPhone;
	/**
	 * 报告人地址
	 */
	private String	ev_reportAddress;
	/**
	 * 相关人员
	 */
	private String	ev_relatedPersonnel;
	/**
	 * 结束时间
	 */
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date	ev_endDate;
	/**
	 * 事件起因、性质
	 */
	private String	ev_cause;
	/**
	 * 影响范围、发展趋势
	 */
	private String	ev_influenceScope;
	/**
	 * 先期处置情况
	 */
	private String	ev_advancedDisposal;
	/**
	 * 事件基本情况
	 */
	private String	ev_basicSituation;
	/**
	 * 事件基本情况
	 */
	private String	ev_nextStep;
	private String	ev_status;
	
	private Integer CallID;
	
	private String ev_del;

	public Integer getEv_id() {
		return ev_id;
	}

	public void setEv_id(Integer ev_id) {
		this.ev_id = ev_id;
	}

	public String getEv_name() {
		return ev_name;
	}

	public void setEv_name(String ev_name) {
		this.ev_name = ev_name;
	}

	public String getEv_address() {
		return ev_address;
	}

	public void setEv_address(String ev_address) {
		this.ev_address = ev_address;
	}

	public Date getEv_date() {
		return ev_date;
	}
	
	public String getEv_date_str() {
		if(ev_date!=null) {
			return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(ev_date);
		}
		
		return "";
	}

	public void setEv_date(Date ev_date) {
		this.ev_date = ev_date;
	}

	public Date getEv_reportDate() {
		return ev_reportDate;
	}

	public void setEv_reportDate(Date ev_reportDate) {
		this.ev_reportDate = ev_reportDate;
	}

	public Integer getEventTypeId() {
		return eventTypeId;
	}

	public void setEventTypeId(Integer eventTypeId) {
		this.eventTypeId = eventTypeId;
	}

	public Integer getOrganId() {
		return organId;
	}

	public void setOrganId(Integer organId) {
		this.organId = organId;
	}

	public String getEv_level() {
		return ev_level;
	}

	public void setEv_level(String ev_level) {
		this.ev_level = ev_level;
	}

	public String getEv_reportMode() {
		return ev_reportMode;
	}

	public void setEv_reportMode(String ev_reportMode) {
		this.ev_reportMode = ev_reportMode;
	}

	public Double getEv_affectedArea() {
		return ev_affectedArea;
	}

	public void setEv_affectedArea(Double ev_affectedArea) {
		this.ev_affectedArea = ev_affectedArea;
	}

	public Integer getEv_participationNumber() {
		return ev_participationNumber;
	}

	public void setEv_participationNumber(Integer ev_participationNumber) {
		this.ev_participationNumber = ev_participationNumber;
	}

	public Integer getEv_injuredPeople() {
		return ev_injuredPeople;
	}

	public void setEv_injuredPeople(Integer ev_injuredPeople) {
		this.ev_injuredPeople = ev_injuredPeople;
	}

	public Integer getEv_deathToll() {
		return ev_deathToll;
	}

	public void setEv_deathToll(Integer ev_deathToll) {
		this.ev_deathToll = ev_deathToll;
	}

	public Double getEv_economicLoss() {
		return ev_economicLoss;
	}

	public void setEv_economicLoss(Double ev_economicLoss) {
		this.ev_economicLoss = ev_economicLoss;
	}

	public Double getEv_longitude() {
		return ev_longitude;
	}

	public void setEv_longitude(Double ev_longitude) {
		this.ev_longitude = ev_longitude;
	}

	public Double getEv_latitude() {
		return ev_latitude;
	}

	public void setEv_latitude(Double ev_latitude) {
		this.ev_latitude = ev_latitude;
	}

	public String getEv_reportName() {
		return ev_reportName;
	}

	public void setEv_reportName(String ev_reportName) {
		this.ev_reportName = ev_reportName;
	}

	public String getEv_reportPost() {
		return ev_reportPost;
	}

	public void setEv_reportPost(String ev_reportPost) {
		this.ev_reportPost = ev_reportPost;
	}

	public String getEv_reportUnit() {
		return ev_reportUnit;
	}

	public void setEv_reportUnit(String ev_reportUnit) {
		this.ev_reportUnit = ev_reportUnit;
	}

	public String getEv_reportPhone() {
		return ev_reportPhone;
	}

	public void setEv_reportPhone(String ev_reportPhone) {
		this.ev_reportPhone = ev_reportPhone;
	}

	public String getEv_reportAddress() {
		return ev_reportAddress;
	}

	public void setEv_reportAddress(String ev_reportAddress) {
		this.ev_reportAddress = ev_reportAddress;
	}

	public String getEv_relatedPersonnel() {
		return ev_relatedPersonnel;
	}

	public void setEv_relatedPersonnel(String ev_relatedPersonnel) {
		this.ev_relatedPersonnel = ev_relatedPersonnel;
	}

	public Date getEv_endDate() {
		return ev_endDate;
	}

	public void setEv_endDate(Date ev_endDate) {
		this.ev_endDate = ev_endDate;
	}

	public String getEv_cause() {
		return ev_cause;
	}

	public void setEv_cause(String ev_cause) {
		this.ev_cause = ev_cause;
	}

	public String getEv_influenceScope() {
		return ev_influenceScope;
	}

	public void setEv_influenceScope(String ev_influenceScope) {
		this.ev_influenceScope = ev_influenceScope;
	}

	public String getEv_advancedDisposal() {
		return ev_advancedDisposal;
	}

	public void setEv_advancedDisposal(String ev_advancedDisposal) {
		this.ev_advancedDisposal = ev_advancedDisposal;
	}

	public String getEv_basicSituation() {
		return ev_basicSituation;
	}

	public void setEv_basicSituation(String ev_basicSituation) {
		this.ev_basicSituation = ev_basicSituation;
	}

	public String getEv_nextStep() {
		return ev_nextStep;
	}

	public void setEv_nextStep(String ev_nextStep) {
		this.ev_nextStep = ev_nextStep;
	}

	public Date getEv_dateBegin() {
		return ev_dateBegin;
	}

	public void setEv_dateBegin(Date ev_dateBegin) {
		this.ev_dateBegin = ev_dateBegin;
	}

	public Date getEv_dateEnd() {
		return ev_dateEnd;
	}

	public void setEv_dateEnd(Date ev_dateEnd) {
		this.ev_dateEnd = ev_dateEnd;
	}

	public String getEv_status() {
		return ev_status;
	}

	public void setEv_status(String ev_status) {
		this.ev_status = ev_status;
	}

	public String getEt_name() {
		return et_name;
	}

	public void setEt_name(String et_name) {
		this.et_name = et_name;
	}

	public Integer getCallID() {
		return CallID;
	}

	public void setCallID(Integer callID) {
		CallID = callID;
	}

	public String getEv_del() {
		return ev_del;
	}

	public void setEv_del(String ev_del) {
		this.ev_del = ev_del;
	}

	public String getEv_address_town() {
		return ev_address_town;
	}

	public void setEv_address_town(String ev_address_town) {
		this.ev_address_town = ev_address_town;
	}
	
}
