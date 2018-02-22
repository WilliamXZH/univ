package hello;
import org.eclipse.swt.*;
import org.eclipse.swt.custom.*;
import org.eclipse.swt.widgets.*;
public class HelloWorld {
	public static void main(String []args){
		Display dip1=new Display();
		Shell sh1=new Shell(dip1);
		sh1.setText("FIRST SWT");
		sh1.setImage(dip1.getSystemImage(SWT.ICON_QUESTION));
		CLabel lb1=new CLabel(sh1,SWT.LEFT);
		lb1.setImage(dip1.getSystemImage(SWT.ICON_INFORMATION));
		lb1.setText("Hello World\n");
		lb1.pack();
		sh1.pack();
		sh1.open();
		while(!sh1.isDisposed()){
			if(dip1.readAndDispatch()){
				dip1.sleep();
			}
		}
		dip1.dispose();
	}
}
