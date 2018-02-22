package experiment4;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.StringTokenizer;

import experiment.Coffee;
import experiment.CoffeeBrewer;
import experiment.Product;
import experiment2.Catalog;

public class FileCatalogLoader implements CatalogLoader{
	private Product readProduct(String line) throws DataFormatException{
		StringTokenizer tr=new StringTokenizer(line,"_");
		tr.nextToken();
		return new Product(tr.nextToken(), tr.nextToken(), Double.parseDouble(tr.nextToken()));
		
	}
	private Coffee readCoffee(String line) throws DataFormatException
	{
		StringTokenizer tr=new StringTokenizer(line,"_");
		tr.nextToken();
		return new Coffee(tr.nextToken(), tr.nextToken(), Double.parseDouble(tr.nextToken()),tr.nextToken(),tr.nextToken(),tr.nextToken(),tr.nextToken(),tr.nextToken(),tr.nextToken());
		
	}
	public CoffeeBrewer readCoffeeBrewer(String line) throws  DataFormatException {
		StringTokenizer tr=new StringTokenizer(line,"_");
		tr.nextToken();
	    return new CoffeeBrewer(tr.nextToken(),
				tr.nextToken(),Double.parseDouble(tr.nextToken()),tr.nextToken(),tr.nextToken()
				,Integer.parseInt(tr.nextToken())); 
	}
	@Override
	public Catalog loadCatalog(String filename) throws FileNotFoundException, IOException, DataFormatException {
		
		Catalog catalog = new Catalog();
		BufferedReader reader = new BufferedReader(new FileReader(filename));
		String line = reader.readLine();
	 
		while(line != null)
		{ 
			Product product = null;
			if(line.startsWith("Product")){
				product = readProduct(line);
			} else if(line.startsWith("Coffee")){
				product = readCoffee(line);
			} else if(line.startsWith("Brewer")){ 
				product = readCoffeeBrewer(line); 
			} else {
				throw new DataFormatException(line); 
			} 
			catalog.addProduct(product); 
			line = reader.readLine(); 
		} 
	    reader.close();     
	    return catalog; 
	}
}
