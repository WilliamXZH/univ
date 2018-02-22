package chap7.pullxml;

import java.io.File;
import java.io.InputStream;
import java.net.URL;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

import android.app.Activity;
import android.os.Bundle;
import android.widget.EditText;

public class PullXmlActivity extends Activity {
	/** Called when the activity is first created. */
	StringBuffer sb = new StringBuffer();

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);
		EditText text = (EditText) findViewById(R.id.text);
/*
		try {
			SAXParser parser = SAXParserFactory.newInstance().newSAXParser();
			parser.parse("http://10.0.2.2:8888/TestServer/test.xml", new SaxHandler());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
*/
		
		
/*		
		try {
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document doc = builder.parse("http://10.0.2.2:8888/TestServer/test.xml");
			NodeList nodelist = doc.getElementsByTagName("city");
			for (int i = 0; i < nodelist.getLength(); i++) {
				Node node = nodelist.item(i);
				sb.append(node.getNodeName()+"-");
				NamedNodeMap map = node.getAttributes();
				Node n = map.item(0);
				sb.append(n.getNodeValue());
				sb.append(node.getTextContent()+"\n");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
*/		
		
		
		try {
			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			XmlPullParser parser = factory.newPullParser();
			InputStream in = new URL("http://10.0.2.2:8888/TestServer/test.xml")
					.openStream();
			parser.setInput(in, "utf-8");
			int eventType = parser.getEventType();
			int type = 0;
			while (eventType != XmlPullParser.END_DOCUMENT) {
				if (eventType == XmlPullParser.START_TAG) {
					if (parser.getName().equals("city")) {
						sb.append(parser.getName() + "-"
								+ parser.getAttributeValue(0) + "\n");
					} else if (parser.getName().equals("name")) {
						type = 1;
					} else if (parser.getName().equals("code")) {
						type = 2;
					}

				} else if (eventType == XmlPullParser.TEXT) {
					if (type == 1) {
						sb.append("    " + parser.getText() + "\n");
					} else if (type == 2) {
						sb.append("    " + parser.getText() + "\n\n");
					}
					type = 0;
				}
				eventType = parser.next();
			}
			in.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		text.setText(sb.toString());
	}
/*	
	class SaxHandler extends DefaultHandler {

		int type = 0;
		
		public void startElement(String uri, String localName, String qName,
				Attributes attributes) throws SAXException {
			if (qName.equals("city")) {
				sb.append(qName + "-" + attributes.getValue(0)+"\n");
			} else if (qName.equals("name")) {
				type=1;				
			} else if (qName.equals("code")) {
				type=2;
			}
		}

		public void characters(char[] ch, int start, int length)
				throws SAXException {
			if(type==1){
				sb.append("    "+new String(ch,start,length)+"\n");
				type=0;
			}
			if(type==2){
				sb.append("    "+new String(ch,start,length)+"\n\n");
				type=0;
			}
		}
	}
*/
}