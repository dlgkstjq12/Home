package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.naming.InitialContext;
import javax.sql.DataSource;
import javax.naming.Context;

public class BoardDAO {

	// �����ͺ��̽��� �����ϱ� ���� ����
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;

	// �����ͺ��̽��� Ŀ�ؼǵ��� ����ϵ��� �����ϴ� �޼ҵ�
	public void getCon() {

		try { // �����ͺ��̽��� �����Ҷ��� ����ó���� ���־���Ѵ�.

			Context initctx = new InitialContext(); // �ܺο��� �����͸� �о���� �ϱ� ������ Context ��ü ����
			// ��Ĺ ������ ������ ��Ƴ��� ������ �̵���
			Context envctx = (Context) initctx.lookup("java:comp/env"); // lookup�޼ҵ带 �̿��ؼ� �ڷḦ �о���� �ڵ�
			DataSource ds = (DataSource) envctx.lookup("jdbc/pool"); // datasource ��ü�� ���� , ������Ʈ Ÿ���̱� ������ Ÿ�Ժ�ȯ�� �Ѵ�.

			con = ds.getConnection(); // ������ �ҽ��� �������� Ŀ�ؼ��� ������
		} catch (Exception e) {
			e.printStackTrace(); // ����κ��� �߸��Ǿ����� �˷��ִ� ����ó��
		}
	}

