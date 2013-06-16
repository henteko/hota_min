$(function() { 
  google.maps.event.addDomListener(window, 'load', function() {
    var TOKYO = new google.maps.LatLng(35.681382, 139.766084);
    var BACKGROUND_COLOR = '#757575';
    var HOTARU_COLOR = '#D2FF8B'; 

    var mapOptions = {
      zoom: 10,
      center: TOKYO,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      scaleControl: true
    };
    var mapObj = new google.maps.Map(document.getElementById('gmap'), mapOptions);
    var setCircle = function(latlng, color, opacity, radius) {
      return new google.maps.Circle({
        center: latlng,  // 中心点(google.maps.LatLng)
        fillColor: color,   // 塗りつぶし色
        fillOpacity: opacity,       // 塗りつぶし透過度（0: 透明 ⇔ 1:不透明）
        map: mapObj,             // 表示させる地図（google.maps.Map）
        radius: radius,          // 半径（ｍ）
        strokeColor: color, // 外周色 
        strokeOpacity: 1,       // 外周透過度（0: 透明 ⇔ 1:不透明）
        strokeWeight: 0         // 外周太さ（ピクセル）
      });
    };

    //全体
    setCircle(TOKYO, BACKGROUND_COLOR, 0.5, 100000000000);

    var opacity_d = 0.1; //増加度
    
    var $infos = $('.infomation');
    console.log($infos);
    $.each($infos, function(index, info){
      var opacity = 0.1;
      var latitude = $(info).attr('latitude');
      var longitude = $(info).attr('longitude');
      var count = $(info).attr('count');

      var latlng = new google.maps.LatLng(latitude, longitude);
      var circle = setCircle(latlng, HOTARU_COLOR, opacity, 1000);
      setInterval(function() {
        circle.setMap(null); 
        opacity += opacity_d;
        circle = setCircle(latlng, HOTARU_COLOR, opacity, 1000);
        if (opacity >= 0.5) {
          opacity_d = -0.1;
        }else if (opacity <= 0.1){
          opacity_d = 0.1;
        }
      }, 500 / count);

    });
  });
});
