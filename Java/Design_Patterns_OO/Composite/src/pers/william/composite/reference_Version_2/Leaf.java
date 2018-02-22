package pers.william.composite.reference_Version_2;

import java.util.ArrayList;
import java.util.Iterator;

public class Leaf implements Node {

	public Iterator<Node> iterator() {
		// TODO Auto-generated method stub
		return new ArrayList<Node>().iterator();
	}

	public void operation() {
		// TODO Auto-generated method stub

	}

	public Node addSubNode(Node node) {
		// TODO Auto-generated method stub
		return null;
	}

	public Node removeSubNodeByIndex(int index) {
		// TODO Auto-generated method stub
		return null;
	}

	public void clearSubNodes() {
		// TODO Auto-generated method stub

	}

}
