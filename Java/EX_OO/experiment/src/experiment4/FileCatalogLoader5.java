package experiment4;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.StringTokenizer;

import experiment.Coffee;
import experiment.CoffeeBrewer;
import experiment.Product;
//experiment.Catalog;
import experiment2.Catalog;
 
public class FileCatalogLoader5 implements  CatalogLoader{
 
public Catalog loadCatalog(String filename)throws 
FileNotFoundException,IOException,DataFormatException{ 
	Catalog catalog = new Catalog();
	@SuppressWarnings("resource")
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
private Product readProduct(String line)throws DataFormatException{
	StringTokenizer toKenizer = new StringTokenizer(line,"_");
	if(toKenizer.countTokens() != 4){
		throw new DataFormatException(line);
	} else {
		try{
			@SuppressWarnings("unused")
			String prefix = toKenizer.nextToken();
			return new Product (toKenizer.nextToken(),
					toKenizer.nextToken(),Double.parseDouble(toKenizer.nextToken()));
		} catch (NumberFormatException  nfe) {
			throw new DataFormatException(line);
		}
	}
}
private Coffee readCoffee(String line) throws DataFormatException{
	StringTokenizer toKenizer = new StringTokenizer(line,"_");
 
	if(toKenizer.countTokens() != 10){
 
		throw new DataFormatException(line);
 
	} else {
 
		try{
 
			@SuppressWarnings("unused")
			String prefix = toKenizer.nextToken();
			return new Coffee (toKenizer.nextToken(),
					toKenizer.nextToken(),Double.parseDouble(toKenizer.nextToken()),
					toKenizer.nextToken(),toKenizer.nextToken()
					,toKenizer.nextToken(),toKenizer.nextToken(),
					toKenizer.nextToken(),toKenizer.nextToken());
		} catch (NumberFormatException  nfe) {
			throw new DataFormatException(line);
		}
	}
}
private CoffeeBrewer readCoffeeBrewer(String line) throws DataFormatException {
	StringTokenizer toKenizer = new StringTokenizer(line,"_");
 
	if(toKenizer.countTokens() != 7){
		throw new DataFormatException(line);
	 
	} else {
		try{ 
			@SuppressWarnings("unused")
			String prefix = toKenizer.nextToken();
			return new CoffeeBrewer (toKenizer.nextToken(),
					toKenizer.nextToken(),Double.parseDouble(toKenizer.nextToken()),
					toKenizer.nextToken(),toKenizer.nextToken()
					,Integer.parseInt(toKenizer.nextToken()));
		} catch (NumberFormatException  nfe) {
				throw new DataFormatException(line);
			}
		}
	}
}