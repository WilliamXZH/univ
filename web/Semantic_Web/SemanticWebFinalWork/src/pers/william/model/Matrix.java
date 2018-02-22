package pers.william.model;

import java.util.List;

public class Matrix {
	private int rowNum;
	private int colNum;


	private double[][] dataMatrix;
	
	private List<User> users;
	
	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	public Matrix() {
		super();
	}

	public Matrix(double[][] dataMatrix) {
		super();
		this.dataMatrix = dataMatrix;
		this.rowNum = dataMatrix.length;
		this.colNum = dataMatrix[0].length;
	}

	public int getRowNum() {
		return rowNum;
	}

	public void setRowNum(int rowNum) {
		this.rowNum = rowNum;
	}

	public int getColNum() {
		return colNum;
	}

	public void setColNum(int colNum) {
		this.colNum = colNum;
	}

	public double[][] getDataMatrix() {
		return dataMatrix;
	}

	public void setDataMatrix(double[][] dataMatrix) {
		this.dataMatrix = dataMatrix;
	}
	
	
}
