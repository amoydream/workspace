/**
 * MsgItem.java
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.lauvan.meip.client;

@SuppressWarnings({"rawtypes", "unused"})
public class MsgItem extends com.lauvan.meip.client.Item implements java.io.Serializable {
	private static final long	serialVersionUID	= -4133203320280711634L;

	private java.lang.String	content;

	private java.lang.Integer	count;

	private java.lang.Integer	deleted;

	private java.lang.Integer	id;

	private java.lang.String	mobile;

	private java.lang.String[]	mobiles;

	private java.util.Calendar	msgtime;

	private java.util.Calendar	msgtimeEnd;

	private java.util.Calendar	msgtimeStart;

	private java.lang.Integer	msgtype;

	public MsgItem() {
	}

	public MsgItem(java.lang.Integer currentPage, java.lang.Integer firstResult, java.lang.Integer maxResults, java.lang.String content, java.lang.Integer count, java.lang.Integer deleted, java.lang.Integer id, java.lang.String mobile, java.lang.String[] mobiles, java.util.Calendar msgtime, java.util.Calendar msgtimeEnd, java.util.Calendar msgtimeStart, java.lang.Integer msgtype) {
		super(currentPage, firstResult, maxResults);
		this.content = content;
		this.count = count;
		this.deleted = deleted;
		this.id = id;
		this.mobile = mobile;
		this.mobiles = mobiles;
		this.msgtime = msgtime;
		this.msgtimeEnd = msgtimeEnd;
		this.msgtimeStart = msgtimeStart;
		this.msgtype = msgtype;
	}

	public java.lang.String getContent() {
		return content;
	}

	public void setContent(java.lang.String content) {
		this.content = content;
	}

	public java.lang.Integer getCount() {
		return count;
	}

	public void setCount(java.lang.Integer count) {
		this.count = count;
	}

	public java.lang.Integer getDeleted() {
		return deleted;
	}

	public void setDeleted(java.lang.Integer deleted) {
		this.deleted = deleted;
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

	public java.util.Calendar getMsgtime() {
		return msgtime;
	}

	public void setMsgtime(java.util.Calendar msgtime) {
		this.msgtime = msgtime;
	}

	public java.util.Calendar getMsgtimeEnd() {
		return msgtimeEnd;
	}

	public void setMsgtimeEnd(java.util.Calendar msgtimeEnd) {
		this.msgtimeEnd = msgtimeEnd;
	}

	public java.util.Calendar getMsgtimeStart() {
		return msgtimeStart;
	}

	public void setMsgtimeStart(java.util.Calendar msgtimeStart) {
		this.msgtimeStart = msgtimeStart;
	}

	public java.lang.Integer getMsgtype() {
		return msgtype;
	}

	public void setMsgtype(java.lang.Integer msgtype) {
		this.msgtype = msgtype;
	}

	private java.lang.Object __equalsCalc = null;

	@Override
	public synchronized boolean equals(java.lang.Object obj) {
		if(!(obj instanceof MsgItem)) {
			return false;
		}
		MsgItem other = (MsgItem)obj;
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
		_equals = super.equals(obj) && (content == null && other.getContent() == null || content != null && content.equals(other.getContent())) && (count == null && other.getCount() == null || count != null && count.equals(other.getCount())) && (deleted == null && other.getDeleted() == null || deleted != null && deleted.equals(other.getDeleted())) && (id == null && other.getId() == null || id != null && id.equals(other.getId())) && (mobile == null && other.getMobile() == null || mobile != null && mobile.equals(other.getMobile())) && (mobiles == null && other.getMobiles() == null || mobiles != null && java.util.Arrays.equals(mobiles, other.getMobiles())) && (msgtime == null && other.getMsgtime() == null || msgtime != null && msgtime.equals(other.getMsgtime())) && (msgtimeEnd == null && other.getMsgtimeEnd() == null || msgtimeEnd != null && msgtimeEnd.equals(other.getMsgtimeEnd())) && (msgtimeStart == null && other.getMsgtimeStart() == null || msgtimeStart != null && msgtimeStart.equals(other.getMsgtimeStart())) && (msgtype == null && other.getMsgtype() == null || msgtype != null && msgtype.equals(other.getMsgtype()));
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
		if(getCount() != null) {
			_hashCode += getCount().hashCode();
		}
		if(getDeleted() != null) {
			_hashCode += getDeleted().hashCode();
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
		if(getMsgtime() != null) {
			_hashCode += getMsgtime().hashCode();
		}
		if(getMsgtimeEnd() != null) {
			_hashCode += getMsgtimeEnd().hashCode();
		}
		if(getMsgtimeStart() != null) {
			_hashCode += getMsgtimeStart().hashCode();
		}
		if(getMsgtype() != null) {
			_hashCode += getMsgtype().hashCode();
		}
		__hashCodeCalc = false;
		return _hashCode;
	}

	private static org.apache.axis.description.TypeDesc typeDesc = new org.apache.axis.description.TypeDesc(MsgItem.class, true);

	static {
		typeDesc.setXmlType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "msgItem"));
		org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("content");
		elemField.setXmlName(new javax.xml.namespace.QName("", "content"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("count");
		elemField.setXmlName(new javax.xml.namespace.QName("", "count"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
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
		elemField.setFieldName("msgtime");
		elemField.setXmlName(new javax.xml.namespace.QName("", "msgtime"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "dateTime"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("msgtimeEnd");
		elemField.setXmlName(new javax.xml.namespace.QName("", "msgtimeEnd"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "dateTime"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("msgtimeStart");
		elemField.setXmlName(new javax.xml.namespace.QName("", "msgtimeStart"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "dateTime"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("msgtype");
		elemField.setXmlName(new javax.xml.namespace.QName("", "msgtype"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
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
