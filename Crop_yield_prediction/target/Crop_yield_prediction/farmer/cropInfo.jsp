<%@page import="service.CropInfoService,model.CropDetail,java.util.List,java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Crop Information</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body{
            background: linear-gradient(135deg,#000,#0f3d0f);
            min-height:100vh;
            padding:30px;
            font-family:Arial,sans-serif;
        }

        .page-title{
            color:#00ff99;
            text-align:center;
            font-weight:bold;
            margin-bottom:35px;
        }

        .crop-card{
            background:white;
            border-radius:20px;
            overflow:hidden;
            box-shadow:0 10px 25px rgba(0,0,0,.4);
            transition:.3s;
            height:100%;
        }

        .crop-card:hover{
            transform:translateY(-8px);
        }

        .crop-img{
            width:100%;
            height:220px;
            object-fit:cover;
        }

        .crop-content{
            padding:15px;
            text-align:center;
        }

        .crop-name{
            font-weight:bold;
            color:#198754;
            margin-bottom:15px;
        }

        .back-btn{
            margin-top:30px;
        }
    </style>
</head>
<body>

<%
List<CropDetail> crops = new ArrayList<>();

try{
    CropInfoService svc = new CropInfoService();

    List<CropDetail> temp = svc.getAllCrops();

    if(temp != null){
        crops = temp;
    }

}catch(Exception e){
%>

<div class="alert alert-danger">
    Error Loading Crops:
    <%= e.getMessage() %>
</div>

<%
}
%>

<div class="container">

    <h2 class="page-title">
        🌾 Crop Information (<%= crops.size() %> Crops)
    </h2>

    <div class="row g-4">

        <% if(crops.isEmpty()){ %>

        <div class="col-12">
            <div class="alert alert-warning text-center">
                No crops available.
            </div>
        </div>

        <% } else {

            for(CropDetail c : crops){
        %>

        <div class="col-md-4 col-lg-3">

            <div class="crop-card">

                <img
                    src="<%= c.getImageUrl() %>"
                    alt="<%= c.getName() %>"
                    class="crop-img"
                    onerror="this.onerror=null;this.src='https://placehold.co/600x400/198754/ffffff?text=<%= c.getName() %>';"
                >

                <div class="crop-content">

                    <h5 class="crop-name">
                        <%= c.getName() %>
                    </h5>

                    <a href="cropDetails.jsp?crop=<%= c.getName() %>"
                       class="btn btn-success">
                        View Details
                    </a>

                </div>

            </div>

        </div>

        <%
            }
        }
        %>

    </div>

    <div class="text-center">
        <a href="dashboard.jsp" class="btn btn-dark back-btn">
            ← Back to Dashboard
        </a>
    </div>

</div>

</body>
</html>