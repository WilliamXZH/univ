package pers.william.service;

import java.util.List;

import pers.william.io.ReadFile;
import pers.william.model.Matrix;

public class Reader {

	public Matrix getData(String pathname){
		Matrix matrix = new Matrix();
		
		ReadFile readFile = new ReadFile();
		
		List<String> strings = readFile.read(pathname);
		
		int length = strings.size();
		for(int i=0;i<length;i++){
			
			String line = strings.get(i);
			
		}
		
		return matrix;
		
	}
}
