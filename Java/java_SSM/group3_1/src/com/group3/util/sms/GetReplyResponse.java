
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
 *         &lt;element name="GetReplyResult" type="{http://106.ihuyi.cn/}GetReplyResult" minOccurs="0"/>
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
    "getReplyResult"
})
@XmlRootElement(name = "GetReplyResponse")
public class GetReplyResponse {

    @XmlElement(name = "GetReplyResult")
    protected GetReplyResult getReplyResult;

    /**
     * Gets the value of the getReplyResult property.
     * 
     * @return
     *     possible object is
     *     {@link GetReplyResult }
     *     
     */
    public GetReplyResult getGetReplyResult() {
        return getReplyResult;
    }

    /**
     * Sets the value of the getReplyResult property.
     * 
     * @param value
     *     allowed object is
     *     {@link GetReplyResult }
     *     
     */
    public void setGetReplyResult(GetReplyResult value) {
        this.getReplyResult = value;
    }

}
