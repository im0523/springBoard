package com.spring.board.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.BoardDao;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.MemberVo;
import com.spring.board.vo.PageVo;

@Repository
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public String selectTest() throws Exception {
		
		String a = sqlSession.selectOne("board.boardList");
		
		return a;
	}
	/**
	 * 
	 * */
	@Override
	public List<BoardVo> selectBoardList(PageVo pageVo) throws Exception {
		return sqlSession.selectList("board.boardList",pageVo);
	}
	
	@Override
	public int selectBoardCnt() throws Exception {
		return sqlSession.selectOne("board.boardTotal");
	}
	
	@Override
	public BoardVo selectBoard(BoardVo boardVo) throws Exception {
		return sqlSession.selectOne("board.boardView", boardVo);
	}
	
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		return sqlSession.insert("board.boardInsert", boardVo);
	}
	@Override
	public int boardDelete(BoardVo boardVo) throws Exception {
		return sqlSession.delete("board.boardDelete", boardVo);
	}
	@Override
	public int boardModify(BoardVo boardVo) throws Exception {
		return sqlSession.update("board.boardModify", boardVo);
	}
	@Override
	public List<ComCodeVo> codeNameList(String codeType) throws Exception {
		return sqlSession.selectList("board.codeNameList", codeType);
	}
	@Override
	public int memberInsert(MemberVo memberVo) throws Exception {
		return sqlSession.insert("board.memberInsert", memberVo);
	}
	@Override
	public boolean id_usable(String userId) throws Exception {
		return (Integer)sqlSession.selectOne("board.usableId", userId) ==1 ? false : true;
	}
	@Override
	public MemberVo loginAction(String userId, String userPw) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		map.put("userPw", userPw);
		return sqlSession.selectOne("board.loginAction", map);
	}
	
}
