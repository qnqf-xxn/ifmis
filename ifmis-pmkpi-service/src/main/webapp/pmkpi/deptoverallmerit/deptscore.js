if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.deptscore){
	Ext.lt.pmkpi.deptscore = {};
}
var serviceid;
var _mainguid;
var _saveAgency;
var _menuid;
var _viewtype;
Ext.lt.pmkpi.deptscore = function(config, service){
    var commcmp = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var
        _tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _busguid,//审核定义
        _modelguid//指标模板guid
    ;
    var cmp = {};
    serviceid = service;
    _mainguid = config.mainguid;
    _menuid = config.menuid;
    _tablecode = config.tablecode;
    _saveAgency = config.saveAgency;
    _viewtype = config.viewtype,
    _querytype = config.querytype,
    _bustype = config.bustype,
    _scrWidth =document.body.clientWidth;
    _scrHeight =document.body.clientHeight;
    /**
     *
     */
    Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
        var config = obj.config;
        _tablecode = obj.uiconfig.tablecode;
        _defquery = obj.uiconfig.defquery;
        _orderby = obj.uiconfig.orderby;
        //审核定义guid，perf_t_busauditdefine表budguid
        _busguid = config.busguid;
        _modelguid = config.modelguid;
    });

    cmp.query = function(){
        var params = {};
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tablecode = _tablecode;
        params.mainguid = _mainguid;
        params.modelguid = _modelguid;
        params.bustype = _bustype;
        params.agency = _saveAgency;
        params.viewtype = _viewtype;
        params.querytype = _querytype;
        params.menuid = _menuid;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
            datatable.setDatas(rs.data);
            setTimeout(function(){
                amtTotal(datatable);
            },100);
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    cmp.save = function(){
        if (!datatable.checkAll()) return false;//先校验
        var params = {};
        var datas = datatable.getRecordSet().toArray();
        var buckle = datatable.getCol('buckle');
        var sbuckle = datatable.getCol('sbuckle');
        if (datas.length > 0){
            for (var i=0; i<datas.length; i++) {
                var j = 1 + 1;
                var col = datas[i];
                if (col.levelno == '2'){
                    if((parseFloat(col.scroe)<parseFloat(col.qualityweight)) && buckle.isvisiable == '1' && col.buckle == undefined){
                        Ext.lt.ui.alert("第"+parseFloat(i+1)+"行自评得分小于分值,请填写理由及依据！",{timeout:1},function(){});
                        return false;
                    }
                    if((parseFloat(col.sscroe)<parseFloat(col.qualityweight)) && sbuckle.isvisiable == '1' && col.sbuckle == undefined){
                        Ext.lt.ui.alert("第"+parseFloat(i+1)+"行考核得分小于分值,请填写理由及依据！",{timeout:1},function(){});
                        return false;
                    }
                }
            }
        }
        params.datas = datatable.getRecordSet().toArray();
        params.updatas = datatable.getUpdataData();
        params.deldatas = datatable.getRemoveData();
        params.tablecode = _tablecode;
        params.busguid = _busguid;
        params.mainguid = _mainguid;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        Ext.lt.ui.loadingClose();
        cmp.query();
        return rs;
    }

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        commcmp.initDatatable();
        cmp.query();
    })
    
    Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
    var cols = obj.cols;
    if(!Ext.lt.isArray(cols))
        cols = [cols];
    for(var i=0; i<cols.length; i++){
        var col = cols[i];

        if(col["colcode"]=="qualityweight"){
            col.fn = function(l,c,data,col){
                if(data.isleaf == "0"){
                    var qualityweight = 0;
                    if(data.qualityweight){
                    	qualityweight = data.qualityweight;
                    }
                    return "<b>"+qualityweight+"</b>";
                }else{
                    return data.qualityweight ? data.qualityweight : "";
                }
            }
        }
        
        if(col["colcode"]=="scroe"){
            col.fn = function(l,c,data,col){
                if(data.isleaf == "0"){
                    var scroe = 0;
                    if(data.scroe){
                    	scroe = data.scroe;
                    }
                    return "<b>"+scroe+"</b>";
                }else{
                    return data.scroe ? data.scroe : "";
                }
            }
            
            col.oneditstart = function (table, el, l, c, d) {
                if(d.levelno != "2"){
                    return false;
                }
            }
            
            col.oneditend = function (table, el, l, c, d) {
            	d.scroe = d.scroe == 0 ? "0" : parseFloat(parseFloat(d.scroe).toFixed(3).toString());
				if(!checkReferencepole(d.scroe)){
                    d.scroe = '';
                    return false;
                }
				if(parseFloat(d.scroe)>parseFloat(d.qualityweight)){
                    Ext.lt.ui.alert("自评得分不能大于分值！",{timeout:1},function(){});
                    d.scroe = '';
                    return false;
				}
                if((parseFloat(d.scroe)<parseFloat(d.qualityweight)) && (d.buckle == undefined || d.buckle == '')){
                    Ext.lt.ui.alert("自评得分小于分值,请填写理由及依据！",{timeout:1},function(){});
                    //return false;
                }
				gatherScore(d.superid);
                amtTotal(datatable);
            }
        }
        
        if(col["colcode"]=="buckle"){
            col.oneditstart = function (table, el, l, c, d) {
                if(d.levelno != "2"){
                    return false;
                }
            }
        }
        
        if(col["colcode"]=="sscroe"){
            col.fn = function(l,c,data,col){
                if(data.isleaf == "0"){
                    var sscroe = 0;
                    if(data.sscroe){
                    	sscroe = data.sscroe;
                    }
                    return "<b>"+sscroe+"</b>";
                }else{
                    return data.sscroe ? data.sscroe : "";
                }
            }
            
            col.oneditstart = function (table, el, l, c, d) {
                if(d.levelno != "2"){
                    return false;
                }
            }
            
            col.oneditend = function (table, el, l, c, d) {
                d.sscroe = d.sscroe == 0 ? "0" : parseFloat(parseFloat(d.sscroe).toFixed(3).toString());
				if(!checkReferencepole(d.sscroe)){
                    d.sscroe = '';
                    return false;
                }
				if(parseFloat(d.sscroe)>parseFloat(d.qualityweight)){
                    Ext.lt.ui.alert("考核得分不能大于分值！",{timeout:1},function(){});
                    d.sscroe = '';
                    return false;
				}
                if((parseFloat(d.sscroe)<parseFloat(d.qualityweight)) && (d.sbuckle == undefined || d.sbuckle == '')){
                    Ext.lt.ui.alert("考核得分小于分值,请填写理由及依据！",{timeout:1},function(){});
                }
				gatherScore(d.superid);
                amtTotal(datatable);
            }
        }
        
        if(col["colcode"]=="sbuckle"){
            col.oneditstart = function (table, el, l, c, d) {
                if(d.levelno != "2"){
                    return false;
                }
            }
        }

    }
});


    return cmp;
}


