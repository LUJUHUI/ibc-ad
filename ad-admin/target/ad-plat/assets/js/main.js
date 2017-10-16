String.prototype.replaceAll = function(s1,s2){
    return this.replace(new RegExp(s1,"gm"),s2);
}

function openMainPage(url, data, callback){
    var mainPage = "#main_page";
    var lastChild = $(mainPage + " > div:last");
    lastChild.addClass("main-page-div-display");//将当前元素隐藏
    var newChildIndex = parseInt(lastChild.attr("id").split("_")[1]) + 1;//计算将要插入的div后缀索引

    var divHtml = '<div id="mainPage_' + newChildIndex + '"></div>';
    $(mainPage).append(divHtml);

    $(mainPage + " > div:last").load(url, data, callback);
}