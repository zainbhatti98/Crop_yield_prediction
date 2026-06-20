<%@page import="service.CropAdvisoryService,model.CropRecommendation"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
double temp = Double.parseDouble(request.getParameter("temperature"));
double humidity = Double.parseDouble(request.getParameter("humidity"));
double rainfall = Double.parseDouble(request.getParameter("rainfall"));
double ph = Double.parseDouble(request.getParameter("ph"));
CropRecommendation best = new CropAdvisoryService().recommend(temp, humidity, rainfall, ph);
%>
<!DOCTYPE html>
<html>
<head><title>Recommendation</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"></head>
<body class="d-flex align-items-center justify-content-center" style="min-height:100vh;">
<div class="card p-5 text-center shadow" style="border-radius:15px;">
    <h2>Recommended Crop</h2>
    <h1 class="text-success"><%=best.getCrop()%></h1>
    <p><%=best.getReason()%></p>
    <p>Score: <%=best.getMatchScore()%>/100</p>
    <a href="cropAdvisory.jsp" class="btn btn-success">Check Again</a>
</div>
</body>
</html>
