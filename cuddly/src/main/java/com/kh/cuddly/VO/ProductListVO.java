package com.kh.cuddly.VO;

import lombok.Data;

//VO(Value Object) 
//	- 내 입맛대로 데이터를 모아서 저장하는 클래스(DB무관)
//	- 등록하지 않고 필요할 때마다 만들어서 사용
@Data
public class ProductListVO {
	private String sort="desc";
	private String target="product_no";
	private String keyword;
	private String creator;
	private int page = 1;//현재 페이지 번호(기본:1)
	private int size = 8;//보여줄 상품 개수(기본:8)
	private int count;//전체 글 수
	private int navigatorSize = 10;//하단 네비게이터 표시 개수(기본:10)
	
	public boolean isSearch() {
		return keyword != null;
	}
	
	public boolean isCreator() {
		return creator != null;
	}
	
	public int getBegin() {
		return (page-1) / navigatorSize * navigatorSize + 1;
	}
	public int getEnd() {
		int end = getBegin() + navigatorSize - 1;
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
		if(isSearch()) {
			return "target="+target+"&sort="+sort+"&keyword="+ keyword +"&page="+(getBegin()-1)+"&size="+size;
		}
		else {
			return "target="+target+"&sort="+sort+"&page="+(getBegin()-1)+"&size="+size;
		}
	}
	
	public String getNextQueryString() {
		if(isSearch()) {
			return "target="+target+"&sort="+sort+"&keyword="+ keyword +"&page="+(getEnd()+1)+"&size="+size;
		}
		else {
			return "target="+target+"&sort="+sort+"&page="+(getEnd()+1)+"&size="+size;
		}
	}
	
	public String getQueryString(int page) {
		if(isSearch()) {
			return "target="+target+"&sort="+sort+"&keyword="+ keyword+"&page="+page+"&size="+size;
		}
		else if(isCreator()) {
			return "target="+target+"&sort="+sort+"&creator="+creator+"&page="+page+"&size="+size;
		}
		else {
			return "target="+target+"&sort="+sort+"&page="+page+"&size="+size;
		}
	}
	
	public String getQueryStringPriceAsc() {
		if(isSearch()) {
			return "target=product_price&sort=asc&keyword="+ keyword+"&page="+page+"&size="+size;
		}
		else {
			return "target=product_price&sort=asc&page="+page+"&size="+size;
		}
	}
	
	public String getQueryStringPriceDesc() {
		if(isSearch()) {
			return "target=product_price&sort=desc&keyword="+ keyword+"&page="+page+"&size="+size;
		}
		else {
			return "target=product_price&sort=desc&page="+page+"&size="+size;
		}
	}
	
	public String getQueryStringNew() {
		if(isSearch()) {
			return "target=product_no&sort=desc&keyword="+ keyword+"&page="+page+"&size="+size;
		}
		else {
			return "target=product_no&sort=desc&page="+page+"&size="+size;
		}
	}
	
	public String getQueryStringPopular() {
		if(isSearch()) {
			return "target=wishlist_count&sort=desc&keyword="+ keyword+"&page="+page+"&size="+size;
		}
		else {
			return "target=wishlist_count&sort=desc&page="+page+"&size="+size;
		}
	}
	
	public int getStartRow() {
		return getFinishRow() - (size-1);
	}
	public int getFinishRow() {
		return page * size;
	}
}