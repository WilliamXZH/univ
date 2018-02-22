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
   
/**  
 * Creates a file catalog and loads it with data stored in a file.  
 *   
 * @author Wang Yunsheng  
 * @version 1.0.0  
 * @see CatalogLoader  
 * @see Catalog  
 * @see CoffeeBrewer  
 * @see Coffee  
 */   
public class FileCatalogLoader3 implements CatalogLoader {   
    /* Prefix of a line with coffee data */   
    private final static String COFFEE = "Coffee";   
   
    /* Prefix of a line with coffeeBrewer data */   
    private final static String COFFEEBREWER = "Brewer";   
   
    /* Prefix of a line with product data */   
    private final static String PRODUCT = "Product";   
   
    /* Delimiter */   
    private final static String DELIM = "_";   
   
    /* Standard input stream */   
    private static BufferedReader stdIn = new BufferedReader(   
            new InputStreamReader(System.in));   
   
    /* Standard output stream */   
    private static PrintWriter stdOut = new PrintWriter(System.out, true);   
   
    /* Standard error stream */   
    private static PrintWriter stdErr = new PrintWriter(System.err, true);   
   
    /**  
     * Extracts the pruduct data in the specified line and returns a  
     * {@link Product} object that encapsulates the product data.  
     *   
     * @param line  
     *            a string that contains product data.  
     * @return a <code>Product</code> object that encapsulates the product  
     *         data in the specified line.  
     * @throws DataFormatException  
     *             if the line contains errors.  
     */   
    private Product readProduct(String line) throws DataFormatException {   
        StringTokenizer tokenizer = new StringTokenizer(line, DELIM);   
   
        if (tokenizer.countTokens() != 4) {   
   
            throw new DataFormatException(line);   
        } else {   
   
            try {   
   
                String prefix = tokenizer.nextToken();   
   
                return new Product(tokenizer.nextToken(),   
                        tokenizer.nextToken(), Double.parseDouble(tokenizer   
                                .nextToken()));   
   
            } catch (NumberFormatException nfe) {   
   
                throw new DataFormatException(line);   
            }   
   
        }   
   
    }   
   
    /**  
     * Extracts the coffee data in the specified line and returns a  
     * {@link Coffee} object that encapsulates the coffee data.  
     *   
     * @param line  
     *            a string that contains coffee data.  
     * @return a <code>Coffee</code> object that encapsulates the recording  
     *         data in the specified line.  
     * @throws DataFormatException  
     *             if the line contains errors.  
     */   
    private Coffee readCoffee(String line) throws DataFormatException {   
   
        StringTokenizer tokenizer = new StringTokenizer(line, DELIM);   
   
        if (tokenizer.countTokens() != 10) {   
   
            throw new DataFormatException(line);   
        } else {   
   
            try {   
                String prefix = tokenizer.nextToken();   
                {   
   
                    return new Coffee(tokenizer.nextToken(), tokenizer   
                            .nextToken(), Double.parseDouble(tokenizer   
                            .nextToken()), tokenizer.nextToken(), tokenizer   
                            .nextToken(), tokenizer.nextToken(), tokenizer   
                            .nextToken(), tokenizer.nextToken(), tokenizer   
                            .nextToken());   
                }   
   
            } catch (NumberFormatException nfe) {   
   
                throw new DataFormatException(line);   
            }   
   
        }   
   
    }   
   
    /**  
     * Extracts the coffeeBrewer data in the specified line and returns a  
     * {@link CoffeeBrewer} object that encapsulates the CoffeeBrewer data.  
     *   
     * @param line  
     *            a string that contains coffeeBrewer data.  
     * @return a <code>CoffeeBrewer</code> object that encapsulates the  
     *         coffeeBrewer data in the specified line.  
     * @throws DataFormatException  
     *             if the line contains errors.  
     */   
    private CoffeeBrewer readCoffeeBrewer(String line)   
            throws DataFormatException {   
        StringTokenizer tokenizer = new StringTokenizer(line, DELIM);   
   
        if (tokenizer.countTokens() != 7) {   
   
            throw new DataFormatException(line);   
        } else {   
   
            try {   
   
                String prefix = tokenizer.nextToken();   
   
                return new CoffeeBrewer(tokenizer.nextToken(), tokenizer   
                        .nextToken(),   
                        Double.parseDouble(tokenizer.nextToken()), tokenizer   
                                .nextToken(), tokenizer.nextToken(), Integer   
                                .parseInt(tokenizer.nextToken()));   
   
            } catch (NumberFormatException nfe) {   
   
                throw new DataFormatException(line);   
            }   
   
        }   
   
    }   
   
    /**  
     * Loads the information in the specified file into a coffee catalog and  
     * returns the catalog.  
     *   
     * @param filename  
     *            The name of a file that contains catalog information.  
     * @return a coffee catalog.  
     * @throws IOException  
     *             if there is an error reading the information in the specified  
     *             file.  
     * @throws FileNotFoundException  
     *             if the specified file does not exist.  
     * @throws DataFormatException  
     *             if the file contains malformed data.  
     */   
    public Catalog loadCatalog(String filename) throws FileNotFoundException,   
            IOException, DataFormatException {   
   
        Catalog catalog = new Catalog();   
   
        BufferedReader reader = new BufferedReader(new FileReader(filename));   
        String line = reader.readLine();   
   
        while (line != null) {   
   
            if (line.startsWith(COFFEE)) {   
                catalog.addProduct((Product) readCoffee(line));   
            } else if (line.startsWith(COFFEEBREWER)) {   
                catalog.addProduct((Product) readCoffeeBrewer(line));   
            } else if (line.startsWith(PRODUCT)) {   
                catalog.addProduct(readProduct(line));   
            } else {   
   
                throw new DataFormatException(line);   
            }   
   
            line = reader.readLine();   
        }   
   
        reader.close();   
   
        return catalog;   
    }   
   
}   