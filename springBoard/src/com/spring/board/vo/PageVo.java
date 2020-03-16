package com.spring.board.vo;

public class PageVo {
	
	private int pageNo = 0;
	private String[] codeId;
	private String userId;
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String[] getCodeId() {
		return codeId;
	}

	public void setCodeId(String[] codeId) {
		this.codeId = codeId;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	
}
