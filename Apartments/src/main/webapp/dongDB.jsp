<%@page import="java.sql.SQLException"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="QueryBean" scope="page" class="db.beans.QueryBean" />
<jsp:setProperty property="*" name="QueryBean" />

<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("UTF-8");
		
	String siName = (request.getParameter("�ñ�����") == null) ? "" : request.getParameter("�ñ�����").trim();
	String doName = (request.getParameter("�õ���") == null) ? "" : request.getParameter("�õ���").trim();
	QueryBean.getConnection();
	ArrayList resArr = new ArrayList();
	try {
		resArr = QueryBean.getDongName(siName, doName);
		
	} catch (SQLException e) {
		out.print(e.toString());
	} finally {
		QueryBean.closeConnection(); 
	}
	out.println("{");
	out.println("\"datas\":[");
	
	if (resArr.size() == 0) {
		out.println("]");
		out.println("}");
	} else {
		out.print("{");
		out.print("\"�������ڵ�\":\"" + (String) resArr.get(0) + "\", ");
		out.print("\"���鵿��\":\"" + (String) resArr.get(1) + "\" ");
//		out.print("\"NAME\":\"" + (String) resArr.get(1) + "\", ");
//		out.print("\"PHONE\":\"" + (String) resArr.get(2) + "\", ");
//		out.print("\"GRADE\":\"" + (String) resArr.get(3) + "\", ");
//		out.print("\"WRITE_TIME\":\"" + (String) resArr.get(4) + "\" ");
		out.print("}");
		for (int i = 2; i < resArr.size(); i=i+2) {
			out.print(",");
			out.print("{");
			out.print("\"�������ڵ�\":\"" + (String) resArr.get(i) + "\", ");
			out.print("\"���鵿��\":\"" + (String) resArr.get(i + 1) + "\" ");
//			out.print("\"NAME\":\"" + (String) resArr.get(i + 1) + "\", ");
//			out.print("\"PHONE\":\"" + (String) resArr.get(i + 2) + "\", ");
//			out.print("\"GRADE\":\"" + (String) resArr.get(i + 3) + "\", ");
//			out.print("\"WRITE_TIME\":\"" + (String) resArr.get(i + 4) + "\" ");
			out.print("}");
		}
		out.println("]");
		out.println("}");
	}
%>
