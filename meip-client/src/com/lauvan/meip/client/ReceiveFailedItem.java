/**
 * ReceiveFailedItem.java
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.lauvan.meip.client;

@SuppressWarnings({"rawtypes", "unused"})
public class ReceiveFailedItem extends com.lauvan.meip.client.Item implements java.io.Serializable {
	private static final long	serialVersionUID	= 7242897030103697354L;

	private java.lang.Integer	deleted;

	private java.lang.String	fcontent;

	private java.lang.String	fmobile;

	private java.lang.String[]	fmobiles;

	private java.util.Calendar	fsendtime;

	private java.util.Calendar	fsendtimeEnd;

	private java.util.Calendar	fsendtimeStart;

	private java.lang.Integer	fstate;

	private java.lang.Integer	id;

	private java.lang.String	remark;

	public ReceiveFailedItem() {
	}

	public ReceiveFailedItem(java.lang.Integer currentPage, java.lang.Integer firstResult, java.lang.Integer maxResults, java.lang.Integer deleted, java.lang.String fcontent, java.lang.String fmobile, java.lang.String[] fmobiles, java.util.Calendar fsendtime, java.util.Calendar fsendtimeEnd, java.util.Calendar fsendtimeStart, java.lang.Integer fstate, java.lang.Integer id, java.lang.String remark) {
		super(currentPage, firstResult, maxResults);
		this.deleted = deleted;
		this.fcontent = fcontent;
		this.fmobile = fmobile;
		this.fmobiles = fmobiles;
		this.fsendtime = fsendtime;
		this.fsendtimeEnd = fsendtimeEnd;
		this.fsendtimeStart = fsendtimeStart;
		this.fstate = fstate;
		this.id = id;
		this.remark = remark;
	}

	public java.lang.Integer getDeleted() {
		return deleted;
	}

	public void setDeleted(java.lang.Integer deleted) {
		this.deleted = deleted;
	}

	public java.lang.String getFcontent() {
		return fcontent;
	}

	public void setFcontent(java.lang.String fcontent) {
		this.fcontent = fcontent;
	}

	public java.lang.String getFmobile() {
		return fmobile;
	}

	public void setFmobile(java.lang.String fmobile) {
		this.fmobile = fmobile;
	}

	public java.lang.String[] getFmobiles() {
		return fmobiles;
	}

	public void setFmobiles(java.lang.String[] fmobiles) {
		this.fmobiles = fmobiles;
	}

	public java.lang.String getFmobiles(int i) {
		return fmobiles[i];
	}

	public void setFmobiles(int i, java.lang.String _value) {
		fmobiles[i] = _value;
	}

	public java.util.Calendar getFsendtime() {
		return fsendtime;
	}

	public void setFsendtime(java.util.Calendar fsendtime) {
		this.fsendtime = fsendtime;
	}

	public java.util.Calendar getFsendtimeEnd() {
		return fsendtimeEnd;
	}

	public void setFsendtimeEnd(java.util.Calendar fsendtimeEnd) {
		this.fsendtimeEnd = fsendtimeEnd;
	}

	public java.util.Calendar getFsendtimeStart() {
		return fsendtimeStart;
	}

	public void setFsendtimeStart(java.util.Calendar fsendtimeStart) {
		this.fsendtimeStart = fsendtimeStart;
	}

	public java.lang.Integer getFstate() {
		return fstate;
	}

	public void setFstate(java.lang.Integer fstate) {
		this.fstate = fstate;
	}

	public java.lang.Integer getId() {
		return id;
	}

	public void setId(java.lang.Integer id) {
		this.id = id;
	}

	public java.lang.String getRemark() {
		return remark;
	}

	public void setRemark(java.lang.String remark) {
		this.remark = remark;
	}

	private java.lang.Object __equalsCalc = null;

	@Override
	public synchronized boolean equals(java.lang.Object obj) {
		if(!(obj instanceof ReceiveFailedItem)) {
			return false;
		}
		ReceiveFailedItem other = (ReceiveFailedItem)obj;
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
		_equals = super.equals(obj) && (deleted == null && other.getDeleted() == null || deleted != null && deleted.equals(other.getDeleted())) && (fcontent == null && other.getFcontent() == null || fcontent != null && fcontent.equals(other.getFcontent())) && (fmobile == null && other.getFmobile() == null || fmobile != null && fmobile.equals(other.getFmobile())) && (fmobiles == null && other.getFmobiles() == null || fmobiles != null && java.util.Arrays.equals(fmobiles, other.getFmobiles())) && (fsendtime == null && other.getFsendtime() == null || fsendtime != null && fsendtime.equals(other.getFsendtime())) && (fsendtimeEnd == null && other.getFsendtimeEnd() == null || fsendtimeEnd != null && fsendtimeEnd.equals(other.getFsendtimeEnd())) && (fsendtimeStart == null && other.getFsendtimeStart() == null || fsendtimeStart != null && fsendtimeStart.equals(other.getFsendtimeStart())) && (fstate == null && other.getFstate() == null || fstate != null && fstate.equals(other.getFstate())) && (id == null && other.getId() == null || id != null && id.equals(other.getId())) && (remark == null && other.getRemark() == null || remark != null && remark.equals(other.getRemark()));
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
		if(getDeleted() != null) {
			_hashCode += getDeleted().hashCode();
		}
		if(getFcontent() != null) {
			_hashCode += getFcontent().hashCode();
		}
		if(getFmobile() != null) {
			_hashCode += getFmobile().hashCode();
		}
		if(getFmobiles() != null) {
			for(int i = 0; i < java.lang.reflect.Array.getLength(getFmobiles()); i++) {
				java.lang.Object obj = java.lang.reflect.Array.get(getFmobiles(), i);
				if(obj != null && !obj.getClass().isArray()) {
					_hashCode += obj.hashCode();
				}
			}
		}
		if(getFsendtime() != null) {
			_hashCode += getFsendtime().hashCode();
		}
		if(getFsendtimeEnd() != null) {
			_hashCode += getFsendtimeEnd().hashCode();
		}
		if(getFsendtimeStart() != null) {
			_hashCode += getFsendtimeStart().hashCode();
		}
		if(getFstate() != null) {
			_hashCode += getFstate().hashCode();
		}
		if(getId() != null) {
			_hashCode += getId().hashCode();
		}
		if(getRemark() != null) {
			_hashCode += getRemark().hashCode();
		}
		__hashCodeCalc = false;
		return _hashCode;
	}

	private static org.apache.axis.description.TypeDesc typeDesc = new org.apache.axis.description.TypeDesc(ReceiveFailedItem.class, true);

	static {
		typeDesc.setXmlType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "receiveFailedItem"));
		org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("deleted");
		elemField.setXmlName(new javax.xml.namespace.QName("", "deleted"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("fcontent");
		elemField.setXmlName(new javax.xml.namespace.QName("", "fcontent"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("fmobile");
		elemField.setXmlName(new javax.xml.namespace.QName("", "fmobile"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("fmobiles");
		elemField.setXmlName(new javax.xml.namespace.QName("", "fmobiles"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
		elemField.setMinOccurs(0);
		elemField.setNillable(true);
		elemField.setMaxOccursUnbounded(true);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("fsendtime");
		elemField.setXmlName(new javax.xml.namespace.QName("", "fsendtime"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "dateTime"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("fsendtimeEnd");
		elemField.setXmlName(new javax.xml.namespace.QName("", "fsendtimeEnd"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "dateTime"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("fsendtimeStart");
		elemField.setXmlName(new javax.xml.namespace.QName("", "fsendtimeStart"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "dateTime"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("fstate");
		elemField.setXmlName(new javax.xml.namespace.QName("", "fstate"));
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
		elemField.setFieldName("remark");
		elemField.setXmlName(new javax.xml.namespace.QName("", "remark"));
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
