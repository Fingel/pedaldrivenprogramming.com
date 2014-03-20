---
layout: page
title: Photo of the Day
categories: []
tags: []
status: publish
type: page
published: true
permalink: /pod/
---
<div class="row">
    <div id="today-div">
        <a href="" target="_blank" id="today-link"><img id="today" style="display:none"/></a>
        <p id="today-description"></p>
    </div>
</div>
<div class="row">
    <h2>Previous PODs</h2>
    <p>I try to take one photo every day. You can view all of them on <a href="https://secure.flickr.com/photos/103377679@N03/sets/72157642172999344/">Flickr</a>.</p>
    <div id="pods" class="gallery"></div>
    <div class="pod-nav">
        <a href="#" id="prev-link" style="display:none"><< Prev </a>
        <a href="#" id="more-link" style="display:none">Next >> </a>
    </div>

</div>
<div class="row">

</div>
<script src="/js/jquery.colorbox-min.js"></script>
<script type="text/javascript">

$('#today').bind('load', function(){
    $(this).fadeIn()
})

$('#more-link, #prev-link').click(function(e){
    e.preventDefault()
    fetchImages($(this).data('page'))
    return false;
})

$(document).ready(function(){
    fetchImages(1)
    flickr_url = 'https://api.flickr.com/services/rest/?method=flickr.people.getPhotos&api_key=377b339d6924ffa502236994dfe17e2c&user_id=103377679%40N03&min_taken_date=1393632000&extras=description%2C+date_upload%2C+date_taken%2C+url_sq%2C+url_t%2C+url_s%2C+url_q%2C+url_m%2C+url_n%2C+url_z%2C+url_c%2C+url_l%2C+url_o&per_page=1&page=1&format=json&nojsoncallback=1'
    $.getJSON(flickr_url, function(data){
        $("#today-link").attr('href', data.photos.photo[0].url_o)
        $("#today").attr('src', data.photos.photo[0].url_l)
        $("#today-description").html('"' + data.photos.photo[0].title + '"')
   })
})

function fetchImages(page){
    $("#pods").html('')
    per_page = 10
    if(page == 1)
        per_page = 11
    flickr_url = 'https://api.flickr.com/services/rest/?method=flickr.people.getPhotos&api_key=377b339d6924ffa502236994dfe17e2c&user_id=103377679%40N03&min_taken_date=1393632000&extras=description%2C+date_upload%2C+date_taken%2C+url_sq%2C+url_t%2C+url_s%2C+url_q%2C+url_m%2C+url_n%2C+url_z%2C+url_c%2C+url_l%2C+url_o&per_page=' + per_page + '&page=' + page + '&format=json&nojsoncallback=1'
    var jqxhr = $.getJSON(flickr_url, function(data){
        photos = data.photos.photo
        page = parseInt(data.photos.page)
        if(data.photos.pages > page){
            $("#more-link").show()
            $("#more-link").data("page", page + 1)
        }else {
            $("#more-link").hide()
        }
        if(page > 1){
            $("#prev-link").show()
            $("#prev-link").data("page", page - 1)
        }else{
            $("#prev-link").hide()
        }
        if(page == 1)
            photos.shift()
        for(image in photos){
            var item = $('<figure class="pod-item-wrapper"><a target="_blank" data-large="' + photos[image].url_o + '"title="' + photos[image].title + '" href="' + photos[image].url_l + '"><img src="' + photos[image].url_s + '" rel="gal" /></a></figure>').hide().fadeIn(2000)
            $('#pods').append(item)
        }
    })

    jqxhr.done(function(){
        $('div.gallery > figure > a').colorbox({rel:'gal', maxWidth: '90%', maxHeight: '85%', scalePhotos: true, title: function(){
                var url = $(this).attr('data-large');
                var title = $(this).attr('title');
                return '<a href="' + url + '" target="_blank">' + title + '</a>';
            },
        })
    })
}
</script>
