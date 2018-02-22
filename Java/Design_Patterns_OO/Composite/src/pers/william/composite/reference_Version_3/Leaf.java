package pers.william.composite.reference_Version_3;

import java.util.ArrayList;
import java.util.Iterator;

public class Leaf extends Node {

	@Override
	public Node AddSubNode(Node node) {
		return null;
	}

	@Override
	public Node removeSubNodeByIndex(int index) {
		return null;
	}

	@Override
	public void clearSubNode() {

	}

	@Override
	public Iterator<Node> iterator() {
		return new ArrayList<Node>().iterator();
	}

	@Override
	public void operation() {
		//do Leaf operation
	}

}
