package com.freshO2O.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-11-19
 * Time: 下午6:14
 * To change this template use File | Settings | File Templates.
 */
public class FileAction extends ActionSupport {
    private File uploadImage;
    private String uploadImageContentType;
    private String uploadImageFileName;

    public FileAction() {
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

    public String saveFile() throws Exception {
    	
    	System.out.println("-----------文件上传-----------  uploadImageFileName  : "+uploadImageFileName);
    	if(null == uploadImageFileName){
    		return "fail";
    	}
        String filePath = ServletActionContext.getServletContext().getRealPath("/upload");
        System.out.println(filePath);
        File file = new File(filePath);
        if (!file.exists()) {
            file.mkdirs();
        }
        FileUtils.copyFile(uploadImage, new File(file, uploadImageFileName));
        ActionContext.getContext().put("filePath", "文件上传成功，路径为：" + filePath);
        System.out.println("filePath : "+filePath);
        readExcel(filePath+"//"+uploadImageFileName);
        
        
        return "success";
    }
    
    public static void readExcel(String filePath) throws BiffException, IOException {
		// 创建一个list 用来存储读取的内容
		List list = new ArrayList();
		Workbook rwb = null;
		Cell cell = null;

		// 创建输入流
		InputStream stream = new FileInputStream(filePath);

		// 获取Excel文件对象
		rwb = Workbook.getWorkbook(stream);

		// 获取文件的指定工作表 默认的第一个
		Sheet sheet = rwb.getSheet(0);

		// 行数(表头的目录不需要，从1开始)
		for (int i = 0; i < sheet.getRows(); i++) {

			// 创建一个数组 用来存储每一列的值
			String[] str = new String[sheet.getColumns()];

			// 列数
			for (int j = 0; j < sheet.getColumns(); j++) {

				// 获取第i行，第j列的值
				cell = sheet.getCell(j, i);
				str[j] = cell.getContents();

			}
			// 把刚获取的列存入list
			list.add(str);
		}
		for (int i = 0; i < list.size(); i++) {
			String[] str = (String[]) list.get(i);
			for (int j = 0; j < str.length; j++) {
				System.out.println("单元格内容 ： "+str[j]);
			} 
		}
	}
    
}
