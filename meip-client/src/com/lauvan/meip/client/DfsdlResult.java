/**
 * DfsdlResult.java
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.lauvan.meip.client;

@SuppressWarnings({"rawtypes", "unused"})
public class DfsdlResult extends com.lauvan.meip.client.Result implements java.io.Serializable {
	private static final long					serialVersionUID	= 3705294930450231838L;

	private com.lauvan.meip.client.DfsdlItem	item;

	private com.lauvan.meip.client.DfsdlItem[]	items;

	public DfsdlResult() {
	}

	public DfsdlResult(java.lang.String msg, boolean success, java.lang.Integer total, com.lauvan.meip.client.DfsdlItem item, com.lauvan.meip.client.DfsdlItem[] items) {
		super(msg, success, total);
		this.item = item;
		this.items = items;
	}

	public com.lauvan.meip.client.DfsdlItem getItem() {
		return item;
	}

	public void setItem(com.lauvan.meip.client.DfsdlItem item) {
		this.item = item;
	}

	public com.lauvan.meip.client.DfsdlItem[] getItems() {
		return items;
	}

	public void setItems(com.lauvan.meip.client.DfsdlItem[] items) {
		this.items = items;
	}

	public com.lauvan.meip.client.DfsdlItem getItems(int i) {
		return items[i];
	}

	public void setItems(int i, com.lauvan.meip.client.DfsdlItem _value) {
		items[i] = _value;
	}

	private java.lang.Object __equalsCalc = null;

	@Override
	public synchronized boolean equals(java.lang.Object obj) {
		if(!(obj instanceof DfsdlResult)) {
			return false;
		}
		DfsdlResult other = (DfsdlResult)obj;
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
		_equals = super.equals(obj) && (item == null && other.getItem() == null || item != null && item.equals(other.getItem())) && (items == null && other.getItems() == null || items != null && java.util.Arrays.equals(items, other.getItems()));
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
		if(getItem() != null) {
			_hashCode += getItem().hashCode();
		}
		if(getItems() != null) {
			for(int i = 0; i < java.lang.reflect.Array.getLength(getItems()); i++) {
				java.lang.Object obj = java.lang.reflect.Array.get(getItems(), i);
				if(obj != null && !obj.getClass().isArray()) {
					_hashCode += obj.hashCode();
				}
			}
		}
		__hashCodeCalc = false;
		return _hashCode;
	}

	private static org.apache.axis.description.TypeDesc typeDesc = new org.apache.axis.description.TypeDesc(DfsdlResult.class, true);

	static {
		typeDesc.setXmlType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "dfsdlResult"));
		org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("item");
		elemField.setXmlName(new javax.xml.namespace.QName("", "item"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "dfsdlItem"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("items");
		elemField.setXmlName(new javax.xml.namespace.QName("", "items"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "dfsdlItem"));
		elemField.setMinOccurs(0);
		elemField.setNillable(true);
		elemField.setMaxOccursUnbounded(true);
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
