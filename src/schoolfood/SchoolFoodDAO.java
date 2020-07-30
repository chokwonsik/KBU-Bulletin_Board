package schoolfood;

import kbu.DBConnectionMgr;
import util.UtilMgr;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Vector;

public class SchoolFoodDAO {
    private SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd"); // 날짜 포맷
    private String today = sdf.format(System.currentTimeMillis()); // 오늘 날짜 문자열로 저장

    private DBConnectionMgr pool;
    private static final String saveFolder = "fileupload";
    private static final String enctype = "UTF-8";
    private static int MAXSIZE = 5 * 1024 * 1024;

    public SchoolFoodDAO() {
        try {
            pool = DBConnectionMgr.getInstance();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Vector<Lunch> getLunch() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;

        Vector<Lunch> list = new Vector<Lunch>();

        try {
            con = pool.getConnection();
            sql = "select * from lunch where date >= "+UtilMgr.getMonday() + " and date <= " + UtilMgr.getFriday();

            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String[] food = new String[6];
                Lunch lunch = new Lunch();
                lunch.setId(rs.getInt("id"));
                lunch.setDate(rs.getString("date"));
                lunch.setDay(rs.getString("day"));
                for (int i = 0; i < 6; i++) {
                     food[i] = rs.getString("food"+(i+1));
                }
                lunch.setFood(food);

                list.add(lunch);
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

    public Lunch getTodayLunch() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;

        Lunch lunch = new Lunch();

        try {
            con = pool.getConnection();

            sql = "select * from lunch where date="+today;

            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String[] food = new String[6];
                lunch.setId(rs.getInt("id"));
                lunch.setDate(rs.getString("date"));
                lunch.setDay(rs.getString("day"));
                for (int i = 0; i < 6; i++) {
                    food[i] = rs.getString("food" + (i + 1));
                }

                lunch.setFood(food);
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

        return lunch;
    }

    public Vector<Dinner> getDinner() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;

        Vector<Dinner> list = new Vector<Dinner>();

        try {
            con = pool.getConnection();

            sql = "select * from dinner where date >= "+UtilMgr.getMonday() + " and date <= " + UtilMgr.getFriday();

            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String[] food = new String[6];
                Dinner dinner = new Dinner();
                dinner.setId(rs.getInt("id"));
                dinner.setDate(rs.getString("date"));
                dinner.setDay(rs.getString("day"));
                for (int i = 0; i < 6; i++) {
                    food[i] = rs.getString("food"+(i+1));
                }
                dinner.setFood(food);

                list.add(dinner);
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

    public Dinner getTodayDinner() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;

        Dinner dinner = new Dinner();

        try {
            con = pool.getConnection();

            sql = "select * from dinner where date="+today;

            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String[] food = new String[6];
                dinner.setId(rs.getInt("id"));
                dinner.setDate(rs.getString("date"));
                dinner.setDay(rs.getString("day"));
                for (int i = 0; i < 6; i++) {
                    food[i] = rs.getString("food" + (i + 1));
                }

                dinner.setFood(food);
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

        return dinner;
    }

    public Vector<Fix> getFix() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;

        Vector<Fix> list = new Vector<Fix>();

        try {
            con = pool.getConnection();

            sql = "select * from fix where date >= "+UtilMgr.getMonday() + " and date <= " + UtilMgr.getFriday();

            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String[] food = new String[2];
                Fix fix = new Fix();
                fix.setId(rs.getInt("id"));
                fix.setDate(rs.getString("date"));
                fix.setDay(rs.getString("day"));
                for (int i = 0; i < 2; i++) {
                    food[i] = rs.getString("food"+(i+1));
                }
                fix.setFood(food);

                list.add(fix);
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

    public Fix getTodayFix() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;

        Fix fix = new Fix();

        try {
            con = pool.getConnection();

            sql = "select * from fix where date="+today;

            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String[] food = new String[2];
                fix.setId(rs.getInt("id"));
                fix.setDate(rs.getString("date"));
                fix.setDay(rs.getString("day"));
                for (int i = 0; i < 2; i++) {
                    food[i] = rs.getString("food" + (i + 1));
                }

                fix.setFood(food);
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

        return fix;
    }

    public Vector<Daily> getDaily() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;

        Vector<Daily> list = new Vector<Daily>();

        try {
            con = pool.getConnection();

            sql = "select * from daily where date >= "+UtilMgr.getMonday() + " and date <= " + UtilMgr.getFriday();

            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Daily daily = new Daily();
                daily.setId(rs.getInt("id"));
                daily.setDate(rs.getString("date"));
                daily.setDay(rs.getString("day"));
                daily.setFood(rs.getString("food1"));

                list.add(daily);
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

    public Daily getTodayDaily() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;

        Daily daily = new Daily();

        try {
            con = pool.getConnection();

            sql = "select * from daily where date="+today;

            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                daily.setId(rs.getInt("id"));
                daily.setDate(rs.getString("date"));
                daily.setDay(rs.getString("day"));
                daily.setFood(rs.getString("food1"));
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

        return daily;
    }

    public void upload(Vector<Lunch> lunches, Vector<Dinner> dinners, Vector<Fix> fixes, Vector<Daily> dailies) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;

        try {
            con = pool.getConnection();

            sql = "insert lunch(date,day,food1,food2,food3,food4,food5,food6) values(?,?,?,?,?,?,?,?)";
            pstmt = con.prepareStatement(sql);

            for (Lunch lunch: lunches) {
                pstmt.setString(1, lunch.getDate());
                pstmt.setString(2, lunch.getDay());
                for (int i = 3; i <= 8; i++)
                    pstmt.setString(i, lunch.getFood()[i-3]);
                pstmt.executeUpdate();
            }

            sql = "insert dinner(date,day,food1,food2,food3,food4,food5,food6) values(?,?,?,?,?,?,?,?)";
            pstmt = con.prepareStatement(sql);

            for (Dinner dinner: dinners) {
                pstmt.setString(1, dinner.getDate());
                pstmt.setString(2, dinner.getDay());
                for (int i = 3; i <= 8; i++)
                    pstmt.setString(i, dinner.getFood()[i-3]);
                pstmt.executeUpdate();
            }

            sql = "insert fix(date,day,food1,food2) values(?,?,?,?)";
            pstmt = con.prepareStatement(sql);

            for (Fix fix: fixes) {
                pstmt.setString(1, fix.getDate());
                pstmt.setString(2, fix.getDay());
                for (int i = 3; i <= 4; i++)
                    pstmt.setString(i, fix.getFood()[i-3]);
                pstmt.executeUpdate();
            }

            sql = "insert daily(date,day,food1) values(?,?,?)";
            pstmt = con.prepareStatement(sql);

            for (Daily daily: dailies) {
                pstmt.setString(1, daily.getDate());
                pstmt.setString(2, daily.getDay());
                pstmt.setString(3, daily.getFood());
                pstmt.executeUpdate();
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
    }
}
