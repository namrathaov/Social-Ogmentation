var request = new XMLHttpRequest();

var action_count = 0
var score = 0
var login_player = "p2" //Get after login
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
            {x: "ACtion - left", value: act_left},
            {x: "ACtion - right", value: act_right},
            {x: "ACtion - top", value: act_top},
            {x: "ACtion - down", value: act_down},
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

request.send();