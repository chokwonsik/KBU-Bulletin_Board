package freetalk;

import kbu.DBConnectionMgr;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

public class FreeTalkDAO {
    private DBConnectionMgr pool;

    public FreeTalkDAO() {
        try {
            pool = DBConnectionMgr.getInstance();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

	// 게시물 가져오기
	public Vector<FreeTalk> getList(String keyField, String keyWord, int start, int end) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        Vector<FreeTalk> list = new Vector<FreeTalk>();

        try {
            con = pool.getConnection();
            if (keyWord.equals("null") || keyWord.equals("")) {
                sql = "select * from freetalk order by id desc limit ?, ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setInt(1, start);
                pstmt.setInt(2, end);
            } else {
                sql = "select * from freetalk where " + keyField + " like ?";
                sql += "order by id desc limit ?, ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, "%" + keyWord + "%");
                pstmt.setInt(2, start);
                pstmt.setInt(3, end);
            }

            rs = pstmt.executeQuery();

            while (rs.next()) {
                FreeTalk freeTalk = new FreeTalk();
                freeTalk.setId(rs.getInt("id"));
                freeTalk.setWriter(rs.getString("writer"));
                freeTalk.setTitle(rs.getString("title"));
                freeTalk.setDate(rs.getDate("date"));
                freeTalk.setCount(rs.getInt("count"));
                list.add(freeTalk);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {}
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException ex) {}

            }

            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex) {}
            }
        }

        return list;
    }

    // 총 게시물 수
    public int getTotalCount (String keyField, String keyWord) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        int totalCount = 0;

        try {
            con = pool.getConnection();
            if (keyWord.equals("null") || keyWord.equals("")) {
                sql = "select count(id) from freetalk";
                pstmt = con.prepareStatement(sql);
            } else {
                sql = "select count(id) from freetalk where " + keyField + " like ? ";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, "%" + keyWord + "%");
            }
            rs = pstmt.executeQuery();
            if (rs.next()) {
                totalCount = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (con != null) try { con.close(); } catch(SQLException ex) {}
        }
        return totalCount;
    }

    // 게시물 입력
    public void write(String title, String writer, String content, String ip) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        try {
            con = pool.getConnection();

            sql = "insert freetalk(writer,content,title,date,count,ip) values(?, ?, ?, now(), 0, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, writer);
            pstmt.setString(2, content);
            pstmt.setString(3, title);
            pstmt.setString(4, ip);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (con != null) try { con.close(); } catch(SQLException ex) {}
        }
    }

    // 게시물 리턴
    public FreeTalk getContent(int num) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        FreeTalk freetalk = new FreeTalk();
        try {
            con = pool.getConnection();
            sql = "select * from freetalk where id=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                freetalk.setId(rs.getInt("id"));
                freetalk.setWriter(rs.getString("writer"));
                freetalk.setTitle(rs.getString("title"));
                freetalk.setContent(rs.getString("content"));
                freetalk.setDate(rs.getDate("date"));
                freetalk.setCount(rs.getInt("count"));
                freetalk.setIp(rs.getString("ip"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (con != null) try { con.close(); } catch(SQLException ex) {}
        }
        return freetalk;
    }

    // 조회수 증가
    public void upCount(int num) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = null;
        try {
            con = pool.getConnection();
            sql = "update freetalk set count=count+1 where id=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (con != null) try { con.close(); } catch(SQLException ex) {}
        }
    }

    // 게시물 삭제
    public void delete(int num) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = null;
        ResultSet rs = null;
        try {
            con = pool.getConnection();
            sql = "delete from freetalk where id=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (con != null) try { con.close(); } catch(SQLException ex) {}
        }
    }

    // 게시물 수정
    public void update(FreeTalk freetalk) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = null;
        try {
            con = pool.getConnection();
            sql = "update freetalk set writer=?,title=?,content=? where id=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, freetalk.getWriter());
            pstmt.setString(2, freetalk.getTitle());
            pstmt.setString(3, freetalk.getContent().replace("/r/n", "<br>"));
            pstmt.setInt(4, freetalk.getId());
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (con != null) try { con.close(); } catch(SQLException ex) {}
        }
    }

    // 댓글 작성
    public void writeComment(int id, String writer, String content, String ip) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        try {
            con = pool.getConnection();

            sql = "insert freetalk_comment(l_id, writer, content, date, ip) values(?, ?, ?, now(), ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.setString(2, writer);
            pstmt.setString(3, content.replace("/r/n", "<br>"));
            pstmt.setString(4, ip);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (con != null) try { con.close(); } catch(SQLException ex) {}
        }
    }

    // 게시물 별 댓글 가져오기
    public Vector<FreeTalkComment> getCommentList(int id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        Vector<FreeTalkComment> list = new Vector<FreeTalkComment>();

        try {
            con = pool.getConnection();

            sql = "select * from freetalk_comment where l_id="+id+" order by l_id ";
            pstmt = con.prepareStatement(sql);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                FreeTalkComment freeTalkComment = new FreeTalkComment();
                freeTalkComment.setCid(rs.getInt("c_id"));
                freeTalkComment.setWriter(rs.getString("writer"));
                freeTalkComment.setContent(rs.getString("content"));
                freeTalkComment.setDate(rs.getDate("date"));
                freeTalkComment.setIp(rs.getString("ip"));
                list.add(freeTalkComment);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {}
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException ex) {}

            }

            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex) {}
            }
        }

        return list;
    }

    // 댓글 삭제
    public void deleteComment(int num) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = null;
        ResultSet rs = null;
        try {
            con = pool.getConnection();
            sql = "delete from freetalk_comment where c_id=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (con != null) try { con.close(); } catch(SQLException ex) {}
        }
    }
}
