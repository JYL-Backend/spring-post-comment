package org.zerock.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class pageDTO {
	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private Criteria criteria;
	public pageDTO(Criteria criteria, int total) {
		this.total = total;
		this.criteria = criteria;
		
		this.endPage =(int) (Math.ceil(criteria.getPageNum()/ 10.0)) * 10;
		this.startPage =this.endPage - 9;
		
		int realEnd = (int) (Math.ceil((total*1.0)/ criteria.getAmount()));
		
		if(realEnd < this.endPage) {
			this.endPage =realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage <realEnd;
		
	}
	
	
}
