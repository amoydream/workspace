package com.lauvan.event.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.lauvan.organ.entity.C_Organ;
import com.lauvan.system.entity.T_User_Info;
/**
 * 
 * ClassName: T_EventInfo 
 * @Description: 事件信息
 * @author 钮炜炜
 * @date 2015年12月3日 下午4:55:37
 */
@Entity
@Table(name = "t_eventinfo")
@DynamicInsert(true)
@DynamicUpdate(true)
public class T_EventInfo implements Serializable{

	private static final long serialVersionUID = 3366298566953380328L;
	private Integer ev_id;
	/**
	 * 事件名称
	 */
	private String ev_name;
	/**
	 * 事件地点
	 */
	private String ev_address;
	/**
	 * 事发地点所在镇
	 */
	private String ev_address_town;
	/**
	 * 事发时间
	 */
	private Date ev_date;
	/**
	 * 接报时间
	 */
	private Date ev_reportDate;
	/**
	 * 事件类型
	 */
	private T_Event_Type eventType;
	/**
	 * 事发单位
	 */
	private C_Organ organ;
	/**
	 * 事件级别
	 */
	private String ev_level;
	/**
	 * 接报方式
	 */
	private String ev_reportMode;
	/**
	 * 受灾面积(㎡)
	 */
	private Double ev_affectedArea;
	/**
	 * 参与（受灾）人数
	 */
	private Integer ev_participationNumber;
	/**
	 * 受伤人数
	 */
	private Integer ev_injuredPeople;
	/**
	 * 死亡人数
	 */
	private Integer ev_deathToll;
	/**
	 * 经济损失(万元)
	 */
	private Double ev_economicLoss;
	
	/**
	 * 经度
	 */
	private Double ev_longitude;
	/**
	 * 纬度
	 */
	private Double ev_latitude;
	/**
	 * 报告人姓名
	 */
	private String ev_reportName;
	/**
	 * 报告人职务
	 */
	private String ev_reportPost;
	/**
	 * 报告人单位
	 */
	private String ev_reportUnit;
	/**
	 * 报告人电话 
	 */
	private String ev_reportPhone;
	/**
	 * 报告人地址
	 */
	private String ev_reportAddress;
	/**
	 * 相关人员
	 */
	private String ev_relatedPersonnel;
	/**
	 * 结束时间
	 */
	private Date ev_endDate;
	/**
	 * 事件起因、性质
	 */
	private String ev_cause;
	/**
	 * 影响范围、发展趋势
	 */
	private String ev_influenceScope;
	/**
	 * 先期处置情况
	 */
	private String ev_advancedDisposal;
	/**
	 * 事件基本情况
	 */
	private String ev_basicSituation;
	/**
	 * 拟采取的措施和 下一步工作建议
	 */
	private String ev_nextStep;
	/**
	 * 事件状态(1:新登记2：处置中3：启动预案4：完成)
	 */
	private String ev_status = "1";
	/**
	 * 记录人
	 */
	private T_User_Info user;
	/**
	 * 记录时间
	 */
	private Date ev_createDate = new Date();
	private String ev_del;
	
	
	public T_EventInfo(Integer ev_id) {
		super();
		this.ev_id = ev_id;
	}
	
	public T_EventInfo() {
		super();
	}

	@Id
	public Integer getEv_id() {
		return ev_id;
	}
	public void setEv_id(Integer ev_id) {
		this.ev_id = ev_id;
	}
	@Column(length=100,nullable=false)
	public String getEv_name() {
		return ev_name;
	}
	public void setEv_name(String ev_name) {
		this.ev_name = ev_name;
	}
	@Column(length=100,nullable=false)
	public String getEv_address() {
		return ev_address;
	}
	public void setEv_address(String ev_address) {
		this.ev_address = ev_address;
	}
	public Date getEv_date() {
		return ev_date;
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
	@ManyToOne
	@JoinColumn(name = "et_id")
	public T_Event_Type getEventType() {
		return eventType;
	}
	public void setEventType(T_Event_Type eventType) {
		this.eventType = eventType;
	}
	@ManyToOne
	@JoinColumn(name = "or_id")
	public C_Organ getOrgan() {
		return organ;
	}
	public void setOrgan(C_Organ organ) {
		this.organ = organ;
	}
	@Column(length=1,nullable=false)
	public String getEv_level() {
		return ev_level;
	}
	public void setEv_level(String ev_level) {
		this.ev_level = ev_level;
	}
	@Column(length=1,nullable=false)
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
	@Column(length=10,nullable=false)
	public String getEv_reportName() {
		return ev_reportName;
	}
	public void setEv_reportName(String ev_reportName) {
		this.ev_reportName = ev_reportName;
	}
	@Column(length=20)
	public String getEv_reportPost() {
		return ev_reportPost;
	}
	public void setEv_reportPost(String ev_reportPost) {
		this.ev_reportPost = ev_reportPost;
	}
	@Column(length=100)
	public String getEv_reportUnit() {
		return ev_reportUnit;
	}
	public void setEv_reportUnit(String ev_reportUnit) {
		this.ev_reportUnit = ev_reportUnit;
	}
	@Column(length=12,nullable=false)
	public String getEv_reportPhone() {
		return ev_reportPhone;
	}
	public void setEv_reportPhone(String ev_reportPhone) {
		this.ev_reportPhone = ev_reportPhone;
	}
	@Column(length=100)
	public String getEv_reportAddress() {
		return ev_reportAddress;
	}
	public void setEv_reportAddress(String ev_reportAddress) {
		this.ev_reportAddress = ev_reportAddress;
	}
	@Column(length=10)
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
	@Column(length=1000)
	public String getEv_cause() {
		return ev_cause;
	}
	public void setEv_cause(String ev_cause) {
		this.ev_cause = ev_cause;
	}
	@Column(length=1000)
	public String getEv_influenceScope() {
		return ev_influenceScope;
	}
	public void setEv_influenceScope(String ev_influenceScope) {
		this.ev_influenceScope = ev_influenceScope;
	}
	@Column(length=1000)
	public String getEv_advancedDisposal() {
		return ev_advancedDisposal;
	}
	public void setEv_advancedDisposal(String ev_advancedDisposal) {
		this.ev_advancedDisposal = ev_advancedDisposal;
	}
	@Column(length=1000)
	public String getEv_basicSituation() {
		return ev_basicSituation;
	}
	public void setEv_basicSituation(String ev_basicSituation) {
		this.ev_basicSituation = ev_basicSituation;
	}
	@Column(length=1000)
	public String getEv_nextStep() {
		return ev_nextStep;
	}
	public void setEv_nextStep(String ev_nextStep) {
		this.ev_nextStep = ev_nextStep;
	}
	@ManyToOne
	@JoinColumn(name = "us_Id")
	public T_User_Info getUser() {
		return user;
	}
	public void setUser(T_User_Info user) {
		this.user = user;
	}
	public Date getEv_createDate() {
		return ev_createDate;
	}
	public void setEv_createDate(Date ev_createDate) {
		this.ev_createDate = ev_createDate;
	}
	@Column(length=1,nullable=false)
	public String getEv_status() {
		return ev_status;
	}
	public void setEv_status(String ev_status) {
		this.ev_status = ev_status;
	}
	@Column(length = 1)
	public String getEv_del() {
		return ev_del;
	}

	public void setEv_del(String ev_del) {
		this.ev_del = ev_del;
	}
	@Column(length = 20)
	public String getEv_address_town() {
		return ev_address_town;
	}

	public void setEv_address_town(String ev_address_town) {
		this.ev_address_town = ev_address_town;
	}
	
}
