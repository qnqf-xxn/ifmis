if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.selffund){
    Ext.lt.pmkpi.selffund = {};
}
var serviceid;
var _mainguid;
Ext.lt.pmkpi.selffund = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var
        _saveAgency = config.saveAgency,
        _viewtype = config.viewtype,
        _procode = config.procode,
        _tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _busguid,//审核定义
        _modelguid//指标模板guid;
    var cmp = {};
    serviceid = service;
    _mainguid = config.mainguid;
    var _projguid = config.projguid;
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

    cmp.query = function(isquery){
        var params = {};
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tablecode = _tablecode;
        params.mainguid = _mainguid;
        params.projguid = _projguid;
        params.procode = _procode; //项目code
        params.url = datatable.config.pageurl;
        params.mainguid = _mainguid;
        params.viewtype = _viewtype;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
            datatable.setDatas(rs.data);
            setMidSaveHidButtons(rs);
            setTimeout(function(){
                amtTotal(datatable);
            },100);
            Ext.lt.ui.loadingClose();
            if (isquery) {
                setTimeout(function(){
                    parent._isQuery = true;
                },500);
            }
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
        params.datas = datatable.getRecordSet().toArray();
        params.updatas = datatable.getUpdataData();
        params.deldatas = datatable.getRemoveData();
        params.tablecode = _tablecode;
        params.busguid = _busguid;
        params.url = datatable.config.pageurl;
        params.mainguid = _mainguid;
        params.compconfigid = "datatable";
        if(!datas || datas.length == 0) {
            var rs = {};
            rs.success = true;
            Ext.lt.ui.loadingClose();
            return rs;
        }
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }

    /**
     * 暂存
     */
    cmp.savetmp = function (obj){
        var params = {};
        var datas = datatable.getRecordSet().toArray();
        params.data = datatable.getRecordSet().toArray();
        params.url = datatable.config.pageurl;
        params.mainguid = _mainguid;
        params.componentid = datatable.config.server;
        params.compconfigid = "datatable";
        Ext.lt.ui.loadingShow();
        if(!datas || datas.length == 0) {
            var rs = {};
            rs.success = true;
            Ext.lt.ui.loadingClose();
            return rs;
        }
        var rs = Ext.lt.RCP.asyncall(serviceid , "midsave", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }

    /**
     * 清除暂存
     */
    cmp.savetmpdel = function (obj){
        var params = {};
        params.url = datatable.config.pageurl;
        params.mainguid = _mainguid;
        params.componentid = datatable.config.server;
        params.compconfigid = "datatable";
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "midsavedel", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        cmp.query(true);
    })

    Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            // if(col["colcode"]=="obligate1"){
            //     if (_viewtype != "query"){
            //         col.style = " text-align:center;";
            //         col.fn = function(l,c,data,col){
            //             var html = "";
            //             if(data.levelno == "2"){
            //                 html = '<a title = "选择" style="color:#468ac9;cursor:pointer;">选择</a>';
            //             }
            //             return html;
            //         }
            //         col.onclick = function(td, el, l, c, d) {
            //             var levelno = d.levelno;
            //             if (levelno == "2"){
            //                 var url = "/pmkpi/deptperformance/report/addperfindex.page";
            //                 var params = {};
            //                 var name = d.name;
            //                 name = encodeURI(encodeURI(name));
            //                 params.name = name;
            //                 params.findex = d.findex;
            //                 params.sindex = d.guid;
            //                 url = Ext.lt.pmkpi.genPageUrl(url, params);
            //                 Ext.lt.ui.openModalWindow(url,_scrWidth - 200, _scrHeight - 100,"新增指标");
            //             } else if (levelno == "3"){
            //                 Ext.lt.ui.confirm("你确定删除选定的数据？",{icon:"warn"},function(ret){
            //                     if(ret){
            //                         eval(_onclickid).removeData(d);
            //                     }
            //                 });
            //             }
            //         };
            //     }
            // }

            if(col["colcode"]=="indexval"){
                //处理指标值，计量单位合并显示
                // col.fn = function(l,c,data,col){
                // 	if(data.levelno == "3"){
                // 		if(data.computesign == "6"){
                // 			var indexvalue = !data.indexval? "" : data.indexval;
                // 			return "<font style=\"margin-left:10px;\">" + indexvalue+"</font>";
                // 		} else {
                // 			var computesignstr ="";
                // 			var computesign_source = [{guid:"1",code:"1",name:"≥"},{guid:"2",code:"2",name:">"},{guid:"3",code:"3",name:"="},{guid:"4",code:"4",name:"<"},{guid:"5",code:"5",name:"≤"},{guid:"6",code:"6",name:"定性"}]
                // 			for(var i =0; i<computesign_source.size() ; i++){
                // 				if(data.computesign == computesign_source[i].guid){
                // 					computesignstr = computesign_source[i].name;
                // 				}
                // 			}
                // 			var unit = "";
                // 			if(data.meterunit){
                // 				unit = data.meterunit;
                // 			}
                // 			var returnstr = !data.indexval ? computesignstr + unit :computesignstr + data.indexval + unit;
                // 			return "<font style=\"margin-left:10px;\">"+returnstr+"</font>";
                // 		}
                // 	}
                // }
                if (_viewtype != "query"){
                    col.oneditstart = function (table, el, l, c, d) {
                        if(d.levelno != "3"){
                            return false;
                        }
                        el.innerText =  d.indexval!=undefined ? d.indexval : '';
                        table.getCol(c).mapping = null;
                        table.nowtype="input";
                        table.getCol(c).format = "";
                        // return;
                    }
                    col.oneditend = function (table, el, l, c, d) {
                        if(d.computesign && d.computesign != '6'){
                            if(!checkReferencepole(d.indexval)){
                                d.indexval = '';
                                return false;
                            }
                        }
                    }
                }

            }

            if(col["colcode"]=="obligate2"){
                if (_viewtype != "query"){
                    col.style = " text-align:center;";
                    col.fn = function(l,c,data,col){
                        var html = '<a title = "删除" style="color:#468ac9;cursor:pointer;">删除</a>';
                        return html;
                    }
                    col.onclick = function(td, el, l, c, d) {
                        Ext.lt.ui.confirm("你确定删除选定的数据？",{icon:"warn"},function(ret){
                            if(ret){
                                eval(_onclickid).removeData(d);
                            }
                        });
                    };
                }
            }

            if(col["colcode"]=="weight"){
                col.fn = function(l,c,data,col){
                    if(data.isleaf == "0"){
                        var weight = 0;
                        if(data.weight){
                            weight = data.weight;
                        }
                        return "<b>"+Math.round(weight*100)/100+"</b>";
                    }else{
                        return data.weight ? data.weight : "";
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    gatherWeight(d.superid);
                    amtTotal(datatable);
                }
            }

            if(col["colcode"]=="obligate3"){
                if (_viewtype != "query"){
                    col.style = " text-align:center;";
                    col.fn = function(l,c,data,col){
                        var html = "";
                        if(data.levelno == "2"){
                            html += '<a title = "选择" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexcheck("'+data.guid+'","'+data.findex+'","'+data.sindex+'")\'>选择</a>';
                            html += '&nbsp;&nbsp;&nbsp;&nbsp';
                            html += '<a title = "新增" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexadd("'+data.guid+'","'+data.findex+'")\'>新增</a>';
                        } else if(data.levelno == "3"){
                            html = '<a title = "删除" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexdel("'+data.guid+'","'+data._locationposition+'","'+data.sindex+'")\'>删除</a>';
                        }
                        return html;
                    }
                }
            }
        }
    });

    Ext.lt.pmkpi.addrow = function(data){
        var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
        data.guid = newguid;
        data.rowtype = "add";
        data.mainguid = _mainguid;
        data.sindex = data.sindex;
        data.findex = data.findex;
        data.superid = data.sindex;
        data.levelno = 3;
        data.isleaf = 1;
        Ext.lt.pmkpi.isadd = true;
        datatable.getRecordSet().addData(data,999);
    }

    return cmp;
}

