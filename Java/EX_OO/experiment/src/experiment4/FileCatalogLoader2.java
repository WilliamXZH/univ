package experiment4;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.StringTokenizer;

import experiment.Coffee;
import experiment.CoffeeBrewer;
import experiment.Product;
import experiment2.Catalog;

public class FileCatalogLoader2 implements CatalogLoader {
	
	 /* Prefix of a line with product data */
    private final static String PRODUCT_PREFIX = "Product";

    /* Prefix of a line with coffee data */
    private final static String COFFEE_PREFIX = "Coffee";
    
    /* Prefix of a line with brewer data */
    private final static String Brewer_PREFIX = "Brewer";
    
    /* Delimiter */
    private final static String DELIM = "_";
    
	@SuppressWarnings("resource")
	public Catalog loadCatalog(String filename) throws FileNotFoundException,IOException,DataFormatException{
		Catalog catalog = new Catalog();
		
        BufferedReader read =
            new BufferedReader(new FileReader(filename));
        String line = read.readLine();

        while (line != null) {

            Product product = null;

            if (line.startsWith(PRODUCT_PREFIX)) {
                product = readProduct(line);
            } else if (line.startsWith(COFFEE_PREFIX)) {
                product = readCoffee(line);
            } else if (line.startsWith(Brewer_PREFIX)) {
                product = readCoffeeBrewer(line);
            }else {

                throw new DataFormatException(line);
            }

            catalog.addProduct(product);

            line = read.readLine();
        }

        return catalog;
	}
	@SuppressWarnings("unused")
	public Product readProduct(String line) throws DataFormatException{
		StringTokenizer tokenizer = new StringTokenizer(line, DELIM);

        if (tokenizer.countTokens() != 4) {

            throw new DataFormatException(line);
        } else {
            try {

                String prefix = tokenizer.nextToken();

                return new Product(tokenizer.nextToken(),
                                  tokenizer.nextToken(),
                                  Double.parseDouble(tokenizer.nextToken()));
            } catch (NumberFormatException nfe) {

                throw new DataFormatException(line);
            }
        }
	}
	@SuppressWarnings("unused")
	public Coffee readCoffee(String line) throws DataFormatException{
		 StringTokenizer tokenizer = new StringTokenizer(line, DELIM);

	        if (tokenizer.countTokens() != 10) {

	            throw new DataFormatException(line);
	        } else {
	            try {

	                String prefix = tokenizer.nextToken();

	                return new Coffee (tokenizer.nextToken(),
	                                  tokenizer.nextToken(),
	                                  Double.parseDouble(tokenizer.nextToken()),
	                                  tokenizer.nextToken(),
	                                  tokenizer.nextToken(),
	                                  tokenizer.nextToken(),
	                                  tokenizer.nextToken(),
	                                  tokenizer.nextToken(),
	                                  tokenizer.nextToken());
	            } catch (NumberFormatException nfe) {

	                throw new DataFormatException(line);
	            }
	        }
	}
	@SuppressWarnings("unused")
	public CoffeeBrewer readCoffeeBrewer(String line) throws DataFormatException{
		StringTokenizer tokenizer = new StringTokenizer(line, DELIM);

        if (tokenizer.countTokens() != 7) {

            throw new DataFormatException(line);
        } else {
            try {

                String prefix = tokenizer.nextToken();

                return new CoffeeBrewer (tokenizer.nextToken(),
                                  tokenizer.nextToken(),
                                  Double.parseDouble(tokenizer.nextToken()),
                                  tokenizer.nextToken(),
                                  tokenizer.nextToken(),
                                  Integer.parseInt(tokenizer.nextToken()));
            } catch (NumberFormatException nfe) {

                throw new DataFormatException(line);
            }
        }
	}
}
