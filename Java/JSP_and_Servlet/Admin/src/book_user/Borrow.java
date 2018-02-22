package book_user;

import java.sql.Date;

public class Borrow {
	private int BookId;
	private String Name;
	private String User;
	private Date BorrowDate;
	private Date ReturnDate;
	public Borrow(int id,String name,String user,Date BorrowDate,Date ReturnDate) {
		// TODO Auto-generated constructor stub
		this.BookId=id;
		this.Name=name;
		this.User=user;
		this.BorrowDate = BorrowDate;
		this.ReturnDate = ReturnDate;

	}
	
	
	public int getBookId() {
		return BookId;
	}
	public void setBookId(int bookId) {
		BookId = bookId;
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
	public Date getReturnDate() {
		return ReturnDate;
	}
	public void setReturnDate(Date returnDate) {
		ReturnDate = returnDate;
	}
	public Date getBorrowDate() {
		return BorrowDate;
	}
	public void setBorrowDate(Date borrowDate) {
		BorrowDate = borrowDate;
	}
}
