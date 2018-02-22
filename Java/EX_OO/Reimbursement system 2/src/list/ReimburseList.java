package list;

import java.util.ArrayList;

import base.ReimburseItem;

public class ReimburseList extends ArrayList<ReimburseItem>{
	public ReimburseList() {
		super();
	}

	public void replaceReimburseItem(ReimburseItem newReimburseItem, ReimburseItem oldReimburseItem) {
		for (ReimburseItem p : this) {
			if (p.equals(oldReimburseItem)) {
				this.remove(p);
				break;
			}
		}
		this.add(newReimburseItem);
	}

}
