package chap7.json;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

public class JsonActivity extends Activity {
	/** Called when the activity is first created. */
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);
		TextView text = (TextView) findViewById(R.id.text);

		try {
			HttpGet request = new HttpGet(
					"http://10.0.2.2:8888/TestServer/Json");
			HttpResponse response = new DefaultHttpClient().execute(request);
			if (response.getStatusLine().getStatusCode() == 200) {
				String msg = EntityUtils.toString(response.getEntity());
				JSONArray array = new JSONArray(msg);
				String s = "";
				for (int i = 0; i < array.length(); i++) {
					JSONObject o = (JSONObject) array.get(i);
					s = s + o.getString("city") + ": " + o.getString("code")+"  ";
				}
				text.setText(s);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}