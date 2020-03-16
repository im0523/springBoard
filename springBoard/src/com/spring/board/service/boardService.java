package com.spring.board.service;

import java.util.List;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.MemberVo;
import com.spring.board.vo.PageVo;

public interface boardService {

	public String selectTest() throws Exception;

	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception;

	public BoardVo selectBoard(String boardType, int boardNum) throws Exception;

	public int selectBoardCnt() throws Exception;

	public int boardInsert(BoardVo boardVo) throws Exception;
	
	public int boardDelete(BoardVo boardVo) throws Exception;

	public int boardModify(BoardVo boardVo) throws Exception;
	
	public List<ComCodeVo> codeNameList(String codeType) throws Exception;		//insert, modify¿« select option ∏Ò∑œ
	
	public int memeberInsert(MemberVo memberVo) throws Exception;
	
	public boolean id_usable(String userId) throws Exception;

	public MemberVo loginAction(String userId, String userPw);

}
