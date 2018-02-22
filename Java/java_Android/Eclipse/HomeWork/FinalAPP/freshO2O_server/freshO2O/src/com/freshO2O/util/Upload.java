package com.freshO2O.util;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class Upload {
	@SuppressWarnings("unchecked")
	public static Map<String, String> upload(HttpServletRequest request){
		Map<String, String> map=new HashMap<String, String>();
		DiskFileItemFactory dis=new DiskFileItemFactory();
		ServletFileUpload ser=new ServletFileUpload(dis);
		try {
			List<FileItem> list=ser.parseRequest(request);
			for (FileItem fileItem : list) {
				if (fileItem.isFormField()) { 
					String name=fileItem.getFieldName();
					String val=fileItem.getString("UTF-8");
					map.put(name, val);
				}else {
					String name=fileItem.getFieldName();
					String pa=fileItem.getName();
					if (pa!=null&&!pa.equals("")) {
						if (pa.contains("\\")) {
							pa=pa.substring(pa.lastIndexOf("\\")+1);
						}
					String base=request.getSession().getServletContext().getRealPath("upload");
					File fil=new File(base);
					if (!fil.exists()) {
						fil.mkdir();
					}
					File file=new File(base,pa);
					fileItem.write(file);
					}
					map.put(name, pa);
				}
			}
		} catch (FileUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return map;
	}
}
