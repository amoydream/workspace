package com.lauvan.system.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "t_ccms_record")
public class T_Ccms_Record implements java.io.Serializable {
	private static final long	serialVersionUID	= -3482485407918678216L;

	private Integer				CALLID;
	private String				ACTM;										// CHAR(1)
	private String				ACTS;										// VARCHAR(128)
	private String				BUSINESSID;									// VARCHAR(20)
	private String				CALLROUTE;									// VARCHAR(20)
	private String				CCID;										// VARCHAR(20)
	private String				CEID;										// VARCHAR(20)
	private Integer				CALLVOCNO;
	private Integer				CHANNELNO;
	private String				DATETIME;									// VARCHAR(20)
	private String			    NETWID;
	private String				ORGCEID;									// VARCHAR(20)
	private Integer				OUTCTIME;
	private Integer				RECDTIME;
	private Integer				TALKTIME;
	private Integer				TOTALTIME;
	private Integer				UGRPNO;
	private String				USERID;										// VARCHAR(20)
	private Integer				WAITTIME;
	private String				VOCRECDFILE;								// VARCHAR(128)
	private Integer				CALLFEES;
	private Integer				FAXST;
	private String				DTMFKEY;									// VARCHAR(128)

	@Id
	public Integer getCALLID() {
		return CALLID;
	}

	public void setCALLID(Integer cALLID) {
		CALLID = cALLID;
	}

	@Column(length = 1)
	public String getACTM() {
		return ACTM;
	}

	public void setACTM(String aCTM) {
		ACTM = aCTM;
	}

	@Column(length = 128)
	public String getACTS() {
		return ACTS;
	}

	public void setACTS(String aCTS) {
		ACTS = aCTS;
	}

	@Column(length = 20)
	public String getBUSINESSID() {
		return BUSINESSID;
	}

	public void setBUSINESSID(String bUSINESSID) {
		BUSINESSID = bUSINESSID;
	}

	@Column(length = 20)
	public String getCALLROUTE() {
		return CALLROUTE;
	}

	public void setCALLROUTE(String cALLROUTE) {
		CALLROUTE = cALLROUTE;
	}

	@Column(length = 20)
	public String getCCID() {
		return CCID;
	}

	public void setCCID(String cCID) {
		CCID = cCID;
	}

	@Column(length = 20)
	public String getCEID() {
		return CEID;
	}

	public void setCEID(String cEID) {
		CEID = cEID;
	}

	@Column(length = 11)
	public Integer getCALLVOCNO() {
		return CALLVOCNO;
	}

	public void setCALLVOCNO(Integer cALLVOCNO) {
		CALLVOCNO = cALLVOCNO;
	}

	@Column(length = 11)
	public Integer getCHANNELNO() {
		return CHANNELNO;
	}

	public void setCHANNELNO(Integer cHANNELNO) {
		CHANNELNO = cHANNELNO;
	}

	@Column(length = 100)
	public String getDATETIME() {
		return DATETIME;
	}

	public void setDATETIME(String dATETIME) {
		DATETIME = dATETIME;
	}

	@Column(length = 11)
	public String getNETWID() {
		return NETWID;
	}

	public void setNETWID(String nETWID) {
		NETWID = nETWID;
	}

	@Column(length = 20)
	public String getORGCEID() {
		return ORGCEID;
	}

	public void setORGCEID(String oRGCEID) {
		ORGCEID = oRGCEID;
	}

	@Column(length = 11)
	public Integer getOUTCTIME() {
		return OUTCTIME;
	}

	public void setOUTCTIME(Integer oUTCTIME) {
		OUTCTIME = oUTCTIME;
	}

	@Column(length = 11)
	public Integer getRECDTIME() {
		return RECDTIME;
	}

	public void setRECDTIME(Integer rECDTIME) {
		RECDTIME = rECDTIME;
	}

	@Column(length = 11)
	public Integer getTALKTIME() {
		return TALKTIME;
	}

	public void setTALKTIME(Integer tALKTIME) {
		TALKTIME = tALKTIME;
	}

	@Column(length = 11)
	public Integer getTOTALTIME() {
		return TOTALTIME;
	}

	public void setTOTALTIME(Integer tOTALTIME) {
		TOTALTIME = tOTALTIME;
	}

	@Column(length = 11)
	public Integer getUGRPNO() {
		return UGRPNO;
	}

	public void setUGRPNO(Integer uGRPNO) {
		UGRPNO = uGRPNO;
	}

	@Column(length = 20)
	public String getUSERID() {
		return USERID;
	}

	public void setUSERID(String uSERID) {
		USERID = uSERID;
	}

	@Column(length = 11)
	public Integer getWAITTIME() {
		return WAITTIME;
	}

	public void setWAITTIME(Integer wAITTIME) {
		WAITTIME = wAITTIME;
	}

	@Column(length = 128)
	public String getVOCRECDFILE() {
		return VOCRECDFILE;
	}

	public void setVOCRECDFILE(String vOCRECDFILE) {
		VOCRECDFILE = vOCRECDFILE;
	}

	@Column(length = 11)
	public Integer getCALLFEES() {
		return CALLFEES;
	}

	public void setCALLFEES(Integer cALLFEES) {
		CALLFEES = cALLFEES;
	}

	@Column(length = 11)
	public Integer getFAXST() {
		return FAXST;
	}

	public void setFAXST(Integer fAXST) {
		FAXST = fAXST;
	}

	@Column(length = 128)
	public String getDTMFKEY() {
		return DTMFKEY;
	}

	public void setDTMFKEY(String dTMFKEY) {
		DTMFKEY = dTMFKEY;
	}
}
