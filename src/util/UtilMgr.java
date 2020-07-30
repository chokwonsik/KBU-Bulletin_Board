package util;

import java.util.Calendar;

public class UtilMgr {
    public static String replace(String str, String pattern, String replace) {
        int s = 0, e = 0;
        StringBuffer result = new StringBuffer();
        while ((e = str.indexOf(pattern, s)) >= 0) {
            result.append(str.substring(s, e));
            result.append(replace);
            s = e + pattern.length();
        }
        result.append(str.substring(s));
        return result.toString();
    }

    // 이번주 월요일 날짜 구하기
    public static String getMonday() {
        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
        Calendar c = Calendar.getInstance();

        c.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

        return formatter.format(c.getTime());
    }


    // 이번주 금요일 날짜 구하기
    public static String getFriday() {
        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
        Calendar c = Calendar.getInstance();

        c.set(Calendar.DAY_OF_WEEK, Calendar.FRIDAY);

        return formatter.format(c.getTime());
    }
}