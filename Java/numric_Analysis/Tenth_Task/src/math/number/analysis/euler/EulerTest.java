package math.number.analysis.euler;

import org.junit.Test;

public class EulerTest {
	
	Euler euler = new Euler(new Double(0),new Double(0), new Double(0), new Double(2));
	
	@Test
	public void testEuler(){
		
		euler.setStepWith(new Double(0.1));
		euler.start();
		
		euler.setStepWith(new Double(0.2));
		euler.start();
		
		euler.setStepWith(new Double(0.4));
		euler.start();
	}
}
