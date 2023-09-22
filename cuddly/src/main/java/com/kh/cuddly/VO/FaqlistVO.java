package com.kh.cuddly.VO;

import lombok.Data;

@Data
public class FaqlistVO {

	private String category;//카테고리 검색용
	private int page = 1;//현재 페이지 번호(기본:1)
	private int size = 10;//보여줄 게시판의 글 수(기본:10)
	private int count;//전체 글 수
	private int navigatorSize = 10;//하단 네비게이터 표시 개수(기본:10)
	
	public boolean isCategory() { // 카테고리 값이 있 / 없 
		return category != null; // 값이 없으면 
	}
	public int getBegin() { // 시작 
		return (page-1) / navigatorSize * navigatorSize + 1; // ex) 
	}
	public int getEnd() { // 끝 
		int end = getBegin() + navigatorSize - 1;  // ex) 
		return Math.min(getPageCount(), end); 
	}
	public boolean isFirst() {
		return getBegin() == 1;
	}
	
	public int getPageCount() {
		return (count-1) / size + 1;
	}
	
	public boolean isLast() {
		return getEnd() >= getPageCount();
	}
	
	public String getPrevQueryString() {
		if(isCategory()) {//카테고리
			return "page="+(getBegin()-1)+"&size="+size+"&category="+category;
		}
		else {//목록
			return "page="+(getBegin()-1)+"&size="+size;
		}
	}
	
	public String getNextQueryString() {
		if(isCategory()) {//검색
			return "page="+(getBegin()+1)+"&size="+size+"&category="+category;
		}
		else {//목록
			return "page="+(getEnd()+1)+"&size="+size;
		}
	}
	
	public String getQueryString(int page) {
		if(isCategory()) {//검색
			return "page="+page+"&size="+size+"&category="+category;
		}
		else {//목록
			return "page="+page+"&size="+size;
		}
	}
	
	public int getStartRow() {
		return getFinishRow() - (size-1);
	}
	public int getFinishRow() {
		return page * size;
	}
}


