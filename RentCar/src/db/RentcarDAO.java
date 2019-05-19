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

	// Ŀ�ؼ�Ǯ�� �̿��� �����ͺ��̽� ����

	public void getcon() {

		// DB�� �����Ҷ��� ����ó���� �ǽ��ؾߵ�
		try {

			Context initctx = new InitialContext(); // �ܺμ����� ���� �����͸� �о���̴°��̱� ������ ����̹��� ������ �־�
			Context envctx = (Context) initctx.lookup("java:comp/env"); // �ڹٸ� �о���ϼ� �ִ� ȯ�濡�� ��� //����ó���� ���ش�.
			DataSource ds = (DataSource) envctx.lookup("jdbc/pool");
			con = ds.getConnection();
			// �����ͼҽ��� username, url, password�� ����ִ´�. �׷��� �ϸ� �����ͼҽ��� Ŀ�ؼ��� ��� �´�.
			// jdbc/pool�� �ִ� �����ͼҽ��� ����Ҽ� �ִ�.
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		}
	}

	// �ֽż� 3���� �ڵ����� �����ϴ� �޼ҵ�
	public Vector<CarListBean> getSelectCar() {
		// ����Ÿ���� ����
		Vector<CarListBean> v = new Vector<>();
		getcon(); // Ŀ�ؼ��� ����Ǿ�� ������ ���� ����

		try {

			String sql = "select * from rentcar order by no desc ";
			pstmt = con.prepareStatement(sql);
			// ���� ������ ������ Result������
			rs = pstmt.executeQuery();
			int count = 0;
			while (rs.next())// ������� ������������ ����
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
				// ���Ϳ� �� Ŭ������ ����
				v.add(bean);
				count++;
				// 3���� ������ �Ǿ��ϱ� ����..
				if (count > 3)
					break; // �ݺ����� ���������ÿ�.

			}
			con.close();
		} catch (Exception e) {// ������������ �˻��ϴ� ������ �ۼ�
			e.printStackTrace();
		}
		return v;

	}

	// ī�װ��� �ڵ��� ����Ʈ�� �����ϴ� �޼ҵ�
	// ���ͷ� �޾����� ���ͷ� ������..
	public Vector<CarListBean> getCategoryCar(int cate)

	{
		// ����Ÿ���� ���� ��ü�̱� ������ ���� ��ü�� �����Ѵ�.
		Vector<CarListBean> v = new Vector<>();

		// �����͸� ������ �� Ŭ���� ����
		CarListBean bean = null;

		getcon();

		try {
			String sql = "select * from rentcar where category=?";
			pstmt = con.prepareStatement(sql);

			// ?�� ���� �ִ´�.
			pstmt.setInt(1, cate);
			// ����� ����
			rs = pstmt.executeQuery();
			// �ݺ����� ������ �����͸� ����

			while (rs.next()) { // �����͸� ������ �� Ŭ���� ����
				bean = new CarListBean();
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setCategory(rs.getInt(3));
				bean.setPrice(rs.getInt(4));
				bean.setUsepeople(rs.getInt(5));
				bean.setCompany(rs.getString(6));
				bean.setImg(rs.getString(7));
				bean.setInfo(rs.getString(8));
				// ���Ϳ� �� Ŭ������ ����
				v.add(bean);

			}

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return v;

	}

	// ��� ������ �˻��ϴ� �޼ҵ�
	public Vector<CarListBean> getAllCar() {

		Vector<CarListBean> v = new Vector<>();
		// �����͸� ������ ��Ŭ���� ����
		CarListBean bean = null;

		getcon();

		try {
			String sql = "select * from rentcar";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			// �ݺ����� �����鼭 �����͸� ������

			while (rs.next()) {// �����͸� ������ ��Ŭ���� ����
				bean = new CarListBean();
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setCategory(rs.getInt(3));
				bean.setPrice(rs.getInt(4));
				bean.setUsepeople(rs.getInt(5));
				bean.setCompany(rs.getString(6));
				bean.setImg(rs.getString(7));
				bean.setInfo(rs.getString(8));
				// ���Ϳ� �� Ŭ������ ����
				v.add(bean);

			}

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return v;

	}

	// �ϳ��� �ڵ��� ������ �����ϴ� �޼ҵ�
	public CarListBean getOneCar(int no) {

		// ����Ÿ���� �����Ѵ�. ��ü�� �����ؼ� �� ��ü�� ���� ������ �����ؾ��ϱ� ����
		CarListBean bean = new CarListBean();

		getcon();

		try {
			String sql = "select * from rentcar where no=?";
			pstmt = con.prepareStatement(sql);
			// sql���� ?ǥ�� �� ������ �ʱ� �ε��� ���� �Ҵ����־�� �Ѵ�.
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

	// ȸ�� ������ �ִ����� ���Ѵ�.
	public int getMember(String id, String pass) {
		int result = 0; // 0�̸� ȸ���� ���ٰ� ����
		getcon();

		try {
			String sql = "select count(*) from member where id=? and pass1=?";
			pstmt = con.prepareStatement(sql);
			// sql���� ?ǥ�� �� ������ �ʱ� �ε��� ���� �Ҵ����־�� �Ѵ�.

			pstmt.setString(1, id);
			pstmt.setString(2, pass);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt(1); // 0�Ǵ� 1�� ����ȴ�. 0�̸� ȸ���� ���°Ű�, 1�̸� �ִ°�
			}

			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;

	}

}
