if (top.location.pathname == "/game1") {
    setTimeout(function(){
        timeOut();
    }, 31000);
    var x = 30;
    function timerUpdate(){
        $('#timer').html(x)
    };
    timerUpdate();
    setInterval(function(){
        x = x - 1;
        timerUpdate();
        if ($('#timer').html() == "5") { $('#timer').css('color','red') };
    } , 1000);
    function timeOut() {
        $.post('/game2');
        top.location.pathname = '/game2'
    };
};