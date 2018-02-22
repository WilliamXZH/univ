package com.freshO2O.action;

import com.freshO2O.dao.CookBookDAO;
import com.freshO2O.po.CookBook;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA. User: Administrator Date: 14-11-19 Time: 下午6:14
 * To change this template use File | Settings | File Templates.
 */
public class CookBookAddAction extends ActionSupport {
	
	private String cname;
	private String cmethod;
	private String csource;
	
	private File uploadImage;
	private String uploadImageContentType;
	private String uploadImageFileName;

	private String result;
	private String msg;
	
	private CookBookDAO cookBookDAO;


	public void setCookBookDAO(CookBookDAO cookBookDAO) {
		this.cookBookDAO = cookBookDAO;
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

	public CookBookAddAction() {
	}

	public File getUploadImage() {
		return uploadImage;
	}

	public void setUploadImage(File uploadImage) {
		this.uploadImage = uploadImage;
	}

	public String getUploadImageContentType() {
		return uploadImageContentType;
	}

	public void setUploadImageContentType(String uploadImageContentType) {
		this.uploadImageContentType = uploadImageContentType;
	}

	public String getUploadImageFileName() {
		return uploadImageFileName;
	}

	public void setUploadImageFileName(String uploadImageFileName) {
		this.uploadImageFileName = uploadImageFileName;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public String getCmethod() {
		return cmethod;
	}

	public void setCmethod(String cmethod) {
		this.cmethod = cmethod;
	}

	public String getCsource() {
		return csource;
	}

	public void setCsource(String csource) {
		this.csource = csource;
	}

	public String execute() {
		
		System.out.println("cname : "+cname+"    csource : "+csource);

		System.out.println("-----------文件上传-----------  uploadImageFileName  : "
						+ uploadImageFileName);
		if (null == uploadImageFileName) {
			return "fail";
		}
		String filePath = ServletActionContext.getServletContext().getRealPath("/upload");
		System.out.println(filePath);
		File file = new File(filePath);
		if (!file.exists()) {
			file.mkdirs();
		}
		try {
			Date date = new Date();
			DateFormat format1 = new SimpleDateFormat("yyyyMMddHHmmss");  
	        System.out.println(format1.format(date));
			
	        uploadImageFileName = format1.format(date)+uploadImageFileName.substring(uploadImageFileName.lastIndexOf("."));
	        
			FileUtils.copyFile(uploadImage, new File(file, uploadImageFileName));
			ActionContext.getContext().put("filePath", "文件上传成功，路径为：" + filePath);
			System.out.println("filePath : " + filePath);
			List<CookBook> list = cookBookDAO.findByProperty("cname", cname);
			
			System.out.println();
			
			if(list.size()==0){
			
				CookBook c = new CookBook();
				c.setCname(cname);
				c.setCmethod(cmethod);
				c.setCsource(csource);
				c.setCpic("/upload/"+uploadImageFileName);
				
				cookBookDAO.save(c);
				
				this.msg = "操作成功";
				this.result = "ok";
			}else{
				this.result = "fail";
				this.msg = "名称已经存在！";
			}
		} catch (Exception e) {

			this.result = "fail";
			this.msg = "名称已经存在！";

			e.printStackTrace();
		}
		
		Map session = ActionContext.getContext().getSession();
		session.put("csource", "");

		return "success";
	}

}
