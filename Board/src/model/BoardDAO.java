package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.naming.InitialContext;
import javax.sql.DataSource;
import javax.naming.Context;

public class BoardDAO {

	// 데이터베이스에 연결하기 위한 설정
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;

	// 데이터베이스의 커넥션들을 사용하도록 설정하는 메소드
	public void getCon() {

		try { // 데이터베이스에 접속할때는 예외처리를 해주어야한다.

			Context initctx = new InitialContext(); // 외부에서 데이터를 읽어들어야 하기 때문에 Context 객체 생성
			// 톰캣 서버에 정보를 담아놓은 곳으로 이동함
			Context envctx = (Context) initctx.lookup("java:comp/env"); // lookup메소드를 이용해서 자료를 읽어오는 코드
			DataSource ds = (DataSource) envctx.lookup("jdbc/pool"); // datasource 객체를 선언 , 오브젝트 타입이기 때문에 타입변환을 한다.

			con = ds.getConnection(); // 데이터 소스를 기준으로 커넥션을 연결함
		} catch (Exception e) {
			e.printStackTrace(); // 어느부분이 잘못되었는지 알려주는 예외처리
		}
	}

	// 하나의 새로운 게시글이 넘어와서 저장되는 메소드
	public void insertBoard(BoardBean bean) {
		getCon();
		// 빈클래스에 넘어오지 않았던 데이터들을 초기화 해주어야 한다.

		int ref = 0; // 글그룹을 의미한다, 쿼리를 실행시켜서 가장 큰 ref값을 가져온후 +1을 더해주면 된다.
		int re_step = 1; // 새글이고, 부모글은 글 스텝(Re_step), 글 레벨(Re_level)은 1이기 때문에 초기값을 1을 준다.
		int re_level = 1; // 새글이고, 부모글은 글 스텝(Re_step), 글 레벨(Re_level)은 1이기 때문에 초기값을 1을 준다.

		try {

			// 가장큰 ref값을 읽어오는 쿼리 준비함 (새로운 글은 ref가 가장크기 때문)
			String refsql = "select max(ref) from board"; // board테이블로부터 가장큰 ref를 검색
			// 쿼리를 실행할 객체
			pstmt = con.prepareStatement(refsql);
			// 쿼리 실행후 결과를 리턴
			rs = pstmt.executeQuery();
			if (rs.next()) { // 쿼리(rs)가 결과값이 있다면 실행하는 구문
				ref = rs.getInt(1) + 1; // 최대값에 1을 더해서 글그룹을 설정. 새로운글은 ref숫자가 하나씩 올라가야 하기 때문
			}

			// 실제로 게시글 전체값을 테이블에 저장
			String sql = "insert into board values(board_seq.NEXTVAL,?,?,?,?,sysdate,?,?,?,0,?)"; // 첫번째 값은 ?가 아니라 시퀀스를
																									// 사용해
																									// 시퀀스에 이미 들어가있는값의
																									// 다음값을 자동으로 매핑해서
																									// 넣어준다.
			pstmt = con.prepareStatement(sql);
			// ?에 값을 매핑한다. //0은 카운트값이기때문 0을 넣어주었다
			pstmt.setString(1, bean.getWriter());
			pstmt.setString(2, bean.getEmail());
			pstmt.setString(3, bean.getSubject());
			pstmt.setString(4, bean.getPassword());
			pstmt.setInt(5, ref);
			pstmt.setInt(6, re_step);
			pstmt.setInt(7, re_level);
			pstmt.setString(8, bean.getContent());

			// 쿼리를 실행하시오.
			pstmt.executeUpdate();
			// 자원 반납
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 모든 게시글을 리턴해주는 메소드 작성
	public Vector<BoardBean> getAllBoard(int start, int end) {
		// 리턴할 객체 선언
		Vector<BoardBean> v = new Vector<>();

		getCon();

		try {
			// 쿼리 준비 (컬럼에 Rownum Rnum을 추가하고, 괄호()안의 결과를 A에 넣는다.)
			String sql = "select * from (select A.*, Rownum Rnum from (select * from board order by ref desc, re_step asc)A)"
					+ "where Rnum >= ? and Rnum <= ?";
			// 쿼리를 실행할 객체 선언
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			// 쿼리 실행후 결과 저장
			rs = pstmt.executeQuery();
			// 데이터 개수가 몇개인지 모르기에 반복문을 이용하여 데이터를 추출
			while (rs.next()) {
				// 데이터를 패키징 시키기(가방 = Boardbean 클래스를 이용) 패키지 안에 넣는다는 의미
				BoardBean bean = new BoardBean();
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString()); // reg데이터가 String타입으로 변한다.
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

	// BoardInfo를 사용할 때 하나의 게시글을 리턴하는 메소드
	public BoardBean getOneBoard(int num) {
		// 리턴타입 선언(객체 생성)
		BoardBean bean = new BoardBean();
		getCon();
		try {

			// 조회수 증가 쿼리
			String readsql = "update board set readcount = readcount+1 where num=?"; // 읽은 게시글의 조회수를 늘리기 위한 sql문
			pstmt = con.prepareStatement(readsql);
			pstmt.setInt(1, num);
			pstmt.execute();

			// 쿼리 준비
			String sql = "select * from board where num=?";
			// 쿼리 실행 객체
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// 쿼리 실행후 결과를 리턴
			rs = pstmt.executeQuery();

			if (rs.next()) { // 게시글에대한 모든 정보를 하나씩 가져옴
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString()); // reg데이터가 String타입으로 변한다.
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

	// 답변글이 저장되는 메소드
	public void reWriteBoard(BoardBean bean) {// re_step와 re_level을 먼저 수정해야 한다.
												// 답변글은 부모글의 step와 level보다 1씩 증가하기 때문이다.
												// 부모글그룹과 글레벨 글스텝을 읽어들인다.
		int ref = bean.getRef();
		int re_step = bean.getRe_step();
		int re_level = bean.getRe_level();

		getCon();

		try {
			///////////////////// 핵심코드///////////////////////////
			// 부모글보다 큰 re_level의 값을 전부 1씩 증가시켜줌(같은 레벨에 있는 것들만)
			String levelsql = "update board set re_level=re_level+1 where ref=? and re_level > ?";
			// 코드해석 = board 테이블에 있는 re_level을 1씩 증가시켜라 (단, ref가 같고 re_level보다 작은것만)
			pstmt = con.prepareStatement(levelsql);
			// 쿼리 실행 객체 선언
			pstmt.setInt(1, ref);
			pstmt.setInt(2, re_level);
			// 쿼리 실행
			pstmt.executeUpdate();
			// 답변글 데이터를 저장
			String sql = "insert into board values(board_seq.NEXTVAL,?,?,?,?,sysdate,?,?,?,0,?)";
			// 첫번째 값은 ?가 아니라 시퀀스를 사용해
			// 시퀀스에 이미 들어가있는값의
			// 다음값을 자동으로 매핑해서
			// 넣어준다.

			pstmt = con.prepareStatement(sql);
			// ?에 값을 매핑한다
			pstmt.setString(1, bean.getWriter());
			pstmt.setString(2, bean.getEmail());
			pstmt.setString(3, bean.getSubject());
			pstmt.setString(4, bean.getPassword());
			pstmt.setInt(5, ref); // 부모의 ref값을 넣어줌
			pstmt.setInt(6, re_step + 1); // 답글이기 때문에 부모글 re_step에 1을 더해준다.
			pstmt.setInt(7, re_level + 1); // 답글이기 때문에 부모글 re_level에 1을 더해준다.
			pstmt.setString(8, bean.getContent());
			pstmt.executeUpdate(); //
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// boardupdate용 Delete시 하나의 게시글을 리턴

	public BoardBean getOneUpdateBoard(int num) {
		// 리턴타입 선언(객체 생성)
		BoardBean bean = new BoardBean();
		getCon();
		try {

			// 쿼리 준비
			String sql = "select * from board where num=?";
			// 쿼리 실행 객체
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// 쿼리 실행후 결과를 리턴
			rs = pstmt.executeQuery();

			if (rs.next()) { // 게시글에대한 모든 정보를 하나씩 가져옴
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString()); // reg데이터가 String타입으로 변한다.
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

	// update 와 delete 시 필요한 패스워드값을 리턴해주는 메소드
	public String getPass(int num) {// 리턴할 변수 객체 선언
		String pass = "";
		// DB연결
		getCon();

		try {

			// 쿼리 준비
			String sql = "select password from board where num=?";
			// 쿼리 실행할 객체 선언
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			// 패스워드 값을 저장
			if (rs.next()) {
				pass = rs.getString(1);
			}
			// 자원 반납
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return pass;

	}

	// 하나의 게시글을 수정하는 메소드
	public void updateBoard(BoardBean bean) {
		getCon();

		try {
			// 쿼리 준비
			String sql = "update board set subject=? , content=? where num=?";
			pstmt = con.prepareStatement(sql);

			// ?값을 대입
			pstmt.setString(1, bean.getSubject());
			pstmt.setString(2, bean.getContent());
			pstmt.setInt(3, bean.getNum());

			pstmt.executeUpdate();

			con.close();// 자원반납

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 하나의 게시글을 삭제 하는 메소드
	public void deleteBoard(int num) {
		getCon();
		try {
			// 쿼리 준비
			String sql = "delete from board where num=?";
			pstmt = con.prepareStatement(sql);

			// 쿼리 실행을 위한 인덱스와 값을 넣어주기
			pstmt.setInt(1, num);

			// 쿼리 실행
			pstmt.executeUpdate();

			// 자원 반납
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 전체 글의 갯수를 리턴하는 메소드
	public int getAllCount() {
		getCon();
		// 게시글 전체수를 저장하는 변수
		int count = 0;

		try {
			// 쿼리 준비
			String sql = "select count(*) from board";
			// 쿼리를 실행할 객체 선언
			pstmt = con.prepareStatement(sql);

			// 쿼리 실행후 결과를 리턴
			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1); // 전체 게시글의 수
			}

			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return count;

	}

}
