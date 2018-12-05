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
    <link href="https://fonts.googleapis.com/css?family=Dosis:400,700" rel="stylesheet">
    <script src="https://cdn.anychart.com/js/8.0.1/anychart-core.min.js"></script>
    <script src="https://cdn.anychart.com/js/8.0.1/anychart-pie.min.js"></script>
    <script src="https://cdn.anychart.com/releases/v8/js/anychart-cartesian.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <style><%@include file="/WEB-INF/jsp/styling.css"%></style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.10/d3.min.js"></script>
    <style><%@include file="/WEB-INF/jsp/style.css"%></style>

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
    <div id="whiteblock" class="jumbotron col-md-12" style="height:700px">
<h3>Arpit's Social Action Profile </h3>
        <h4>The action profile corresponds to different Java concepts:
            <ol><li>Game 1 aims at learning object creation and destruction.</li>
                <li>Game 2 aims at learning Java threads.</li>
                <li>Game 3 aims at learning different datatypes in Java.</li></ol>
        </h4>
<!-- External JS libraries -->
<script src="https://d3js.org/d3.v5.min.js"></script>
        <div id = full2>
            <div id="container3"></div>
            <div id="container4"></div>
            <div id="container5"></div>
        </div>
        <div id = full1>
            <div id="container"></div>
            <div id="container2"></div>
        </div>
        <script>var request = new XMLHttpRequest();

        var action_count = 0
        var score = 0
        var login_player = "Arpit" //Get after login
        var game_count = 0;
        var act_left = 0;
        var act_right = 0;
        var act_top = 0;
        var act_down=0;
        var total_score=0;
        var other_players = 0;
        var all_left = 0;
        var all_right = 0;
        var all_top = 0;
        var all_down = 0;
        var game1 = {};
        var game2 = {};
        var game3 = {};
        var player_set = new Set();


        request.open('GET', 'http://localhost:8080/api/getGameScoreForUsers', true);
        request.onload = function () {

            // Begin accessing JSON data here
            var data = JSON.parse(this.response);

            if (request.status >= 200 && request.status < 400) {

                for (var obj_key in data) {

                    if (data.hasOwnProperty(obj_key)) {
                        //console.log(obj_key + " -> " + data[obj_key]);
                        var players = data[obj_key];
                        if(!player_set.has(players.playerName)){
                            player_set.add(players.playerName);
                            game1[players.playerName] = 0;
                            game2[players.playerName] = 0;
                            game3[players.playerName] = 0;
                        }

                        if (players.playerName == login_player){
                            //console.log(players.playerName);
                            //console.log(players.gameScores);
                            //console.log(players.totalScore);
                            //console.log(players.totalActions);
                            total_score = players.totalScore;

                            var gameScores = players.gameScores
                            for (var key in gameScores ){
                                if (gameScores.hasOwnProperty(key)) {
                                    //console.log(key + " -> " + gameScores[key].gameScore);
                                    //console.log(key + " -> " + gameScores[key].gameName);
                                    //console.log(key + " -> " + gameScores[key].gameActions);
                                    if(gameScores[key].gameName == "game1"){
                                        //console.log(game1[players.playerName]);
                                        game1[players.playerName] = game1[players.playerName] + gameScores[key].gameScore
                                        //console.log(game1[players.playerName]);
                                    }else if(gameScores[key].gameName == "game2"){
                                        //console.log(game2[players.playerName]);
                                        game2[players.playerName] = game2[players.playerName] + gameScores[key].gameScore;
                                        //console.log(game2[players.playerName]);
                                    }else if(gameScores[key].gameName == "game3"){
                                        //console.log(game3[players.playerName]);
                                        game3[players.playerName] = game3[players.playerName] + gameScores[key].gameScore;
                                        //console.log(game3[players.playerName]);
                                    }


                                    var gameActions =  gameScores[key].gameActions
                                    for (var key2 in gameActions ){
                                        if (gameActions.hasOwnProperty(key)) {
                                            //console.log(key + " -> " + gameActions[key2].actionName);
                                            //console.log(key + " -> " + gameActions[key2].actionCount);
                                            //console.log(typeof gameActions[key2].action_count);

                                            var action = gameActions[key2].actionName;
                                            var action_count = gameActions[key2].actionCount;
                                            if( action == "left"){
                                                //console.log(act_left);
                                                //console.log(action_count);
                                                act_left = act_left + action_count;
                                                //console.log(act_left);

                                            }else if(action == "right"){
                                                //console.log(act_left);
                                                //console.log(action_count);
                                                act_right = act_right + action_count;
                                                //console.log(act_right);
                                            }
                                            else if(action == "top"){
                                                //console.log(act_left);
                                                //console.log(action_count);
                                                act_top = act_top + action_count;
                                                // console.log(act_top);
                                            }
                                            else if(action == "down"){
                                                //console.log(act_left);
                                                //console.log(action_count);
                                                act_down = act_down + action_count;
                                                //console.log(act_down);
                                            }
                                        }
                                    }
                                }
                            }
                        }else{
                            other_players = other_players + 1;
                            var gameScores_2 = players.gameScores
                            for (var key_1 in gameScores_2 ){
                                if (gameScores_2.hasOwnProperty(key_1)) {
                                    if(gameScores_2[key_1].gameName == "game1"){
                                        game1[players.playerName] += gameScores_2[key_1].gameScore;
                                    }else if(gameScores_2[key_1].gameName == "game2"){
                                        game2[players.playerName] += gameScores_2[key_1].gameScore;
                                    }else if(gameScores_2[key_1].gameName == "game3"){
                                        game3[players.playerName] += gameScores_2[key_1].gameScore;
                                    }
                                    var gameActions_2 =  gameScores_2[key_1].gameActions;
                                    for (var key_2 in gameActions_2){
                                        if (gameActions_2.hasOwnProperty(key_2)) {
                                            var action_2 = gameActions_2[key_2].actionName
                                            var action_count_2 = gameActions_2[key_2].actionCount;
                                            if( action_2 == "left"){
                                                all_left = all_left + action_count_2 ;
                                            }else if(action_2 == "right"){
                                                all_right = all_right + action_count_2 ;
                                            }
                                            else if(action_2 == "top"){
                                                all_top = all_top + action_count_2 ;
                                            }
                                            else if(action_2 == "down"){
                                                all_down = all_down + action_count_2 ;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }}
            } else {
                console.log('error');
            }

            //console.log(total_score);
            //console.log(game_count);
            //console.log(act_left);
            //console.log(act_right);
            //console.log(act_top);
            //console.log(act_down);
            //console.log(all_left/other_players);
            //console.log(all_right/other_players);
            //console.log(all_top/other_players);
            //console.log(all_down/other_players);
            //console.log(game1);
            //console.log(game2);
            //console.log(game3);


            anychart.onDocumentReady(function() {
                // set the data
                var data = [
                    {x: "Action - left", value: act_left},
                    {x: "Action - right", value: act_right},
                    {x: "Action - top", value: act_top},
                    {x: "Action - down", value: act_down},
                ];

                // create the chart
                var chart = anychart.pie();

                // set the chart title
                chart.title("User Profile");

                // add the data
                chart.data(data);

                // display the chart in the container
                chart.container('container');
                chart.draw();

            });

            anychart.onDocumentReady(function() {
                // set the data
                var data = [
                    {x: "Avg ACtion - left", value: all_left/other_players},
                    {x: "Avg ACtion - right", value: all_right/other_players},
                    {x: "AVg ACtion - top", value: all_top/other_players},
                    {x: "Avg ACtion - down", value: all_down/other_players},
                ];

                // create the chart
                var chart = anychart.pie();

                // set the chart title
                chart.title("Social Profile");

                // add the data
                chart.data(data);

                // display the chart in the container
                chart.container('container2');
                chart.draw();

            });


            anychart.onDocumentReady(function() {
                // set the data
                var data_game1 = [];
                var data_game2 = [];
                var data_game3 = [];

                //console.log(players_names, player_score_dict, player_game_dict);
                var p_array = Array.from(player_set);

                for (i=0; i<player_set.size; i++){

                    data_game1.push({x: p_array[i], value: game1[p_array[i]]});
                    data_game2.push({x: p_array[i], value: game2[p_array[i]]});
                    data_game3.push({x: p_array[i], value: game3[p_array[i]]});
                }

                console.log(data_game1);
                console.log(data_game2);
                console.log(data_game3);

                // create the chart
                var chart1 = anychart.pie();
                var chart2 = anychart.pie();
                var chart3 = anychart.pie();

                // set the chart title
                chart1.title("Social profile - game1");
                // add the data
                chart1.data(data_game1);
                // display the chart in the container
                chart1.container('container3');
                chart1.draw();

                // set the chart title
                chart2.title("Social profile - game-2");
                // add the data
                chart2.data(data_game2);
                // display the chart in the container
                chart2.container('container4');
                chart2.draw();

                // set the chart title
                chart3.title("Social profile - game-3");
                // add the data
                chart3.data(data_game3);
                // display the chart in the container
                chart3.container('container5');
                chart3.draw();

            });


        }

        request.send();</script>

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
    </div></div>
</body>
</html>