/**
 * YfsdlItem.java
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.lauvan.meip.client;

@SuppressWarnings({"rawtypes", "unused"})
public class YfsdlItem extends com.lauvan.meip.client.Item implements java.io.Serializable {
	private static final long	serialVersionUID	= 8994244002837915552L;

	private java.lang.String	content;

	private java.lang.Integer	deleted;

	private java.lang.String	eid;

	private java.lang.Integer	id;

	private java.lang.String	mobile;

	private java.lang.String[]	mobiles;

	private java.lang.Integer	msgid;

	private java.lang.String	password;

	private java.util.Calendar	deadtime;

	private java.util.Calendar	deadtimeEnd;

	private java.util.Calendar	deadtimeStart;

	private java.lang.Integer	status;

	private java.lang.String	userid;

	private java.lang.String	userport;

	public YfsdlItem() {
	}

	public YfsdlItem(java.lang.Integer currentPage, java.lang.Integer firstResult, java.lang.Integer maxResults, java.lang.String content, java.lang.Integer deleted, java.lang.String eid, java.lang.Integer id, java.lang.String mobile, java.lang.String[] mobiles, java.lang.Integer msgid, java.lang.String password, java.util.Calendar deadtime, java.util.Calendar deadtimeEnd, java.util.Calendar deadtimeStart, java.lang.Integer status, java.lang.String userid, java.lang.String userport) {
		super(currentPage, firstResult, maxResults);
		this.content = content;
		this.deleted = deleted;
		this.eid = eid;
		this.id = id;
		this.mobile = mobile;
		this.mobiles = mobiles;
		this.msgid = msgid;
		this.password = password;
		this.deadtime = deadtime;
		this.deadtimeEnd = deadtimeEnd;
		this.deadtimeStart = deadtimeStart;
		this.status = status;
		this.userid = userid;
		this.userport = userport;
	}

	public java.lang.String getContent() {
		return content;
	}

	public void setContent(java.lang.String content) {
		this.content = content;
	}

	public java.lang.Integer getDeleted() {
		return deleted;
	}

	public void setDeleted(java.lang.Integer deleted) {
		this.deleted = deleted;
	}

	public java.lang.String getEid() {
		return eid;
	}

	public void setEid(java.lang.String eid) {
		this.eid = eid;
	}

	public java.lang.Integer getId() {
		return id;
	}

	public void setId(java.lang.Integer id) {
		this.id = id;
	}

	public java.lang.String getMobile() {
		return mobile;
	}

	public void setMobile(java.lang.String mobile) {
		this.mobile = mobile;
	}

	public java.lang.String[] getMobiles() {
		return mobiles;
	}

	public void setMobiles(java.lang.String[] mobiles) {
		this.mobiles = mobiles;
	}

	public java.lang.String getMobiles(int i) {
		return mobiles[i];
	}

	public void setMobiles(int i, java.lang.String _value) {
		mobiles[i] = _value;
	}

	public java.lang.Integer getMsgid() {
		return msgid;
	}

	public void setMsgid(java.lang.Integer msgid) {
		this.msgid = msgid;
	}

	public java.lang.String getPassword() {
		return password;
	}

	public void setPassword(java.lang.String password) {
		this.password = password;
	}

	public java.util.Calendar getDeadtime() {
		return deadtime;
	}

	public void setDeadtime(java.util.Calendar deadtime) {
		this.deadtime = deadtime;
	}

	public java.util.Calendar getDeadtimeEnd() {
		return deadtimeEnd;
	}

	public void setDeadtimeEnd(java.util.Calendar deadtimeEnd) {
		this.deadtimeEnd = deadtimeEnd;
	}

	public java.util.Calendar getDeadtimeStart() {
		return deadtimeStart;
	}

	public void setDeadtimeStart(java.util.Calendar deadtimeStart) {
		this.deadtimeStart = deadtimeStart;
	}

	public java.lang.Integer getStatus() {
		return status;
	}

	public void setStatus(java.lang.Integer status) {
		this.status = status;
	}

	public java.lang.String getUserid() {
		return userid;
	}

	public void setUserid(java.lang.String userid) {
		this.userid = userid;
	}

	public java.lang.String getUserport() {
		return userport;
	}

	public void setUserport(java.lang.String userport) {
		this.userport = userport;
	}

	private java.lang.Object __equalsCalc = null;

	@Override
	public synchronized boolean equals(java.lang.Object obj) {
		if(!(obj instanceof YfsdlItem)) {
			return false;
		}
		YfsdlItem other = (YfsdlItem)obj;
		if(obj == null) {
			return false;
		}
		if(this == obj) {
			return true;
		}
		if(__equalsCalc != null) {
			return __equalsCalc == obj;
		}
		__equalsCalc = obj;
		boolean _equals;
		_equals = super.equals(obj) && (content == null && other.getContent() == null || content != null && content.equals(other.getContent())) && (deleted == null && other.getDeleted() == null || deleted != null && deleted.equals(other.getDeleted())) && (eid == null && other.getEid() == null || eid != null && eid.equals(other.getEid())) && (id == null && other.getId() == null || id != null && id.equals(other.getId())) && (mobile == null && other.getMobile() == null || mobile != null && mobile.equals(other.getMobile())) && (mobiles == null && other.getMobiles() == null || mobiles != null && java.util.Arrays.equals(mobiles, other.getMobiles())) && (msgid == null && other.getMsgid() == null || msgid != null && msgid.equals(other.getMsgid())) && (password == null && other.getPassword() == null || password != null && password.equals(other.getPassword())) && (deadtime == null && other.getDeadtime() == null || deadtime != null && deadtime.equals(other.getDeadtime())) && (deadtimeEnd == null && other.getDeadtimeEnd() == null || deadtimeEnd != null && deadtimeEnd.equals(other.getDeadtimeEnd())) && (deadtimeStart == null && other.getDeadtimeStart() == null || deadtimeStart != null && deadtimeStart.equals(other.getDeadtimeStart())) && (status == null && other.getStatus() == null || status != null && status.equals(other.getStatus())) && (userid == null && other.getUserid() == null || userid != null && userid.equals(other.getUserid())) && (userport == null && other.getUserport() == null || userport != null && userport.equals(other.getUserport()));
		__equalsCalc = null;
		return _equals;
	}

	private boolean __hashCodeCalc = false;

	@Override
	public synchronized int hashCode() {
		if(__hashCodeCalc) {
			return 0;
		}
		__hashCodeCalc = true;
		int _hashCode = super.hashCode();
		if(getContent() != null) {
			_hashCode += getContent().hashCode();
		}
		if(getDeleted() != null) {
			_hashCode += getDeleted().hashCode();
		}
		if(getEid() != null) {
			_hashCode += getEid().hashCode();
		}
		if(getId() != null) {
			_hashCode += getId().hashCode();
		}
		if(getMobile() != null) {
			_hashCode += getMobile().hashCode();
		}
		if(getMobiles() != null) {
			for(int i = 0; i < java.lang.reflect.Array.getLength(getMobiles()); i++) {
				java.lang.Object obj = java.lang.reflect.Array.get(getMobiles(), i);
				if(obj != null && !obj.getClass().isArray()) {
					_hashCode += obj.hashCode();
				}
			}
		}
		if(getMsgid() != null) {
			_hashCode += getMsgid().hashCode();
		}
		if(getPassword() != null) {
			_hashCode += getPassword().hashCode();
		}
		if(getDeadtime() != null) {
			_hashCode += getDeadtime().hashCode();
		}
		if(getDeadtimeEnd() != null) {
			_hashCode += getDeadtimeEnd().hashCode();
		}
		if(getDeadtimeStart() != null) {
			_hashCode += getDeadtimeStart().hashCode();
		}
		if(getStatus() != null) {
			_hashCode += getStatus().hashCode();
		}
		if(getUserid() != null) {
			_hashCode += getUserid().hashCode();
		}
		if(getUserport() != null) {
			_hashCode += getUserport().hashCode();
		}
		__hashCodeCalc = false;
		return _hashCode;
	}

	private static org.apache.axis.description.TypeDesc typeDesc = new org.apache.axis.description.TypeDesc(YfsdlItem.class, true);

	static {
		typeDesc.setXmlType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "yfsdlItem"));
		org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("content");
		elemField.setXmlName(new javax.xml.namespace.QName("", "content"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("deleted");
		elemField.setXmlName(new javax.xml.namespace.QName("", "deleted"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("eid");
		elemField.setXmlName(new javax.xml.namespace.QName("", "eid"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("id");
		elemField.setXmlName(new javax.xml.namespace.QName("", "id"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("mobile");
		elemField.setXmlName(new javax.xml.namespace.QName("", "mobile"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("mobiles");
		elemField.setXmlName(new javax.xml.namespace.QName("", "mobiles"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
		elemField.setMinOccurs(0);
		elemField.setNillable(true);
		elemField.setMaxOccursUnbounded(true);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("msgid");
		elemField.setXmlName(new javax.xml.namespace.QName("", "msgid"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("password");
		elemField.setXmlName(new javax.xml.namespace.QName("", "password"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("deadtime");
		elemField.setXmlName(new javax.xml.namespace.QName("", "deadtime"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "dateTime"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("deadtimeEnd");
		elemField.setXmlName(new javax.xml.namespace.QName("", "deadtimeEnd"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "dateTime"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("deadtimeStart");
		elemField.setXmlName(new javax.xml.namespace.QName("", "deadtimeStart"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "dateTime"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("status");
		elemField.setXmlName(new javax.xml.namespace.QName("", "status"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("userid");
		elemField.setXmlName(new javax.xml.namespace.QName("", "userid"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("userport");
		elemField.setXmlName(new javax.xml.namespace.QName("", "userport"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
	}

	public static org.apache.axis.description.TypeDesc getTypeDesc() {
		return typeDesc;
	}

	public static org.apache.axis.encoding.Serializer getSerializer(java.lang.String mechType, java.lang.Class _javaType, javax.xml.namespace.QName _xmlType) {
		return new org.apache.axis.encoding.ser.BeanSerializer(_javaType, _xmlType, typeDesc);
	}

	public static org.apache.axis.encoding.Deserializer getDeserializer(java.lang.String mechType, java.lang.Class _javaType, javax.xml.namespace.QName _xmlType) {
		return new org.apache.axis.encoding.ser.BeanDeserializer(_javaType, _xmlType, typeDesc);
	}

}
