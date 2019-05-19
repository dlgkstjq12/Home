package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class RentcarDAO {

	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;

	// 커넥션풀을 이용한 데이터베이스 연결

	public void getcon() {

		// DB에 접속할때는 예외처리를 실시해야됨
		try {

			Context initctx = new InitialContext(); // 외부서버로 부터 데이터를 읽어들이는것이기 때문에 드라이버가 없을수 있어
			Context envctx = (Context) initctx.lookup("java:comp/env"); // 자바를 읽어들일수 있는 환경에서 사용 //예외처리를 해준다.
			DataSource ds = (DataSource) envctx.lookup("jdbc/pool");
			con = ds.getConnection();
			// 데이터소스에 username, url, password를 집어넣는다. 그렇게 하면 데이터소스가 커넥션을 얻어 온다.
			// jdbc/pool에 있는 데이터소스를 사용할수 있다.
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		}
	}

	// 최신순 3대의 자동차를 리턴하는 메소드
	public Vector<CarListBean> getSelectCar() {
		// 리턴타입을 설정
		Vector<CarListBean> v = new Vector<>();
		getcon(); // 커넥션이 연결되어야 쿼리를 실행 가능

		try {

			String sql = "select * from rentcar order by no desc ";
			pstmt = con.prepareStatement(sql);
			// 쿼리 실행후 실행결과 Result리턴함
			rs = pstmt.executeQuery();
			int count = 0;
			while (rs.next())// 결과값이 끝날때까지만 실행
			{
				CarListBean bean = new CarListBean();
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setCategory(rs.getInt(3));
				bean.setPrice(rs.getInt(4));
				bean.setUsepeople(rs.getInt(5));
				bean.setCompany(rs.getString(6));
				bean.setImg(rs.getString(7));
				bean.setInfo(rs.getString(8));
				// 벡터에 빈 클래스를 저장
				v.add(bean);
				count++;
				// 3개만 저장이 되야하기 때문..
				if (count > 3)
					break; // 반복문을 빠져나가시오.

			}
			con.close();
		} catch (Exception e) {// 내림차순으로 검색하는 쿼리문 작성
			e.printStackTrace();
		}
		return v;

	}

	// 카테고리별 자동차 리스트를 저장하는 메소드
	// 벡터로 받았으니 벡터로 리턴함..
	public Vector<CarListBean> getCategoryCar(int cate)

	{
		// 리턴타입이 벡터 객체이기 때문에 벡터 객체를 생성한다.
		Vector<CarListBean> v = new Vector<>();

		// 데이터를 저장할 빈 클래스 선언
		CarListBean bean = null;

		getcon();

		try {
			String sql = "select * from rentcar where category=?";
			pstmt = con.prepareStatement(sql);

			// ?에 값을 넣는다.
			pstmt.setInt(1, cate);
			// 결과를 리턴
			rs = pstmt.executeQuery();
			// 반복문을 돌려서 데이터를 저장

			while (rs.next()) { // 데이터를 저장할 빈 클래스 생성
				bean = new CarListBean();
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setCategory(rs.getInt(3));
				bean.setPrice(rs.getInt(4));
				bean.setUsepeople(rs.getInt(5));
				bean.setCompany(rs.getString(6));
				bean.setImg(rs.getString(7));
				bean.setInfo(rs.getString(8));
				// 벡터에 빈 클래스를 저장
				v.add(bean);

			}

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return v;

	}

	// 모든 차량을 검색하는 메소드
	public Vector<CarListBean> getAllCar() {

		Vector<CarListBean> v = new Vector<>();
		// 데이터를 저장할 빈클래스 선언
		CarListBean bean = null;

		getcon();

		try {
			String sql = "select * from rentcar";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			// 반복문을 돌리면서 데이터를 저장함

			while (rs.next()) {// 데이터를 저장할 빈클래스 생성
				bean = new CarListBean();
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setCategory(rs.getInt(3));
				bean.setPrice(rs.getInt(4));
				bean.setUsepeople(rs.getInt(5));
				bean.setCompany(rs.getString(6));
				bean.setImg(rs.getString(7));
				bean.setInfo(rs.getString(8));
				// 벡터에 빈 클래스를 저장
				v.add(bean);

			}

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return v;

	}

	// 하나의 자동차 정보를 리턴하는 메소드
	public CarListBean getOneCar(int no) {

		// 리턴타입을 선언한다. 객체를 생성해서 그 객체에 값을 넣은후 리턴해야하기 때문
		CarListBean bean = new CarListBean();

		getcon();

		try {
			String sql = "select * from rentcar where no=?";
			pstmt = con.prepareStatement(sql);
			// sql문에 ?표가 들어가 있으면 초기 인덱스 값을 할당해주어야 한다.
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setCategory(rs.getInt(3));
				bean.setPrice(rs.getInt(4));
				bean.setUsepeople(rs.getInt(5));
				bean.setCompany(rs.getString(6));
				bean.setImg(rs.getString(7));
				bean.setInfo(rs.getString(8));

			}

			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;

	}

	// 회원 정보가 있는지를 비교한다.
	public int getMember(String id, String pass) {
		int result = 0; // 0이면 회원이 없다고 가정
		getcon();

		try {
			String sql = "select count(*) from member where id=? and pass1=?";
			pstmt = con.prepareStatement(sql);
			// sql문에 ?표가 들어가 있으면 초기 인덱스 값을 할당해주어야 한다.

			pstmt.setString(1, id);
			pstmt.setString(2, pass);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt(1); // 0또는 1이 저장된다. 0이면 회원이 없는거고, 1이면 있는것
			}

			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;

	}

}
