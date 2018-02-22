package com.freshO2O.po;



/**
 * Deduction entity. @author MyEclipse Persistence Tools
 */

public class Deduction  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private Integer deduction;


    // Constructors

    /** default constructor */
    public Deduction() {
    }

    
    /** full constructor */
    public Deduction(Integer deduction) {
        this.deduction = deduction;
    }

   
    // Property accessors

    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getDeduction() {
        return this.deduction;
    }
    
    public void setDeduction(Integer deduction) {
        this.deduction = deduction;
    }
   








}