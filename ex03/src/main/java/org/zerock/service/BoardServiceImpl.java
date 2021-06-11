package org.zerock.service;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequiredArgsConstructor
@Service
public class BoardServiceImpl implements BoardService{

	


	final BoardMapper boardMapper;
	
	@Override
	public void register(BoardVO boardVO) {
		// TODO Auto-generated method stub
		log.info("register..........." + boardVO);
		
		boardMapper.insertSelectKey(boardVO);
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get..........." + bno);
		return boardMapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO boardVO) {
		log.info("modify..........." + boardVO);
		return boardMapper.update(boardVO) == 1;
	}

	@Override
	public boolean remove(Long bno) {
		log.info("remove..........." + bno);
		return boardMapper.delete(bno) == 1;
	}

	/**
	 *
	 */
//	@Override
//	public List<BoardVO> getList() {
//		log.info("getList..........." );
//		return	boardMapper.getList();
//	}
	@Override
	public List<BoardVO> getList(Criteria criteria) {
		log.info("getList..........." );
		if(criteria == null )criteria = new Criteria();
		return	boardMapper.getList(criteria);
	}


	@Override
	public int getTotal(Criteria criteria) {
		return boardMapper.getTotalCount(criteria);
	}
	
	@Override
	public List<BoardVO> getListWithPaging(Criteria criteria) {
		// TODO Auto-generated method stub
		if(criteria == null) criteria = new Criteria();
		return boardMapper.getListWithPaging(criteria);
	}
	
}
