if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

if(!Ext.lt.pmkpi.randomComment){
    Ext.lt.pmkpi.randomComment = {};
}
Ext.lt.pmkpi.randomComment.random = function(config, service){
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    
	cmp.random = function(resultlist,rantime){
		var res = [];
		rantime = rantime!=null ? rantime : 3000; 
		var l =resultlist.size()>=10 ? 10 : resultlist.size();
		for(var i=0;i<l;i++){
			res.push(resultlist[i].projname);
		}
		var trandom = $("#tttt");
		Ext.lt.HTML.mark();
		trandom.remove();
//		if(trandom.size()==0){
			var url = Ext.lt.token.urlAddToken("/pmkpi/randomComment/random.jsp?listsize="+resultlist.size()+"&list="+encodeURI(encodeURI(res)));
			var htmlArr = [];
			var zindex = 200000 + Ext.lt.ui.getwinindex();
			htmlArr.push("<div id='tttt' style='position: absolute;z-index:"+zindex+";left: 428px; top: 173px; display: block;'>");
			htmlArr.push("<input id='list' type='hidden' value ='"+res+"'/>");
			htmlArr.push("<input id='listsize' type='hidden' value ='"+resultlist.size()+"'/>");
			htmlArr.push("<input id='rantime' type='hidden' value ='"+rantime+"'/>");
			htmlArr.push("<iframe src='"+url+"' allowtransparency='true' style='background-color:transparent;width:600px;height:400px; border: white;' scrolling='yes'></iframe>");
			htmlArr.push("</div>");
			trandom = $(htmlArr.join(""));
			$("body").append(trandom);
//		}
		trandom.show();
	    Ext.lt.HTML.center(trandom[0]);
	}
	
	cmp.randomend = function(){
		Ext.lt.ui.alert("标识成功!",{icon:"sucess",timeout:2},function(){
			var trandom = $("#tttt");
			trandom.hide();
	    	parent.Ext.lt.pmkpi.query();
		});
	}

    return cmp;
}