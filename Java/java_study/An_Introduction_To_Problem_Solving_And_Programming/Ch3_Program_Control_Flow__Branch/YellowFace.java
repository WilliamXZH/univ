import javax.swing.JApplet;
import java.awt.Color;
import java.awt.Graphics;

/**
 *Applet that displays a happy face.
 *Authoe: Jane Q. Programmer.
 *Revision of Listing 1.2.
 */

public class YellowFace extends JApplet
{
	public static final int FACE_DIAMETER = 200;
	public static final int X_FACE = 100;
	public static final int Y_FACE = 50;

	public static final int EYE_WIDTH = 10;
	public static final int EYE_HEIGHT = 20;
	public static final int X_RIGHT_EYE = 155;
	public static final int Y_RIGHT_EYE = 100;
	public static final int X_LEFT_EYE = 230;
	public static final int Y_LEFT_EYE = Y_RIGHT_EYE;

	public static final int NOSE_DIAMETER = 10;
	public static final int X_NOSE = 195;//Center of nose will be at 200
	public static final int Y_NOSE = 135;

	public static final int MOUTH_WIDTH = 100;
	public static final int MOUTH_HEIGHT = 50;
	public static final int X_MOUTH = 150;
	public static final int Y_MOUTH = 160;
	public static final int MOUTH_START_ANGLE = 180;
	public static final int MOUTH_DEGREES_SHOWN = 180;

	public void paint(Graphics canvas)
	{
		super.paint(canvas);
		//Draw face outline:
		canvas.setColor(Color.YELLOW);
		canvas.drawOval(X_FACE, Y_FACE, FACE_DIAMETER, FACE_DIAMETER);
		canvas.setColor(Color.BLACK);
		canvas.drawOval(X_FACE, Y_FACE, FACE_DIAMETER, FACE_DIAMETER);

		//Draw eyes
		canvas.setColor(Color.BLUE);
		canvas.fillOval(X_RIGHT_EYE, Y_RIGHT_EYE, EYE_WIDTH, EYE_HEIGHT);
		canvas.fillOval(X_LEFT_EYE, Y_LEFT_EYE, EYE_WIDTH, EYE_HEIGHT);
		
		//Draw nose
		canvas.setColor(Color.BLACK);
		canvas.fillOval(X_NOSE, Y_NOSE, NOSE_DIAMETER, NOSE_DIAMETER);

		//Draw mouth
		canvas.setColor(Color.RED);
		canvas.drawArc(X_MOUTH, Y_MOUTH, MOUTH_WIDTH, MOUTH_HEIGHT,
					MOUTH_START_ANGLE, MOUTH_DEGREES_SHOWN);
	}
}