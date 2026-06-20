<%@page import="service.CropInfoService,model.CropDetail"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
String cropName = request.getParameter("crop");
CropDetail crop = new CropInfoService().getCropByName(cropName);
if (crop == null) { response.sendRedirect("cropInfo.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head><title><%=crop.getName()%></title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"></head>
<body class="p-4">
<div class="container bg-white p-4 rounded shadow" style="max-width:700px;">
    <h3 class="text-success"><%=crop.getName()%></h3>
    <p><b>Fertilizers:</b> <%=crop.getFertilizers()%></p>
    <p><b>Disease Control:</b> <%=crop.getDiseaseControl()%></p>
    <p><b>Water:</b> <%=crop.getWaterRequirement()%></p>
    <p><b>Harvest:</b> <%=crop.getHarvestTime()%></p>
    <a href="cropInfo.jsp" class="btn btn-success">â Back</a>
</div>
</body>
</html>
