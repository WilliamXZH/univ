package com.freshO2O.action;

import com.freshO2O.dao.GoodsDAO;
import com.freshO2O.po.Goods;
import com.freshO2O.po.User;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created with IntelliJ IDEA. User: Administrator Date: 14-11-19 Time: 下午6:14
 * To change this template use File | Settings | File Templates.
 */
public class GoodsAddAction extends ActionSupport {
	
	private String category;
	private String g_name;
	private Double g_price;
	private String g_desc;
	
	private Integer g_count;
	
	private File uploadImage;
	private String uploadImageContentType;
	private String uploadImageFileName;

	private String result;
	private String msg;
	
	private GoodsDAO goodsDAO;

	public void setGoodsDAO(GoodsDAO goodsDAO) {
		this.goodsDAO = goodsDAO;
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

	public GoodsAddAction() {
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

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getG_name() {
		return g_name;
	}

	public void setG_name(String gName) {
		g_name = gName;
	}

	public double getG_price() {
		return g_price;
	}

	public void setG_price(Double gPrice) {
		g_price = gPrice;
	}

	public String getG_desc() {
		return g_desc;
	}

	public void setG_desc(String gDesc) {
		g_desc = gDesc;
	}

	public Integer getG_count() {
		return g_count;
	}

	public void setG_count(Integer gCount) {
		g_count = gCount;
	}

	public String execute() {
		
		System.out.println("category : "+category+"    g_price : "+g_price);

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
			List<Goods> list = goodsDAO.findByProperty("GName", g_name);
			
			System.out.println();
			
			if(list.size()==0){
			
				Goods goods = new Goods();
				goods.setCategoryId(Integer.parseInt(category));
				goods.setGName(g_name);
				goods.setGPrice(g_price);
				goods.setGDesc(g_desc);
				goods.setG_reco("0");
				goods.setG_count(g_count);
				goods.setG_integration(0);
				goods.setG_discount(0);
				goods.setGPic("/upload/"+uploadImageFileName);
				
				goodsDAO.save(goods);
				
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

		return "success";
	}

}
