package pers.william.composite.reference_Version_4;

import java.util.ArrayList;
import java.util.Iterator;

public class Leaf extends Node {

	@Override
	public Node addSubNode(Node node) {
		return null;
	}

	@Override
	public Node removeSubNodeByIndex(int index) {
		return null;
	}

	@Override
	public void clearSubNodes() {

	}

	@Override
	public Iterator<Node> iterator() {
		return new ArrayList<Node>().iterator();
	}

	@Override
	public void operation() {
		//do leaf's operation
	}

}
