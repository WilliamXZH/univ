package com.freshO2O.po;



/**
 * Area entity. @author MyEclipse Persistence Tools
 */

public class Area  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private String areaname;
     private String addr;
     private String xypoint;


    // Constructors

    /** default constructor */
    public Area() {
    }

    
    /** full constructor */
    public Area(String areaname, String addr) {
        this.areaname = areaname;
        this.addr = addr;
    }

   
    // Property accessors

    public String getXypoint() {
		return xypoint;
	}


	public void setXypoint(String xypoint) {
		this.xypoint = xypoint;
	}


	public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }

    public String getAreaname() {
        return this.areaname;
    }
    
    public void setAreaname(String areaname) {
        this.areaname = areaname;
    }

    public String getAddr() {
        return this.addr;
    }
    
    public void setAddr(String addr) {
        this.addr = addr;
    }
   








}