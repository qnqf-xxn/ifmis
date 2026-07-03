if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.prorevision){
	Ext.lt.pmkpi.prorevision = {};
}


Ext.lt.pmkpi.prorevision.revisionpower = function(config, service){
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _menuid = config.menuid,
        _tablecode = config.tablecode,
        _tabfilter,
        _tabcode = "waitpower",
		_name,
    scrWidth =document.body.clientWidth,
    scrHeight =document.body.clientHeight;

    var serviceid = service;
    var isFirst = true;

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        deptcmp.initDatatable();
        cmp.query();
        isFirst = false;
    })
    //查询
    cmp.query = function (obj){
        query();
    }
    function query(){
        Ext.lt.ui.loadingShow();
        var params = {};
        params.menuid = _menuid;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tabfilter = _tabfilter;
        params.tabcode = _tabcode;
        params.menuid = _menuid;
        params.beanid = "pmkpi.prorevision.RevisionPowerBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    //页签方法,切换页签，更改tablecode
    cmp.clickTabpage = function(obj){
        deptcmp.changTooltoolbuttontStatus(0,obj.hidebtns);
        _tabfilter = obj.filter;
        var config = eval('(' + obj.config + ')');
        if(config.tablecode){
            _tablecode = config.tablecode;
        }
        _tabcode = obj.code;
        if (!isFirst) {
            cmp.query();
        }
    }

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj) {
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _tablecode = uiconfig.tablecode;
        var cols = obj.cols;
    });
    cmp.power = function (){
        var data = datatable.getSelected();
        Ext.lt.ui.confirm('是否授权已选中单位？',{icon: "warn"},function(is){
            if(is){
                Ext.lt.ui.loadingShow();
                var params = {};
                params.deldatas = data;
                params.tablecode = _tablecode;
                params.code = "power";
                Ext.lt.RCP.call(service , "revisionpower", params, function(rs){
                    Ext.lt.ui.loadingClose();
                    if (rs.flg=="1") {
                        Ext.lt.ui.alert('授权成功！',function(){
                            cmp.query();
                        });
                    }else{
                        Ext.lt.ui.alert(rs.message);
                    }
                },function(rs){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('授权失败！'+rs.message,function(){
                    });
                });
            }
        })
    }



    cmp.cancelpower = function (){
        var data = datatable.getSelected();
        Ext.lt.ui.confirm('是否取消授权已选中单位？',null,function(is){
            if(is){
                Ext.lt.ui.loadingShow();
                var params = {};
                params.deldatas = data;
                params.tablecode = _tablecode;
                params.code = "cancelpower";
                Ext.lt.RCP.call(service , "revisionpower", params, function(rs){
                    Ext.lt.ui.loadingClose();
                    if (rs.flg=="1") {
                        Ext.lt.ui.alert('取消授权成功！',function(){
                            cmp.query();
                        });
                    }else{
                        Ext.lt.ui.alert(rs.message);
                    }
                },function(rs){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('取消授权失败！'+rs.message,function(){
                    });
                });
            }
        })
    }


    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });
    return cmp;
}
function subseldata(selData){
    for(var j = 0; j < selData.length; j++){
        var guid = selData[j];
        //删除选中数据
        var parent_sel_rows = datatable.getRecordset().query({guid:guid});
        datatable.removeData(parent_sel_rows);
        //查询选中数据下级
        var datas = datatable.getRecordset().query({superid:guid});
        //循环查询删除最末级
        for (var i = 0; i < datas.length; i++) {
            //选中数据的下级的下级数据
            var data2 = datatable.getRecordset().query({superid:datas[i].guid});
            datatable.removeData(data2);
            //datatable.removeData(datas[i].guid);
            subseldata(datas);
        }
    }
}