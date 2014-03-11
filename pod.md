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
    <p>I try to take one photo every day. You can view the set on <a href="https://secure.flickr.com/photos/103377679@N03/sets/72157642172999344/">Flickr</a></p>
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
var photoset_id = '72157642172999344'
//var photoset_id = '72157635929089523'

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
    flickr_url = 'https://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=377b339d6924ffa502236994dfe17e2c&photoset_id=' + photoset_id +'&extras=date_taken%2Curl_sq%2C+url_t%2C+url_s%2C+url_m%2C+url_o&per_page=1&page=1&format=json&nojsoncallback=1'
    $.getJSON(flickr_url, function(data){
        $("#today-link").attr('href', 'https://secure.flickr.com/photos/' + data.photoset.owner + '/' + data.photoset.photo[0].id)
        $("#today").attr('src', data.photoset.photo[0].url_m)
        $("#today-description").html('"' + data.photoset.photo[0].title + '"')
   })
})

function fetchImages(page){
    $("#pods").html('')
    per_page = 10
    if(page == 1)
        per_page = 11
    flickr_url = 'https://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=377b339d6924ffa502236994dfe17e2c&photoset_id=' + photoset_id +'&extras=date_taken%2Curl_sq%2C+url_t%2C+url_s%2C+url_m%2C+url_o&per_page=' + per_page + '&page=' + page + '&format=json&nojsoncallback=1'
    var jqxhr = $.getJSON(flickr_url, function(data){
        photos = data.photoset.photo
        page = parseInt(data.photoset.page)
        if(data.photoset.pages > page){
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
            var item = $('<figure class="pod-item-wrapper"><a target="_blank" href="' + photos[image].url_m + '"><img src="' + photos[image].url_s + '" rel="gal" /></a><figcaption>' + photos[image].title +  ' ' + photos[image].datetaken.split(' ')[0] + '</figcaption></figure>').hide().fadeIn(2000)
            $('#pods').append(item)
        }
    })

    jqxhr.done(function(){
        $('ul.gallery > li> a').colorbox({rel:'gal'});
    })
}
</script>