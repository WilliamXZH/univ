/*!Begin Snippet:file*/
import  java.util.*;
import java.io.*;

/**
 * Maintains the information of a library catalog. Contains a
 * collection of {@link CatalogItem} objects.
 *
 * @author iCarnegie
 * @version  1.0.0
 * @see CatalogItem
 */
public class Catalog implements Iterable<CatalogItem>  {

	/* Collection of <code>CatalogItem</code> objects.*/
	private ArrayList<CatalogItem>  items;

	/**
	 * Constructs an empty catalog.
	 */
	public Catalog() {

		this.items = new ArrayList<CatalogItem>();
	}

	/**
	 * Adds a {@link CatalogItem} object to this catalog.
	 *
	 * @param catalogItem  the {@link CatalogItem} object.
	 */
	public void  addItem(CatalogItem catalogItem)  {

		this.items.add(catalogItem);
	}

	/**
	 * Returns an iterator over the items in this catalog.
	 *
	 * return  an {@link Iterator} of {@link CatalogItem}
	 */
	public Iterator<CatalogItem>  iterator() {

		return this.items.iterator();
	}

	/**
	 * Returns the {@link CatalogItem} object with the specified
	 * <code>code</code>.
	 *
	 * @param code  the code of an item.
	 * @return  The {@link CatalogItem} object with the specified
	 *          code. Returns <code>null</code> if the object with
	 *          the code is not found.
	 */
	public CatalogItem  getItem(String code)  {

		for (CatalogItem catalogItem : this.items) {
			if (catalogItem.getCode().equals(code)) {

				return catalogItem;
			}
		}

		return null;
	}

	/**
	 * Returns the number of items in the catalog.
	 *
	 * @return the number of {@link CatalogItem} objects in this catalog.
	 */
	public int  getNumberOfItems()  {

		return this.items.size();
	}
	
	/**
	 * Returns an array containing all the codes products in this
	 * catalog.
	 *
	 * @return an array containing the code products of this catalog 
	 */
	public String[] getCodes()  {

		String[] result = new String[getNumberOfItems()];
		int index = 0;
		
		for (CatalogItem catalogItem : items) {
			result[index++] = catalogItem.getCode();
		}
		
		return  result;
	}
}
/*!End Snippet:file*/