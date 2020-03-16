package com.spring.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.BoardDao;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.MemberVo;
import com.spring.board.vo.PageVo;

@Service
public class boardServiceImpl implements boardService{
	
	@Autowired
	BoardDao boardDao;
	
	@Override
	public String selectTest() throws Exception {
		return boardDao.selectTest();
	}
	
	@Override
	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception {
		return boardDao.selectBoardList(pageVo);
	}
	
	@Override
	public int selectBoardCnt() throws Exception {
		return boardDao.selectBoardCnt();
	}
	
	@Override
	public BoardVo selectBoard(String boardType, int boardNum) throws Exception {
		BoardVo boardVo = new BoardVo();
		
		boardVo.setBoardType(boardType);
		boardVo.setBoardNum(boardNum);
		
		return boardDao.selectBoard(boardVo);
	}
	
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		return boardDao.boardInsert(boardVo);
	}

	@Override
	public int boardDelete(BoardVo boardVo) throws Exception {
		return boardDao.boardDelete(boardVo);
	}

	@Override
	public int boardModify(BoardVo boardVo) throws Exception {
		return boardDao.boardModify(boardVo);
	}

	@Override
	public List<ComCodeVo> codeNameList(String codeType) throws Exception {
		System.out.println(codeType);
		
		return boardDao.codeNameList(codeType);
	}

	@Override
	public int memeberInsert(MemberVo memberVo) throws Exception {
		return boardDao.memberInsert(memberVo);
	}

	@Override
	public boolean id_usable(String userId) throws Exception {
		return boardDao.id_usable(userId);
	}

//	@Override
//	public List<ComCodeVo> codeList() throws Exception {
//		return boardDao.codeList();
//	}

	@Override
	public MemberVo loginAction(String userId, String userPw) {
		return boardDao.loginAction(userId, userPw);
	}

}
