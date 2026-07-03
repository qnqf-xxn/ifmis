/**
 * 二级项目调用项目库，项目信息
 * vchtypeid 		单据ID
 * proguid	 		项目ID
 * promaininfo		?
 * procategory  	项目分类
 * submenu 			菜单ID
 * 
 */
function queryOprodetail(vchtypeid,proguid,promaininfo,procategory,submenu){
	if(vchtypeid == "" || vchtypeid == undefined){
		Ext.lt.ui.alert('未找到对应的单据！',function(){});
	}else{
		var params = [];
		params.push('vchtypeid='+vchtypeid);
		params.push('selectbillguid='+proguid);
		params.push('promaininfo=' +promaininfo);
		params.push('projectkind='+procategory);
		params.push('submenu='+submenu);
		params.push('pagetype=detailinfo');
		var url = Ext.lt.token.urlAddToken('/pdm/prodetail/detailinfo.page')+ Ext.lt.token.getAuthorization() + '&' + params.join('&');
		Ext.lt.pdm = {};
		Ext.lt.pdm.common = {};
		Ext.lt.pdm.common.config = {};
		Ext.lt.pdm.common.config.pagetype = 'detailinfo';
		var width = $(window).width()*0.98, height = $(window).height()*0.9;
		Ext.lt.pdm.common.window = new Ext.lt.window({
			title:'',
			pop:true,
			mark:true,
			drag:true,
			close:true,
			w:width,
			h:height,
			fitmode:'content',
			className:'windpblue',
			onclose:function(){
			}
		});
		var framediv = $('<div style="width:'
		+ (width) + 'px; height:' + height + 'px;overflow:hidden;"><iframe src="'
		+ url + '"  frameborder="0"  style="top:auto;left:auto;scrolling: yes;width:'+(width)+'px'
		+ '; height:'+height+'px;'+'"></iframe></div>');
		Ext.lt.pdm.common.window.draw(framediv[0]);
	}
}

/**
 * 一级项目调用项目库，项目信息
 * vchtypeid 		单据ID
 * proguid	 		项目ID
 * promaininfo		?
 * procategory  	项目分类
 * submenu 			菜单ID
 * 
 */
function queryTprodetail(vchtypeid,proguid,projectkind,adjstatus,submenu){
	if(vchtypeid == "" || vchtypeid == undefined){
		Ext.lt.ui.alert('未找到对应的单据！',function(){});
	}else{
		var params = [];
		params.push('vchtypeid='+vchtypeid);      //数据vchtypeid
		params.push('selectbillguid='+proguid);  //项目guid
		params.push('projectkind='+projectkind); //项目分类id
		params.push('submenu='+submenu);
		params.push('pagetype=detail');
		params.push('adjadd=0');
		params.push('adjstatus='+adjstatus);  //数据是原始还调整
		params.push('showlog=0'); 
		var url = Ext.lt.token.urlAddToken('/pdm/promain/detail.page') + Ext.lt.token.getAuthorization() + '&' + params.join('&');
		Ext.lt.pdm = {};
		Ext.lt.pdm.common = {};
		Ext.lt.pdm.common.config = {};
		Ext.lt.pdm.common.config.pagetype = 'detail';
		Ext.lt.pdm.leftprojectkinddatas= new Ext.lt.recordset();
		var width = $(window).width()*0.98, height = $(window).height()*0.9;
		Ext.lt.pdm.common.window = new Ext.lt.window({
			title:'',
			pop:true,
			mark:true,
			drag:true,
			close:true,
			w:width,
			h:height,
			fitmode:'content',
			className:'windpblue',
			onclose:function(){
			}
		});
		var framediv = $('<div style="width:'
		+ (width) + 'px; height:' + height + 'px;overflow:hidden;"><iframe src="'
		+ url + '"  frameborder="0"  style="top:auto;left:auto;scrolling: yes;width:'+(width)+'px'
		+ '; height:'+height+'px;'+'"></iframe></div>');
		Ext.lt.pdm.common.window.draw(framediv[0]);
	}
}