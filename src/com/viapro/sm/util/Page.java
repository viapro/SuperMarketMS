package com.viapro.sm.util;

import java.util.List;

public class Page<T> {
	
	private List<T> list;
	private int rowCount;// 总记录数
	private int pageCount;// 总页数
	private int pageSize = 10;// 每页显示条数
	private int currentPage;// 当前页码
	private int start;// 当前页起始记录数
	private int startPage;// 当前起始页码
	private int endPage;// 当前结束页码

	// 通过总记录数和当前页码获得总记录数和当前页的起始记录数
	public Page(int rowCount, int currentPage) {
		this.rowCount = rowCount;
		if (rowCount % pageSize == 0) pageCount = rowCount / pageSize;
		else pageCount = rowCount / pageSize + 1;
		this.currentPage = currentPage;// 1
		start = (currentPage - 1) * pageSize;
		if (getPageCount() <= 10) {
			startPage = 1;
			endPage = getPageCount();
		} else {
			startPage = currentPage - 4;
			endPage = currentPage + 5;
			
			if (startPage < 1) {
				startPage = 1;
				endPage = 10;
			}
			if (endPage > pageCount) {
				endPage = pageCount;
				startPage = pageCount - 9;
			}
		}
	}

	public List<T> getList() {
		return list;
	}

	public void setList(List<T> list) {
		this.list = list;
	}

	public int getRowCount() {
		return rowCount;
	}

	public void setRowCount(int rowCount) {
		this.rowCount = rowCount;
	}

	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
}
