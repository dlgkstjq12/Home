package ch11;
 
import java.sql.*; //SQL 패키지인지 반드시 확인
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
//*을 쓰면 sql에 있는 패키지를 모두 가져오기 때문에 따로 안써도 된다.
 
//오라클 데이터 베이스에 연결하고 SELECT, INSERT, UPDATE, DELETE 작업을 실행해주는 클래스입니다.
public class MemberDAO {
 
    // 아이디,비밀번호 사용해서 연결하는 부분은 반복적으로 계속 사용하므로 메소드로 만드는 것이 좋다.
 
    // 오라클에 접속하는 소스를 작성
	/*
	 * String id = "system"; String pass = "123456"; String url =
	 * "jdbc:oracle:thin:@localhost:1521:XE"; // 접속 URL
	 */ 
    Connection con; // 데이터베이스에 접근할수 있도록 설정
    PreparedStatement pstmt; // 데이터베이스에서 쿼리를 실행시켜주는 객체
    ResultSet rs; // 데이터베이스의 테이블의 결과(SELECT, INSERT, UPDATE, DELETE 등)
                    // 데이터베이스의 테이블의 결과를 리턴받아 자바에 저장해주는 객체
 
    // 데이터베이스에 접근할 수 있도록 도와주는 메소드
 
    public void getCon() {
    	
    	//커넥션 풀을 이용하여 데이터 베이스에 접근
    	try 
    	{
			//외부에서 데이터를 읽어들어야 한다.
    		Context initctx =  new InitialContext();
    		System.out.println("1111111");
    		//톰캣 서버에 정보를 담아놓은 곳으로 이동
    		Context envctx = (Context) initctx.lookup("java:comp/env"); //오브젝트 타입이기때문에 Context타입으로 타입변환
    		System.out.println("2222222");
    		//데이터 소스 객체를 선언
    		DataSource ds = (DataSource) envctx.lookup("jdbc/pool");//오브젝트 타입이기때문에 Context타입으로 타입변환
    		System.out.println("333333");
    		//데이터 소스를 기준으로 커넥션을 연결
    		con = ds.getConnection();
    		System.out.println("4444444");
		} 
    	catch (Exception e) 
    	{
			e.printStackTrace();
		}
  
    	
		/*
		 * try { // 1.해당 데이터베이스를 사용한다고 선언 (클래스를 등록 = 오라클을 사용)
		 * Class.forName("oracle.jdbc.driver.OracleDriver"); // 2. 해당 데이터 베이스에 접속 con =
		 * DriverManager.getConnection(url, id, pass); // con 앞에 Connection을 쓰면 메소드의
		 * 지역변수에 저장이 되기때문에 쓰지 않는다 } catch (Exception e) {
		 * 
		 * }
		 */
    }
 
