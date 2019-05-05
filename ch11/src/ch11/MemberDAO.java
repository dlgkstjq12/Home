package ch11;
 
import java.sql.*; //SQL ��Ű������ �ݵ�� Ȯ��
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
//*�� ���� sql�� �ִ� ��Ű���� ��� �������� ������ ���� �Ƚᵵ �ȴ�.
 
//����Ŭ ������ ���̽��� �����ϰ� SELECT, INSERT, UPDATE, DELETE �۾��� �������ִ� Ŭ�����Դϴ�.
public class MemberDAO {
 
    // ���̵�,��й�ȣ ����ؼ� �����ϴ� �κ��� �ݺ������� ��� ����ϹǷ� �޼ҵ�� ����� ���� ����.
 
    // ����Ŭ�� �����ϴ� �ҽ��� �ۼ�
	/*
	 * String id = "system"; String pass = "123456"; String url =
	 * "jdbc:oracle:thin:@localhost:1521:XE"; // ���� URL
	 */ 
    Connection con; // �����ͺ��̽��� �����Ҽ� �ֵ��� ����
    PreparedStatement pstmt; // �����ͺ��̽����� ������ ��������ִ� ��ü
    ResultSet rs; // �����ͺ��̽��� ���̺��� ���(SELECT, INSERT, UPDATE, DELETE ��)
                    // �����ͺ��̽��� ���̺��� ����� ���Ϲ޾� �ڹٿ� �������ִ� ��ü
 
    // �����ͺ��̽��� ������ �� �ֵ��� �����ִ� �޼ҵ�
 
    public void getCon() {
    	
    	//Ŀ�ؼ� Ǯ�� �̿��Ͽ� ������ ���̽��� ����
    	try 
    	{
			//�ܺο��� �����͸� �о���� �Ѵ�.
    		Context initctx =  new InitialContext();
    		System.out.println("1111111");
    		//��Ĺ ������ ������ ��Ƴ��� ������ �̵�
    		Context envctx = (Context) initctx.lookup("java:comp/env"); //������Ʈ Ÿ���̱⶧���� ContextŸ������ Ÿ�Ժ�ȯ
    		System.out.println("2222222");
    		//������ �ҽ� ��ü�� ����
    		DataSource ds = (DataSource) envctx.lookup("jdbc/pool");//������Ʈ Ÿ���̱⶧���� ContextŸ������ Ÿ�Ժ�ȯ
    		System.out.println("333333");
    		//������ �ҽ��� �������� Ŀ�ؼ��� ����
    		con = ds.getConnection();
    		System.out.println("4444444");
		} 
    	catch (Exception e) 
    	{
			e.printStackTrace();
		}
  
    	
		/*
		 * try { // 1.�ش� �����ͺ��̽��� ����Ѵٰ� ���� (Ŭ������ ��� = ����Ŭ�� ���)
		 * Class.forName("oracle.jdbc.driver.OracleDriver"); // 2. �ش� ������ ���̽��� ���� con =
		 * DriverManager.getConnection(url, id, pass); // con �տ� Connection�� ���� �޼ҵ���
		 * ���������� ������ �Ǳ⶧���� ���� �ʴ´� } catch (Exception e) {
		 * 
		 * }
		 */
    }
 
