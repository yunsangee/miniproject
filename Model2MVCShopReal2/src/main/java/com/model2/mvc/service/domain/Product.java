package com.model2.mvc.service.domain;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;


public class Product {
	
	private String fileName;
	private String manuDate;
	private int price;
	private String prodDetail;
	private String prodName;
	private int prodNo;
	private Date regDate;
	private String proTranCode;
	
	private String manuDateString;
	private String regDateString;
	private String category;
	
	
	
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getManuDateString() {
		return manuDateString;
	}

	public void setManuDateString(String manuDateString) {
		this.manuDateString = manuDateString;
	}

	public String getRegDateString() {
		return regDateString;
	}

	public void setRegDateString(String regDateString) {
		this.regDateString = regDateString;
	}

	public Product(){
	}
	
	public String getProTranCode() {
		return proTranCode;
	}
	public void setProTranCode(String proTranCode) {
		this.proTranCode = proTranCode.trim();
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getManuDate() {
		return manuDate;
	}
	public void setManuDate(String manuDate) {
		this.manuDate = manuDate;
//		if(manuDate !=null) {
//			// JSON ==> Domain Object  Binding�� ���� ��publ���� �κ�
//			this.setManuDateString( manuDate.toString().split("-")[0]
//													+"-"+ manuDate.toString().split("-")[1]
//													+ "-" +manuDate.toString().split("-")[2] );
//		}
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getProdDetail() {
		return prodDetail;
	}
	public void setProdDetail(String prodDetail) {
		this.prodDetail = prodDetail;
	}
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	public int getProdNo() {
		return prodNo;
	}
	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
		if(regDate !=null) {
			// JSON ==> Domain Object  Binding�� ���� ��publ���� �κ�
			this.setRegDateString( regDate.toString().split("-")[0]
													+"-"+ regDate.toString().split("-")[1]
													+ "-" +regDate.toString().split("-")[2] );
		}
	}

	public void setImagePath(String path) {
		// TODO Auto-generated method stub
		
	}	
	// Override
	public String toString() {
		return "ProductVO : [fileName]" + fileName
				+ "[manuDate]" + manuDate+ "[price]" + price + "[prodDetail]" + prodDetail
				+ "[prodName]" + prodName + "[prodNo]" + prodNo + "[proTranCode]" + proTranCode
				+ "[category]" + category;
	}

	
}