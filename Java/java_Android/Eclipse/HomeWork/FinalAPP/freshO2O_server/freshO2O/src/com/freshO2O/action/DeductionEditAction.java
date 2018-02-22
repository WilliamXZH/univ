package com.freshO2O.action;

import com.freshO2O.dao.DeductionDAO;
import com.freshO2O.po.Deduction;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;

/**
 * Created with IntelliJ IDEA. User: Administrator Date: 14-11-19 Time: 下午6:14
 * To change this template use File | Settings | File Templates.
 */
public class DeductionEditAction extends ActionSupport {
	
	private int deduction;

	private String result;
	private String msg;
	
	private DeductionDAO deductionDAO;

	public void setDeductionDAO(DeductionDAO deductionDAO) {
		this.deductionDAO = deductionDAO;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public DeductionEditAction() {
	}

	public int getDeduction() {
		return deduction;
	}

	public void setDeduction(int deduction) {
		this.deduction = deduction;
	}

	public String execute() {

		System.out.println("deduction : " + deduction );

		List<Deduction> list = deductionDAO.findAll();

		if (list.size() != 0) {

			Deduction d = list.get(0);
			d.setDeduction(deduction);
			deductionDAO.delete(d);
			deductionDAO.save(d);

			this.msg = "操作成功";
			this.result = "ok";
		} else {
			
			Deduction d = list.get(0);
			d.setDeduction(deduction);
			deductionDAO.save(d);
		}

		return "success";
	}

}
