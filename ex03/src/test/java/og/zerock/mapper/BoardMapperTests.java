package og.zerock.mapper;

import static org.junit.Assert.assertArrayEquals;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThat;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests
{
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;

	@Test
	public void testInsert() {
		BoardVO boardVO =new BoardVO();
		boardVO.setTitle("새글 제목33");
		boardVO.setContent("새글 내용33");
		boardVO.setWriter("newbie33");
		
		mapper.insert(boardVO);
		
		log.info(boardVO);
		
		 
	}
	@Test
	public void testInsertSelectKey() {
		BoardVO boardVO =new BoardVO();
		boardVO.setTitle("새글 제목53");
		boardVO.setContent("새글 내용53");
		boardVO.setWriter("newbie53");
		
		mapper.insert(boardVO);
		
		log.info(boardVO);
	}
	
	@Test
	public void testRead() {
		BoardVO board =mapper.read(2938L);
		log.info(board);
	}
	
	@Test
	public void testDelete() {
		log.info("delete count : " + mapper.delete(2941L));
	}
	
	@Test
	public void testUpdate() {
		BoardVO boardVO = new BoardVO();
		
		boardVO.setBno(2943L);
		boardVO.setTitle("수정");
		boardVO.setContent("수정내용");
		boardVO.setWriter("user00");
		
		int count = mapper.update(boardVO);
		log.info("update count : " + count);
	}
	
	@Test
	public void testPaging() {
		Criteria criteria = new Criteria();
		
		List<BoardVO> list = mapper.getList(criteria);
		
		list.forEach(board -> log.info(board));
	}
}
