package board;

import java.util.ArrayList;

public class BoardService {
	private BoardDao dao;
	//public final static String path = "C:\\Users\\원유경\\Desktop\\Eclipse\\Web Workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\webapps\\img\\";
//	public final static String path = "C:\\Users\\Hi there\\Desktop\\webProgramming\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\webapps\\HmemberImg\\";
	public final static String path = "/Users/choeyeeun/Desktop/ME/Project/Hamo_yeah/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/webapps/img/";
	
	public BoardService() {
		dao = new BoardDao();
	}
	
	public void addBoard(BoardVo vo) {
		dao.insert(vo);
	}
	
	public void editBoard(BoardVo vo) {
		dao.update(vo);
	}
	
	public void delBoard(int board_num) {
		dao.delete(board_num);
	}
	
	public ArrayList<BoardVo> getAllBoard() {
		return dao.selectAll();
	}
	
	public BoardVo getByBoardNum(int board_num) {
		return dao.selectBoardNum(board_num);
	}
	
	public ArrayList<BoardVo> getById(String memberId) {
		return dao.selectId(memberId);
	}
	
	public ArrayList<BoardVo> getByTag(String tag) {
		return dao.selectTag(tag);
	}
	
	public ArrayList<BoardVo> getByPlace(String place) {
		return dao.selectPlace(place);
	}
	
	public ArrayList<BoardVo> getByTitle(String title) {
		return dao.selectTitle(title);
	}
	
	public ArrayList<BoardVo> getByContent(String content)	{
		return dao.selectContent(content);
	}
	
	public ArrayList<BoardVo> getByPlaceAndTag(String place, String tag)	{
		return dao.selectPlaceAndTag(place, tag);
	}
	
	public ArrayList<BoardVo> getByTitleAndTag(String title, String tag)	{
		return dao.selectPlaceAndTag(title, tag);
	}
	
	public ArrayList<BoardVo> getByContentAndTag(String content, String tag)	{
		return dao.selectPlaceAndTag(content, tag);
	}
	
	public ArrayList<BoardVo> getByComplete() {
		return dao.selectComplete();
	}
	
	public ArrayList<BoardVo> getByOngoing() {
		return dao.selectOngoing();
	}
	
	public void EditParticipate(BoardVo vo) {
		dao.updateParticipate(vo);;
	}
	
	public void Recovery(int boardnum) {
		dao.updateProcessRe(boardnum);
	}
	
	public void Stop(int boardnum) {
		dao.updateProcessStop(boardnum);
	}
	
	public ArrayList<BoardVo> getYCard3() {
		return dao.selectYCard3();
	}
	
	public ArrayList<BoardVo> getRecovery() {
		return dao.selectRecovery();
	}
	
	public void plusYcard(int boardNum) {
		dao.updateYcard(boardNum);
	}
}