function indexcheck(guid,findex,sindex) {
    var url = "/pmkpi/deptperformance/report/indexcheck.page";
    var params = {};
    params.checksuperid = guid;
    params.findex = findex;
    url = Ext.lt.pmkpi.genPageUrl(url, params);
    Ext.lt.ui.openModalWindow(url,_scrWidth - 200, _scrHeight - 100,"选择指标");
}

function indexadd(sindex,findex) {
    var data = {};
    var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
    data.guid = newguid;
    data.rowtype = "add";
    data.mainguid = _mainguid;
    data.sindex = sindex;
    data.findex = findex;
    data.superid = sindex;
    data.levelno = 3;
    data.isleaf = 1;
    Ext.lt.pmkpi.isadd = true;
    datatable.getRecordSet().addData(data,999);
}

function indexdel(guid,_locationposition,sindex) {
    Ext.lt.ui.confirm("你确定删除选定的数据？",{icon:"warn"},function(ret){
        if(ret){
            var data = {};
            data.guid = guid;
            data._locationposition = _locationposition;
            datatable.removeData(data);
            gatherWeight(sindex);
        }
    });
}

function gatherWeight(superid){
    var datas = datatable.getRecordSet().toArray();
    if(superid){
        if(datas!=null && datas.length > 0){
            var supguid = '';
            var sortid = 0;
            var result = 0;
            var guid = '';
            for(var i=0;i<datas.length;i++){
                var selectDatas = datas[i];
                if(superid == selectDatas.guid){
                    supguid = selectDatas.superid;
                    guid = selectDatas.guid;
                }
                if(selectDatas.superid == superid && selectDatas.weight && !isNaN(selectDatas.weight)){
                    result += parseFloat(selectDatas.weight);
                }
            }
            datas.each(function(data,i){
                if(data.guid == guid){
                    datas[i]['weight'] = result==0 ? "" : result.toFixed(2);
                }
            });
            gatherWeight(supguid);
        }
    }
    datatable.reflash();
}

function amtTotal(table) {
    if(table.getSumobj()){
        var totalrow = table.getRecordset();
        var sumamt = 0;
        var rowarr = totalrow.toArray();
        var len = rowarr.length;
        for ( var i = 0; i < len; i++) {
            if (rowarr[i].isleaf == "1" && rowarr[i].levelno == "3") {
                var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0;
                sumamt += parseFloat(weight);
            } else if (rowarr[i].isleaf == undefined && rowarr[i].levelno == undefined) {
                var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0;
                sumamt += parseFloat(weight);
            }
        }
        var totalrs = {};
        totalrs["weight"] = sumamt == 0 ? "" : sumamt.toFixed(2);
        totalrs.datatable_do_sum=true;
        table.getClockRowSet().setData(totalrs,0);
        if((totalrow.size&&totalrow.size()>0)||(totalrow.length&&totalrow.length>0)){
            table.reflashdata();
        }
    }
}