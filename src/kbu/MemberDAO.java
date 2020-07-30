package kbu;

import java.sql.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.Session;
import java.util.Properties;
import java.net.InetAddress;

public class MemberDAO { //DB연결
    private DBConnectionMgr pool = null;
    private static MemberDAO instance;


    public static MemberDAO getInstance() {
        if (instance == null)
            instance = new MemberDAO();
        return instance;
    }

    public MemberDAO() {
        try {
            pool = DBConnectionMgr.getInstance();
            InetAddress ip = InetAddress.getLocalHost();
            System.out.println("DB연결 성공");
            System.out.println("연결된 ip 주소: " + ip.getHostAddress());

        } catch (Exception e) {
            System.out.println("오류: " + e);
        }
    }


    public boolean checkId(String id) throws Exception { //ID 중복확인 메서드

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        boolean flag = false;
        try {
            con = pool.getConnection();  //커넥션연결
            pstmt = con.prepareStatement("select id from member where id = ?"); //DB에서 id찾기를 실행하는 sql문 실행
            pstmt.setString(1, id);
            flag = pstmt.executeQuery().next();

        } catch (Exception e) {
            System.out.println("ID확인오류: " + e);
        } finally {
            if (rs != null) try {
                rs.close();
            } catch (SQLException ex) {
            }
            if (pstmt != null) try {
                pstmt.close();
            } catch (SQLException ex) {
            }
            if (con != null) try {
                con.close();
            } catch (SQLException ex) {
            }
        }
        return flag;

    }

