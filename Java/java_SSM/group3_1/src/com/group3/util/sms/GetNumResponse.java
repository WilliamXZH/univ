
package com.group3.util.sms;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for anonymous complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="GetNumResult" type="{http://106.ihuyi.cn/}GetNumResult" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "getNumResult"
})
@XmlRootElement(name = "GetNumResponse")
public class GetNumResponse {

    @XmlElement(name = "GetNumResult")
    protected GetNumResult getNumResult;

    /**
     * Gets the value of the getNumResult property.
     * 
     * @return
     *     possible object is
     *     {@link GetNumResult }
     *     
     */
    public GetNumResult getGetNumResult() {
        return getNumResult;
    }

    /**
     * Sets the value of the getNumResult property.
     * 
     * @param value
     *     allowed object is
     *     {@link GetNumResult }
     *     
     */
    public void setGetNumResult(GetNumResult value) {
        this.getNumResult = value;
    }

}
