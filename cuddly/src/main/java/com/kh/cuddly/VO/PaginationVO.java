package com.kh.cuddly.VO;

import lombok.Data;

//VO(Value Object) 
//	- 내 입맛대로 데이터를 모아서 저장하는 클래스(DB무관)
//	- 등록하지 않고 필요할 때마다 만들어서 사용
@Data
public class PaginationVO {
	private String keyword;	//검색 분류 및 키워드
	private String type;//회원 검색할때 쓸 타입 추가
	private String creatorName;
	private String productItem;
	private String sort;//상품 정렬때매
	private String sortByWish;//찜하기 개수로 정렬
	private int page = 1;//현재 페이지 번호(기본:1)
	private int size = 10;//보여줄 게시판의 글 수(기본:10)
	private int count;//전체 글 수
	private int navigatorSize = 10;//하단 네비게이터 표시 개수(기본:10)
	
	public boolean isSearch() {
		return keyword != null;
	}
	public boolean isSearchByCreatorName() {
		return creatorName != null;
	}
	public boolean isSearchByMember() {//회원 검색용
		return type != null && keyword != null;
	}
	public boolean isSearchByProductItem() {
		return productItem != null;
	}
	public boolean isSort() {
		return type != null && sort != null;
	}
	public boolean isSortByWishlist() {
		return sortByWish != null;
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
		if(isSearch()) {//검색
			return "page="+(getBegin()-1)+"&size="+size+"&keyword="+keyword;
		}
		else if(isSearchByCreatorName()) {
			return "page="+(getBegin()-1)+"&size="+size+"&creatorName="+creatorName;
		}
		else if(isSearchByMember()) {//회원 검색용
			return "page="+(getBegin()-1)+"&size="+size+"&type="+type+"&keyword="+keyword;
		}
		else if(isSearchByProductItem()) {
			return "page="+(getBegin()-1)+"&size="+size+"&type="+type+"&productItem="+productItem;
		}
		else if(isSort()){
			return "page="+(getBegin()-1)+"&size="+size+"&type="+type+"&sort="+sort;
		}
		else if(isSortByWishlist()) {
			return "page="+(getBegin()-1)+"&size="+size+"&type="+type+"&sortByWish="+sortByWish;
		}
		else {//목록
			return "page="+(getBegin()-1)+"&size="+size;
		}
	}
	
	public String getNextQueryString() {
		if(isSearch()) {//검색
			return "page="+(getEnd()+1)+"&size="+size+"&keyword="+keyword;
		}
		else if(isSearchByCreatorName()) {
			return "page="+(getEnd()+1)+"&size="+size+"&creatorName="+creatorName;
		}
		else if(isSearchByMember()) {//회원검색용
			return "page="+(getEnd()+1)+"&size="+size+"&type="+type+"&keyword="+keyword;
		}
		else if(isSearchByProductItem()) {
			return "page="+(getEnd()+1)+"&size="+size+"&productItem="+productItem;
		}
		else if(isSort()){
			return "page="+(getEnd()+1)+"&size="+size+"&type="+type+"&sort="+sort;
		}
		else if(isSortByWishlist()) {
			return "page="+(getEnd()+1)+"&size="+size+"&sortByWish="+sortByWish;
		}
		else {//목록
			return "page="+(getEnd()+1)+"&size="+size;
		}
	}
	
	public String getQueryString(int page) {
		if(isSearch()) {//검색
			return "page="+page+"&size="+size+ "&keyword=" + keyword;
		}
		else if(isSearchByCreatorName()) {
			return "page="+page+"&size="+size+"&creatorName="+creatorName;
		}
		else if(isSearchByMember()) {//회원검색용
			return "page="+page+"&size="+size+"&type="+type+"&keyword="+keyword;
		}
		else if(isSearchByProductItem()) {
			return "page="+page+"&size="+size+"&productItem="+productItem;
		}
		else if(isSort()){
			return "page="+page+"&size"+size+"&type="+type+"&sort="+sort;
		}
		else if(isSortByWishlist()) {
			return "page="+page+"&size="+size+"&sortByWish="+sortByWish;
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






