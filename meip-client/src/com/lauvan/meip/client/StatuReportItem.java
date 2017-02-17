/**
 * StatuReportItem.java
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.lauvan.meip.client;

@SuppressWarnings({"rawtypes", "unused"})
public class StatuReportItem extends com.lauvan.meip.client.Item implements java.io.Serializable {
	private static final long	serialVersionUID	= 4813768817945549881L;

	private java.lang.String	client_id;

	private java.lang.String	content;

	private java.lang.Integer	deleted;

	private java.lang.String	eid;

	private java.lang.Integer	id;

	private java.lang.String[]	mobiles;

	private java.lang.String	receiver;

	private java.lang.Integer	smsstatu;

	private java.util.Calendar	updateTime;

	private java.util.Calendar	updateTimeEnd;

	private java.util.Calendar	updateTimeStart;

	private java.lang.String	userid;

	public StatuReportItem() {
	}

	public StatuReportItem(java.lang.Integer currentPage, java.lang.Integer firstResult, java.lang.Integer maxResults, java.lang.String client_id, java.lang.String content, java.lang.Integer deleted, java.lang.String eid, java.lang.Integer id, java.lang.String[] mobiles, java.lang.String receiver, java.lang.Integer smsstatu, java.util.Calendar updateTime, java.util.Calendar updateTimeEnd, java.util.Calendar updateTimeStart, java.lang.String userid) {
		super(currentPage, firstResult, maxResults);
		this.client_id = client_id;
		this.content = content;
		this.deleted = deleted;
		this.eid = eid;
		this.id = id;
		this.mobiles = mobiles;
		this.receiver = receiver;
		this.smsstatu = smsstatu;
		this.updateTime = updateTime;
		this.updateTimeEnd = updateTimeEnd;
		this.updateTimeStart = updateTimeStart;
		this.userid = userid;
	}

	public java.lang.String getClient_id() {
		return client_id;
	}

	public void setClient_id(java.lang.String client_id) {
		this.client_id = client_id;
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

	public java.lang.String getReceiver() {
		return receiver;
	}

	public void setReceiver(java.lang.String receiver) {
		this.receiver = receiver;
	}

	public java.lang.Integer getSmsstatu() {
		return smsstatu;
	}

	public void setSmsstatu(java.lang.Integer smsstatu) {
		this.smsstatu = smsstatu;
	}

	public java.util.Calendar getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(java.util.Calendar updateTime) {
		this.updateTime = updateTime;
	}

	public java.util.Calendar getUpdateTimeEnd() {
		return updateTimeEnd;
	}

	public void setUpdateTimeEnd(java.util.Calendar updateTimeEnd) {
		this.updateTimeEnd = updateTimeEnd;
	}

	public java.util.Calendar getUpdateTimeStart() {
		return updateTimeStart;
	}

	public void setUpdateTimeStart(java.util.Calendar updateTimeStart) {
		this.updateTimeStart = updateTimeStart;
	}

	public java.lang.String getUserid() {
		return userid;
	}

	public void setUserid(java.lang.String userid) {
		this.userid = userid;
	}

	private java.lang.Object __equalsCalc = null;

	@Override
	public synchronized boolean equals(java.lang.Object obj) {
		if(!(obj instanceof StatuReportItem)) {
			return false;
		}
		StatuReportItem other = (StatuReportItem)obj;
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
		_equals = super.equals(obj) && (client_id == null && other.getClient_id() == null || client_id != null && client_id.equals(other.getClient_id())) && (content == null && other.getContent() == null || content != null && content.equals(other.getContent())) && (deleted == null && other.getDeleted() == null || deleted != null && deleted.equals(other.getDeleted())) && (eid == null && other.getEid() == null || eid != null && eid.equals(other.getEid())) && (id == null && other.getId() == null || id != null && id.equals(other.getId())) && (mobiles == null && other.getMobiles() == null || mobiles != null && java.util.Arrays.equals(mobiles, other.getMobiles())) && (receiver == null && other.getReceiver() == null || receiver != null && receiver.equals(other.getReceiver())) && (smsstatu == null && other.getSmsstatu() == null || smsstatu != null && smsstatu.equals(other.getSmsstatu())) && (updateTime == null && other.getUpdateTime() == null || updateTime != null && updateTime.equals(other.getUpdateTime())) && (updateTimeEnd == null && other.getUpdateTimeEnd() == null || updateTimeEnd != null && updateTimeEnd.equals(other.getUpdateTimeEnd())) && (updateTimeStart == null && other.getUpdateTimeStart() == null || updateTimeStart != null && updateTimeStart.equals(other.getUpdateTimeStart())) && (userid == null && other.getUserid() == null || userid != null && userid.equals(other.getUserid()));
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
		if(getClient_id() != null) {
			_hashCode += getClient_id().hashCode();
		}
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
		if(getMobiles() != null) {
			for(int i = 0; i < java.lang.reflect.Array.getLength(getMobiles()); i++) {
				java.lang.Object obj = java.lang.reflect.Array.get(getMobiles(), i);
				if(obj != null && !obj.getClass().isArray()) {
					_hashCode += obj.hashCode();
				}
			}
		}
		if(getReceiver() != null) {
			_hashCode += getReceiver().hashCode();
		}
		if(getSmsstatu() != null) {
			_hashCode += getSmsstatu().hashCode();
		}
		if(getUpdateTime() != null) {
			_hashCode += getUpdateTime().hashCode();
		}
		if(getUpdateTimeEnd() != null) {
			_hashCode += getUpdateTimeEnd().hashCode();
		}
		if(getUpdateTimeStart() != null) {
			_hashCode += getUpdateTimeStart().hashCode();
		}
		if(getUserid() != null) {
			_hashCode += getUserid().hashCode();
		}
		__hashCodeCalc = false;
		return _hashCode;
	}

	private static org.apache.axis.description.TypeDesc typeDesc = new org.apache.axis.description.TypeDesc(StatuReportItem.class, true);

	static {
		typeDesc.setXmlType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "statuReportItem"));
		org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("client_id");
		elemField.setXmlName(new javax.xml.namespace.QName("", "client_id"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
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
		elemField.setFieldName("mobiles");
		elemField.setXmlName(new javax.xml.namespace.QName("", "mobiles"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
		elemField.setMinOccurs(0);
		elemField.setNillable(true);
		elemField.setMaxOccursUnbounded(true);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("receiver");
		elemField.setXmlName(new javax.xml.namespace.QName("", "receiver"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("smsstatu");
		elemField.setXmlName(new javax.xml.namespace.QName("", "smsstatu"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("updateTime");
		elemField.setXmlName(new javax.xml.namespace.QName("", "updateTime"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "dateTime"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("updateTimeEnd");
		elemField.setXmlName(new javax.xml.namespace.QName("", "updateTimeEnd"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "dateTime"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("updateTimeStart");
		elemField.setXmlName(new javax.xml.namespace.QName("", "updateTimeStart"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "dateTime"));
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
