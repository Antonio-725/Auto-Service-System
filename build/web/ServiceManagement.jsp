<%-- 
    Document   : ServiceManagement
    Created on : Mar 23, 2024, 12:28:22 AM
    Author     : antonio
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.util.Base64"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="Database.DatabaseConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSetMetaData"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Auto Service System</title>
        <link rel="stylesheet"
              href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link rel="stylesheet"
              href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script
        src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script
        src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script
        src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <link
            href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
            rel="stylesheet" id="bootstrap-css">
        <script
        src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script
        src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/adddataform.css">
        <link rel="stylesheet" type="text/css" href="css/adddatafrm1.css">
        <link rel="stylesheet" type="text/css" href="css/table.css">
        <style>
             body {
            background-image:linear-gradient(rgba(0,0,0,0.75),rgba(0,0,0,0.75)), url("img/carup.jpg");
            position: relative;
            height: 100vh;
            width: 100%;
            background-size: cover; 
            background-position: center;
           justify-content: flex-start;
            background-color: #cccccc;
        }
            .serchbar
            {
                width: 60%;
                height: 5%;
                margin-top:2%; 
                margin-left: 100px;
                margin-bottom: 0%;
            }
            .search
            {
                width: 40%;
                height: 40px; 
                border-radius: 10px;
            }
            .text-center{
                color: grey;
                padding: 10px;
                margin-top: 0px;
            }
            input {
                text-align: center;
            }
            ::-webkit-input-placeholder {
                text-align: center;
            }
            :-moz-placeholder {
                text-align: center;
            }
            .mybutton{
                display: inline;
            }
            

        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a href="index.jsp" class="navbar-brand"> <img src="img/servicelogo.png"
                                                   height="30" width="80" alt="AutoServiceSystem">
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <h3>
                    <b>Auto Service Management System</b>
                </h3>
                <ul class="navbar-nav ml-auto" style="margin-right: 70px;">

                    <li class="nav-item active">
                        <a class="nav-link" href="DashboardAdmin.jsp">Home <span class="sr-only">(current)</span></a>
                    </li>
                    
                    
                    
                    
                </ul>
            </div>
        </nav>

        <div class="serchbar">
            <form action=" " method="post">
                <input class="search" type="text" name="search" placeholder="Search Here..."/>
            </form>
        </div>
        


      
<%
    Connection con = null;
%>
<div>
    <div class="container-table100">
        <div class="wrap-table100">
            <div class="table100 ver3 m-b-110">
                <div class="table100-head">
                    <table>
                        <thead>
                            <tr class="row100 head">
                                <th class="cell100 column0">Id</th>
                                <th class="cell100 column1">Vehicle Type</th>
                                <th class="cell100 column2">Plate Number</th>
                                <th class="cell100 column3">Mechanic</th>
                                <th class="cell100 column4">Service Start</th>
                                <th class="cell100 column5">Service End</th>
                           
                                <th class="cell100 column6">Actions</th>
                            </tr>
                        </thead>
                    </table>
                </div>
                <div class="table100-body js-pscroll">
                    <table>
                        <tbody>
<%
try {
    con = DatabaseConnection.initializeDatabase();
    Statement st = con.createStatement();
    String sql, ownerSql;

    String query = request.getParameter("search");
    if (query != null && !query.isEmpty()) {
        sql = "SELECT * FROM ServiceManagement WHERE VehicleType LIKE '%" + query + "%' OR VehicleId LIKE '%" + query + "%'";
    } else {
        sql = "SELECT VehicleId, VehicleType, PlateNumber, MechanicName, ServiceStartDate, ServiceEndDate FROM ServiceManagement";
    }

    ResultSet rs = st.executeQuery(sql);

    while (rs.next()) {
        ownerSql = "SELECT Username, Email, Phone FROM Client WHERE id IN (SELECT owner_id FROM vehicle_details WHERE id = " + rs.getInt("VehicleId") + ")";
        Statement ownerSt = con.createStatement();
        ResultSet ownerRs = ownerSt.executeQuery(ownerSql);

        String ownerUsername = "", ownerEmail = "", ownerPhone = "";
        if (ownerRs.next()) {
            ownerUsername = ownerRs.getString("Username");
            ownerEmail = ownerRs.getString("Email");
            ownerPhone = ownerRs.getString("Phone");
        }

        // Close ownerRs and ownerSt
        ownerRs.close();
        ownerSt.close();
        %>
        <tr class="row100 body">
            <td class="cell100 column0"><%=rs.getInt("VehicleId")%></td>
            <td class="cell100 column1"><%=rs.getString("VehicleType")%></td>
            <td class="cell100 column2"><%=rs.getString("PlateNumber")%></td>
            <td class="cell100 column3"><%=rs.getString("MechanicName")%></td>
            <td class="cell100 column4"><%=rs.getDate("ServiceStartDate")%></td>
            <td class="cell100 column5"><%=rs.getDate("ServiceEndDate")%></td>
            <td class="cell100 column6">
                <div class="mybutton">
                    <a href="ClearService.jsp?id=<%=rs.getInt("VehicleId")%>&vehicleType=<%=rs.getString("VehicleType")%>&plateNumber=<%=rs.getString("PlateNumber")%>&Username=<%=ownerUsername%>&Email=<%=ownerEmail%>&Phone=<%=ownerPhone%>" class="btn btn-success">Clear Service</a>
                </div>
            </td>
        </tr>
        <% 
    }

    // Close ResultSet and Statement
    rs.close();
    st.close();
} catch (Exception e) {
    e.printStackTrace();
} finally {
    // Close connection
    if (con != null) {
        try {
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
%>
                       </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

  </body>
</html>