    // 데이터베이스에 한사람의 회원 정보를 저장해주는 메소드
    public void insertMember(MemberBean mbean) {
        try {
            getCon();
            // 3. 접속후 쿼리준비하여 쿼리를 사용하도록 설정
            String sql = "insert into member values(?,?,?,?,?,?,?,?)"; // 8개의 값이 들어간다.
            // 쿼리를 사용하도록 설정
            PreparedStatement pstmt = con.prepareStatement(sql); // jsp 에서 쿼리를 사용하도록 설정
            // ?에 맞게 데이터를 맵핑
            pstmt.setString(1, mbean.getId()); // SQL의 insert to values에 넣을 값들.
            pstmt.setString(2, mbean.getPass1());
            pstmt.setString(3, mbean.getEmail());
            pstmt.setString(4, mbean.getTel());
            pstmt.setString(5, mbean.getHobby());
            pstmt.setString(6, mbean.getJob());
            pstmt.setString(7, mbean.getAge());
            pstmt.setString(8, mbean.getInfo());
            // 4. 오라클에서 쿼리를 실행 하시오.
            pstmt.executeUpdate(); // insert, update, delete 시 사용하는 메소드
 
            // 5. 자원 반납
            con.close();
 
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
 
    // 모든 회원의 정보를 리턴해주는 메소드 호출
    // 아까 벡터로 받았기 때문에 리턴타입을 Vector<MemberBean>로 사용한다.
 
    // 회원가입을 했을 때 자료는 bean클래스에 일단 저장하고 다시 벡터에 저장 (반복한다)
    public Vector<MemberBean> allSelectMember() {
        // 가변길이로 데이터를 저장
        Vector<MemberBean> v = new Vector<>();
 
        // 무조건 데이터 베이스는 예외처리를 해야된다.
        // 무조건 예외처리를 해야될때 (데이터베이스, 네트워크, 스레드, 입출력)
        try {
            // 커넥션 연결 (getCon() 메소드를 호출해서 데이터베이스와 연결)
            getCon();
            // 쿼리 준비
            String sql = "select * from member";
            // 쿼리를 실행시켜주는 객체 선언
            pstmt = con.prepareStatement(sql);
            // 쿼리를 실행 시킨 결과를 리턴해서(오라클 테이블의 검색된 결과를 자바객체에 저장)
            rs = pstmt.executeQuery(); // 데이터베이스의 쿼리를 실행한 데이터가 rs에 저장된다.
            // 반복문을 사용해서 rs에 저장된 데이터를 추출해놓아야 한다.
            while (rs.next()) // 저장된 데이터만큼 반복문 실행한다는 뜻
            {
                MemberBean bean = new MemberBean(); // 데이터베이스에서 멤버빈클래스로 데이터를 받아야 하기 때문에 객체 생성
                bean.setId(rs.getString(1)); // 컬럼으로 나뉘어진 데이터를 빈클래스에 저장, 계속 데이터를 넣어야 하기때문에 새로운 객체를 계속 만들어야함
                bean.setPass1(rs.getString(2));
                bean.setEmail(rs.getString(3));
                bean.setTel(rs.getString(4));
                bean.setHobby(rs.getString(5));
                bean.setJob(rs.getString(6));
                bean.setAge(rs.getString(7));
                bean.setInfo(rs.getString(8));
                // 패키징된 memberbean 클래스를 벡터에 저장
                v.add(bean); // 벡터에 0번지부터 순서대로 데이터가 저장
            }
            // 자원 반납
            con.close();
 
        } catch (Exception e) {
 
        }
 
        // 다 저장된 벡터를 리턴
        return v;
    }
 
    
    //한사람의 대한 정보를 리턴하는 메소드 작성
    public MemberBean oneSelectMember(String id) 
    {
    	MemberBean bean = new MemberBean();
    	try 
    	
    	{
    		//커넥션 연결
    		getCon();
    		//쿼리 준비
    		String sql = "select * from member where id=?";
    		pstmt = con.prepareStatement(sql);
    		//인덱스와 값을 매핑한다.
    		pstmt.setString(1, id);
    		//쿼리 실행
    		rs = pstmt.executeQuery();
    		if(rs.next()) {
    			//레코드가 있다면
    			bean.setId(rs.getString(1)); // 컬럼으로 나뉘어진 데이터를 빈클래스에 저장, 계속 데이터를 넣어야 하기때문에 새로운 객체를 계속 만들어야함
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
    	//리턴
    	return bean;
    }
    
    //한 회원의 패스워드 값을 리턴하는 메소드 작성
    public String getPass(String id) //스트링으로 리턴을 해야하기에 스트링 변수 선언
    {
    	String pass = ""; //초기값은 지역변수이기 때문에 값이 없이 시작
    	try {
			getCon();
			//쿼리 준비
			String sql = "select pass1 from member where id=?";
			pstmt = con.prepareStatement(sql);
    		//인덱스와 값을 매핑한다.
    		pstmt.setString(1, id);
    		//쿼리 실행
    		rs = pstmt.executeQuery();
    		if(rs.next()) 
    		{
    			pass=rs.getString(1); //패스워드 값이 저장된 컬럼인덱스
    		}
    		//자원 반납
    		con.close();
    		
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	//결과를 리턴
    	return pass;
    	
    }
    
    
    //한회원의 정보를 수정하는 메소드
    public void updateMember(MemberBean bean) 
    {
    	getCon();
    	try {
			//쿼리 준비
    		String sql = "update member set email=?,tel=? where id=?"; //아이디로 이메일과 전화번호를 식별한다.
    		//쿼리 실행 객체 선언
    		pstmt = con.prepareStatement(sql);
    		//?에 값을 연결
    		pstmt.setString(1, bean.getEmail());//각각 해당하는 값들을 빈클래스에서 받아온다.
    		pstmt.setString(2, bean.getTel());
    		pstmt.setString(3, bean.getId());
    		
    		pstmt.executeUpdate(); //result로 부터 받는값이 아니기 때문에 execute()는 사용불가.
    		
    		con.close();//자원반납
    		
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    }
   
    //한 회원을 삭제하는 메소드 작성
    public void deleteMember(String id) 
    {
    	getCon();
    	try {
			//쿼리 준비
    		String sql = "delete from member where id=?";
    		//쿼리 실행 객체 선언
    		pstmt = con.prepareStatement(sql);
    		//?에 값을 연결
    		pstmt.setString(1, id);//각각 해당하는 값들을 빈클래스에서 받아온다.
    	
    		
    		pstmt.executeUpdate(); //result로 부터 받는값이 아니기 때문에 execute()는 사용불가.
    		
    		con.close();//자원반납
    		
    		
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    }
    
    
}
