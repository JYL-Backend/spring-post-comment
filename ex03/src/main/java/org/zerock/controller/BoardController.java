package org.zerock.controller;

import org.apache.ibatis.javassist.expr.NewArray;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.pageDTO;
import org.zerock.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@RequiredArgsConstructor
public class BoardController {
	final private BoardService boardService;
	
	/**
	 * 조회
	 */
	@GetMapping("list")
	public void list(Criteria criteria, Model model) {
		log.info("list");
		model.addAttribute("list", boardService.getListWithPaging(criteria));
		
		int total = boardService.getTotal(criteria);
		
		model.addAttribute("pageMaker",new pageDTO(criteria, total));
	}
	
	@GetMapping({"get", "modify"})
	public void get(
			@RequestParam("bno") Long bno, 
			@ModelAttribute("criteria") Criteria criteria,
			Model model) {
		log.info("/get");
		model.addAttribute( "board", boardService.get(bno));
	}
	
	/**
	 * 생성
	 */
	@PostMapping("register")
	public String register(BoardVO boardVO, RedirectAttributes rttr) {
		log.info("register : " + boardVO);
		boardService.register(boardVO);
		rttr.addFlashAttribute("result", boardVO.getBno());
		
		return "redirect:/board/list";
	}
	
	@GetMapping("register")
	public String register(){
		
		return "/board/register";
	}
	
	/**
	 * 수정
	 */
	@PostMapping("modify")
	public String modify(
			BoardVO board,
			@ModelAttribute("criteria") Criteria criteria,
			RedirectAttributes rttr) {
		
		if(boardService.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}

		rttr.addAttribute("pageNum", criteria.getPageNum());
		rttr.addAttribute("amount", criteria.getAmount());
		rttr.addAttribute("type", criteria.getType());
		rttr.addAttribute("keyword", criteria.getKeyword());
		
		return "redirect:/board/list";
	}
	
	/**
	 * 삭제
	 */
	@PostMapping("remove")
	public String remove(
			@RequestParam("bno") Long bno,
			@ModelAttribute("criteria") Criteria criteria, 
			RedirectAttributes rttr) {
		log.info("remove :" + bno);
		if(boardService.remove(bno)) {
			rttr.addFlashAttribute("result", "suecess");
		}

		rttr.addAttribute("pageNum", criteria.getPageNum());
		rttr.addAttribute("amount", criteria.getAmount());
		rttr.addAttribute("type", criteria.getType());
		rttr.addAttribute("keyword", criteria.getKeyword());
		
		return "redirect:/board/list";
	}
}
