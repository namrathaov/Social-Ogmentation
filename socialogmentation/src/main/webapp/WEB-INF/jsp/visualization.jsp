<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content=""><link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link href='https://fonts.googleapis.com/css?family=Raleway' rel='stylesheet' type='text/css'>

    <title>Social Ogmentation</title>
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    <![endif]-->

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <style><%@include file="/WEB-INF/jsp/styling.css"%></style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.10/d3.min.js"></script>
</head>
<body>
<div class="container" style="padding-bottom: 150px;">

    <div class="page-header">
        <nav>
            <ul class="nav nav-pills">
                <li>
                    <a href="home" >Home</a>
                </li>
                <li><a href="visualization" >Visualizations</a></li>
                <li><a href="summary" >Summary</a></li>

                <c:if test="${username eq error}">
                    <li><a href="login" >Login</a></li>
                </c:if>
                <c:if test="${username ne error}">
                    <li><a href="summary">${username}</a></li>
                </c:if>
            </ul>
        </nav>
    </div>
    <div id="whiteblock" class="jumbotron col-md-12">

<!-- External JS libraries -->
<script src="https://d3js.org/d3.v5.min.js"></script>
        <!--
<script>
    dataset = {
        "children": [{"Name":"Skill 1","Count":3},
            {"Name":"Skill 2","Count": 9},
            {"Name":"Skill 3","Count":0},
            {"Name":"Skill 4","Count":1},
            {"Name":"Skill 5","Count":1}]
    };
    var diameter = 600;

    var color = d3.scaleOrdinal(d3.schemeCategory20);

    var bubble = d3.pack(dataset)
        .size([diameter, diameter])
        .padding(1.5);

    var svg = d3.select("whiteblock")
        .append("svg")
        .attr("width", diameter)
        .attr("height", diameter)
        .attr("class", "bubble");

    var nodes = d3.hierarchy(dataset)
        .sum(function(d) { return d.Count; });

    var node = svg.selectAll(".node")
        .data(bubble(nodes).descendants())
        .enter()
        .filter(function(d){
            return  !d.children
        })
        .append("g")
        .attr("class", "node")
        .attr("transform", function(d) {
            return "translate(" + d.x + "," + d.y + ")";
        });

    node.append("title")
        .text(function(d) {
            return d.Name + ": " + d.Count;
        });

    node.append("circle")
        .attr("r", function(d) {
            return d.r;
        })
        .style("fill", function(d,i) {
            return color(i);
        });

    node.append("text")
        .attr("dy", ".2em")
        .style("text-anchor", "middle")
        .text(function(d) {
            return d.data.Name.substring(0, d.r / 3);
        })
        .attr("font-family", "sans-serif")
        .attr("font-size", function(d){
            return d.r/5;
        })
        .attr("fill", "white");

    node.append("text")
        .attr("dy", "1.3em")
        .style("text-anchor", "middle")
        .text(function(d) {
            return d.data.Count;
        })
        .attr("font-family",  "Gill Sans", "Gill Sans MT")
        .attr("font-size", function(d){
            return d.r/5;
        })
        .attr("fill", "white");

    d3.select(self.frameElement)
        .style("height", diameter + "px");


</script> -->
        <div id="game">
        <h3>Try playing.. </h3></div>
        <script>$.ajax({
        url : '<c:url value='http://localhost:8080/api/getSuggestedGames?playername=${username}'/>',
        type : 'GET',
        success : function(data) {
            console.log(data);
            var k = '<ul>';
            data = data.substring(1,data.length-1);
            var d = data.split(",");
            console.log(d.length);
            var k ="<ul>";
            for(var i = 0; i< d.length; i++){
                k+="<li><a href=''>"+(d[i].split(":")[1]).substring(1,d[i].split(":")[1].length-1)+"</a></li>";
            }
            k+='</ul>';
            $('#game').append(k);
        },
        error : function(request,error)
        {
            alert("Request: "+JSON.stringify(request));
        }
    });</script>
                <div id="player">
                <h3>Try playing with.. </h3></div>
            <script>$.ajax({
                url : '<c:url value='http://localhost:8080/api/getSuggestedPlayers?playername=${username}'/>',
                type : 'GET',
                success : function(data) {
                    console.log(data);
                    var k = '<ul>';
                    data = data.substring(1,data.length-1);
                    var d = data.split(",");
                    console.log(d.length);
                    var k ="<ul>";
                    for(var i = 0; i< d.length; i++){
                        k+="<li><a href=''>"+(d[i].split(":")[1]).substring(1,d[i].split(":")[1].length-1)+"</a></li>";
                    }
                    k+='</ul>';
                    $('#player').append(k);
                },
                error : function(request,error)
                {
                    alert("Request: "+JSON.stringify(request));
                }
            });</script>
    </div></div>
</body>
</html>