    public int checklogin(String id, String pwd) { //로그인 메서드

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int flage = -1;
        String dbpwd = ""; //DB에 저장된 비밀번호 저장
        try {
            // 쿼리 - 먼저 입력된 아이디로 DB에서 비밀번호를 조회한다.
            StringBuffer query = new StringBuffer();
            query.append(" SELECT pwd FROM member WHERE id=?");

            con = pool.getConnection(); //커넥션 연결
            pstmt = con.prepareStatement(query.toString());
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) // 입력된 아이디에 해당하는 비번 있을경우
            {
                dbpwd = rs.getString("pwd"); // 비번을 변수에 넣는다.

                if (dbpwd.equals(pwd))
                    flage = 1; // 넘겨받은 비번과 꺼내온 배번 비교. 같으면 인증성공
                else
                    flage = 2; // DB의 비밀번호와 입력받은 비밀번호 다름, 인증실패

            } else {
                flage = 3; // 아이디가 없을 경우
            }

            return flage;

        } catch (Exception e1) {
            throw new RuntimeException(e1.getMessage());
        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                    pstmt = null;
                }
                if (con != null) {
                    con.close();
                    con = null;
                }
            } catch (Exception e) {
                System.out.println("에러(lognin2): " + e);
                throw new RuntimeException(e.getMessage());
            }
        }
    }

    public String search_id(String std_id, String email) throws Exception { //id찾기 메서드
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = pool.getConnection(); //커넥션 연결
            pstmt = con.prepareStatement("select id from member where std_id = ? and email = ?");
            pstmt.setString(1, std_id);
            pstmt.setString(2, email);
            rs = pstmt.executeQuery(); //객체에 결과값을 담을때 사용한다.
            if (rs.next())
                return (rs.getString("id"));
            else
                return null;
        } finally {
            if (rs != null) try {
                rs.close();
            } catch (SQLException ex) {
                System.out.println("에러(id찾기): " + ex);
            }
            if (pstmt != null) try {
                pstmt.close();
            } catch (SQLException ex) {
                System.out.println("에러(id찾기2): " + ex);
            }
        }
    }

    public String se_id(String std_id, String id) throws Exception { //ID찾기 메서드 2
        Connection con = null;
        try {
            con = pool.getConnection(); //커넥션 연결

            String id2 = search_id(std_id, id); //ID찾기 메서드1 의 데이터를 가져옴
            return (id2);
        } finally {
            if (con != null) try {
                con.close();
            } catch (SQLException e) {
                System.out.println("i에러: " + e);
            }
        }
    }

    public Student search_student(String std_id) throws Exception { // 학생 정보 찾기 메서드
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Student student = new Student();

        try {
            con = pool.getConnection(); //커넥션 연결
            pstmt = con.prepareStatement("select * from student where std_id = " + std_id); //DB에서 학번을 입력 받으면 나머지의 학생정보를 저장한다.
            rs = pstmt.executeQuery(); //객체에 결과값을 담을때 사용한다.

            while (rs.next()) {
                student.setName(rs.getString("name1"));
                student.setGrade(rs.getString("grade"));
                student.setDepartment(rs.getString("department"));
            }

            return student;

        } finally {
            if (rs != null) try {
                rs.close();
            } catch (SQLException ex) {
                System.out.println("에러(학생정보찾기): " + ex);
            }
            if (pstmt != null) try {
                pstmt.close();
            } catch (SQLException ex) {
                System.out.println("에러(학생정보찾기2): " + ex);
            }
        }
    }

    public static class Email { //이메일 인증 메소드
        public String connectEmail(String email) {

            String to1 = email; // 인증위해 사용자가 입력한 이메일주소
            String host = "smtp.gmail.com"; // smtp 서버
            String subject = "KBUBOOK 회원가입 인증번호"; // 보내는 제목 설정
            String fromName = "KBUBOOK JOIN TEAM"; // 보내는 이름 설정
            String from = "korlgg2@gmail.com"; // 보내는 사람(구글계정)
            String CODE = Email.code(); // 인증번호 위한 난수 발생부분
            String content = "인증번호는 [" + CODE + "] 입니다. <br> 인증번호를 정확히 입력해주십시오."; // 이메일 내용 설정


            // SMTP 이용하기 위해 설정해주는 설정값들
            try { //건들지 말것!
                Properties props = new Properties();
                props.put("mail.smtp.starttls.enable", "true");
                props.put("mail.transport.protocol", "smtp");
                props.put("mail.smtp.host", host);
                props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
                props.put("mail.smtp.port", "465");
                props.put("mail.smtp.user", from);
                props.put("mail.smtp.auth", "true");

                Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication
                                ("korlgg2@gmail.com", "kbubook!004"); // gmail계정
                    }
                });

                Message msg = new MimeMessage(mailSession);
                InternetAddress[] address1 = {new InternetAddress(to1)}; //이메일 전송
                msg.setFrom(new InternetAddress(from, MimeUtility.encodeText(fromName, "UTF-8", "B")));
                msg.setRecipients(Message.RecipientType.TO, address1); // 받는사람 설정
                msg.setSubject(subject); // 제목설정
                msg.setSentDate(new java.util.Date()); // 보내는 날짜 설정
                msg.setContent(content, "text/html; charset=utf-8"); // 내용설정 및 인코딩
                Transport.send(msg); // 메일보내기
                System.out.println("이메일 보내기 성공");

            } catch (MessagingException e) {
                e.printStackTrace();
                System.out.println("이메일 보내기 오류: " + e);
            } catch (Exception e) {
                System.out.println("이메일 보내기 오류2 " + e);
                e.printStackTrace();
            }
            return CODE;

        }

        public static String code() {   // 인증번호 난수 발생 메소드
            StringBuffer buffer = new StringBuffer();
            for (int i = 0; i <= 5; i++) {
                int num = (int) (Math.random() * 10);
                buffer.append(num);
            }
            return buffer.toString();
        }

    }

    public Member getmember(String id) throws Exception { //회원정보 수정을 위하여 정보를 가져오는 메서드
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Member member = null;
        try {
            con = pool.getConnection(); //커넥션 연결
            pstmt = con.prepareStatement("select * from member where id = ?"); //DB에서 id를 검색하여 회원정보를 불러오는 sql문
            pstmt.setString(1, id);
            rs = pstmt.executeQuery(); //객체에 결과값을 담을때 사용한다.
            if (rs.next()) {
                member = new Member();
                member.setStd_id(rs.getString("std_id"));
                member.setId(rs.getString("id"));
                member.setPwd(rs.getString("pwd"));
                member.setEmail(rs.getString("email"));
                member.setTel(rs.getString("tel"));
                member.setJoin_date(rs.getDate("join_date"));
            }
        } catch (Exception e) {
            System.out.println("회원정보 가져옴 오류: " + e);
        } finally {
            if (rs != null) try {
                rs.close();
            } catch (SQLException ex) {
            }
            if (pstmt != null) try {
                pstmt.close();
            } catch (SQLException ex) {
            }
            if (con != null) try {
                con.close();
            } catch (SQLException ex) {
            }
        }
        return member;
    }

    public boolean update_member(Member member) throws Exception { //회원정보 변경 메소드
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean up = false;
        try {
            con = pool.getConnection(); //커넥션 연결
            pstmt = con.prepareStatement("update member set pwd = ?, tel = ? where id =?"); //DB에서 변경할 회원정보
            pstmt.setString(1, member.getPwd());
            pstmt.setString(2, member.getTel());
            pstmt.setString(3, member.getId());
            pstmt.executeUpdate();
            System.out.println("회원 정보 변경 성공");
        } catch (Exception e) {
            System.out.println("회원 정보 변경 오류: " + e);
        } finally {
            if (pstmt != null) try {
                pstmt.close();
            } catch (SQLException ex) {
            }
            if (con != null) try {
                con.close();
            } catch (SQLException ex) {
            }
        }
        return up;
    }

    public boolean delete_member(String id) throws Exception { //회원탈퇴 메소드
        Connection con = null;
        PreparedStatement pstmt = null;

        boolean del = false;
        try {
            con = pool.getConnection(); //커넥션 연결
            pstmt = con.prepareStatement("delete from member where id =?");
            pstmt.setString(1, id);
            int c = pstmt.executeUpdate();
            del = true;
            System.out.println("회원탈퇴 성공");
        } catch (Exception e) {
            System.out.println("회원탈퇴 실패: " + e);
        } finally {
            if (pstmt != null) try {
                pstmt.close();
            } catch (SQLException ex) {
            }
            if (con != null) try {
                con.close();
            } catch (SQLException ex) {
            }
        }
        return del;
    }


    public String temp_pwd(String email) throws Exception { //임시 비밀번호 메일 전송 메소드

        String to1 = email; // 인증위해 사용자가 입력한 이메일주소
        String host = "smtp.gmail.com"; // smtp 서버
        String subject = "KBUBOOK 비밀번호 찾기"; // 보내는 제목 설정
        String fromName = "KBUBOOK JOIN TEAM"; // 보내는 이름 설정
        String from = "korlgg2@gmail.com"; // 보내는 사람(구글계정)
        String CODE = temp(); // 인증번호 위한 난수 발생부분
        String content = "임시 비밀번호는 [ " + CODE + " ] 입니다. <br> 로그인후 비밀번호를 변경해주십시오."; // 이메일 내용 설정


        // SMTP 이용하기 위해 설정해주는 설정값들
        try { //건들지 말것!
            Properties props = new Properties();
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.transport.protocol", "smtp");
            props.put("mail.smtp.host", host);
            props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            props.put("mail.smtp.port", "465");
            props.put("mail.smtp.user", from);
            props.put("mail.smtp.auth", "true");

            Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication
                            ("korlgg2@gmail.com", "kbubook!004"); // gmail계정
                }
            });

            Message msg = new MimeMessage(mailSession);
            InternetAddress[] address1 = {new InternetAddress(to1)}; //이메일 전송
            msg.setFrom(new InternetAddress(from, MimeUtility.encodeText(fromName, "UTF-8", "B")));
            msg.setRecipients(Message.RecipientType.TO, address1); // 받는사람 설정
            msg.setSubject(subject); // 제목설정
            msg.setSentDate(new java.util.Date()); // 보내는 날짜 설정
            msg.setContent(content, "text/html; charset=utf-8"); // 내용설정 및 인코딩
            Transport.send(msg); // 메일보내기
            System.out.println("임시 비번 이메일 보내기 성공");

        } catch (MessagingException e) {
            e.printStackTrace();
            System.out.println("임시 비번 이메일 보내기 오류: " + e);
        } catch (Exception e) {
            System.out.println("임시 비번 이메일 보내기 오류2 " + e);
            e.printStackTrace();
        }
        return CODE;

    }

    public static String temp() throws Exception {   // 임시비밀번호 난수 발생 메소드
        char [] key= {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9','a', 'b', 'c', 'd', 'e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','!','@','#','$'};
        StringBuffer tempKey = new StringBuffer();
        for(int i = 0; i <= 7; i++) {
            int num = (int) (key.length *Math.random());
            tempKey.append(key[num]);
            System.out.println("임시비밀번호 생성 완료");
        }
        return tempKey.toString();
    }


    public void temp_pwdchange(Member member) throws Exception { //임시 비밀번호 변경 메소드
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = pool.getConnection(); //커넥션 연결
            pstmt = con.prepareStatement("update member set pwd = ? where id =?"); //DB에서 변경할 회원정보
            pstmt.setString(1, member.getPwd());
            pstmt.setString(2, member.getId());
            pstmt.executeUpdate();
            System.out.println("임시 비밀번호 변경 완료");
        } catch (Exception e) {
            System.out.println("임시 비밀번호 변경 오류: " + e);
        } finally {
            if (pstmt != null) try {
                pstmt.close();
            } catch (SQLException ex) {
            }
            if (con != null) try {
                con.close();
            } catch (SQLException ex) {
            }
        }

    }


}