	// �ϳ��� ���ο� �Խñ��� �Ѿ�ͼ� ����Ǵ� �޼ҵ�
	public void insertBoard(BoardBean bean) {
		getCon();
		// ��Ŭ������ �Ѿ���� �ʾҴ� �����͵��� �ʱ�ȭ ���־�� �Ѵ�.

		int ref = 0; // �۱׷��� �ǹ��Ѵ�, ������ ������Ѽ� ���� ū ref���� �������� +1�� �����ָ� �ȴ�.
		int re_step = 1; // �����̰�, �θ���� �� ����(Re_step), �� ����(Re_level)�� 1�̱� ������ �ʱⰪ�� 1�� �ش�.
		int re_level = 1; // �����̰�, �θ���� �� ����(Re_step), �� ����(Re_level)�� 1�̱� ������ �ʱⰪ�� 1�� �ش�.

		try {

			// ����ū ref���� �о���� ���� �غ��� (���ο� ���� ref�� ����ũ�� ����)
			String refsql = "select max(ref) from board"; // board���̺�κ��� ����ū ref�� �˻�
			// ������ ������ ��ü
			pstmt = con.prepareStatement(refsql);
			// ���� ������ ����� ����
			rs = pstmt.executeQuery();
			if (rs.next()) { // ����(rs)�� ������� �ִٸ� �����ϴ� ����
				ref = rs.getInt(1) + 1; // �ִ밪�� 1�� ���ؼ� �۱׷��� ����. ���ο���� ref���ڰ� �ϳ��� �ö󰡾� �ϱ� ����
			}

			// ������ �Խñ� ��ü���� ���̺� ����
			String sql = "insert into board values(board_seq.NEXTVAL,?,?,?,?,sysdate,?,?,?,0,?)"; // ù��° ���� ?�� �ƴ϶� ��������
																									// �����
																									// �������� �̹� ���ִ°���
																									// �������� �ڵ����� �����ؼ�
																									// �־��ش�.
			pstmt = con.prepareStatement(sql);
			// ?�� ���� �����Ѵ�. //0�� ī��Ʈ���̱⶧�� 0�� �־��־���
			pstmt.setString(1, bean.getWriter());
			pstmt.setString(2, bean.getEmail());
			pstmt.setString(3, bean.getSubject());
			pstmt.setString(4, bean.getPassword());
			pstmt.setInt(5, ref);
			pstmt.setInt(6, re_step);
			pstmt.setInt(7, re_level);
			pstmt.setString(8, bean.getContent());

			// ������ �����Ͻÿ�.
			pstmt.executeUpdate();
			// �ڿ� �ݳ�
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// ��� �Խñ��� �������ִ� �޼ҵ� �ۼ�
	public Vector<BoardBean> getAllBoard(int start, int end) {
		// ������ ��ü ����
		Vector<BoardBean> v = new Vector<>();

		getCon();

		try {
			// ���� �غ� (�÷��� Rownum Rnum�� �߰��ϰ�, ��ȣ()���� ����� A�� �ִ´�.)
			String sql = "select * from (select A.*, Rownum Rnum from (select * from board order by ref desc, re_step asc)A)"
					+ "where Rnum >= ? and Rnum <= ?";
			// ������ ������ ��ü ����
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			// ���� ������ ��� ����
			rs = pstmt.executeQuery();
			// ������ ������ ����� �𸣱⿡ �ݺ����� �̿��Ͽ� �����͸� ����
			while (rs.next()) {
				// �����͸� ��Ű¡ ��Ű��(���� = Boardbean Ŭ������ �̿�) ��Ű�� �ȿ� �ִ´ٴ� �ǹ�
				BoardBean bean = new BoardBean();
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString()); // reg�����Ͱ� StringŸ������ ���Ѵ�.
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));

				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));
				// ��Ű¡�� �����͸� ���Ϳ� ����
				v.add(bean);
			}

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return v;
	}

	// BoardInfo�� ����� �� �ϳ��� �Խñ��� �����ϴ� �޼ҵ�
	public BoardBean getOneBoard(int num) {
		// ����Ÿ�� ����(��ü ����)
		BoardBean bean = new BoardBean();
		getCon();
		try {

			// ��ȸ�� ���� ����
			String readsql = "update board set readcount = readcount+1 where num=?"; // ���� �Խñ��� ��ȸ���� �ø��� ���� sql��
			pstmt = con.prepareStatement(readsql);
			pstmt.setInt(1, num);
			pstmt.execute();

			// ���� �غ�
			String sql = "select * from board where num=?";
			// ���� ���� ��ü
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// ���� ������ ����� ����
			rs = pstmt.executeQuery();

			if (rs.next()) { // �Խñۿ����� ��� ������ �ϳ��� ������
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString()); // reg�����Ͱ� StringŸ������ ���Ѵ�.
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

	// �亯���� ����Ǵ� �޼ҵ�
	public void reWriteBoard(BoardBean bean) {// re_step�� re_level�� ���� �����ؾ� �Ѵ�.
												// �亯���� �θ���� step�� level���� 1�� �����ϱ� �����̴�.
												// �θ�۱׷�� �۷��� �۽����� �о���δ�.
		int ref = bean.getRef();
		int re_step = bean.getRe_step();
		int re_level = bean.getRe_level();

		getCon();

		try {
			///////////////////// �ٽ��ڵ�///////////////////////////
			// �θ�ۺ��� ū re_level�� ���� ���� 1�� ����������(���� ������ �ִ� �͵鸸)
			String levelsql = "update board set re_level=re_level+1 where ref=? and re_level > ?";
			// �ڵ��ؼ� = board ���̺� �ִ� re_level�� 1�� �������Ѷ� (��, ref�� ���� re_level���� �����͸�)
			pstmt = con.prepareStatement(levelsql);
			// ���� ���� ��ü ����
			pstmt.setInt(1, ref);
			pstmt.setInt(2, re_level);
			// ���� ����
			pstmt.executeUpdate();
			// �亯�� �����͸� ����
			String sql = "insert into board values(board_seq.NEXTVAL,?,?,?,?,sysdate,?,?,?,0,?)";
			// ù��° ���� ?�� �ƴ϶� �������� �����
			// �������� �̹� ���ִ°���
			// �������� �ڵ����� �����ؼ�
			// �־��ش�.

			pstmt = con.prepareStatement(sql);
			// ?�� ���� �����Ѵ�
			pstmt.setString(1, bean.getWriter());
			pstmt.setString(2, bean.getEmail());
			pstmt.setString(3, bean.getSubject());
			pstmt.setString(4, bean.getPassword());
			pstmt.setInt(5, ref); // �θ��� ref���� �־���
			pstmt.setInt(6, re_step + 1); // ����̱� ������ �θ�� re_step�� 1�� �����ش�.
			pstmt.setInt(7, re_level + 1); // ����̱� ������ �θ�� re_level�� 1�� �����ش�.
			pstmt.setString(8, bean.getContent());
			pstmt.executeUpdate(); //
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// boardupdate�� Delete�� �ϳ��� �Խñ��� ����

	public BoardBean getOneUpdateBoard(int num) {
		// ����Ÿ�� ����(��ü ����)
		BoardBean bean = new BoardBean();
		getCon();
		try {

			// ���� �غ�
			String sql = "select * from board where num=?";
			// ���� ���� ��ü
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// ���� ������ ����� ����
			rs = pstmt.executeQuery();

			if (rs.next()) { // �Խñۿ����� ��� ������ �ϳ��� ������
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString()); // reg�����Ͱ� StringŸ������ ���Ѵ�.
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

	// update �� delete �� �ʿ��� �н����尪�� �������ִ� �޼ҵ�
	public String getPass(int num) {// ������ ���� ��ü ����
		String pass = "";
		// DB����
		getCon();

		try {

			// ���� �غ�
			String sql = "select password from board where num=?";
			// ���� ������ ��ü ����
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			// �н����� ���� ����
			if (rs.next()) {
				pass = rs.getString(1);
			}
			// �ڿ� �ݳ�
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return pass;

	}

	// �ϳ��� �Խñ��� �����ϴ� �޼ҵ�
	public void updateBoard(BoardBean bean) {
		getCon();

		try {
			// ���� �غ�
			String sql = "update board set subject=? , content=? where num=?";
			pstmt = con.prepareStatement(sql);

			// ?���� ����
			pstmt.setString(1, bean.getSubject());
			pstmt.setString(2, bean.getContent());
			pstmt.setInt(3, bean.getNum());

			pstmt.executeUpdate();

			con.close();// �ڿ��ݳ�

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// �ϳ��� �Խñ��� ���� �ϴ� �޼ҵ�
	public void deleteBoard(int num) {
		getCon();
		try {
			// ���� �غ�
			String sql = "delete from board where num=?";
			pstmt = con.prepareStatement(sql);

			// ���� ������ ���� �ε����� ���� �־��ֱ�
			pstmt.setInt(1, num);

			// ���� ����
			pstmt.executeUpdate();

			// �ڿ� �ݳ�
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// ��ü ���� ������ �����ϴ� �޼ҵ�
	public int getAllCount() {
		getCon();
		// �Խñ� ��ü���� �����ϴ� ����
		int count = 0;

		try {
			// ���� �غ�
			String sql = "select count(*) from board";
			// ������ ������ ��ü ����
			pstmt = con.prepareStatement(sql);

			// ���� ������ ����� ����
			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1); // ��ü �Խñ��� ��
			}

			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return count;

	}

}
