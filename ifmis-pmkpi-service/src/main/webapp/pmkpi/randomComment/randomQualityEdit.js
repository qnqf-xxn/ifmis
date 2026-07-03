if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.randomQualityEdit){
	Ext.lt.pmkpi.randomQualityEdit = {};
}
var serviceid;
var _mainguid;
Ext.lt.pmkpi.randomQualityEdit = function(config, service){
    var commoncmp = Ext.lt.pmkpi.perfcommon(config, service);
    var serviceid = service,
        _tabcode,
        _tabcode1,
        _tabcode2,
        _menuid = config.menuid,
        _mainguid = config.mainguid,
        _procode = config.procode,
        _bustype = config.bustype,
        _tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _busguid,//审核定义
        _modelguid//指标模板guid
    ;
    var cmp = {};
    
    _scrWidth =document.body.clientWidth;
    _scrHeight =document.body.clientHeight;


    cmp.query = function(){
        var params = {};
        params.tablesql = _defquery;
        params.bustype = _bustype;
        params.tablecode = _tablecode;
        params.tabcode = _tabcode1;
        params.tabcode1 = _tabcode2;
        params.menuid = _menuid;
        params.mainguid = _mainguid;
        params.procode = _procode;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
            datatable.setDatas(rs.data);
            setTimeout(function(){
                initgatherWeight();
                amtTotal(datatable);
            },2000);
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
        params.datas = datatable.getRecordSet().toArray();
        params.updatas = datatable.getUpdataData();
        params.deldatas = datatable.getRemoveData();
        params.tablecode = _tabcode;
        params.mainguid = _mainguid;
        params.procode = _procode;
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        cmp.query();
        return rs;
    }

    $(function () {
        debugger
        commoncmp.initDatatable();
        cmp.query();
    })

    Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
        var cols = obj.cols;
        var config = obj.table.config;
        var uiconfig = obj.table.uiconfig;
        _tabcode = config.tabcode;
        _tabcode1 = config.tabcode1;
        _tabcode2 = config.tabcode2;
        _tablecode = uiconfig.tablecode;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"]=="scroe"){
                col.fn = function(l,c,data,col){
                    if(data.isleaf == "0"){
                        var score = 0;
                        if(data.scroe){
                        	score = data.scroe;
                        }
                        return "<b>"+Math.round(score*100)/100+"</b>";
                    }else{
                        return data.scroe ? data.scroe : "";
                    }
                }
                
                col.oneditstart = function (table, el, l, c, d) {
                    if(d.isleaf != "1"){
                        return false;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                	if(!checkReferencepole(d.scroe)){
                        d.scroe = '';
                        return false;
                    }
                	d.scroe = d.scroe!="" ? getPointNum(parseFloat(d.scroe)) : "0";
                	gatherScore(d.superid);
                    amtTotal(datatable);
                }
            }
            if(col["colcode"]=="buckle"){
                col.oneditstart = function (table, el, l, c, d) {
                    if(d.isleaf != "1"){
                	//if(d.levelno != "2"){
                        return false;
                    }
                }
            }
        }
    });


    return cmp;
}

function initgatherWeight(){
    var data = datatable.getRecordSet().toArray();
    var datas = data;
    var superid;
    for(var i = 0; i < data.length; i++){
        var selectData = data[i];
        if(selectData.isleaf == "1" && selectData.levelno != "1"){
            superid = selectData.superid;
            gatherScore(superid);
        }
    }
    amtTotal(datatable);
    datatable.reflash();
}
function gatherScore(superid){
    var datas = datatable.getRecordSet().toArray();
    if(superid){
        if(datas!=null && datas.length > 0){
            var supguid = '';
            var sortid = 0;
            var result = 0;
            var resultWeight = 0;
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
                if(selectDatas.superid == superid && selectDatas.qualityweight && !isNaN(selectDatas.qualityweight)){
                    resultWeight += parseFloat(selectDatas.qualityweight);
                }
            }
            datas.each(function(data,i){
                if(data.guid == guid){
                    datas[i]['scroe'] = result==0 ? "" : result.toFixed(1);
                }
                if(data.guid == guid){
                    datas[i]['qualityweight'] = resultWeight==0 ? "" : resultWeight.toFixed(1);
                }
            });
            gatherScore(supguid);
        }
    }
    datatable.reflash();
}

function getPointNum(num){  
    var str = String(num);
	var index = str.split(".");
	var str1 = null;
	if(index.length == 2){
		str1 = index[1].substring(0,1);
		str1 = Number(index[0]+"."+str1);
	} else {
		str1 = Number(index[0]);
	}		
    return str1;
}



function checkReferencepole(referencepole){
	var re = /^\d*\.{0,1}\d{0,1}$/;
	if(!re.test(referencepole)){
		Ext.lt.ui.alert("请填写数字！",{timeout:1},function(){});
		return false;
	}else{
		return true;
	}
}

function amtTotal(table){
    var totalrow = table.getRecordset();
    var weightsumamt = 0;
    var ownscoresumamt = 0;
    var rowarr = totalrow.toArray();
    var len = rowarr.length;
    for ( var i = 0; i < len; i++) {
    	if(rowarr[i].isleaf == "1" && rowarr[i].levelno != "1"){
    		var weight = rowarr[i]["qualityweight"] ? rowarr[i]["qualityweight"] : 0;
            weightsumamt += parseFloat(weight);
    		var ownscore = rowarr[i]["scroe"] ? rowarr[i]["scroe"] : 0;
    		ownscoresumamt += parseFloat(ownscore);
    	}
    }
    var totalrs = {};
    totalrs["qualityweight"] = (weightsumamt?weightsumamt.toFixed(1):"0.00");
    totalrs["scroe"] = (ownscoresumamt?ownscoresumamt.toFixed(1):"0.00");
    totalrs.datatable_do_sum=true;
    table.getClockRowSet().setData(totalrs,0);
    if((totalrow.size&&totalrow.size()>0)||(totalrow.length&&totalrow.length>0)){
        table.reflashdata();
    }
}