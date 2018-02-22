
package org.gnuhpc.wsClient;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the org.gnuhpc.wsClient package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

    private final static QName _GetGreeting_QNAME = new QName("http://wsServer.gnuhpc.org/", "getGreeting");
    private final static QName _GetGreetingResponse_QNAME = new QName("http://wsServer.gnuhpc.org/", "getGreetingResponse");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: org.gnuhpc.wsClient
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link GetGreetingResponse }
     * 
     */
    public GetGreetingResponse createGetGreetingResponse() {
        return new GetGreetingResponse();
    }

    /**
     * Create an instance of {@link GetGreeting }
     * 
     */
    public GetGreeting createGetGreeting() {
        return new GetGreeting();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetGreeting }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://wsServer.gnuhpc.org/", name = "getGreeting")
    public JAXBElement<GetGreeting> createGetGreeting(GetGreeting value) {
        return new JAXBElement<GetGreeting>(_GetGreeting_QNAME, GetGreeting.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetGreetingResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://wsServer.gnuhpc.org/", name = "getGreetingResponse")
    public JAXBElement<GetGreetingResponse> createGetGreetingResponse(GetGreetingResponse value) {
        return new JAXBElement<GetGreetingResponse>(_GetGreetingResponse_QNAME, GetGreetingResponse.class, null, value);
    }

}
