package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {

	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;

	// 데이터 베이스에 연결 메소드
	public void getCon() {
		try {
			Context initctx = new InitialContext();
			Context envctx = (Context) initctx.lookup("java:comp/env");
			// 타입이 데이터 소스이므로 데이터소스로 (타입변환해서) 받는다.
			DataSource ds = (DataSource) envctx.lookup("jdbc/pool");
			// 얻은 데이터소스를 사용해 연결한다.
			con = ds.getConnection(); // 커넥션 연결 해주는 메소드

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 전체 게시글의 갯수를 리턴하는 메소드
	public int getAllCount() {
		getCon();
		// 개시글의 갯수를 세야하기 때문에 카운트 변수를 추가하고 초기값을 선언한다.
		int count = 0;

		try {
			// sql 쿼리 준비함
			String sql = "select count(*) from board";
			pstmt = con.prepareStatement(sql);
			// ?표가 없으므로 바로 결과실행후 리턴시켜주면 된다.
			rs = pstmt.executeQuery();
			// 전체게시글은 한칸에서 밖에 출력이 되지 않으므로 1칸만 있으면 된다. 반복문 말고 if문으로 사용한다.
			if (rs.next()) { // 데이터가 있다면 카운트에 넣는다.
				// 전체 게시글 수
				count = rs.getInt(1);
			}
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	// 화면에 보여질 데이터를 10개씩 추출해서 리턴하는 메소드
	public Vector<BoardBean> getAllBoard(int startRow, int endRow) {
		// 리턴할객체 선언
		getCon();
		Vector<BoardBean> v = new Vector<>();
		try {
			// 쿼리 작성
			String sql = "select * from (select A.*, Rownum Rnum from (select * from board order by ref desc, re_step asc)A)"
					+ "where Rnum >= ? and Rnum <= ?";
			// 쿼리 실행할 객체를 선언
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			// 쿼리실행후 결과 저장
			rs = pstmt.executeQuery();
			// 데이터 개수가 몇개인지 모르기에 반복문을 이용하여 데이터를 추출
			while (rs.next()) {
				// 데이터를 패키징 ( BoardBean 클래스를 이용) 해줌
				BoardBean bean = new BoardBean();
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString());
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));
				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));
				// 패키징한 데이터를 벡터에 저장
				v.add(bean);
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return v;
	}

	// 하나의 게시글을 저장하는 메소드 호출
	public void insertBoard(BoardBean bean) {

		getCon();
		// 초기값 지정
		int ref = 0;
		int re_step = 1;// 새글이기에
		int re_level = 1;// 새글이기에

		try {
			// 쿼리 작성
			// 이 sql에서 1만 더하면 되기때문에 가장큰값을 검색
			String refsql = "select max(ref) from board";
			pstmt = con.prepareStatement(refsql);
			// 쿼리 실행후 결과를 리턴
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ref = rs.getInt(1) + 1; // ref가장 큰 값에 1을 더해줌
				// 최신글은 글번호가 가장 크기 때문에 원래 있던 글에서 1을 더해줌

			}
			// 데이터를 삽입하는 쿼리
			String sql = "insert into board values(board_seq.NEXTVAL,?,?,?,?,sysdate,?,?,?,0,?)";
			pstmt = con.prepareStatement(sql);
			// ?에 값을 매핑한다.
			pstmt.setString(1, bean.getWriter());
			pstmt.setString(2, bean.getEmail());
			pstmt.setString(3, bean.getSubject());
			pstmt.setString(4, bean.getPassword());
			pstmt.setInt(5, ref);
			pstmt.setInt(6, re_step);
			pstmt.setInt(7, re_level);
			pstmt.setString(8, bean.getContent());

			pstmt.executeUpdate();
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 하나의 게시글을 읽어들이는 메소드 작성
	// 게시글을 읽었다는 뜻은 조회수가 1증가된다는 뜻
	// 게시글을 누르면 조회수도 올라가야함
	public BoardBean getOneBoard(int num) {
		getCon();
		// 초기값이니까 null을 준다.
		BoardBean bean = null;
		try {
			// 하나의 게시글을 읽었을때 조회수 증가
			String countsql = "update board set readcount = readcount+1 where num=?";
			pstmt = con.prepareStatement(countsql);
			pstmt.setInt(1, num);
			// 쿼리를 실행
			pstmt.executeUpdate();

			// 한 게시글에 대한 정보를 리턴해주는 쿼리를 작성
			String sql = "select * from board where num=?";
			pstmt = con.prepareStatement(sql);
			// ?에 값을 집어넣기
			pstmt.setInt(1, num);
			// 쿼리실행후 결과를 리턴
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new BoardBean();
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString());
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));
				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));

			}

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;

	}

	// 답변글을 저장하는 메소드
	public void reInsertBoard(BoardBean bean) {
		getCon();
		// 초기값 지정
		int ref = bean.getRef();
		int re_step = bean.getRe_step();
		int re_level = bean.getRe_level();

		try {
			// 쿼리 작성
			// 이 sql에서 1만 더하면 되기때문에 가장큰값을 검색
			// 답변형 게시판의 특징인 글을 쓰면 먼저쓴글이 가장 위로 올라가야 하기 때문에 다른글들은 다 밑으로 내려야한다.
			String relevelsql = "update board set re_level=re_level+1 where ref=? and re_level >?";
			pstmt = con.prepareStatement(relevelsql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, re_level);

			// 쿼리 실행후 결과를 리턴
			pstmt.executeUpdate();

			// 데이터를 삽입하는 쿼리
			String sql = "insert into board values(board_seq.NEXTVAL,?,?,?,?,sysdate,?,?,?,0,?)";
			pstmt = con.prepareStatement(sql);
			// ?에 값을 매핑한다.
			pstmt.setString(1, bean.getWriter());
			pstmt.setString(2, bean.getEmail());
			pstmt.setString(3, bean.getSubject());
			pstmt.setString(4, bean.getPassword());
			pstmt.setInt(5, ref);
			pstmt.setInt(6, re_step + 1); // 기존 부모글에 스텝보다 1을 증가시켜야 한다.
			pstmt.setInt(7, re_level + 1); // 기존 부모글에 스텝보다 1을 증가시켜야 한다.
			pstmt.setString(8, bean.getContent());

			pstmt.executeUpdate();
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 조회수를 증가하지 않는 하나의 게시글을 리턴하는 메소드
	// 게시글 확인을 확인하는 메소드에서 조회수 증가 쿼리만 제외한다.
	public BoardBean getOneUpdateBoard(int num) {
		getCon();
		// 초기값이니까 null을 준다.
		BoardBean bean = null;
		try {

			// 한 게시글에 대한 정보를 리턴해주는 쿼리를 작성
			String sql = "select * from board where num=?";
			pstmt = con.prepareStatement(sql);
			// ?에 값을 집어넣기
			pstmt.setInt(1, num);
			// 쿼리실행후 결과를 리턴
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new BoardBean();
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString());
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));
				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));

			}

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;
	}

	// 하나의 게시글을 수정하는 메소드
	public void updateBoard(int num, String subject, String content) {

		// 데이터베이스 연결
		getCon();
		try {
			String sql = "update board set subject=?,content=? where num=?";
			pstmt = con.prepareStatement(sql);
			// ?에 값을 대입한다.
			pstmt.setString(1, subject);
			pstmt.setString(2, content);
			pstmt.setInt(3, num);

			// 4. 쿼리를 실행한다.
			pstmt.executeUpdate();
			// insert, delete, update 쿼리 구문은 executeUpdate를 사용한다.
			// 즉 DML(데이터조작어)를 사용할 때는 executeUpdate()를 사용한다.
			// 5. 자원 반납
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 하나의 게시글을 삭제하는 메소드
	public void deleteBoard(int num) {

		getCon();

		try {
			String sql = "delete from board where num=?";
			pstmt = con.prepareStatement(sql);
			// ?에 값을 넣어준다.
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}