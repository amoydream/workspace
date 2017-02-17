/**
 * Item.java
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.lauvan.meip.client;

@SuppressWarnings({"rawtypes", "unused"})
public class Item implements java.io.Serializable {
	private static final long	serialVersionUID	= -8538374965225447785L;

	private java.lang.Integer	currentPage;

	private java.lang.Integer	firstResult;

	private java.lang.Integer	maxResults;

	public Item() {
	}

	public Item(java.lang.Integer currentPage, java.lang.Integer firstResult, java.lang.Integer maxResults) {
		this.currentPage = currentPage;
		this.firstResult = firstResult;
		this.maxResults = maxResults;
	}

	public java.lang.Integer getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(java.lang.Integer currentPage) {
		this.currentPage = currentPage;
	}

	public java.lang.Integer getFirstResult() {
		return firstResult;
	}

	public void setFirstResult(java.lang.Integer firstResult) {
		this.firstResult = firstResult;
	}

	public java.lang.Integer getMaxResults() {
		return maxResults;
	}

	public void setMaxResults(java.lang.Integer maxResults) {
		this.maxResults = maxResults;
	}

	private java.lang.Object __equalsCalc = null;

	@Override
	public synchronized boolean equals(java.lang.Object obj) {
		if(!(obj instanceof Item)) {
			return false;
		}
		Item other = (Item)obj;
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
		_equals = true && (currentPage == null && other.getCurrentPage() == null || currentPage != null && currentPage.equals(other.getCurrentPage())) && (firstResult == null && other.getFirstResult() == null || firstResult != null && firstResult.equals(other.getFirstResult())) && (maxResults == null && other.getMaxResults() == null || maxResults != null && maxResults.equals(other.getMaxResults()));
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
		int _hashCode = 1;
		if(getCurrentPage() != null) {
			_hashCode += getCurrentPage().hashCode();
		}
		if(getFirstResult() != null) {
			_hashCode += getFirstResult().hashCode();
		}
		if(getMaxResults() != null) {
			_hashCode += getMaxResults().hashCode();
		}
		__hashCodeCalc = false;
		return _hashCode;
	}

	private static org.apache.axis.description.TypeDesc typeDesc = new org.apache.axis.description.TypeDesc(Item.class, true);

	static {
		typeDesc.setXmlType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "item"));
		org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("currentPage");
		elemField.setXmlName(new javax.xml.namespace.QName("", "currentPage"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("firstResult");
		elemField.setXmlName(new javax.xml.namespace.QName("", "firstResult"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("maxResults");
		elemField.setXmlName(new javax.xml.namespace.QName("", "maxResults"));
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
