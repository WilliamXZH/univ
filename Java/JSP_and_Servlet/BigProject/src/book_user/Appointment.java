package book_user;

import java.sql.Date;
public class Appointment {
	private int BookId;
	private String Name;
	private String User;
	private Date AppointmentDate;
	private Date BeforeDate;
	public Appointment(int id,String name,String user,Date appointmentDate,Date beforeDate) {
		this.BookId=id;
		this.Name=name;
		this.User=user;
		AppointmentDate = appointmentDate;
		BeforeDate = beforeDate;

	}
	
	
	public int getId() {
		return BookId;
	}
	public void setId(int id) {
		BookId = id;
	}
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}

	public String getUser() {
		return User;
	}
	public void setUser(String user) {
		User = user;
	}


	public Date getAppointmentDate() {
		return AppointmentDate;
	}


	public void setAppointmentDate(Date appointmentDate) {
		AppointmentDate = appointmentDate;
	}


	public Date getBeforeDate() {
		return BeforeDate;
	}


	public void setBeforeDate(Date beforeDate) {
		BeforeDate = beforeDate;
	}

}
