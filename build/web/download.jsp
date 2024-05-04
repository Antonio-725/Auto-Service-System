<%-- 
    Document   : Download
    Created on : Feb 28, 2024, 12:39:43 AM
    Author     : antonio
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
    
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.util.Base64" %><!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
  
<%
    String documentType = request.getParameter("documentType");
     String documentBase64 = request.getParameter("document");
    byte[] documentBytes = Base64.getDecoder().decode(documentBase64);

    // Set the appropriate content type for the file being downloaded
    String contentType = "application/pdf"; // Set the correct content type based on the file type

    // Set the appropriate file name for the downloaded file
    String fileName = "document.pdf"; // Set the correct file name based on the file type

    // Set the appropriate headers for the file download
    response.setContentType(contentType);
    response.setContentLength(documentBytes.length);
    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

    // Write the file bytes to the output stream
    OutputStream out1 = response.getOutputStream();
    out1.write(documentBytes);
    out.flush();
    out.close();
   /* try {
        String documentType = request.getParameter("documentType");
        String base64Document = request.getParameter("document");

        byte[] documentBytes = Base64.getDecoder().decode(base64Document);
        InputStream inputStream = new ByteArrayInputStream(documentBytes);

        String fileName = "file"; // Default filename without extension
        if ("pdf".equals(documentType)) {
            fileName += ".pdf";
            response.setContentType("application/pdf");
        } else if ("docx".equals(documentType)) {
            fileName += ".docx";
            response.setContentType("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
        } else if ("txt".equals(documentType)) {
            fileName += ".txt";
            response.setContentType("text/plain");
        } else {
            // Handle unknown file types here
        }

        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

        OutputStream outputStream = response.getOutputStream();
        byte[] buffer = new byte[4096];
        int bytesRead = -1;
        while ((bytesRead = inputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, bytesRead);
        }

        inputStream.close();
        outputStream.close();
    } catch (Exception ex) {
        //Logger.getLogger(DownloadFile.class.getName()).log(Level.SEVERE, null, ex);
    }*/
%>

        
    </body>
</html>
