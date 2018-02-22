package com.example.noname.bean;

import java.io.Serializable;

public class WelTitle implements Serializable {
	private static final long serialVersionUID = 3988663497599238343L;
	private int category;
	private int display;
	private int id;
	private int mode;
	private String name;
	private String photo;
	private String summary;

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public int getDisplay() {
		return display;
	}

	public void setDisplay(int display) {
		this.display = display;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getMode() {
		return mode;
	}

	public void setMode(int mode) {
		this.mode = mode;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public WelTitle(int category, int display, int id, int mode, String name,
			String photo, String summary) {
		super();
		this.category = category;
		this.display = display;
		this.id = id;
		this.mode = mode;
		this.name = name;
		this.photo = photo;
		this.summary = summary;
	}

	public WelTitle() {
		super();
	}

	@Override
	public String toString() {
		return "WelTitle [category=" + category + ", display=" + display
				+ ", id=" + id + ", mode=" + mode + ", name=" + name
				+ ", photo=" + photo + ", summary=" + summary + "]";
	}
	// @Override
	// public int describeContents() {
	// return 0;
	// }
	// @Override
	// public void writeToParcel(Parcel parcel, int flags) {
	// //序列化对象，必须按照声明顺序
	// parcel.writeInt(category);
	// parcel.writeInt(id);
	// parcel.writeInt(mode);
	// parcel.writeString(name);
	// parcel.writeString(photo);
	// parcel.writeString(summary);
	// }
	// //必须实现这个接口，它的作用是从 percel中读出来数据，顺序必须按照声明顺序
	// public static final Parcelable.Creator<WelTitle> CREATOR = new
	// Creator<WelTitle>(){
	// @Override
	// public WelTitle createFromParcel(Parcel source) {
	// WelTitle app= new WelTitle();
	// app.category=source.readInt();
	// app.id=source.readInt();
	// app.mode=source.readInt();
	// app.name = source.readString();
	// app.photo = source.readString();
	// app.summary = source.readString();
	// return app;
	// }
	// @Override
	// public WelTitle[] newArray(int size) {
	// return new WelTitle[size];
	// }
	//
	// };

}
