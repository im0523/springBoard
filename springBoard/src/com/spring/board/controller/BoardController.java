package com.spring.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.MemberVo;
import com.spring.board.vo.PageVo;
import com.spring.common.CommonUtil;

@Controller
public class BoardController {
	
	@Autowired boardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	//게시판 목록화면 요청
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model,PageVo pageVo) throws Exception{
		
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		List<ComCodeVo> comCodeList = new ArrayList<ComCodeVo>();
		
		int page = 1;
		int totalCnt = 0;
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);;
		}
		
		boardList = boardService.SelectBoardList(pageVo);
		comCodeList = boardService.codeNameList("menu"); 
		totalCnt = boardService.selectBoardCnt();
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("codeName", comCodeList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", page);
		
		return "board/boardList";
	}
	
	//게시판 상세화면 요청
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		return "board/boardView";
	}
	
	//게시판 신규글 작성화면 요청
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model) throws Exception{
		List<ComCodeVo> comCodeList = new ArrayList<ComCodeVo>();
		comCodeList = boardService.codeNameList("menu");
		
		model.addAttribute("codeName", comCodeList);
		return "board/boardWrite";
	}
	
	//게시판 신규글 작성처리 요청
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction(Locale locale,BoardVo boardVo, Model model) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardInsert(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	//게시판 글 삭제처리 요청
	@RequestMapping(value = "/board/boardDelete.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardDelete(Locale local, BoardVo boardVo) throws Exception {

		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardDelete(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	//게시판 수정화면 요청
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardModify.do", method = RequestMethod.GET)
	public String boardmodify(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		List<ComCodeVo> comCodeList = new ArrayList<ComCodeVo>();
		BoardVo boardVo = new BoardVo();
		
		comCodeList = boardService.codeNameList("menu");
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("codeName", comCodeList);
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		return "board/boardModify";
	}
	
	//게시판 수정처리 요청
	@RequestMapping(value = "/board/boardModifyAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardModifyAction(Locale locale,BoardVo boardVo, Model model) throws Exception{
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();

		int resultCnt = boardService.boardModify(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	//회원가입 화면
	@RequestMapping("/board/join.do")
	public String join(Model model) throws Exception {
		List<ComCodeVo> comCodeList = new ArrayList<ComCodeVo>();
		comCodeList = boardService.codeNameList("phone"); 
		model.addAttribute("codeList", comCodeList);
		return "member/join";
	}
	
	//회원가입 처리 요청
	@RequestMapping(value="/board/memberInsert.do", produces="text/html; charset=UTF-8")
	@ResponseBody
	public String memberInsert(MemberVo memberVo, HttpServletRequest request) throws Exception {
		System.out.println(request.getParameter("userName"));
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.memeberInsert(memberVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	//아이디 중복검사
	@RequestMapping("/id_usable.do")
	@ResponseBody
	public String id_usable(String userId) throws Exception {
		return String.valueOf(boardService.id_usable(userId));
	}
	
	//로그인 화면
	@RequestMapping("/board/login.do")
	public String login() {
		return "member/login";
	}
	
	//로그인 처리 요청
	@RequestMapping("/loginAction.do")
	@ResponseBody
	public int loginAction(String userId, String userPw, HttpSession ss) {
		MemberVo vo = boardService.loginAction(userId, userPw);
		ss.setAttribute("login_info", vo);

		int result;
		
		result = (vo == null ? 0 : 1);
		return result;
	}
	
	//로그아웃 처리 요청
	@RequestMapping("/logout.do")
	public String logout(HttpSession ss) {
		ss.removeAttribute("login_info");
		return "member/logout";
	}
		
}
