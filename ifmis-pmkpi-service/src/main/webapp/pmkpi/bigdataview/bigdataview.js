if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

if(!Ext.lt.pmkpi.bigdataview){
    Ext.lt.pmkpi.bigdataview = {};
}

Ext.lt.pmkpi.bigdataview.index = function(config, service){
	var type = config.type;
    $(function () {
    	var div = document.getElementsByClassName('bd_main')[0];
		var url = null;
    	if(type == "1"){ // 绩效监控分析
    		url = Ext.lt.token.urlAddToken("/pmkpi/bigdataview/jkindex.jsp?1=1");
    		div.innerHTML = "<iframe name='myiframe' width='100%' height='100%' marginwidth='0' marginheight='0' hspace='0' vspace='0' frameborder='0' scrolling='yes' src='"+url+"'></iframe>";
    	} else if(type == "2"){ // 绩效自评分析
    		url = Ext.lt.token.urlAddToken("/pmkpi/bigdataview/zpindex.jsp?1=1");
    		div.innerHTML = "<iframe name='myiframe' width='100%' height='100%' marginwidth='0' marginheight='0' hspace='0' vspace='0' frameborder='0' scrolling='yes' src='"+url+"'></iframe>";
    	} else if(type == "3"){ // 绩效监控自评对比分析
    		url = Ext.lt.token.urlAddToken("/pmkpi/bigdataview/dbindex.jsp?1=1");
    		div.innerHTML = "<iframe name='myiframe' width='100%' height='100%' marginwidth='0' marginheight='0' hspace='0' vspace='0' frameborder='0' scrolling='yes' src='"+url+"'></iframe>";
    	}else { // 总览
			url = Ext.lt.token.urlAddToken("/pmkpi/bigdataview/index.jsp?1=1");
			div.innerHTML = "<iframe name='myiframe' width='100%' height='100%' marginwidth='0' marginheight='0' hspace='0' vspace='0' frameborder='0' scrolling='yes' src='"+url+"'></iframe>";
		}

    })
}