package tool;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;

public class DateFormatter extends Date {
	private static SimpleDateFormat minFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	private static SimpleDateFormat dayFormatter = new SimpleDateFormat("yyyy-MM-dd");
	public static String minToString(Date date) {
		return minFormatter.format(date);
	}

	public  static Date stringToMin(String line) throws ParseException {
		Date date = minFormatter.parse(line);
		return date;
	}

	public static String dayToString(Date date) {
		return dayFormatter.format(date);
	}
	public static Date stringToDay(String line) throws ParseException {
		Date date = dayFormatter.parse(line);
		return date;
	}
	public static Date localToDate(LocalDate localDate) {
		ZoneId zone = ZoneId.systemDefault();
	    Instant instant = localDate.atStartOfDay().atZone(zone).toInstant();
	    Date date=Date.from(instant);
		return date;
	}
	public static LocalDate dateToLocal(Date date) {
		LocalDate localDate=date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		return localDate;
	}
	
}
