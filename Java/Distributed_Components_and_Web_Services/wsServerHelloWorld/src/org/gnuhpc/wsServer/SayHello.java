package org.gnuhpc.wsServer;

import javax.jws.WebService;

@WebService
public class SayHello extends Object{
    private static final String SALUTATION = "Hello";
    
    public String getGreeting(String name)
    {
    	return SALUTATION + ", " + name;
    }
}
