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

    <title>My new webapp</title>
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
<style>  .axis path,
.axis line {
    fill: none;
    stroke: #000;
    shape-rendering: crispEdges;
}

.bar {
    fill: steelblue;
}

.x.axis path {
    display: none;
}
</style>

</head>

<body>

<script src="https://d3js.org/d3.v3.min.js"></script>
<div class="container" style="padding-bottom: 150px;">

    <div class="page-header">
        <nav>
            <ul class="nav nav-pills">
                <li>
                    <a href="home" >Home</a>
                </li>
                <li><a href="visualization" >Visualizations</a></li>
                <li><a href="summary" >Summary</a></li>

                <li><a href="login" >Login</a></li>
            </ul>
        </nav>
    </div>
    <div id="whiteblock" class="jumbotron col-md-12">
        <script>
            var data1 = [{"playerName":"p1","gameScores":[{"gameScore":20,"gameName":"game2"},{"gameScore":10,"gameName":"game1"},{"gameScore":9,"gameName":"game3"}],"totalScore":39},{"playerName":"p2","gameScores":[{"gameScore":20,"gameName":"game2"},{"gameScore":8,"gameName":"game3"}],"totalScore":"28"}];
            var data2 = "";
            for(var i =0; i<data1.length; i++){
                data2+="{\"playerName\":\""+data1[i]["playerName"]+"\",";
                for(var j =0; j<data1[i]["gameScores"].length; j++) {
                    var gamename = data1[i]["gameScores"][j];
                    data2+="\""+(gamename["gameName"].toString()+'":"'+gamename["gameScore"].toString()+"\",");
                }
                data2=data2.substring(0,data2.length-1)+"},"
            }
            var data = ("["+data2.substring(0,data2.length-1)+"]");
            data = JSON.parse(data);
            console.log(data);
            var margin = {top: 20, right: 20, bottom: 30, left: 40},
                width = 960 - margin.left - margin.right,
                height = 300 - margin.top - margin.bottom;

            var x = d3.scale.ordinal()
                .rangeRoundBands([0, width], .1);

            var y = d3.scale.linear()
                .rangeRound([height, 0]);

            var color = d3.scale.ordinal()
                .range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]);

            var xAxis = d3.svg.axis()
                .scale(x)
                .orient("bottom");

            var yAxis = d3.svg.axis()
                .scale(y)
                .orient("left")
                .tickFormat(d3.format(".2s"));

            var svg = d3.select("#whiteblock").append("svg")
                .attr("width", width + margin.left + margin.right)
                .attr("height", height + margin.top + margin.bottom)
                .append("g")
                .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

            color.domain(d3.keys(data[0]).filter(function(key) { return key !== "playerName"; }));

            data.forEach(function(d) {
                var y0 = 0;
                console.log(d);
                d.ages = color.domain().map(function(name) { return {name: name, y0: y0, y1: y0 += +d[name]}; });
                d.total = d.ages[d.ages.length - 1].y1;
            });

            data.sort(function(a, b) { return b.total - a.total; });

            x.domain(data.map(function(d) { return d.playerName; }));
            y.domain([0, d3.max(data, function(d) { return d.total; })]);

            svg.append("g")
                .attr("class", "x axis")
                .attr("transform", "translate(0," + height + ")")
                .call(xAxis);

            svg.append("g")
                .attr("class", "y axis")
                .call(yAxis)
                .append("text")
                .attr("transform", "rotate(-90)")
                .attr("y", 6)
                .attr("dy", ".71em")
                .style("text-anchor", "end")
                .text("Game Score");

            var state = svg.selectAll(".state")
                .data(data)
                .enter().append("g")
                .attr("class", "g")
                .attr("transform", function(d) { return "translate(" + x(d.playerName) + ",0)"; });

            state.selectAll("rect")
                .data(function(d) { return d.ages; })
                .enter().append("rect")
                .attr("width", x.rangeBand())
                .attr("y", function(d) { if(isNaN(y(d.y1))) return y(d.y0); return y(d.y1); })
                .attr("height", function(d) {  if(isNaN(y(d.y1)))  return y(d.y0); return y(d.y0) - y(d.y1); })
                .style("fill", function(d) { return color(d.name); });

            var legend = svg.selectAll(".legend")
                .data(color.domain().slice().reverse())
                .enter().append("g")
                .attr("class", "legend")
                .attr("transform", function(d, i) { return "translate(0," + i * 20 + ")"; });

            legend.append("rect")
                .attr("x", width - 18)
                .attr("width", 18)
                .attr("height", 18)
                .style("fill", color);

            legend.append("text")
                .attr("x", width - 24)
                .attr("y", 9)
                .attr("dy", ".35em")
                .style("text-anchor", "end")
                .text(function(d) { return d; });
        </script><br/><br/><script>

             svg = d3.select("#whiteblock")
                .append("svg")
                .append("g")

            svg.append("g")
                .attr("class", "slices");
            svg.append("g")
                .attr("class", "labels");
            svg.append("g")
                .attr("class", "lines");

            width = 360, height = 150, radius = Math.min(width, height) / 2;

            var pie = d3.layout.pie()
                .sort(null)
                .value(function(d) {
                    return d.value;
                });

            var arc = d3.svg.arc()
                .outerRadius(radius * 0.8)
                .innerRadius(radius * 0.4);

            var outerArc = d3.svg.arc()
                .innerRadius(radius * 0.9)
                .outerRadius(radius * 0.9);

            svg.attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

            var key = function(d){ return d.data.label; };

            color = d3.scale.ordinal()
                .domain(["skill3","skill1","skill2"])
                .range(["#180aaf", "#38af0a", "#8b0aaf"]);

            function randomData (){
                var labels = color.domain();
                console.log(${res});
                var jsonData = ${res};
                return labels.map(function(label){
                    return { label: label, value: jsonData[label] }
                });
            }

            change(randomData());

            d3.select(".randomize")
                .on("click", function(){
                    change(randomData());
                });


            function change(data) {
                var slice = svg.select(".slices").selectAll("path.slice")
                    .data(pie(data), key);

                slice.enter()
                    .insert("path")
                    .style("fill", function(d) { return color(d.data.label); })
                    .attr("class", "slice");

                slice
                    .transition().duration(1000)
                    .attrTween("d", function(d) {
                        this._current = this._current || d;
                        var interpolate = d3.interpolate(this._current, d);
                        this._current = interpolate(0);
                        return function(t) {
                            return arc(interpolate(t));
                        };
                    })

                slice.exit()
                    .remove();

                var text = svg.select(".labels").selectAll("text")
                    .data(pie(data), key);

                text.enter()
                    .append("text")
                    .attr("dy", ".35em")
                    .text(function(d) {
                        return d.data.label;
                    });

                function midAngle(d){
                    return d.startAngle + (d.endAngle - d.startAngle)/2;
                }

                text.transition().duration(1000)
                    .attrTween("transform", function(d) {
                        this._current = this._current || d;
                        var interpolate = d3.interpolate(this._current, d);
                        this._current = interpolate(0);
                        return function(t) {
                            var d2 = interpolate(t);
                            var pos = outerArc.centroid(d2);
                            pos[0] = radius * (midAngle(d2) < Math.PI ? 1 : -1);
                            return "translate("+ pos +")";
                        };
                    })
                    .styleTween("text-anchor", function(d){
                        this._current = this._current || d;
                        var interpolate = d3.interpolate(this._current, d);
                        this._current = interpolate(0);
                        return function(t) {
                            var d2 = interpolate(t);
                            return midAngle(d2) < Math.PI ? "start":"end";
                        };
                    });

                text.exit()
                    .remove();

                var polyline = svg.select(".lines").selectAll("polyline")
                    .data(pie(data), key);

                polyline.enter()
                    .append("polyline");

                polyline.transition().duration(1000)
                    .attrTween("points", function(d){
                        this._current = this._current || d;
                        var interpolate = d3.interpolate(this._current, d);
                        this._current = interpolate(0);
                        return function(t) {
                            var d2 = interpolate(t);
                            var pos = outerArc.centroid(d2);
                            pos[0] = radius * 0.95 * (midAngle(d2) < Math.PI ? 1 : -1);
                            return [arc.centroid(d2), outerArc.centroid(d2), pos];
                        };
                    });

                polyline.exit()
                    .remove();
            };

        </script>
        <script>

            svg = d3.select("#whiteblock")
                .append("svg")
                .append("g")

            svg.append("g")
                .attr("class", "slices");
            svg.append("g")
                .attr("class", "labels");
            svg.append("g")
                .attr("class", "lines");

            width = 360, height = 150, radius = Math.min(width, height) / 2;

            var pie = d3.layout.pie()
                .sort(null)
                .value(function(d) {
                    return d.value;
                });

            var arc = d3.svg.arc()
                .outerRadius(radius * 0.8)
                .innerRadius(radius * 0.4);

            var outerArc = d3.svg.arc()
                .innerRadius(radius * 0.9)
                .outerRadius(radius * 0.9);

            svg.attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

            var key = function(d){ return d.data.label; };

            color = d3.scale.ordinal()
                .domain(["skill3","skill1","skill2"])
                .range(["#180aaf", "#38af0a", "#8b0aaf"]);

            function randomData (){
                var labels = color.domain();
                console.log(${res});
                var jsonData = ${res};
                return labels.map(function(label){
                    return { label: label, value: jsonData[label] }
                });
            }

            change(randomData());

            d3.select(".randomize")
                .on("click", function(){
                    change(randomData());
                });


            function change(data) {
                var slice = svg.select(".slices").selectAll("path.slice")
                    .data(pie(data), key);

                slice.enter()
                    .insert("path")
                    .style("fill", function(d) { return color(d.data.label); })
                    .attr("class", "slice");

                slice
                    .transition().duration(1000)
                    .attrTween("d", function(d) {
                        this._current = this._current || d;
                        var interpolate = d3.interpolate(this._current, d);
                        this._current = interpolate(0);
                        return function(t) {
                            return arc(interpolate(t));
                        };
                    })

                slice.exit()
                    .remove();

                var text = svg.select(".labels").selectAll("text")
                    .data(pie(data), key);

                text.enter()
                    .append("text")
                    .attr("dy", ".35em")
                    .text(function(d) {
                        return d.data.label;
                    });

                function midAngle(d){
                    return d.startAngle + (d.endAngle - d.startAngle)/2;
                }

                text.transition().duration(1000)
                    .attrTween("transform", function(d) {
                        this._current = this._current || d;
                        var interpolate = d3.interpolate(this._current, d);
                        this._current = interpolate(0);
                        return function(t) {
                            var d2 = interpolate(t);
                            var pos = outerArc.centroid(d2);
                            pos[0] = radius * (midAngle(d2) < Math.PI ? 1 : -1);
                            return "translate("+ pos +")";
                        };
                    })
                    .styleTween("text-anchor", function(d){
                        this._current = this._current || d;
                        var interpolate = d3.interpolate(this._current, d);
                        this._current = interpolate(0);
                        return function(t) {
                            var d2 = interpolate(t);
                            return midAngle(d2) < Math.PI ? "start":"end";
                        };
                    });

                text.exit()
                    .remove();

                var polyline = svg.select(".lines").selectAll("polyline")
                    .data(pie(data), key);

                polyline.enter()
                    .append("polyline");

                polyline.transition().duration(1000)
                    .attrTween("points", function(d){
                        this._current = this._current || d;
                        var interpolate = d3.interpolate(this._current, d);
                        this._current = interpolate(0);
                        return function(t) {
                            var d2 = interpolate(t);
                            var pos = outerArc.centroid(d2);
                            pos[0] = radius * 0.95 * (midAngle(d2) < Math.PI ? 1 : -1);
                            return [arc.centroid(d2), outerArc.centroid(d2), pos];
                        };
                    });

                polyline.exit()
                    .remove();
            };

        </script>
        </div></div>
        </body>
</html>