function gatherScore(superid){
    var datas = datatable.getRecordSet().toArray();
    if(superid){
        if(datas!=null && datas.length > 0){
            var supguid = '';
            var sortid = 0;
            var result = 0;
            var results = 0;
            var guid = '';
            for(var i=0;i<datas.length;i++){
                var selectDatas = datas[i];
                if(superid == selectDatas.guid){
                    supguid = selectDatas.superid;
                    guid = selectDatas.guid;
                }
                if(selectDatas.superid == superid && selectDatas.scroe && !isNaN(selectDatas.scroe)){
                    result += parseFloat(selectDatas.scroe);
                }
                if(selectDatas.superid == superid && selectDatas.sscroe && !isNaN(selectDatas.sscroe)){
                	results += parseFloat(selectDatas.sscroe);
                }
            }
            datas.each(function(data,i){
                if(data.guid == guid){
                    datas[i]['scroe'] = result==0 ? "" : parseFloat(result.toFixed(3));
                    datas[i]['sscroe'] = results==0 ? "" : parseFloat(results.toFixed(3));
                }
            });
            gatherScore(supguid);
        }
    }
    datatable.reflash();
}

function amtTotal(table){
    var totalrow = table.getRecordset();
    var ownscoresumamt = 0;
    var ownsscoresumamt = 0;
    var qualityweight = 0;
    var rowarr = totalrow.toArray();
    var len = rowarr.length;
    for ( var i = 0; i < len; i++) {
    	if(rowarr[i].isleaf == "1" && rowarr[i].levelno == "2"){
    		var ownscore = rowarr[i]["scroe"] ? rowarr[i]["scroe"] : 0;
    		var ownsscore = rowarr[i]["sscroe"] ? rowarr[i]["sscroe"] : 0;
    		var weight = rowarr[i]["qualityweight"] ? rowarr[i]["qualityweight"] : 0;
    		ownscoresumamt += parseFloat(ownscore);
    		ownsscoresumamt += parseFloat(ownsscore);
    		qualityweight += parseFloat(weight);
    	}
    }
    var totalrs = {};
    totalrs["scroe"] = parseFloat(ownscoresumamt?ownscoresumamt.toFixed(3):"0.00");
    totalrs["sscroe"] = parseFloat(ownsscoresumamt?ownsscoresumamt.toFixed(3):"0.00");
    totalrs["qualityweight"] = parseFloat(qualityweight?qualityweight.toFixed(3):"0.00");
    totalrs.datatable_do_sum=true;
    table.getClockRowSet().setData(totalrs,0);
    if((totalrow.size&&totalrow.size()>0)||(totalrow.length&&totalrow.length>0)){
        table.reflashdata();
    }
}

function checkReferencepole(referencepole){
	var re = /^\d*\.{0,1}\d{0,3}$/;
	if(!re.test(referencepole)){
		Ext.lt.ui.alert("请填写数字！",{timeout:1},function(){});
		return false;
	}else{
		return true;
	}
}