    // �����ͺ��̽��� �ѻ���� ȸ�� ������ �������ִ� �޼ҵ�
    public void insertMember(MemberBean mbean) {
        try {
            getCon();
            // 3. ������ �����غ��Ͽ� ������ ����ϵ��� ����
            String sql = "insert into member values(?,?,?,?,?,?,?,?)"; // 8���� ���� ����.
            // ������ ����ϵ��� ����
            PreparedStatement pstmt = con.prepareStatement(sql); // jsp ���� ������ ����ϵ��� ����
            // ?�� �°� �����͸� ����
            pstmt.setString(1, mbean.getId()); // SQL�� insert to values�� ���� ����.
            pstmt.setString(2, mbean.getPass1());
            pstmt.setString(3, mbean.getEmail());
            pstmt.setString(4, mbean.getTel());
            pstmt.setString(5, mbean.getHobby());
            pstmt.setString(6, mbean.getJob());
            pstmt.setString(7, mbean.getAge());
            pstmt.setString(8, mbean.getInfo());
            // 4. ����Ŭ���� ������ ���� �Ͻÿ�.
            pstmt.executeUpdate(); // insert, update, delete �� ����ϴ� �޼ҵ�
 
            // 5. �ڿ� �ݳ�
            con.close();
 
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
 
    // ��� ȸ���� ������ �������ִ� �޼ҵ� ȣ��
    // �Ʊ� ���ͷ� �޾ұ� ������ ����Ÿ���� Vector<MemberBean>�� ����Ѵ�.
 
    // ȸ�������� ���� �� �ڷ�� beanŬ������ �ϴ� �����ϰ� �ٽ� ���Ϳ� ���� (�ݺ��Ѵ�)
    public Vector<MemberBean> allSelectMember() {
        // �������̷� �����͸� ����
        Vector<MemberBean> v = new Vector<>();
 
        // ������ ������ ���̽��� ����ó���� �ؾߵȴ�.
        // ������ ����ó���� �ؾߵɶ� (�����ͺ��̽�, ��Ʈ��ũ, ������, �����)
        try {
            // Ŀ�ؼ� ���� (getCon() �޼ҵ带 ȣ���ؼ� �����ͺ��̽��� ����)
            getCon();
            // ���� �غ�
            String sql = "select * from member";
            // ������ ��������ִ� ��ü ����
            pstmt = con.prepareStatement(sql);
            // ������ ���� ��Ų ����� �����ؼ�(����Ŭ ���̺��� �˻��� ����� �ڹٰ�ü�� ����)
            rs = pstmt.executeQuery(); // �����ͺ��̽��� ������ ������ �����Ͱ� rs�� ����ȴ�.
            // �ݺ����� ����ؼ� rs�� ����� �����͸� �����س��ƾ� �Ѵ�.
            while (rs.next()) // ����� �����͸�ŭ �ݺ��� �����Ѵٴ� ��
            {
                MemberBean bean = new MemberBean(); // �����ͺ��̽����� �����Ŭ������ �����͸� �޾ƾ� �ϱ� ������ ��ü ����
                bean.setId(rs.getString(1)); // �÷����� �������� �����͸� ��Ŭ������ ����, ��� �����͸� �־�� �ϱ⶧���� ���ο� ��ü�� ��� ��������
                bean.setPass1(rs.getString(2));
                bean.setEmail(rs.getString(3));
                bean.setTel(rs.getString(4));
                bean.setHobby(rs.getString(5));
                bean.setJob(rs.getString(6));
                bean.setAge(rs.getString(7));
                bean.setInfo(rs.getString(8));
                // ��Ű¡�� memberbean Ŭ������ ���Ϳ� ����
                v.add(bean); // ���Ϳ� 0�������� ������� �����Ͱ� ����
            }
            // �ڿ� �ݳ�
            con.close();
 
        } catch (Exception e) {
 
        }
 
        // �� ����� ���͸� ����
        return v;
    }
 
    
    //�ѻ���� ���� ������ �����ϴ� �޼ҵ� �ۼ�
    public MemberBean oneSelectMember(String id) 
    {
    	MemberBean bean = new MemberBean();
    	try 
    	
    	{
    		//Ŀ�ؼ� ����
    		getCon();
    		//���� �غ�
    		String sql = "select * from member where id=?";
    		pstmt = con.prepareStatement(sql);
    		//�ε����� ���� �����Ѵ�.
    		pstmt.setString(1, id);
    		//���� ����
    		rs = pstmt.executeQuery();
    		if(rs.next()) {
    			//���ڵ尡 �ִٸ�
    			bean.setId(rs.getString(1)); // �÷����� �������� �����͸� ��Ŭ������ ����, ��� �����͸� �־�� �ϱ⶧���� ���ο� ��ü�� ��� ��������
                bean.setPass1(rs.getString(2));
                bean.setEmail(rs.getString(3));
                bean.setTel(rs.getString(4));
                bean.setHobby(rs.getString(5));
                bean.setJob(rs.getString(6));
                bean.setAge(rs.getString(7));
                bean.setInfo(rs.getString(8));
    		}
    		con.close();
    		
    	}
    	catch (Exception e)
    	
    	{
    		e.printStackTrace();
    	}
    	//����
    	return bean;
    }
    
    //�� ȸ���� �н����� ���� �����ϴ� �޼ҵ� �ۼ�
    public String getPass(String id) //��Ʈ������ ������ �ؾ��ϱ⿡ ��Ʈ�� ���� ����
    {
    	String pass = ""; //�ʱⰪ�� ���������̱� ������ ���� ���� ����
    	try {
			getCon();
			//���� �غ�
			String sql = "select pass1 from member where id=?";
			pstmt = con.prepareStatement(sql);
    		//�ε����� ���� �����Ѵ�.
    		pstmt.setString(1, id);
    		//���� ����
    		rs = pstmt.executeQuery();
    		if(rs.next()) 
    		{
    			pass=rs.getString(1); //�н����� ���� ����� �÷��ε���
    		}
    		//�ڿ� �ݳ�
    		con.close();
    		
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	//����� ����
    	return pass;
    	
    }
    
    
    //��ȸ���� ������ �����ϴ� �޼ҵ�
    public void updateMember(MemberBean bean) 
    {
    	getCon();
    	try {
			//���� �غ�
    		String sql = "update member set email=?,tel=? where id=?"; //���̵�� �̸��ϰ� ��ȭ��ȣ�� �ĺ��Ѵ�.
    		//���� ���� ��ü ����
    		pstmt = con.prepareStatement(sql);
    		//?�� ���� ����
    		pstmt.setString(1, bean.getEmail());//���� �ش��ϴ� ������ ��Ŭ�������� �޾ƿ´�.
    		pstmt.setString(2, bean.getTel());
    		pstmt.setString(3, bean.getId());
    		
    		pstmt.executeUpdate(); //result�� ���� �޴°��� �ƴϱ� ������ execute()�� ���Ұ�.
    		
    		con.close();//�ڿ��ݳ�
    		
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    }
   
    //�� ȸ���� �����ϴ� �޼ҵ� �ۼ�
    public void deleteMember(String id) 
    {
    	getCon();
    	try {
			//���� �غ�
    		String sql = "delete from member where id=?";
    		//���� ���� ��ü ����
    		pstmt = con.prepareStatement(sql);
    		//?�� ���� ����
    		pstmt.setString(1, id);//���� �ش��ϴ� ������ ��Ŭ�������� �޾ƿ´�.
    	
    		
    		pstmt.executeUpdate(); //result�� ���� �޴°��� �ƴϱ� ������ execute()�� ���Ұ�.
    		
    		con.close();//�ڿ��ݳ�
    		
    		
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    }
    
    
}
