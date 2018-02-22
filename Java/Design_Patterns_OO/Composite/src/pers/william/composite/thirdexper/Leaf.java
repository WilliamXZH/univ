package pers.william.composite.thirdexper;

import java.util.ArrayList;
import java.util.Iterator;

/**
 * @author William
 *
 */
public class Leaf extends Node {

	public Leaf(){
		
	}
	
	public Leaf(int currentDepth, int totalDepth, String postfix) {
		this.setValue(this.getValue()+"_"+currentDepth+postfix);
		//super.operation(currentDepth);
	}
	@Override
	public void clearSubNode() {
	}
	@Override
	public Node addSubNode(Node node) {
		return null;
	}

	@Override
	public Node removeSubNodeByIndex(int index) {
		return null;
	}

	@Override
	public Iterator<Node> iterator() {
		return new ArrayList<Node>().iterator();
	}



}
