
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
 *         &lt;element name="GetKeFuResult" type="{http://106.ihuyi.cn/}GetKeFuResult" minOccurs="0"/>
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
    "getKeFuResult"
})
@XmlRootElement(name = "GetKeFuResponse")
public class GetKeFuResponse {

    @XmlElement(name = "GetKeFuResult")
    protected GetKeFuResult getKeFuResult;

    /**
     * Gets the value of the getKeFuResult property.
     * 
     * @return
     *     possible object is
     *     {@link GetKeFuResult }
     *     
     */
    public GetKeFuResult getGetKeFuResult() {
        return getKeFuResult;
    }

    /**
     * Sets the value of the getKeFuResult property.
     * 
     * @param value
     *     allowed object is
     *     {@link GetKeFuResult }
     *     
     */
    public void setGetKeFuResult(GetKeFuResult value) {
        this.getKeFuResult = value;
    }

}
