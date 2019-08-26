<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %> 
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>
    		Docker workflow
    	</title>
	    <link href="assets/css/bootstrap.css" rel="stylesheet">
	    <style>
	      body { padding-top: 60px; }
	    </style>
	    <link href="assets/css/bootstrap-responsive.css" rel="stylesheet">
	</head>
<body>
	<div class="navbar navbar-fixed-top navbar-inverse">
		<div class="navbar-inner">
			<div class="container">
				<a class="brand" href="/SpringDockerJenkins"> Home </a>
				<ul class="nav">
				</ul>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="hero-unit">
			<h1 align="center">${welcome}</h1>
			<img height="100%" width="100%"
				src="assets/images/dockerWorkflow.jpg"
				alt="Docker" />
		</div>
	</div>

</body>
</html>