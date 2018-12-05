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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.10/d3.min.js"></script>
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
<style>.node {
    cursor: pointer;
}

.node:hover {
    stroke: #000;
    stroke-width: 1.5px;
}

.node--leaf {
    fill: white;
}

.label {
    font: 11px "Helvetica Neue", Helvetica, Arial, sans-serif;
    text-anchor: middle;
    text-shadow: 0 1px 0 #fff, 1px 0 0 #fff, -1px 0 0 #fff, 0 -1px 0 #fff;
}

.label,
.node--root,
.node--leaf {
    pointer-events: none;
}
</style>
</head>

<body>
<div class="container" style="padding-bottom: 150px;">

    <div class="page-header">
        <nav>
            <ul class="nav nav-pills">
                <li>
                    <a href="home" >Home</a>
                </li>
                <li><a href="visualization" >Action Model</a></li>
                <li><a href="summary" >Visualization</a></li>
                <li><a href="recommend" >Recommendations</a></li>
            </ul>
        </nav>
    </div>
    <div id="whiteblock" class="jumbotron col-md-12">
        <h4>The Open Social User Model shows collaborative learning of Java among peers through various games. It is available for everyone and below is an example for one group:</h4>
        <svg width="500" height="500"></svg>
        <script src="https://d3js.org/d3.v4.min.js"></script>
        <script>

            var svg = d3.select("svg"),
                margin = 20,
                diameter = +svg.attr("width"),
                g = svg.append("g").attr("transform", "translate(" + diameter / 2 + "," + diameter / 2 + ")");

            var color = d3.scaleLinear()
                .domain([-1, 5])
                .range(["hsl(222,60%,30%)", "hsl(100,100%,50%)"])
                .interpolate(d3.interpolateHcl);

            var pack = d3.pack()
                .size([diameter - margin, diameter - margin])
                .padding(2);


            d3.json("http://localhost:8080/api/getCircleData", function(error, root) {

                console.log(root);
                if (error) throw error;

                root = d3.hierarchy(root)
                    .sum(function(d) { return d.size; })
                    .sort(function(a, b) { return b.value - a.value; });

                var focus = root,
                    nodes = pack(root).descendants(),
                    view;

                var circle = g.selectAll("circle")
                    .data(nodes)
                    .enter().append("circle")
                    .attr("class", function(d) { return d.parent ? d.children ? "node" : "node node--leaf" : "node node--root"; })
                    .style("fill", function(d) { return d.children ? color(d.depth) : null; })
                    .on("click", function(d) { if (focus !== d) zoom(d), d3.event.stopPropagation(); });

                var text = g.selectAll("text")
                    .data(nodes)
                    .enter().append("text")
                    .attr("class", "label")
                    .style("fill-opacity", function(d) { return d.parent === root ? 1 : 0; })
                    .style("display", function(d) { return d.parent === root ? "inline" : "none"; })
                    .text(function(d) { return d.data.name; });

                var node = g.selectAll("circle,text");

                svg
                    .style("background", color(-1

                    ))
                    .on("click", function() { zoom(root); });

                zoomTo([root.x, root.y, root.r * 2 + margin]);

                function zoom(d) {
                    var focus0 = focus; focus = d;

                    var transition = d3.transition()
                        .duration(d3.event.altKey ? 7500 : 750)
                        .tween("zoom", function(d) {
                            var i = d3.interpolateZoom(view, [focus.x, focus.y, focus.r * 2 + margin]);
                            return function(t) { zoomTo(i(t)); };
                        });

                    transition.selectAll("text")
                        .filter(function(d) { return d.parent === focus || this.style.display === "inline"; })
                        .style("fill-opacity", function(d) { return d.parent === focus ? 1 : 0; })
                        .on("start", function(d) { if (d.parent === focus) this.style.display = "inline"; })
                        .on("end", function(d) { if (d.parent !== focus) this.style.display = "none"; });
                }

                function zoomTo(v) {
                    var k = diameter / v[2]; view = v;
                    node.attr("transform", function(d) { return "translate(" + (d.x - v[0]) * k + "," + (d.y - v[1]) * k + ")"; });
                    circle.attr("r", function(d) { return d.r * k; });
                }
            });

        </script>

    </div></div>
</body>
</html>