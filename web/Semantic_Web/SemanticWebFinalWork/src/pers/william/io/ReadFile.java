package pers.william.io;

import java.util.ArrayList;
import java.util.List;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

public class ReadFile {
	
	public List<String> read(String pathname){
		
		File file = new File(pathname);
		FileReader fr = null;
		
		
		System.out.println(pathname);
		try {
			fr = new FileReader(file);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		BufferedReader br = new BufferedReader(fr);
		
		List<String> lines = new ArrayList<>();
		
		String line;
		try {
			while((line=br.readLine()) != null){
				lines.add(line);
			}
			br.close();
			fr.close();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		return lines;
	}
}
